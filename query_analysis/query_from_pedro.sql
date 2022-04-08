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
    JOIN block b
      ON tx.block_id = b.id
   WHERE block_no <= 3459224
         and (
          block_no > -1
          or
            (block_no = -1 and tx.block_index > -1)
          )
     AND (address = ANY(('{}')::varchar array)
      OR source_tx_out.payment_cred = ANY(('{\\xe87e42a01b2573f5cad3ffd4c00a1577f4a83bced4e32232ac210359,\\xb57b7d23c5c0e6d8baf4eb9cfdd77eb6a0c036dfd5a114de7e587441,\\xb8ff3a64a000182dc9612400b88c3eef04f8c4ed091b2a485e9573f1,\\x32aad29c5b1461f7e38a4a3719844e35101fa3c2db66b07a414a2693,\\xa6ef596f30702deab861fafe7b21a6e89516ee4eb5747e7957c850c3,\\xfb6d2d198efdb3d24076116fff2ee605f577ab63f1fdfe0eb8ede14b,\\xd899507bde3a7ee733ab3a0cfb71ea202ad8e6e261f241ed4d7d374f,\\x3af5a19ef73b81f1dd01a473247d12061a066a4e9d8d21296fdd42b4,\\x40a72c8fcd6745402ea228ca4eec497d54c89ef45eb04ef7b638c879,\\x38c28930e847db08171354c98fb618058ceeb2ec5befe2362003b4a5,\\x3d5349e2d0873c334d05854a51c228b0f23c93dc37d68ad0c1f24595,\\xda9849abb9acc31846965c35c6732b97d5ab04ad3c9f0babdc8ddfb9,\\x349a16305573790b84fe819bbf5807c211507919740bfde587fe7533,\\x627ac94a87b3f87c2685b34c43592cccc1e0650e8f344d5843166774,\\x5f3d6580f62bf504cbf27e0e77f575ca2dbb9e630ba6357f616315b5,\\x8e8a5720ca914087cc0c457f31197fb6dbd6693883ee99bd90a86c83,\\x936b30f423f1df9f8a9a8d0e7dd7e83b44f0558ff46bdafcd70901a0,\\xca1696e91316a05d5de0c668c41809e049a5d0bb849e7ac7f7d375dd,\\x1dc68df2b19c978a51fb975b734bdfb8b13b61aea308cc4400395159,\\x9fa30a172c187b92430fc0e03daaa0a20f43076f9e09daf38827ad42,\\xd2c145f4c8ed02201e6e529e263c4b33c6ab0201891d37a99e2c7523,\\xc714c0f2baf2b3c2af7aa31dd6f9f1ad07c49e415c38767a39470002,\\x225192786b5cc21d2f6b9060041492dabc467c12a5b34bc72a2522c5,\\x6d89f103d1525d06212cfce1b727b4522b5447408363d4f4c262dc83,\\x72482856aa0edf63e529e649c0d230dff9bcae2900aeba8622dc15ce,\\x859d3202607b718f0ab12a75011f6924e6824a420fe0d3de4f9a437d,\\x5762b3ec6ba7262ab88f9553357cee41a432574e28ca1e2fcb3f7fbd,\\x8bcfc059abe15cd1d900db6e7481a22cee04cc62ea4523a7adab38a1,\\x7d7aa2ac88945a5aff869626f415df0f193b7f966d4ec5b8aaeee8a2,\\x05efc304a07a368aa81a7e91184121068b872279d5f1cb51acf49aed,\\xa08c17478a2250863a06e250857a7a22f719adc2cb52292fae16672e,\\x8f512fa919a800508202643c8614820d56b3e6f424783b924158867e,\\x6eccb84fd897ee111bc3804e98bcd901acfca0daccbcd86838929ea1,\\x47f157335b45b632550e7ced391cee136a499c134f60078392d08ac0,\\x2f3f0fe9cc0dbfd99a6c78dff2ad757c27c6184ce830c622bb18e74d,\\x6ff9e39f6c54d754fb1768ca703d7984233d67e4ea1537eb0e668a0e,\\x84902505b702a2970fafde2afca956a6765d9dc9b9a0d385e1fe1b4c,\\x73f7100e66a05657c321b8a70f1c4998bffb313484316590ee470e57,\\xd6e02231ed9017b940bcca90ece51096452d810351a1e82a5020969d,\\xcd5c3fa6b286a64903892231a8fbf456c0f376a3a8c9b2a038c05454,\\x2eee5afb51387b31ddb78564a25091eb13811691025c4088d2b3ec4a,\\xbe7594204c54e25a622c002be01eb73b04155c39b888e26f47c4af45,\\x61ac44e8cf6d6b5873c62f8f25e06d3201044243f377fdc21fdd8580,\\xf0adbd6bfc25548cdcacca7bd360ce1294be82fbd1d6bf5cac3af9a4,\\x0e55b1eb760a9b3453939e19ecba85e925d4367f4e295014d4da880b,\\x2c83d5cfe147652e7efb1b6ef88e375563448c6251e5932d81bb90fc,\\x41ea88f079ff7970fbf46179f4ea8b703b3a31c8c1fedae95f6e8895,\\x8f70793183e19ab97235e453c3cb2718bc727d94aa6f8d58484bc042,\\x670432831998f15f3e9411b0351e1e1c422bddd0c1f644dbbc0ad125,\\xbd526a57b32bb0be31c1c6f23c9f4cc97fb341130370c28a28b47df4}')::bytea array))),
