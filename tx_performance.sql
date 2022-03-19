create table colin_tx_out (
 id                  bigserial primary key,
 tx_id               bigint                        not null  ,
 index               bigint                        not null  ,
 address             text             not null  ,
 address_raw         bytea                         not null  ,
 address_has_script  boolean                       not null  ,
 payment_cred        text                              ,
 stake_address_id    bigint                                  ,
 value               text                      not null  ,
 data_hash           text                              
);

create table colin_tx (
id                 bigserial primary key,
 hash               text             not null  ,
 block_id           bigint                 not null  ,
 block_index        bigint               not null  ,
 out_sum            text               not null  ,
 fee                text               not null  ,
 deposit            bigint                 not null  ,
 size               bigint               not null  ,
 invalid_before     text                       ,
 invalid_hereafter  text                       ,
 valid_contract     boolean                not null  ,
 script_size        bigint               not null  
);

CREATE TABLE colin_tx_in (
 id            bigserial primary key,
 tx_in_id      bigint              not null,  
 tx_out_id     bigint              not null,  
 tx_out_index  text             not null,  
 redeemer_id   bigint                       
 );

insert into colin_tx_out
select * from tx_out;

insert into colin_tx
select * from tx;

insert into colin_tx_in
select * from tx_in;

create table colin_add_x_out (
    id bigserial primary key, 
    addr_id bigint references tx_address(id), 
    out_id bigint references colin_tx_out(id));

insert into colin_add_x_out (addr_id, out_id)
  select id, tx_address_id
  FROM colin_tx_out;

-- CREATE TABLE colin_tx_out_x_in (
-- id bigserial primary key,
-- tx_out_id BIGINT REFERENCES tx_out(tx_id),
-- tx_in_id BIGINT REFERENCES tx_in(id)
-- tx_index txindex 
-- );
