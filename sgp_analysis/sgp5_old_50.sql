https://explain.depesz.com/s/Cmag#html
Time: 3046.997 ms (00:03.047)
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
     WHERE (source_tx_out.address = ANY(('{"addr1qxsnezdjclcc03e5znpt470n405l9ryczupedg6e7h84gz94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqvrydcj",
"addr1q8vxu0jgdruwameanq7sfnc7yuxpjgy7scnqfcd2x85al894nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqfh7w8s",
"addr1q95l7l43az9d9rhwcksa36pqzj3judes8dknjxmqar6wtd94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqafvn73",
"addr1q9hkynau373740gp4rtn6nj9qrt9uywxg46n000sg52mxu94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqe85dx8",
"addr1q9pk2zc5mrxemc8m37rn2zswwr844gtq7yve2gmg2s35ec94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqvem75m",
"addr1q8uc659kgcvfx8twe5lxntju6dqe2r4wxzl2epk9pwgfnka4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqc83gj6",
"addr1qyn9m2mfw9kapmg7s49ff673eh4l55uupnm4urzh8lgrka94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqvvyvvu",
"addr1q8d9a8lr4znw83skve0vre8ztyay76uyuejdt2cw4d263vd4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqkte066",
"addr1qxeh99lwfcugq3cqzkuljcw4ypxk25wxpnvx26tw7yjr2kd4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqd6ws59",
"addr1qxerm5wsjjg2g72ndl0r7dne0mcvfpj4sr8ngtuyusfyjpa4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqr7xnht",
"addr1q8nfdz95zh42n23p84kjegtyajaycvap4yszurv4mk4fam44nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqzhz8t3",
"addr1qyf36d7txczxy6hgejf89m75dgv07q9gdaycc33nxm4urv44nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nql2y9l3",
"addr1qyxhzewq7ltfchtklgzlwjujzsut44l5uv77vrxnf6aqtt44nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqegyr4t",
"addr1q949xunlrg6uruhtdxrdrwuupzmlvlkcplp2p495j6jwmwd4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqnamrgn",
"addr1qysmx2lr93atq0fdshvktallgpahp9ew8aesynvnekl4u444nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq6pq8l5",
"addr1q87j3zsujdmfzugp69dnhu9ucu8xh7gl9p52q09jaep44s94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq2dmsj3",
"addr1qxyax8mj5zg5zkl40rfn6svt46k0hs6vfssrcll9v0es5j94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq3rvdat",
"addr1q85pwfjhw67k2ku3czyshx0squzwhart6ruwae2jmhl682a4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq7kf4wu",
"addr1q9fp0tm3kcccql5ukevy2ac66mj5nl4te65n3cpcxpa6c8a4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq0vdp72",
"addr1q8gxhyxxpye48gzvz7afsr3h3eu3a92gt3haga4jj8f3j744nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqayjnfr",
"addr1qxnag3m68960939ypl0f6wspqad28v3c39tv3vavrep74a94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq6dx4fy",
"addr1qytz04axfrf6zrmgvrcd29pljmnqe9sjvndacgnkmx4m9744nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqa7yeq0",
"addr1qxmv8ktpr4znzpfqg6sh9fle9dkt9k6vjrzasezl047p5c44nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqeppf4z",
"addr1qxzj50tlwrfwn8pa42rvhrpz4d9wrhn9e25e5azrlzvn7wa4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq8r4fd6",
"addr1qxm5ztq4syz77crfvmlnlca2afgqgch7a28gs5lf99fyde44nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq4d4kqz",
"addr1qxh2fgs9cnph4kw0g2l6gslwy0l2k5etsv2zll8u7sf8jja4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqqmpgny",
"addr1q8zdnjg6jg0p9atttdgrpg2s3ewx6d46xuvqpravwjsyrh94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqudwlle",
"addr1qxswj5l920ph6v9qcwn5as7qafk2wskw0gdnuu2vyu2kp744nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nquwaguf",
"addr1qx9h7s4m57rzvnyljzzpsm2cz5ug6aszu3rwc9lyes4qcpd4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqvtlqnp",
"addr1qxs7e79vvg4p4jnnz2r9xq8kh2dzc85ggxnd37n3w8zdjx94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq4r3g6s",
"addr1q8hzxsrmutj0ke6mvrjdp0azz9rr2u9cy6ey859ce2gvg8a4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqkctnpj",
"addr1qy2p3gnc7s888jfqtsl9zvpytxymhxfn7ywg5racsrplee44nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqp6ns0e",
"addr1q9c3jkc5xd5hxq8x2sa4qqhpng4f0lkl4hr3lyumv9td9ed4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqzskc7a",
"addr1q859w8r9dgavkfnd40m2q9vna5qpkmdrqdrr9cndz6v6gpa4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqsrvu72",
"addr1q9lday0y6zpmwdu3tm7y88hrgvtnahumxmy5l3x004rtll44nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq4hyqd6",
"addr1qx78r8x5nf9nh3373vq5nda293clhgwuj85kddnfzq6cwea4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqjz76gs",
"addr1qyrawk5flmqgxa4j77eyl768xepjyhhsy8a6kzn7y8xxws44nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqllqy6c",
"addr1qxaqpduhle7pjc4g23j8eadsycvjyte94tz68fppkz77j094nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqcpl23j",
"addr1qxms8438ezujd5qywg6du5j53qnsxk8s8flapdmvthvqxu94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqznpj69",
"addr1q84ddrd9y5p3f82pwpws6epxqu5ulf4zc9n8vr5fdzxkx2d4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq72dppl",
"addr1qypflz22wcj8mf5l4a944w66qvgwjecyeysstexc0nzuvt44nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq6mthdf",
"addr1q84f55qx0xd86vn9lg7vf0nk56kf3chnv77mltuurjw4rs94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqlsaqsu",
"addr1qxv3tzhfmetgc5mjrcp6dwe6stnyhn8scn9ajppvswsdar44nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqw8d0wx",
"addr1qyf73smgcvxvctdxwsp563ky5dw6aaeuhpzagvrtskv7rj94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq7x7nla",
"addr1qxx8ykdmmjt6accck8sfdvwcgn8eu0c7c4apq6dmwjy29r44nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq6azcfx",
"addr1qyj2m02kjp4jz7k9k7eycyje0ncqxmacpas7nf39xjc8v344nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqmh5fsw",
"addr1q9667j9898zw3hcl20h8y95dw9673wjxeqzkfh9l42pq7k94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqpnm0pz",
"addr1qxd5636dwq2t5yra45gp7yzumyln8jlypndunw28jfqs9m94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqgp06cf",
"addr1q9sz77pq475l63rr8n3r8cqt3gyfu6y5alg6nr9cxl5c5p44nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqcv674s",
"addr1q8gcehel7ydapqmexkkvptk54hgjr3qp5h5uu6s3p4lr3wa4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq5yum09",
"addr1q937mcs7zqf0r36l6hst43avns4jxh4wuu9deu4cx4q8fwd4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqs4nmwl",
"addr1qy55hc9r8wwt3s65re7yyzeudt5ysh0vlclwsa668dljt444nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqhyfkpj"}')::varchar array)
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
     WHERE (source_tx_out.address = ANY(('{"addr1qxsnezdjclcc03e5znpt470n405l9ryczupedg6e7h84gz94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqvrydcj",
"addr1q8vxu0jgdruwameanq7sfnc7yuxpjgy7scnqfcd2x85al894nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqfh7w8s",
"addr1q95l7l43az9d9rhwcksa36pqzj3judes8dknjxmqar6wtd94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqafvn73",
"addr1q9hkynau373740gp4rtn6nj9qrt9uywxg46n000sg52mxu94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqe85dx8",
"addr1q9pk2zc5mrxemc8m37rn2zswwr844gtq7yve2gmg2s35ec94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqvem75m",
"addr1q8uc659kgcvfx8twe5lxntju6dqe2r4wxzl2epk9pwgfnka4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqc83gj6",
"addr1qyn9m2mfw9kapmg7s49ff673eh4l55uupnm4urzh8lgrka94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqvvyvvu",
"addr1q8d9a8lr4znw83skve0vre8ztyay76uyuejdt2cw4d263vd4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqkte066",
"addr1qxeh99lwfcugq3cqzkuljcw4ypxk25wxpnvx26tw7yjr2kd4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqd6ws59",
"addr1qxerm5wsjjg2g72ndl0r7dne0mcvfpj4sr8ngtuyusfyjpa4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqr7xnht",
"addr1q8nfdz95zh42n23p84kjegtyajaycvap4yszurv4mk4fam44nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqzhz8t3",
"addr1qyf36d7txczxy6hgejf89m75dgv07q9gdaycc33nxm4urv44nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nql2y9l3",
"addr1qyxhzewq7ltfchtklgzlwjujzsut44l5uv77vrxnf6aqtt44nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqegyr4t",
"addr1q949xunlrg6uruhtdxrdrwuupzmlvlkcplp2p495j6jwmwd4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqnamrgn",
"addr1qysmx2lr93atq0fdshvktallgpahp9ew8aesynvnekl4u444nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq6pq8l5",
"addr1q87j3zsujdmfzugp69dnhu9ucu8xh7gl9p52q09jaep44s94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq2dmsj3",
"addr1qxyax8mj5zg5zkl40rfn6svt46k0hs6vfssrcll9v0es5j94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq3rvdat",
"addr1q85pwfjhw67k2ku3czyshx0squzwhart6ruwae2jmhl682a4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq7kf4wu",
"addr1q9fp0tm3kcccql5ukevy2ac66mj5nl4te65n3cpcxpa6c8a4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq0vdp72",
"addr1q8gxhyxxpye48gzvz7afsr3h3eu3a92gt3haga4jj8f3j744nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqayjnfr",
"addr1qxnag3m68960939ypl0f6wspqad28v3c39tv3vavrep74a94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq6dx4fy",
"addr1qytz04axfrf6zrmgvrcd29pljmnqe9sjvndacgnkmx4m9744nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqa7yeq0",
"addr1qxmv8ktpr4znzpfqg6sh9fle9dkt9k6vjrzasezl047p5c44nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqeppf4z",
"addr1qxzj50tlwrfwn8pa42rvhrpz4d9wrhn9e25e5azrlzvn7wa4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq8r4fd6",
"addr1qxm5ztq4syz77crfvmlnlca2afgqgch7a28gs5lf99fyde44nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq4d4kqz",
"addr1qxh2fgs9cnph4kw0g2l6gslwy0l2k5etsv2zll8u7sf8jja4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqqmpgny",
"addr1q8zdnjg6jg0p9atttdgrpg2s3ewx6d46xuvqpravwjsyrh94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqudwlle",
"addr1qxswj5l920ph6v9qcwn5as7qafk2wskw0gdnuu2vyu2kp744nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nquwaguf",
"addr1qx9h7s4m57rzvnyljzzpsm2cz5ug6aszu3rwc9lyes4qcpd4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqvtlqnp",
"addr1qxs7e79vvg4p4jnnz2r9xq8kh2dzc85ggxnd37n3w8zdjx94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq4r3g6s",
"addr1q8hzxsrmutj0ke6mvrjdp0azz9rr2u9cy6ey859ce2gvg8a4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqkctnpj",
"addr1qy2p3gnc7s888jfqtsl9zvpytxymhxfn7ywg5racsrplee44nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqp6ns0e",
"addr1q9c3jkc5xd5hxq8x2sa4qqhpng4f0lkl4hr3lyumv9td9ed4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqzskc7a",
"addr1q859w8r9dgavkfnd40m2q9vna5qpkmdrqdrr9cndz6v6gpa4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqsrvu72",
"addr1q9lday0y6zpmwdu3tm7y88hrgvtnahumxmy5l3x004rtll44nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq4hyqd6",
"addr1qx78r8x5nf9nh3373vq5nda293clhgwuj85kddnfzq6cwea4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqjz76gs",
"addr1qyrawk5flmqgxa4j77eyl768xepjyhhsy8a6kzn7y8xxws44nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqllqy6c",
"addr1qxaqpduhle7pjc4g23j8eadsycvjyte94tz68fppkz77j094nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqcpl23j",
"addr1qxms8438ezujd5qywg6du5j53qnsxk8s8flapdmvthvqxu94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqznpj69",
"addr1q84ddrd9y5p3f82pwpws6epxqu5ulf4zc9n8vr5fdzxkx2d4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq72dppl",
"addr1qypflz22wcj8mf5l4a944w66qvgwjecyeysstexc0nzuvt44nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq6mthdf",
"addr1q84f55qx0xd86vn9lg7vf0nk56kf3chnv77mltuurjw4rs94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqlsaqsu",
"addr1qxv3tzhfmetgc5mjrcp6dwe6stnyhn8scn9ajppvswsdar44nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqw8d0wx",
"addr1qyf73smgcvxvctdxwsp563ky5dw6aaeuhpzagvrtskv7rj94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq7x7nla",
"addr1qxx8ykdmmjt6accck8sfdvwcgn8eu0c7c4apq6dmwjy29r44nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq6azcfx",
"addr1qyj2m02kjp4jz7k9k7eycyje0ncqxmacpas7nf39xjc8v344nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqmh5fsw",
"addr1q9667j9898zw3hcl20h8y95dw9673wjxeqzkfh9l42pq7k94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqpnm0pz",
"addr1qxd5636dwq2t5yra45gp7yzumyln8jlypndunw28jfqs9m94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqgp06cf",
"addr1q9sz77pq475l63rr8n3r8cqt3gyfu6y5alg6nr9cxl5c5p44nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqcv674s",
"addr1q8gcehel7ydapqmexkkvptk54hgjr3qp5h5uu6s3p4lr3wa4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq5yum09",
"addr1q937mcs7zqf0r36l6hst43avns4jxh4wuu9deu4cx4q8fwd4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqs4nmwl",
"addr1qy55hc9r8wwt3s65re7yyzeudt5ysh0vlclwsa668dljt444nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqhyfkpj"}')::varchar array)
     OR source_tx_out.payment_cred = ANY(('{}')::bytea array))
       UNION
            select tx.hash as hash
            from tx
            JOIN tx_out
              on tx.id = tx_out.tx_id
     WHERE (address = ANY(('{"addr1qxsnezdjclcc03e5znpt470n405l9ryczupedg6e7h84gz94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqvrydcj",
"addr1q8vxu0jgdruwameanq7sfnc7yuxpjgy7scnqfcd2x85al894nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqfh7w8s",
"addr1q95l7l43az9d9rhwcksa36pqzj3judes8dknjxmqar6wtd94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqafvn73",
"addr1q9hkynau373740gp4rtn6nj9qrt9uywxg46n000sg52mxu94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqe85dx8",
"addr1q9pk2zc5mrxemc8m37rn2zswwr844gtq7yve2gmg2s35ec94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqvem75m",
"addr1q8uc659kgcvfx8twe5lxntju6dqe2r4wxzl2epk9pwgfnka4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqc83gj6",
"addr1qyn9m2mfw9kapmg7s49ff673eh4l55uupnm4urzh8lgrka94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqvvyvvu",
"addr1q8d9a8lr4znw83skve0vre8ztyay76uyuejdt2cw4d263vd4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqkte066",
"addr1qxeh99lwfcugq3cqzkuljcw4ypxk25wxpnvx26tw7yjr2kd4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqd6ws59",
"addr1qxerm5wsjjg2g72ndl0r7dne0mcvfpj4sr8ngtuyusfyjpa4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqr7xnht",
"addr1q8nfdz95zh42n23p84kjegtyajaycvap4yszurv4mk4fam44nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqzhz8t3",
"addr1qyf36d7txczxy6hgejf89m75dgv07q9gdaycc33nxm4urv44nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nql2y9l3",
"addr1qyxhzewq7ltfchtklgzlwjujzsut44l5uv77vrxnf6aqtt44nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqegyr4t",
"addr1q949xunlrg6uruhtdxrdrwuupzmlvlkcplp2p495j6jwmwd4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqnamrgn",
"addr1qysmx2lr93atq0fdshvktallgpahp9ew8aesynvnekl4u444nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq6pq8l5",
"addr1q87j3zsujdmfzugp69dnhu9ucu8xh7gl9p52q09jaep44s94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq2dmsj3",
"addr1qxyax8mj5zg5zkl40rfn6svt46k0hs6vfssrcll9v0es5j94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq3rvdat",
"addr1q85pwfjhw67k2ku3czyshx0squzwhart6ruwae2jmhl682a4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq7kf4wu",
"addr1q9fp0tm3kcccql5ukevy2ac66mj5nl4te65n3cpcxpa6c8a4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq0vdp72",
"addr1q8gxhyxxpye48gzvz7afsr3h3eu3a92gt3haga4jj8f3j744nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqayjnfr",
"addr1qxnag3m68960939ypl0f6wspqad28v3c39tv3vavrep74a94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq6dx4fy",
"addr1qytz04axfrf6zrmgvrcd29pljmnqe9sjvndacgnkmx4m9744nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqa7yeq0",
"addr1qxmv8ktpr4znzpfqg6sh9fle9dkt9k6vjrzasezl047p5c44nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqeppf4z",
"addr1qxzj50tlwrfwn8pa42rvhrpz4d9wrhn9e25e5azrlzvn7wa4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq8r4fd6",
"addr1qxm5ztq4syz77crfvmlnlca2afgqgch7a28gs5lf99fyde44nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq4d4kqz",
"addr1qxh2fgs9cnph4kw0g2l6gslwy0l2k5etsv2zll8u7sf8jja4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqqmpgny",
"addr1q8zdnjg6jg0p9atttdgrpg2s3ewx6d46xuvqpravwjsyrh94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqudwlle",
"addr1qxswj5l920ph6v9qcwn5as7qafk2wskw0gdnuu2vyu2kp744nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nquwaguf",
"addr1qx9h7s4m57rzvnyljzzpsm2cz5ug6aszu3rwc9lyes4qcpd4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqvtlqnp",
"addr1qxs7e79vvg4p4jnnz2r9xq8kh2dzc85ggxnd37n3w8zdjx94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq4r3g6s",
"addr1q8hzxsrmutj0ke6mvrjdp0azz9rr2u9cy6ey859ce2gvg8a4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqkctnpj",
"addr1qy2p3gnc7s888jfqtsl9zvpytxymhxfn7ywg5racsrplee44nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqp6ns0e",
"addr1q9c3jkc5xd5hxq8x2sa4qqhpng4f0lkl4hr3lyumv9td9ed4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqzskc7a",
"addr1q859w8r9dgavkfnd40m2q9vna5qpkmdrqdrr9cndz6v6gpa4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqsrvu72",
"addr1q9lday0y6zpmwdu3tm7y88hrgvtnahumxmy5l3x004rtll44nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq4hyqd6",
"addr1qx78r8x5nf9nh3373vq5nda293clhgwuj85kddnfzq6cwea4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqjz76gs",
"addr1qyrawk5flmqgxa4j77eyl768xepjyhhsy8a6kzn7y8xxws44nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqllqy6c",
"addr1qxaqpduhle7pjc4g23j8eadsycvjyte94tz68fppkz77j094nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqcpl23j",
"addr1qxms8438ezujd5qywg6du5j53qnsxk8s8flapdmvthvqxu94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqznpj69",
"addr1q84ddrd9y5p3f82pwpws6epxqu5ulf4zc9n8vr5fdzxkx2d4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq72dppl",
"addr1qypflz22wcj8mf5l4a944w66qvgwjecyeysstexc0nzuvt44nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq6mthdf",
"addr1q84f55qx0xd86vn9lg7vf0nk56kf3chnv77mltuurjw4rs94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqlsaqsu",
"addr1qxv3tzhfmetgc5mjrcp6dwe6stnyhn8scn9ajppvswsdar44nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqw8d0wx",
"addr1qyf73smgcvxvctdxwsp563ky5dw6aaeuhpzagvrtskv7rj94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq7x7nla",
"addr1qxx8ykdmmjt6accck8sfdvwcgn8eu0c7c4apq6dmwjy29r44nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq6azcfx",
"addr1qyj2m02kjp4jz7k9k7eycyje0ncqxmacpas7nf39xjc8v344nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqmh5fsw",
"addr1q9667j9898zw3hcl20h8y95dw9673wjxeqzkfh9l42pq7k94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqpnm0pz",
"addr1qxd5636dwq2t5yra45gp7yzumyln8jlypndunw28jfqs9m94nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqgp06cf",
"addr1q9sz77pq475l63rr8n3r8cqt3gyfu6y5alg6nr9cxl5c5p44nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqcv674s",
"addr1q8gcehel7ydapqmexkkvptk54hgjr3qp5h5uu6s3p4lr3wa4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nq5yum09",
"addr1q937mcs7zqf0r36l6hst43avns4jxh4wuu9deu4cx4q8fwd4nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqs4nmwl",
"addr1qy55hc9r8wwt3s65re7yyzeudt5ysh0vlclwsa668dljt444nvnvag40lslxr0m9lsp0hjzr75l4gh5j443a46zh76nqhyfkpj"}')::varchar array)
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