collateral_transactions as (
  select tx.hash as hash, collateral_tx_in.tx_out_index, collateral_tx_in.id,
     source_tx_out.tx_id source_tx_out_tx_id, source_tx.id source_tx_id,
     source_tx.hash source_tx_hash,
     source_tx_out.id source_tx_out_id,
     source_tx_out.address source_tx_out_address,
     source_tx_out.value source_tx_out_value,
     tx.block_id, tx.fee, tx.valid_contract, tx.script_size, tx.block_index
        FROM tx tx
        JOIN collateral_tx_in
          ON collateral_tx_in.tx_in_id = tx.id
        JOIN tx_out source_tx_out
          ON collateral_tx_in.tx_out_id = source_tx_out.tx_id
         AND collateral_tx_in.tx_out_index = source_tx_out.index
        JOIN tx source_tx
          ON source_tx_out.tx_id = source_tx.id
        JOIN block b
          ON tx.block_id = b.id
       WHERE block_no <= 3459224
    and (
      block_no > -1
      or
        (block_no = -1 and tx.block_index > -1)
      )
  AND (address = ANY(('{}')::varchar array)
  OR source_tx_out.payment_cred = ANY(('{\\xe87e42a01b2573f5cad3ffd4c00a1577f4a83bced4e32232ac210359,\\xb57b7d23c5c0e6d8baf4eb9cfdd77eb6a0c036dfd5a114de7e587441,\\xb8ff3a64a000182dc9612400b88c3eef04f8c4ed091b2a485e9573f1,\\x32aad29c5b1461f7e38a4a3719844e35101fa3c2db66b07a414a2693,\\xa6ef596f30702deab861fafe7b21a6e89516ee4eb5747e7957c850c3,\\xfb6d2d198efdb3d24076116fff2ee605f577ab63f1fdfe0eb8ede14b,\\xd899507bde3a7ee733ab3a0cfb71ea202ad8e6e261f241ed4d7d374f,\\x3af5a19ef73b81f1dd01a473247d12061a066a4e9d8d21296fdd42b4,\\x40a72c8fcd6745402ea228ca4eec497d54c89ef45eb04ef7b638c879,\\x38c28930e847db08171354c98fb618058ceeb2ec5befe2362003b4a5,\\x3d5349e2d0873c334d05854a51c228b0f23c93dc37d68ad0c1f24595,\\xda9849abb9acc31846965c35c6732b97d5ab04ad3c9f0babdc8ddfb9,\\x349a16305573790b84fe819bbf5807c211507919740bfde587fe7533,\\x627ac94a87b3f87c2685b34c43592cccc1e0650e8f344d5843166774,\\x5f3d6580f62bf504cbf27e0e77f575ca2dbb9e630ba6357f616315b5,\\x8e8a5720ca914087cc0c457f31197fb6dbd6693883ee99bd90a86c83,\\x936b30f423f1df9f8a9a8d0e7dd7e83b44f0558ff46bdafcd70901a0,\\xca1696e91316a05d5de0c668c41809e049a5d0bb849e7ac7f7d375dd,\\x1dc68df2b19c978a51fb975b734bdfb8b13b61aea308cc4400395159,\\x9fa30a172c187b92430fc0e03daaa0a20f43076f9e09daf38827ad42,\\xd2c145f4c8ed02201e6e529e263c4b33c6ab0201891d37a99e2c7523,\\xc714c0f2baf2b3c2af7aa31dd6f9f1ad07c49e415c38767a39470002,\\x225192786b5cc21d2f6b9060041492dabc467c12a5b34bc72a2522c5,\\x6d89f103d1525d06212cfce1b727b4522b5447408363d4f4c262dc83,\\x72482856aa0edf63e529e649c0d230dff9bcae2900aeba8622dc15ce,\\x859d3202607b718f0ab12a75011f6924e6824a420fe0d3de4f9a437d,\\x5762b3ec6ba7262ab88f9553357cee41a432574e28ca1e2fcb3f7fbd,\\x8bcfc059abe15cd1d900db6e7481a22cee04cc62ea4523a7adab38a1,\\x7d7aa2ac88945a5aff869626f415df0f193b7f966d4ec5b8aaeee8a2,\\x05efc304a07a368aa81a7e91184121068b872279d5f1cb51acf49aed,\\xa08c17478a2250863a06e250857a7a22f719adc2cb52292fae16672e,\\x8f512fa919a800508202643c8614820d56b3e6f424783b924158867e,\\x6eccb84fd897ee111bc3804e98bcd901acfca0daccbcd86838929ea1,\\x47f157335b45b632550e7ced391cee136a499c134f60078392d08ac0,\\x2f3f0fe9cc0dbfd99a6c78dff2ad757c27c6184ce830c622bb18e74d,\\x6ff9e39f6c54d754fb1768ca703d7984233d67e4ea1537eb0e668a0e,\\x84902505b702a2970fafde2afca956a6765d9dc9b9a0d385e1fe1b4c,\\x73f7100e66a05657c321b8a70f1c4998bffb313484316590ee470e57,\\xd6e02231ed9017b940bcca90ece51096452d810351a1e82a5020969d,\\xcd5c3fa6b286a64903892231a8fbf456c0f376a3a8c9b2a038c05454,\\x2eee5afb51387b31ddb78564a25091eb13811691025c4088d2b3ec4a,\\xbe7594204c54e25a622c002be01eb73b04155c39b888e26f47c4af45,\\x61ac44e8cf6d6b5873c62f8f25e06d3201044243f377fdc21fdd8580,\\xf0adbd6bfc25548cdcacca7bd360ce1294be82fbd1d6bf5cac3af9a4,\\x0e55b1eb760a9b3453939e19ecba85e925d4367f4e295014d4da880b,\\x2c83d5cfe147652e7efb1b6ef88e375563448c6251e5932d81bb90fc,\\x41ea88f079ff7970fbf46179f4ea8b703b3a31c8c1fedae95f6e8895,\\x8f70793183e19ab97235e453c3cb2718bc727d94aa6f8d58484bc042,\\x670432831998f15f3e9411b0351e1e1c422bddd0c1f644dbbc0ad125,\\xbd526a57b32bb0be31c1c6f23c9f4cc97fb341130370c28a28b47df4}')::bytea array))),
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
                      (SELECT array_agg(encode(addr, 'hex')) from UNNEST(('{}')::bytea array) as addr)::varchar array
                    )
                  ) or (
                    certs."formalType" in ('CertRegPool')
                    and certs."poolParamsRewardAccount" = any(
                      (SELECT array_agg(encode(addr, 'hex')) from UNNEST(('{}')::bytea array) as addr)::varchar array
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
        ),
        distinct_transactions AS (
          SELECT DISTINCT tx.id, tx.hash, tx.block_id, tx.fee, tx.valid_contract,
                 tx.script_size, tx.block_index
            FROM transactions tx
           UNION 
          SELECT DISTINCT tx.id, tx.hash, tx.block_id, tx.fee, tx.valid_contract,
                 tx.script_size, tx.block_index
            FROM collateral_transactions tx )
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
                              , inadd_tx.tx_out_index
                              , (select json_agg(ROW(encode("ma"."policy", 'hex'), encode("ma"."name", 'hex'), "quantity"))
                                from ma_tx_out
                                inner join multi_asset ma on ma_tx_out.ident = ma.id
                                WHERE ma_tx_out."tx_out_id" = inadd_tx.source_tx_out_id)
                              ) order by inadd_tx.id asc) as inAddrValPairs
              FROM transactions inadd_tx
              where inadd_tx.hash = tx.hash) as "inAddrValPairs"
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
      FROM hashes
      JOIN distinct_transactions tx
        on hashes.hash = tx.hash
      JOIN block
        on block.id = tx.block_id
      LEFT JOIN pool_metadata_ref
        on tx.id = pool_metadata_ref.registered_tx_id
        order by block_no asc, tx.block_index;