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

CREATE TABLE tx_address (
id BIGSERIAL PRIMARY KEY,
address text,
created TIMESTAMPTZ DEFAULT now());

INSERT INTO tx_address (address)
SELECT DISTINCT address FROM colin_tx_out;

ALTER TABLE colin_tx_out ADD COLUMN tx_address_id BIGINT DEFAULT 0 NOT NULL;


create table colin_add_x_out (
    id bigserial primary key, 
    addr_id bigint references tx_address(id), 
    out_id bigint references colin_tx_out(id));

insert into colin_add_x_out (addr_id, out_id)
  select id, tx_address_id
  FROM colin_tx_out;


UPDATE colin_tx_out 
SET tx_address_id = tx_address.id 
FROM tx_address  	
WHERE tx_address.address = colin_tx_out.address;
-- UPDATE 8881636
-- Time: 570580.183 ms (09:30.580)

# port over FKs from my colin tables to save processing time

CREATE TABLE colin_tx_out_x_in (
id bigserial primary key,
tx_out_id BIGINT REFERENCES tx_out(tx_id),
tx_in_id BIGINT REFERENCES tx_in(id)
tx_index txindex 
);

create index idx_tx_block_id on colin_tx (block_id);

create table colin_tx_join_part (
id                 bigint,
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
 script_size        bigint               not null  ,
 in_id            bigint             not null  ,
 tx_in_id      bigint             not null  ,
 tx_out_id     bigint             not null  ,
 tx_out_index  bigint             not null  ,
 redeemer_id   bigint                       ,
 out_id                  bigint,
 tx_id               bigint              not null  ,
 index               bigint              not null  ,
 address             text                not null  ,
 address_raw         bytea               not null  ,
 address_has_script  boolean             not null  ,
 payment_cred        text                          ,
 stake_address_id    bigint                        ,
 value               text                not null  ,
 data_hash           text,
 source_tx_id                 bigint,
 source_tx_hash               text             not null  ,
 source_tx_block_id           bigint                 not null  ,
 source_tx_block_index        bigint               not null  ,
 source_tx_out_sum            text               not null  ,
 source_tx_fee                text               not null  ,
 source_tx_deposit            bigint                 not null  ,
 source_tx_size               bigint               not null  ,
 source_tx_invalid_before     text                       ,
 source_tx_invalid_hereafter  text                       ,
 source_tx_valid_contract     boolean                not null  ,
 source_tx_script_size        bigint               not null  
) partition by range (block_id);


create index idx_tx_part_block_id on colin_tx_join_part (block_id);

SELECT 'CREATE TABLE colin_tx_join_part_' || generate_series || ' PARTITION OF colin_tx_join_part
    FOR VALUES FROM (' || generate_series-1 || '0000) TO (' || generate_series || '0000);

'
FROM generate_series(1, 1000);

