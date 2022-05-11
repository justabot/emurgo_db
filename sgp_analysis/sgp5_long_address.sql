# server timeout before explain plan could be returned
Time: 7204232.386 ms (02:00:04.232)
explain (analyze, buffers)
with
    hashes as (
      select distinct hash
      from (
            select tx.hash as hash
            FROM tx
            JOIN tx_in 
              ON tx_in.tx_in_id = tx.id
    
            JOIN tx_out source_tx_out 
              ON tx_in.tx_out_id = source_tx_out.tx_id 
             AND tx_in.tx_out_index::smallint = source_tx_out.index::smallint
            JOIN tx source_tx 
              ON source_tx_out.tx_id = source_tx.id
     WHERE (source_tx_out.address = ANY(('{"addr1vy740r73x2w3du2xxt76cs4hdml4zw2c5h7tddcyf3jauys9tyns4"}')::varchar array)
     OR source_tx_out.payment_cred = ANY(('{}')::bytea array))      UNION
          select tx.hash as hash
            FROM tx
            JOIN collateral_tx_in 
              ON collateral_tx_in.tx_in_id = tx.id
            JOIN tx_out source_tx_out 
              ON collateral_tx_in.tx_out_id = source_tx_out.tx_id 
            AND collateral_tx_in.tx_out_index::smallint = source_tx_out.index::smallint
            JOIN tx source_tx 
              ON source_tx_out.tx_id = source_tx.id
     WHERE (source_tx_out.address = ANY(('{"addr1vy740r73x2w3du2xxt76cs4hdml4zw2c5h7tddcyf3jauys9tyns4"}')::varchar array)
     OR source_tx_out.payment_cred = ANY(('{}')::bytea array))
       UNION
            select tx.hash as hash
            from tx
            JOIN tx_out
              on tx.id = tx_out.tx_id
     WHERE (address = ANY(('{"addr1vy740r73x2w3du2xxt76cs4hdml4zw2c5h7tddcyf3jauys9tyns4"}')::varchar array)
     OR payment_cred = ANY(('{}')::bytea array))
          UNION
            select tx.hash as hash
            from tx 
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
            from tx
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
       , (select json_agg(( source_tx_out.address
                          , source_tx_out.value
                          , encode(source_tx.hash, 'hex')
                          , tx_in.tx_out_index
                          , (select json_agg(ROW(encode("ma"."policy", 'hex'), encode("ma"."name", 'hex'), "quantity"))
                            from ma_tx_out
                            inner join multi_asset ma on ma_tx_out.ident = ma.id
                            WHERE ma_tx_out."tx_out_id" = source_tx_out.id)
                          ) order by tx_in.id asc) as inAddrValPairs
          FROM tx inadd_tx
          JOIN tx_in
            ON tx_in.tx_in_id = inadd_tx.id
          JOIN tx_out source_tx_out 
            ON tx_in.tx_out_id = source_tx_out.tx_id AND tx_in.tx_out_index::smallint = source_tx_out.index::smallint
          JOIN tx source_tx 
            ON source_tx_out.tx_id = source_tx.id
          where inadd_tx.hash = tx.hash) as "inAddrValPairs"
        , (select json_agg(( source_tx_out.address
            , source_tx_out.value
            , encode(source_tx.hash, 'hex')
            , collateral_tx_in.tx_out_index
            , (select json_agg(ROW(encode("ma"."policy", 'hex'), encode("ma"."name", 'hex'), "quantity"))
              from ma_tx_out
              inner join multi_asset ma on ma_tx_out.ident = ma.id
              WHERE ma_tx_out."tx_out_id" = source_tx_out.id)
            ) order by collateral_tx_in.id asc) as collateralInAddrValPairs
          FROM tx inadd_tx
          JOIN collateral_tx_in
          ON collateral_tx_in.tx_in_id = inadd_tx.id
          JOIN tx_out source_tx_out 
          ON collateral_tx_in.tx_out_id = source_tx_out.tx_id AND collateral_tx_in.tx_out_index::smallint = source_tx_out.index::smallint
          JOIN tx source_tx 
          ON source_tx_out.tx_id = source_tx.id
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
                            
  from tx
  JOIN hashes
    on hashes.hash = tx.hash
  JOIN block
    on block.id = tx.block_id
  LEFT JOIN pool_metadata_ref 
    on tx.id = pool_metadata_ref.registered_tx_id 
  where 
        block.block_no <= 7000000
        and (
          block.block_no > 0
            or
          
          (block.block_no = 0 and tx.block_index > 15)
        ) 
  order by block.time asc, tx.block_index asc
  limit 500
  ;