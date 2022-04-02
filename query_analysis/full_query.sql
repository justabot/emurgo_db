WITH transactions AS (
  SELECT tx.id, tx.hash, address, payment_cred, 
         source_tx_out.tx_id source_tx_out_tx_id, source_tx.id source_tx_id,
         source_tx.hash source_tx_hash, 
         source_tx_out.id source_tx_out_id,
         source_tx_out.address source_tx_out_address,
         source_tx_out.value source_tx_out_value,
         tx.block_id, tx.fee, tx.valid_contract, 
         tx.script_size, tx.block_index, tx_in_id, tx_out_id, tx_out_index
    FROM tx tx
     JOIN tx_in
      ON tx_in.tx_in_id = tx.id
JOIN tx_out source_tx_out 
  ON tx_in.tx_out_id = source_tx_out.tx_id 
 AND tx_in.tx_out_index::smallint = source_tx_out.index::smallint
JOIN tx source_tx 
  ON source_tx_out.tx_id = source_tx.id 
   WHERE tx.block_id <= 1206628
        and (
          tx.block_id > 180928
          or
            (tx.block_id = 180928 and tx.block_index > 15)
          )
      AND source_tx.block_id <= 1206628
        and (
          source_tx.block_id > 180928
          or
            (source_tx.block_id = 180928 and source_tx.block_index > 15)
          )
     AND address = ANY(('{
    "37btjrVyb4KDj2x14SC4FUtLhqnHKEtz3YtcFsfqnEkvybLJGyx6kBzX8sv9niQpy2yYKxDbpVYfq8ZzsuMVvmoPL8pCpd1i8c2JZDtPuEf1bAG1Ye",
    "37btjrVyb4KBGrAzVJ382Hxbbd2VBXu3eJG5jZJyBbSeVAQ4SwDxn66eD4rf1dKm89RY5QRt1T3Zf9UyS69CgVb6Eyewp9yjjzn6PBGmnoxyBkfKsC",
    "37btjrVyb4KCFVxvE7HNuAvcJRSaPNAT6mb2o2Wjq73juV3aNoSc3LP5f9sLMrjkLMZL5pTrnBRrhhfCgjfKt6AS2RKkMaVWovdREELHrqibH8xCNh",
    "2cWKMJemoBaivGd3SNWQiFUk9Noc7mbjxX6UQamU2GHG41tE2LvCN3upaK7ZkafY3etRi",
    "37btjrVyb4KCjE4UG8c9qn3WfxJQXKKUSmYuju8GKSTS7tQDe5zS9tJSrgoZ96wKBywHa1NgiZZ9jFwKi14Sfg9ZGkySepAZzVWgdEt7wUkxiDuRyQ"}')::varchar array)),
     -- OR source_tx_out.payment_cred = ANY(($6)::bytea array))
    collateral_transactions as (
      select tx.hash as hash, collateral_tx_in.tx_out_index, collateral_tx_in.id,
         source_tx_out.tx_id source_tx_out_tx_id, source_tx.id source_tx_id,
         source_tx.hash source_tx_hash, 
         source_tx_out.id source_tx_out_id,
         source_tx_out.address source_tx_out_address,
         source_tx_out.value source_tx_out_value
            FROM transactions tx
            JOIN collateral_tx_in 
              ON collateral_tx_in.tx_in_id = tx.id
            JOIN tx_out source_tx_out 
              ON collateral_tx_in.tx_out_id = source_tx_out.tx_id 
            AND collateral_tx_in.tx_out_index = source_tx_out.index
            JOIN transactions source_tx 
              ON source_tx_out.tx_id = source_tx.id),
    hashes as (
      select distinct hash
      from (
            select tx.hash as hash
            FROM transactions tx
          UNION
          select tx.hash as hash
            FROM collateral_transactions tx
          UNION
            select tx.hash as hash
            from transactions tx
            JOIN tx_out
              on tx.id = tx_out.tx_id
          UNION
            select tx.hash as hash
            from transactions tx 
            JOIN combined_certificates as certs 
              on tx.id = certs."txId" 
            where
              (
                certs."formalType" in ('CertRegKey', 'CertDeregKey','CertDelegate')
                and certs."stakeCred" = any(
                  (SELECT array_agg(encode(addr, 'hex')) from UNNEST('{}'::bytea array) as addr)::varchar array
                )
              ) or (
                certs."formalType" in ('CertRegPool')
                and certs."poolParamsRewardAccount" = any(
                  (SELECT array_agg(encode(addr, 'hex')) from UNNEST('{}'::bytea array) as addr)::varchar array
                )
              )
          UNION
            select tx.hash as hash
            from transactions tx
            JOIN withdrawal as w
            on tx.id = w."tx_id"
            JOIN stake_address as addr
            on w.addr_id = addr.id
            where addr.hash_raw = any(('{}')::bytea array)
           ) hashes
    )
  select tx.hash
       , tx.fee
       , tx.valid_contract
       , tx.script_size
       , (select jsonb_object_agg(key, bytes)
        from tx_metadata
        where tx_metadata.tx_id = tx.id) as metadata
       , tx.block_index as "txIndex"
       , block.block_no as "blockNumber"
       , block.hash as "blockHash"
       , block.epoch_no as "blockEpochNo"
       , block.slot_no as "blockSlotNo"
       , block.epoch_slot_no as "blockSlotInEpoch"
       , case when vrf_key is null then 'byron' 
              else 'shelley' end 
         as "blockEra"
       , block.time at time zone 'UTC' as "includedAt"
       , (select json_agg(( inadd_tx.source_tx_out_address
                          , inadd_tx.source_tx_out_value
                          , encode(inadd_tx.source_tx_hash, 'hex')
                          , tx.tx_out_index
                          , (select json_agg(ROW(encode("ma"."policy", 'hex'), encode("ma"."name", 'hex'), "quantity"))
                            from ma_tx_out
                            inner join multi_asset ma on ma_tx_out.ident = ma.id
                            WHERE ma_tx_out."tx_out_id" = inadd_tx.source_tx_out_id)
                          ) order by inadd_tx.id asc) as inAddrValPairs
          FROM transactions inadd_tx
          where inadd_tx.source_tx_hash = tx.hash) as "inAddrValPairs"
        , (select json_agg(( inadd_tx.source_tx_out_address
            , inadd_tx.source_tx_out_value
            , encode(inadd_tx.source_tx_hash, 'hex')
            , inadd_tx.tx_out_index
            , (select json_agg(ROW(encode("ma"."policy", 'hex'), encode("ma"."name", 'hex'), "quantity"))
              from ma_tx_out
              inner join multi_asset ma on ma_tx_out.ident = ma.id
              WHERE ma_tx_out."tx_out_id" = source_tx_out_id)
            ) order by inadd_tx.id asc) as collateralInAddrValPairs
          FROM collateral_transactions inadd_tx
          where inadd_tx.hash = tx.hash) as "collateralInAddrValPairs"
       , (select json_agg((
                    "address", 
                    "value",
                    "txDataHash",
                   (select json_agg(ROW(encode("ma"."policy", 'hex'), encode("ma"."name", 'hex'), "quantity"))
                        FROM ma_tx_out
                        inner join multi_asset ma on ma_tx_out.ident = ma.id
                        JOIN tx_out token_tx_out
                        ON tx.id = token_tx_out.tx_id         
                        WHERE ma_tx_out."tx_out_id" = token_tx_out.id AND hasura_to."address" = token_tx_out.address AND hasura_to.index = token_tx_out.index)
                    ) order by "index" asc) as outAddrValPairs
          from "TransactionOutput" hasura_to
          where hasura_to."txHash" = tx.hash) as "outAddrValPairs"
       , (select json_agg((encode(addr."hash_raw",'hex'), "amount") order by w."id" asc)
          from withdrawal as w
          join stake_address as addr
          on addr.id = w.addr_id
          where tx_id = tx.id) as withdrawals
       , (select json_agg(row_to_json(combined_certificates) order by "certIndex" asc)
          from combined_certificates 
          where "txId" = tx.id) as certificates           
  from transactions tx 
  JOIN hashes
    on hashes.hash = tx.hash
  JOIN block
    on block.id = tx.block_id
  LEFT JOIN pool_metadata_ref 
    on tx.id = pool_metadata_ref.registered_tx_id ;