CREATE TABLE colin_tx_join_part_1 PARTITION OF colin_tx_join_part
    FOR VALUES FROM (0) TO (10000);


 CREATE TABLE colin_tx_join_part_2 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (10000) TO (20000);                  
                                                          
 
 CREATE TABLE colin_tx_join_part_3 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (20000) TO (30000);                  
                                                          
 
 CREATE TABLE colin_tx_join_part_4 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (30000) TO (40000);                  
                                                          
 
 CREATE TABLE colin_tx_join_part_5 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (40000) TO (50000);                  
                                                          
 
 CREATE TABLE colin_tx_join_part_6 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (50000) TO (60000);                  
                                                          
 
 CREATE TABLE colin_tx_join_part_7 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (60000) TO (70000);                  
                                                          
 
 CREATE TABLE colin_tx_join_part_8 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (70000) TO (80000);                  
                                                          
 
 CREATE TABLE colin_tx_join_part_9 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (80000) TO (90000);                  
                                                          
 
 CREATE TABLE colin_tx_join_part_10 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (90000) TO (100000);                 
                                                          
 
 CREATE TABLE colin_tx_join_part_11 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (100000) TO (110000);                
                                                          
 
 CREATE TABLE colin_tx_join_part_12 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (110000) TO (120000);                
                                                          
 
 CREATE TABLE colin_tx_join_part_13 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (120000) TO (130000);                
                                                          
 
 CREATE TABLE colin_tx_join_part_14 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (130000) TO (140000);                
                                                          
 
 CREATE TABLE colin_tx_join_part_15 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (140000) TO (150000);                
                                                          
 
 CREATE TABLE colin_tx_join_part_16 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (150000) TO (160000);                
                                                          
 
 CREATE TABLE colin_tx_join_part_17 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (160000) TO (170000);                
                                                          
 
 CREATE TABLE colin_tx_join_part_18 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (170000) TO (180000);                
                                                          
 
 CREATE TABLE colin_tx_join_part_19 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (180000) TO (190000);                
                                                          
 
 CREATE TABLE colin_tx_join_part_20 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (190000) TO (200000);                
                                                          
 
 CREATE TABLE colin_tx_join_part_21 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (200000) TO (210000);                
                                                          
 
 CREATE TABLE colin_tx_join_part_22 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (210000) TO (220000);                
                                                          
 
 CREATE TABLE colin_tx_join_part_23 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (220000) TO (230000);                
                                                          
 
 CREATE TABLE colin_tx_join_part_24 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (230000) TO (240000);                
                                                          
 
 CREATE TABLE colin_tx_join_part_25 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (240000) TO (250000);                
                                                          
 
 CREATE TABLE colin_tx_join_part_26 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (250000) TO (260000);                
                                                          
 CREATE TABLE colin_tx_join_part_27 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (260000) TO (270000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_28 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (270000) TO (280000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_29 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (280000) TO (290000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_30 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (290000) TO (300000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_31 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (300000) TO (310000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_32 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (310000) TO (320000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_33 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (320000) TO (330000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_34 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (330000) TO (340000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_35 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (340000) TO (350000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_36 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (350000) TO (360000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_37 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (360000) TO (370000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_38 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (370000) TO (380000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_39 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (380000) TO (390000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_40 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (390000) TO (400000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_41 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (400000) TO (410000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_42 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (410000) TO (420000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_43 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (420000) TO (430000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_44 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (430000) TO (440000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_45 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (440000) TO (450000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_46 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (450000) TO (460000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_47 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (460000) TO (470000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_48 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (470000) TO (480000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_49 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (480000) TO (490000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_50 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (490000) TO (500000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_51 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (500000) TO (510000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_52 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (510000) TO (520000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_53 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (520000) TO (530000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_54 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (530000) TO (540000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_55 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (540000) TO (550000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_56 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (550000) TO (560000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_57 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (560000) TO (570000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_58 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (570000) TO (580000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_59 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (580000) TO (590000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_60 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (590000) TO (600000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_61 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (600000) TO (610000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_62 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (610000) TO (620000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_63 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (620000) TO (630000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_64 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (630000) TO (640000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_65 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (640000) TO (650000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_66 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (650000) TO (660000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_67 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (660000) TO (670000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_68 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (670000) TO (680000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_69 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (680000) TO (690000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_70 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (690000) TO (700000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_71 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (700000) TO (710000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_72 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (710000) TO (720000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_73 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (720000) TO (730000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_74 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (730000) TO (740000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_75 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (740000) TO (750000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_76 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (750000) TO (760000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_77 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (760000) TO (770000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_78 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (770000) TO (780000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_79 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (780000) TO (790000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_80 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (790000) TO (800000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_81 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (800000) TO (810000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_82 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (810000) TO (820000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_83 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (820000) TO (830000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_84 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (830000) TO (840000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_85 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (840000) TO (850000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_86 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (850000) TO (860000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_87 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (860000) TO (870000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_88 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (870000) TO (880000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_89 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (880000) TO (890000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_90 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (890000) TO (900000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_91 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (900000) TO (910000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_92 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (910000) TO (920000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_93 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (920000) TO (930000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_94 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (930000) TO (940000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_95 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (940000) TO (950000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_96 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (950000) TO (960000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_97 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (960000) TO (970000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_98 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (970000) TO (980000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_99 PARTITION OF colin_tx_join_part  
     FOR VALUES FROM (980000) TO (990000);                 
                                                           
 
 CREATE TABLE colin_tx_join_part_100 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (990000) TO (1000000);                
                                                           
 
 CREATE TABLE colin_tx_join_part_101 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1000000) TO (1010000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_102 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1010000) TO (1020000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_103 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1020000) TO (1030000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_104 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1030000) TO (1040000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_105 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1040000) TO (1050000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_106 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1050000) TO (1060000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_107 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1060000) TO (1070000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_108 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1070000) TO (1080000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_109 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1080000) TO (1090000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_110 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1090000) TO (1100000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_111 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1100000) TO (1110000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_112 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1110000) TO (1120000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_113 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1120000) TO (1130000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_114 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1130000) TO (1140000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_115 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1140000) TO (1150000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_116 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1150000) TO (1160000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_117 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1160000) TO (1170000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_118 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1170000) TO (1180000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_119 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1180000) TO (1190000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_120 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1190000) TO (1200000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_121 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1200000) TO (1210000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_122 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1210000) TO (1220000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_123 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1220000) TO (1230000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_124 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1230000) TO (1240000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_125 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1240000) TO (1250000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_126 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1250000) TO (1260000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_127 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1260000) TO (1270000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_128 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1270000) TO (1280000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_129 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1280000) TO (1290000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_130 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1290000) TO (1300000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_131 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1300000) TO (1310000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_132 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1310000) TO (1320000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_133 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1320000) TO (1330000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_134 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1330000) TO (1340000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_135 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1340000) TO (1350000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_136 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1350000) TO (1360000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_137 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1360000) TO (1370000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_138 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1370000) TO (1380000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_139 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1380000) TO (1390000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_140 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1390000) TO (1400000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_141 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1400000) TO (1410000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_142 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1410000) TO (1420000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_143 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1420000) TO (1430000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_144 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1430000) TO (1440000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_145 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1440000) TO (1450000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_146 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1450000) TO (1460000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_147 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1460000) TO (1470000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_148 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1470000) TO (1480000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_149 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1480000) TO (1490000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_150 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1490000) TO (1500000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_151 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1500000) TO (1510000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_152 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1510000) TO (1520000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_153 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1520000) TO (1530000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_154 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1530000) TO (1540000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_155 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1540000) TO (1550000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_156 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1550000) TO (1560000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_157 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1560000) TO (1570000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_158 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1570000) TO (1580000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_159 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1580000) TO (1590000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_160 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1590000) TO (1600000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_161 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1600000) TO (1610000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_162 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1610000) TO (1620000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_163 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1620000) TO (1630000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_164 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1630000) TO (1640000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_165 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1640000) TO (1650000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_166 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1650000) TO (1660000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_167 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1660000) TO (1670000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_168 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1670000) TO (1680000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_169 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1680000) TO (1690000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_170 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1690000) TO (1700000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_171 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1700000) TO (1710000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_172 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1710000) TO (1720000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_173 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1720000) TO (1730000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_174 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1730000) TO (1740000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_175 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1740000) TO (1750000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_176 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1750000) TO (1760000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_177 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1760000) TO (1770000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_178 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1770000) TO (1780000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_179 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1780000) TO (1790000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_180 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1790000) TO (1800000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_181 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1800000) TO (1810000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_182 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1810000) TO (1820000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_183 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1820000) TO (1830000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_184 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1830000) TO (1840000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_185 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1840000) TO (1850000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_186 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1850000) TO (1860000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_187 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1860000) TO (1870000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_188 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1870000) TO (1880000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_189 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1880000) TO (1890000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_190 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1890000) TO (1900000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_191 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1900000) TO (1910000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_192 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1910000) TO (1920000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_193 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1920000) TO (1930000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_194 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1930000) TO (1940000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_195 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1940000) TO (1950000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_196 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1950000) TO (1960000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_197 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1960000) TO (1970000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_198 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1970000) TO (1980000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_199 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1980000) TO (1990000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_200 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (1990000) TO (2000000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_201 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2000000) TO (2010000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_202 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2010000) TO (2020000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_203 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2020000) TO (2030000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_204 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2030000) TO (2040000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_205 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2040000) TO (2050000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_206 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2050000) TO (2060000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_207 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2060000) TO (2070000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_208 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2070000) TO (2080000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_209 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2080000) TO (2090000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_210 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2090000) TO (2100000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_211 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2100000) TO (2110000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_212 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2110000) TO (2120000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_213 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2120000) TO (2130000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_214 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2130000) TO (2140000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_215 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2140000) TO (2150000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_216 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2150000) TO (2160000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_217 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2160000) TO (2170000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_218 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2170000) TO (2180000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_219 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2180000) TO (2190000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_220 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2190000) TO (2200000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_221 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2200000) TO (2210000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_222 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2210000) TO (2220000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_223 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2220000) TO (2230000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_224 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2230000) TO (2240000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_225 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2240000) TO (2250000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_226 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2250000) TO (2260000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_227 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2260000) TO (2270000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_228 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2270000) TO (2280000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_229 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2280000) TO (2290000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_230 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2290000) TO (2300000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_231 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2300000) TO (2310000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_232 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2310000) TO (2320000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_233 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2320000) TO (2330000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_234 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2330000) TO (2340000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_235 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2340000) TO (2350000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_236 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2350000) TO (2360000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_237 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2360000) TO (2370000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_238 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2370000) TO (2380000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_239 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2380000) TO (2390000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_240 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2390000) TO (2400000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_241 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2400000) TO (2410000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_242 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2410000) TO (2420000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_243 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2420000) TO (2430000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_244 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2430000) TO (2440000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_245 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2440000) TO (2450000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_246 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2450000) TO (2460000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_247 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2460000) TO (2470000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_248 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2470000) TO (2480000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_249 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2480000) TO (2490000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_250 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2490000) TO (2500000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_251 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2500000) TO (2510000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_252 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2510000) TO (2520000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_253 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2520000) TO (2530000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_254 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2530000) TO (2540000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_255 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2540000) TO (2550000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_256 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2550000) TO (2560000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_257 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2560000) TO (2570000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_258 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2570000) TO (2580000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_259 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2580000) TO (2590000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_260 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2590000) TO (2600000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_261 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2600000) TO (2610000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_262 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2610000) TO (2620000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_263 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2620000) TO (2630000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_264 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2630000) TO (2640000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_265 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2640000) TO (2650000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_266 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2650000) TO (2660000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_267 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2660000) TO (2670000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_268 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2670000) TO (2680000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_269 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2680000) TO (2690000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_270 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2690000) TO (2700000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_271 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2700000) TO (2710000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_272 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2710000) TO (2720000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_273 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2720000) TO (2730000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_274 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2730000) TO (2740000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_275 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2740000) TO (2750000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_276 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2750000) TO (2760000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_277 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2760000) TO (2770000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_278 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2770000) TO (2780000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_279 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2780000) TO (2790000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_280 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2790000) TO (2800000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_281 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2800000) TO (2810000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_282 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2810000) TO (2820000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_283 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2820000) TO (2830000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_284 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2830000) TO (2840000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_285 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2840000) TO (2850000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_286 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2850000) TO (2860000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_287 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2860000) TO (2870000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_288 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2870000) TO (2880000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_289 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2880000) TO (2890000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_290 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2890000) TO (2900000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_291 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2900000) TO (2910000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_292 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2910000) TO (2920000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_293 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2920000) TO (2930000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_294 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2930000) TO (2940000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_295 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2940000) TO (2950000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_296 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2950000) TO (2960000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_297 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2960000) TO (2970000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_298 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2970000) TO (2980000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_299 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2980000) TO (2990000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_300 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (2990000) TO (3000000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_301 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3000000) TO (3010000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_302 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3010000) TO (3020000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_303 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3020000) TO (3030000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_304 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3030000) TO (3040000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_305 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3040000) TO (3050000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_306 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3050000) TO (3060000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_307 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3060000) TO (3070000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_308 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3070000) TO (3080000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_309 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3080000) TO (3090000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_310 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3090000) TO (3100000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_311 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3100000) TO (3110000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_312 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3110000) TO (3120000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_313 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3120000) TO (3130000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_314 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3130000) TO (3140000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_315 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3140000) TO (3150000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_316 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3150000) TO (3160000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_317 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3160000) TO (3170000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_318 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3170000) TO (3180000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_319 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3180000) TO (3190000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_320 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3190000) TO (3200000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_321 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3200000) TO (3210000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_322 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3210000) TO (3220000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_323 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3220000) TO (3230000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_324 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3230000) TO (3240000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_325 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3240000) TO (3250000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_326 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3250000) TO (3260000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_327 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3260000) TO (3270000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_328 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3270000) TO (3280000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_329 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3280000) TO (3290000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_330 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3290000) TO (3300000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_331 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3300000) TO (3310000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_332 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3310000) TO (3320000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_333 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3320000) TO (3330000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_334 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3330000) TO (3340000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_335 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3340000) TO (3350000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_336 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3350000) TO (3360000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_337 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3360000) TO (3370000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_338 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3370000) TO (3380000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_339 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3380000) TO (3390000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_340 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3390000) TO (3400000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_341 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3400000) TO (3410000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_342 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3410000) TO (3420000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_343 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3420000) TO (3430000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_344 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3430000) TO (3440000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_345 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3440000) TO (3450000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_346 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3450000) TO (3460000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_347 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3460000) TO (3470000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_348 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3470000) TO (3480000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_349 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3480000) TO (3490000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_350 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3490000) TO (3500000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_351 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3500000) TO (3510000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_352 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3510000) TO (3520000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_353 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3520000) TO (3530000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_354 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3530000) TO (3540000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_355 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3540000) TO (3550000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_356 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3550000) TO (3560000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_357 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3560000) TO (3570000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_358 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3570000) TO (3580000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_359 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3580000) TO (3590000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_360 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3590000) TO (3600000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_361 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3600000) TO (3610000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_362 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3610000) TO (3620000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_363 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3620000) TO (3630000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_364 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3630000) TO (3640000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_365 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3640000) TO (3650000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_366 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3650000) TO (3660000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_367 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3660000) TO (3670000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_368 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3670000) TO (3680000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_369 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3680000) TO (3690000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_370 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3690000) TO (3700000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_371 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3700000) TO (3710000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_372 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3710000) TO (3720000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_373 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3720000) TO (3730000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_374 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3730000) TO (3740000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_375 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3740000) TO (3750000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_376 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3750000) TO (3760000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_377 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3760000) TO (3770000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_378 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3770000) TO (3780000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_379 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3780000) TO (3790000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_380 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3790000) TO (3800000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_381 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3800000) TO (3810000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_382 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3810000) TO (3820000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_383 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3820000) TO (3830000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_384 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3830000) TO (3840000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_385 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3840000) TO (3850000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_386 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3850000) TO (3860000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_387 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3860000) TO (3870000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_388 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3870000) TO (3880000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_389 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3880000) TO (3890000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_390 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3890000) TO (3900000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_391 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3900000) TO (3910000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_392 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3910000) TO (3920000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_393 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3920000) TO (3930000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_394 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3930000) TO (3940000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_395 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3940000) TO (3950000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_396 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3950000) TO (3960000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_397 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3960000) TO (3970000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_398 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3970000) TO (3980000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_399 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3980000) TO (3990000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_400 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (3990000) TO (4000000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_401 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4000000) TO (4010000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_402 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4010000) TO (4020000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_403 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4020000) TO (4030000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_404 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4030000) TO (4040000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_405 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4040000) TO (4050000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_406 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4050000) TO (4060000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_407 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4060000) TO (4070000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_408 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4070000) TO (4080000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_409 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4080000) TO (4090000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_410 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4090000) TO (4100000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_411 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4100000) TO (4110000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_412 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4110000) TO (4120000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_413 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4120000) TO (4130000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_414 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4130000) TO (4140000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_415 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4140000) TO (4150000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_416 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4150000) TO (4160000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_417 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4160000) TO (4170000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_418 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4170000) TO (4180000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_419 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4180000) TO (4190000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_420 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4190000) TO (4200000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_421 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4200000) TO (4210000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_422 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4210000) TO (4220000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_423 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4220000) TO (4230000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_424 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4230000) TO (4240000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_425 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4240000) TO (4250000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_426 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4250000) TO (4260000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_427 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4260000) TO (4270000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_428 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4270000) TO (4280000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_429 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4280000) TO (4290000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_430 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4290000) TO (4300000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_431 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4300000) TO (4310000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_432 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4310000) TO (4320000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_433 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4320000) TO (4330000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_434 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4330000) TO (4340000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_435 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4340000) TO (4350000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_436 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4350000) TO (4360000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_437 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4360000) TO (4370000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_438 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4370000) TO (4380000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_439 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4380000) TO (4390000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_440 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4390000) TO (4400000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_441 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4400000) TO (4410000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_442 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4410000) TO (4420000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_443 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4420000) TO (4430000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_444 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4430000) TO (4440000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_445 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4440000) TO (4450000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_446 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4450000) TO (4460000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_447 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4460000) TO (4470000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_448 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4470000) TO (4480000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_449 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4480000) TO (4490000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_450 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4490000) TO (4500000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_451 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4500000) TO (4510000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_452 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4510000) TO (4520000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_453 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4520000) TO (4530000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_454 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4530000) TO (4540000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_455 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4540000) TO (4550000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_456 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4550000) TO (4560000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_457 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4560000) TO (4570000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_458 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4570000) TO (4580000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_459 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4580000) TO (4590000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_460 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4590000) TO (4600000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_461 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4600000) TO (4610000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_462 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4610000) TO (4620000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_463 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4620000) TO (4630000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_464 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4630000) TO (4640000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_465 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4640000) TO (4650000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_466 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4650000) TO (4660000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_467 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4660000) TO (4670000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_468 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4670000) TO (4680000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_469 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4680000) TO (4690000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_470 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4690000) TO (4700000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_471 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4700000) TO (4710000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_472 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4710000) TO (4720000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_473 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4720000) TO (4730000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_474 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4730000) TO (4740000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_475 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4740000) TO (4750000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_476 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4750000) TO (4760000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_477 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4760000) TO (4770000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_478 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4770000) TO (4780000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_479 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4780000) TO (4790000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_480 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4790000) TO (4800000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_481 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4800000) TO (4810000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_482 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4810000) TO (4820000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_483 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4820000) TO (4830000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_484 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4830000) TO (4840000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_485 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4840000) TO (4850000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_486 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4850000) TO (4860000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_487 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4860000) TO (4870000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_488 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4870000) TO (4880000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_489 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4880000) TO (4890000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_490 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4890000) TO (4900000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_491 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4900000) TO (4910000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_492 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4910000) TO (4920000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_493 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4920000) TO (4930000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_494 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4930000) TO (4940000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_495 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4940000) TO (4950000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_496 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4950000) TO (4960000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_497 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4960000) TO (4970000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_498 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4970000) TO (4980000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_499 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4980000) TO (4990000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_500 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (4990000) TO (5000000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_501 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5000000) TO (5010000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_502 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5010000) TO (5020000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_503 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5020000) TO (5030000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_504 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5030000) TO (5040000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_505 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5040000) TO (5050000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_506 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5050000) TO (5060000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_507 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5060000) TO (5070000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_508 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5070000) TO (5080000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_509 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5080000) TO (5090000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_510 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5090000) TO (5100000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_511 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5100000) TO (5110000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_512 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5110000) TO (5120000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_513 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5120000) TO (5130000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_514 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5130000) TO (5140000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_515 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5140000) TO (5150000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_516 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5150000) TO (5160000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_517 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5160000) TO (5170000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_518 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5170000) TO (5180000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_519 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5180000) TO (5190000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_520 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5190000) TO (5200000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_521 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5200000) TO (5210000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_522 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5210000) TO (5220000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_523 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5220000) TO (5230000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_524 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5230000) TO (5240000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_525 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5240000) TO (5250000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_526 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5250000) TO (5260000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_527 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5260000) TO (5270000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_528 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5270000) TO (5280000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_529 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5280000) TO (5290000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_530 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5290000) TO (5300000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_531 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5300000) TO (5310000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_532 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5310000) TO (5320000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_533 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5320000) TO (5330000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_534 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5330000) TO (5340000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_535 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5340000) TO (5350000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_536 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5350000) TO (5360000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_537 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5360000) TO (5370000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_538 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5370000) TO (5380000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_539 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5380000) TO (5390000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_540 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5390000) TO (5400000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_541 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5400000) TO (5410000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_542 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5410000) TO (5420000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_543 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5420000) TO (5430000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_544 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5430000) TO (5440000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_545 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5440000) TO (5450000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_546 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5450000) TO (5460000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_547 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5460000) TO (5470000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_548 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5470000) TO (5480000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_549 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5480000) TO (5490000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_550 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5490000) TO (5500000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_551 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5500000) TO (5510000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_552 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5510000) TO (5520000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_553 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5520000) TO (5530000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_554 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5530000) TO (5540000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_555 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5540000) TO (5550000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_556 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5550000) TO (5560000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_557 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5560000) TO (5570000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_558 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5570000) TO (5580000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_559 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5580000) TO (5590000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_560 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5590000) TO (5600000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_561 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5600000) TO (5610000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_562 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5610000) TO (5620000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_563 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5620000) TO (5630000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_564 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5630000) TO (5640000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_565 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5640000) TO (5650000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_566 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5650000) TO (5660000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_567 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5660000) TO (5670000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_568 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5670000) TO (5680000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_569 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5680000) TO (5690000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_570 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5690000) TO (5700000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_571 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5700000) TO (5710000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_572 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5710000) TO (5720000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_573 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5720000) TO (5730000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_574 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5730000) TO (5740000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_575 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5740000) TO (5750000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_576 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5750000) TO (5760000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_577 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5760000) TO (5770000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_578 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5770000) TO (5780000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_579 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5780000) TO (5790000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_580 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5790000) TO (5800000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_581 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5800000) TO (5810000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_582 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5810000) TO (5820000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_583 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5820000) TO (5830000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_584 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5830000) TO (5840000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_585 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5840000) TO (5850000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_586 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5850000) TO (5860000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_587 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5860000) TO (5870000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_588 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5870000) TO (5880000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_589 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5880000) TO (5890000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_590 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5890000) TO (5900000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_591 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5900000) TO (5910000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_592 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5910000) TO (5920000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_593 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5920000) TO (5930000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_594 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5930000) TO (5940000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_595 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5940000) TO (5950000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_596 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5950000) TO (5960000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_597 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5960000) TO (5970000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_598 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5970000) TO (5980000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_599 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5980000) TO (5990000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_600 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (5990000) TO (6000000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_601 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6000000) TO (6010000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_602 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6010000) TO (6020000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_603 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6020000) TO (6030000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_604 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6030000) TO (6040000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_605 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6040000) TO (6050000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_606 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6050000) TO (6060000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_607 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6060000) TO (6070000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_608 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6070000) TO (6080000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_609 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6080000) TO (6090000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_610 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6090000) TO (6100000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_611 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6100000) TO (6110000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_612 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6110000) TO (6120000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_613 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6120000) TO (6130000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_614 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6130000) TO (6140000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_615 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6140000) TO (6150000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_616 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6150000) TO (6160000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_617 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6160000) TO (6170000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_618 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6170000) TO (6180000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_619 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6180000) TO (6190000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_620 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6190000) TO (6200000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_621 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6200000) TO (6210000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_622 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6210000) TO (6220000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_623 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6220000) TO (6230000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_624 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6230000) TO (6240000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_625 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6240000) TO (6250000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_626 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6250000) TO (6260000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_627 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6260000) TO (6270000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_628 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6270000) TO (6280000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_629 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6280000) TO (6290000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_630 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6290000) TO (6300000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_631 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6300000) TO (6310000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_632 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6310000) TO (6320000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_633 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6320000) TO (6330000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_634 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6330000) TO (6340000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_635 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6340000) TO (6350000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_636 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6350000) TO (6360000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_637 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6360000) TO (6370000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_638 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6370000) TO (6380000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_639 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6380000) TO (6390000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_640 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6390000) TO (6400000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_641 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6400000) TO (6410000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_642 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6410000) TO (6420000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_643 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6420000) TO (6430000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_644 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6430000) TO (6440000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_645 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6440000) TO (6450000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_646 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6450000) TO (6460000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_647 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6460000) TO (6470000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_648 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6470000) TO (6480000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_649 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6480000) TO (6490000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_650 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6490000) TO (6500000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_651 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6500000) TO (6510000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_652 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6510000) TO (6520000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_653 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6520000) TO (6530000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_654 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6530000) TO (6540000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_655 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6540000) TO (6550000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_656 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6550000) TO (6560000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_657 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6560000) TO (6570000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_658 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6570000) TO (6580000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_659 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6580000) TO (6590000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_660 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6590000) TO (6600000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_661 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6600000) TO (6610000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_662 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6610000) TO (6620000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_663 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6620000) TO (6630000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_664 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6630000) TO (6640000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_665 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6640000) TO (6650000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_666 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6650000) TO (6660000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_667 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6660000) TO (6670000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_668 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6670000) TO (6680000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_669 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6680000) TO (6690000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_670 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6690000) TO (6700000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_671 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6700000) TO (6710000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_672 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6710000) TO (6720000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_673 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6720000) TO (6730000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_674 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6730000) TO (6740000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_675 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6740000) TO (6750000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_676 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6750000) TO (6760000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_677 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6760000) TO (6770000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_678 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6770000) TO (6780000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_679 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6780000) TO (6790000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_680 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6790000) TO (6800000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_681 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6800000) TO (6810000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_682 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6810000) TO (6820000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_683 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6820000) TO (6830000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_684 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6830000) TO (6840000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_685 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6840000) TO (6850000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_686 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6850000) TO (6860000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_687 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6860000) TO (6870000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_688 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6870000) TO (6880000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_689 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6880000) TO (6890000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_690 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6890000) TO (6900000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_691 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6900000) TO (6910000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_692 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6910000) TO (6920000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_693 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6920000) TO (6930000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_694 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6930000) TO (6940000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_695 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6940000) TO (6950000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_696 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6950000) TO (6960000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_697 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6960000) TO (6970000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_698 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6970000) TO (6980000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_699 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6980000) TO (6990000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_700 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (6990000) TO (7000000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_701 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7000000) TO (7010000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_702 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7010000) TO (7020000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_703 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7020000) TO (7030000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_704 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7030000) TO (7040000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_705 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7040000) TO (7050000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_706 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7050000) TO (7060000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_707 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7060000) TO (7070000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_708 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7070000) TO (7080000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_709 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7080000) TO (7090000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_710 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7090000) TO (7100000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_711 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7100000) TO (7110000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_712 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7110000) TO (7120000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_713 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7120000) TO (7130000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_714 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7130000) TO (7140000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_715 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7140000) TO (7150000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_716 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7150000) TO (7160000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_717 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7160000) TO (7170000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_718 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7170000) TO (7180000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_719 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7180000) TO (7190000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_720 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7190000) TO (7200000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_721 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7200000) TO (7210000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_722 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7210000) TO (7220000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_723 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7220000) TO (7230000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_724 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7230000) TO (7240000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_725 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7240000) TO (7250000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_726 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7250000) TO (7260000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_727 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7260000) TO (7270000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_728 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7270000) TO (7280000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_729 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7280000) TO (7290000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_730 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7290000) TO (7300000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_731 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7300000) TO (7310000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_732 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7310000) TO (7320000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_733 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7320000) TO (7330000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_734 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7330000) TO (7340000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_735 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7340000) TO (7350000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_736 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7350000) TO (7360000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_737 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7360000) TO (7370000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_738 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7370000) TO (7380000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_739 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7380000) TO (7390000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_740 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7390000) TO (7400000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_741 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7400000) TO (7410000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_742 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7410000) TO (7420000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_743 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7420000) TO (7430000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_744 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7430000) TO (7440000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_745 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7440000) TO (7450000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_746 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7450000) TO (7460000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_747 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7460000) TO (7470000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_748 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7470000) TO (7480000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_749 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7480000) TO (7490000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_750 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7490000) TO (7500000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_751 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7500000) TO (7510000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_752 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7510000) TO (7520000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_753 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7520000) TO (7530000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_754 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7530000) TO (7540000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_755 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7540000) TO (7550000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_756 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7550000) TO (7560000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_757 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7560000) TO (7570000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_758 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7570000) TO (7580000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_759 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7580000) TO (7590000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_760 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7590000) TO (7600000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_761 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7600000) TO (7610000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_762 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7610000) TO (7620000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_763 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7620000) TO (7630000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_764 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7630000) TO (7640000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_765 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7640000) TO (7650000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_766 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7650000) TO (7660000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_767 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7660000) TO (7670000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_768 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7670000) TO (7680000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_769 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7680000) TO (7690000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_770 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7690000) TO (7700000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_771 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7700000) TO (7710000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_772 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7710000) TO (7720000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_773 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7720000) TO (7730000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_774 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7730000) TO (7740000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_775 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7740000) TO (7750000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_776 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7750000) TO (7760000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_777 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7760000) TO (7770000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_778 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7770000) TO (7780000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_779 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7780000) TO (7790000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_780 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7790000) TO (7800000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_781 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7800000) TO (7810000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_782 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7810000) TO (7820000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_783 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7820000) TO (7830000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_784 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7830000) TO (7840000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_785 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7840000) TO (7850000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_786 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7850000) TO (7860000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_787 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7860000) TO (7870000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_788 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7870000) TO (7880000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_789 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7880000) TO (7890000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_790 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7890000) TO (7900000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_791 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7900000) TO (7910000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_792 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7910000) TO (7920000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_793 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7920000) TO (7930000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_794 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7930000) TO (7940000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_795 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7940000) TO (7950000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_796 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7950000) TO (7960000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_797 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7960000) TO (7970000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_798 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7970000) TO (7980000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_799 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7980000) TO (7990000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_800 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (7990000) TO (8000000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_801 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8000000) TO (8010000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_802 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8010000) TO (8020000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_803 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8020000) TO (8030000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_804 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8030000) TO (8040000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_805 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8040000) TO (8050000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_806 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8050000) TO (8060000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_807 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8060000) TO (8070000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_808 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8070000) TO (8080000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_809 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8080000) TO (8090000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_810 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8090000) TO (8100000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_811 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8100000) TO (8110000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_812 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8110000) TO (8120000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_813 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8120000) TO (8130000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_814 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8130000) TO (8140000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_815 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8140000) TO (8150000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_816 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8150000) TO (8160000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_817 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8160000) TO (8170000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_818 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8170000) TO (8180000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_819 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8180000) TO (8190000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_820 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8190000) TO (8200000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_821 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8200000) TO (8210000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_822 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8210000) TO (8220000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_823 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8220000) TO (8230000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_824 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8230000) TO (8240000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_825 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8240000) TO (8250000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_826 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8250000) TO (8260000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_827 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8260000) TO (8270000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_828 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8270000) TO (8280000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_829 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8280000) TO (8290000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_830 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8290000) TO (8300000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_831 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8300000) TO (8310000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_832 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8310000) TO (8320000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_833 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8320000) TO (8330000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_834 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8330000) TO (8340000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_835 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8340000) TO (8350000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_836 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8350000) TO (8360000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_837 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8360000) TO (8370000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_838 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8370000) TO (8380000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_839 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8380000) TO (8390000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_840 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8390000) TO (8400000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_841 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8400000) TO (8410000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_842 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8410000) TO (8420000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_843 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8420000) TO (8430000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_844 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8430000) TO (8440000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_845 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8440000) TO (8450000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_846 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8450000) TO (8460000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_847 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8460000) TO (8470000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_848 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8470000) TO (8480000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_849 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8480000) TO (8490000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_850 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8490000) TO (8500000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_851 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8500000) TO (8510000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_852 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8510000) TO (8520000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_853 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8520000) TO (8530000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_854 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8530000) TO (8540000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_855 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8540000) TO (8550000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_856 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8550000) TO (8560000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_857 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8560000) TO (8570000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_858 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8570000) TO (8580000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_859 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8580000) TO (8590000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_860 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8590000) TO (8600000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_861 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8600000) TO (8610000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_862 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8610000) TO (8620000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_863 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8620000) TO (8630000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_864 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8630000) TO (8640000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_865 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8640000) TO (8650000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_866 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8650000) TO (8660000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_867 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8660000) TO (8670000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_868 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8670000) TO (8680000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_869 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8680000) TO (8690000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_870 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8690000) TO (8700000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_871 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8700000) TO (8710000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_872 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8710000) TO (8720000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_873 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8720000) TO (8730000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_874 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8730000) TO (8740000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_875 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8740000) TO (8750000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_876 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8750000) TO (8760000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_877 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8760000) TO (8770000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_878 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8770000) TO (8780000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_879 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8780000) TO (8790000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_880 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8790000) TO (8800000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_881 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8800000) TO (8810000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_882 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8810000) TO (8820000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_883 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8820000) TO (8830000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_884 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8830000) TO (8840000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_885 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8840000) TO (8850000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_886 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8850000) TO (8860000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_887 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8860000) TO (8870000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_888 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8870000) TO (8880000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_889 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8880000) TO (8890000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_890 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8890000) TO (8900000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_891 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8900000) TO (8910000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_892 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8910000) TO (8920000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_893 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8920000) TO (8930000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_894 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8930000) TO (8940000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_895 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8940000) TO (8950000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_896 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8950000) TO (8960000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_897 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8960000) TO (8970000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_898 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8970000) TO (8980000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_899 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8980000) TO (8990000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_900 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (8990000) TO (9000000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_901 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9000000) TO (9010000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_902 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9010000) TO (9020000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_903 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9020000) TO (9030000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_904 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9030000) TO (9040000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_905 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9040000) TO (9050000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_906 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9050000) TO (9060000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_907 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9060000) TO (9070000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_908 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9070000) TO (9080000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_909 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9080000) TO (9090000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_910 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9090000) TO (9100000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_911 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9100000) TO (9110000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_912 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9110000) TO (9120000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_913 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9120000) TO (9130000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_914 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9130000) TO (9140000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_915 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9140000) TO (9150000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_916 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9150000) TO (9160000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_917 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9160000) TO (9170000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_918 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9170000) TO (9180000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_919 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9180000) TO (9190000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_920 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9190000) TO (9200000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_921 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9200000) TO (9210000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_922 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9210000) TO (9220000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_923 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9220000) TO (9230000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_924 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9230000) TO (9240000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_925 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9240000) TO (9250000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_926 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9250000) TO (9260000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_927 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9260000) TO (9270000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_928 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9270000) TO (9280000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_929 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9280000) TO (9290000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_930 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9290000) TO (9300000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_931 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9300000) TO (9310000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_932 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9310000) TO (9320000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_933 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9320000) TO (9330000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_934 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9330000) TO (9340000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_935 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9340000) TO (9350000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_936 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9350000) TO (9360000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_937 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9360000) TO (9370000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_938 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9370000) TO (9380000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_939 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9380000) TO (9390000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_940 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9390000) TO (9400000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_941 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9400000) TO (9410000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_942 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9410000) TO (9420000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_943 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9420000) TO (9430000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_944 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9430000) TO (9440000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_945 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9440000) TO (9450000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_946 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9450000) TO (9460000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_947 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9460000) TO (9470000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_948 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9470000) TO (9480000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_949 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9480000) TO (9490000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_950 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9490000) TO (9500000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_951 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9500000) TO (9510000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_952 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9510000) TO (9520000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_953 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9520000) TO (9530000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_954 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9530000) TO (9540000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_955 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9540000) TO (9550000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_956 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9550000) TO (9560000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_957 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9560000) TO (9570000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_958 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9570000) TO (9580000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_959 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9580000) TO (9590000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_960 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9590000) TO (9600000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_961 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9600000) TO (9610000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_962 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9610000) TO (9620000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_963 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9620000) TO (9630000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_964 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9630000) TO (9640000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_965 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9640000) TO (9650000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_966 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9650000) TO (9660000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_967 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9660000) TO (9670000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_968 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9670000) TO (9680000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_969 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9680000) TO (9690000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_970 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9690000) TO (9700000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_971 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9700000) TO (9710000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_972 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9710000) TO (9720000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_973 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9720000) TO (9730000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_974 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9730000) TO (9740000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_975 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9740000) TO (9750000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_976 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9750000) TO (9760000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_977 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9760000) TO (9770000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_978 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9770000) TO (9780000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_979 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9780000) TO (9790000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_980 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9790000) TO (9800000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_981 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9800000) TO (9810000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_982 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9810000) TO (9820000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_983 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9820000) TO (9830000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_984 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9830000) TO (9840000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_985 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9840000) TO (9850000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_986 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9850000) TO (9860000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_987 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9860000) TO (9870000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_988 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9870000) TO (9880000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_989 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9880000) TO (9890000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_990 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9890000) TO (9900000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_991 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9900000) TO (9910000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_992 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9910000) TO (9920000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_993 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9920000) TO (9930000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_994 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9930000) TO (9940000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_995 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9940000) TO (9950000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_996 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9950000) TO (9960000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_997 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9960000) TO (9970000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_998 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9970000) TO (9980000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_999 PARTITION OF colin_tx_join_part 
     FOR VALUES FROM (9980000) TO (9990000);               
                                                           
 
 CREATE TABLE colin_tx_join_part_1000 PARTITION OF colin_tx_join_part
     FOR VALUES FROM (9990000) TO (10000000);              
                                                           
insert into colin_tx_join_part 
SELECT tx.id, tx.hash , tx.block_id , tx.block_index , tx.out_sum , tx.fee , tx.deposit , 
       tx.size , tx.invalid_before , tx.invalid_hereafter , tx.valid_contract , 
       tx.script_size , tx_in.id , tx_in_id , tx_out_id , tx_out_index , 
       redeemer_id , source_tx_out.id , tx_id , index , address , address_raw , 
       address_has_script , payment_cred , stake_address_id , value , 
       data_hash,source_tx.id, source_tx.hash , source_tx.block_id , source_tx.block_index , source_tx.out_sum , source_tx.fee , source_tx.deposit , 
       source_tx.size , source_tx.invalid_before , source_tx.invalid_hereafter , source_tx.valid_contract , 
       source_tx.script_size
  FROM colin_tx tx
  JOIN colin_tx_in tx_in
    ON tx_in.tx_in_id = tx.id
  JOIN colin_tx_out source_tx_out 
    ON tx_in.tx_out_id = source_tx_out.tx_id 
   AND tx_in.tx_out_index::smallint = source_tx_out.index::smallint
  JOIN colin_tx source_tx 
    ON source_tx_out.tx_id = source_tx.id;
