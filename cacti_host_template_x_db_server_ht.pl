# This is the definition of a Cacti template.  This file should contain nothing
# but a big Perl data structure.  Don't execute this file.  Instead, process it
# with make-template.pl like this:
#
# perl make-template.pl <file>
#
# This program is copyright (c) 2007 Baron Schwartz. Feedback and improvements
# are welcome.
#
# THIS PROGRAM IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
# MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
#
# This program is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, version 2.  On UNIX and similar systems, you can issue `man
# perlgpl' to read this license.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, write to the Free Software Foundation, Inc., 59 Temple
# Place, Suite 330, Boston, MA  02111-1307  USA.

# TODO: add a port to the ss_get_mysql_stats.php

{  name   => 'DB Server',
   hash   => 'hash_0200133df221ff7893faad48ecc15026687215',
   inputs => {
      'Get MySQL Stats' => {
         name         => 'Get MySQL Stats',
         hash         => 'hash_030013a7b8dc9089ba40cbb293524024e51129',
         type_id      => 1,
         input_string => '<path_php_binary> -q '
            . '<path_cacti>/scripts/ss_get_mysql_stats.php <hostname> <username>'
            . '<password>',
         inputs => [
            {  name        => 'hostname',
               hash        => 'hash_070013c89cbc8b1c987e050a310ee5414b2a02',
               allow_nulls => '',
            },
            {  name        => 'username',
               hash        => 'hash_070013181ee907dbb2bbfbfb3c6611f44e5625',
               allow_nulls => 'on',
            },
            {  name        => 'password',
               hash        => 'hash_070013e4ad68877c6e87087e52785d0a870282',
               allow_nulls => 'on',
            },
         ],
         outputs => {
            Key_reads                   => 'hash_070013744750ba74f76128825af0421da2fc5e',
            Key_read_requests           => 'hash_070013b1c52bc482f979e5098096f60a346d96',
            Key_writes                  => 'hash_070013edc5905b12c0765d8b244467bf90ef13',
            Key_write_requests          => 'hash_070013f883de2e830958a1b3472f1bb8209b16',
            pool_size                   => 'hash_070013e8e63bb323d0fdad091c36c34175776d',
            free_pages                  => 'hash_070013a20d995282519d16fc752a83eef5a3cc',
            database_pages              => 'hash_0700131541608aedbc3f66f8964f545cfbadd3',
            modified_pages              => 'hash_0700137fd4378c273fa2bd1a40fcee558169db',
            pages_read                  => 'hash_070013464d8fc2c9da8d0657979ac35df748f6',
            pages_created               => 'hash_0700133405fec44aa54f12cc5714ac32ec89ce',
            pages_written               => 'hash_070013a74fef18073e5f400ce9cc0440bcc58c',
            file_reads                  => 'hash_070013e4419947e30b9bc7840b0dcfcc69e95a',
            file_writes                 => 'hash_0700132d0066b72fa27a71d2b7fb17c6684533',
            file_fsyncs                 => 'hash_070013338fe39f1812b7153d5f9cbb88d60a38',
            log_writes                  => 'hash_070013bd1957bb74760e72094707f078f44217',
            ibuf_inserts                => 'hash_070013318e8cd8d2b8819a2b014907dfa2c518',
            ibuf_merged                 => 'hash_0700134d89fa70976ef750c1cc791059ec7892',
            ibuf_merges                 => 'hash_070013e64d32c93cfee9363a08a94bebeee12c',
            os_waits                    => 'hash_070013cff71ad21c7d95ecf3043be784ec2502',
            spin_rounds                 => 'hash_070013475d54378bf332f88341c03c73acd5f3',
            spin_waits                  => 'hash_07001349230ca679f7ef5a0ddff3323eb9c46e',
            rows_deleted                => 'hash_0700130b5522e2956470a5ca78c0f1ce7f334d',
            rows_inserted               => 'hash_0700135b48ba3c3a988f25757cfe44c3741e50',
            rows_updated                => 'hash_07001379b393539feac8db3a0b993805f1b8f3',
            rows_read                   => 'hash_0700139f6faa993da08c83488ba60448256a44',
            Slow_queries                => 'hash_07001373b510ddd4c5709d62169d01bc2a92d2',
            Table_locks_immediate       => 'hash_07001399dfcebcfaa0a280eb131fb4d8a45f4b',
            Table_locks_waited          => 'hash_070013841b475aa6f2a008eed6611f275b136f',
            max_connections             => 'hash_07001311485b409d6dfabcad2dbc51091ace72',
            Aborted_connects            => 'hash_070013caf8529043654bbe8ecd836b5ba5025e',
            Connections                 => 'hash_0700138bc4cf68ea89224e7c328c9ad02cca53',
            Threads_connected           => 'hash_07001395162a78295564e41ef944f3a3187587',
            Threads_running             => 'hash_070013f1b71ba2bafde85d3da86e22bd299ec1',
            Threads_created             => 'hash_0700132f6575618e56c8347fdc06fe8202ec36',
            Threads_cached              => 'hash_070013a8b56906d6206d98f70dfc7ef46023f0',
            Slow_launch_threads         => 'hash_0700136480fb6847f8590afbc71bd81d225c3a',
            thread_cache_size           => 'hash_070013a12707d396d3414a4ebed49ccc83b4d8',
            Max_used_connections        => 'hash_0700132f241c0517d2360b95c7a4e77b02f566',
            Aborted_clients             => 'hash_070013c44a197ff40a95758cf75c0cade30652',
            relay_log_space             => 'hash_0700135b2975e68247d14e05d9d362cdd78342',
            seconds_behind_master       => 'hash_070013e58a27d656265dc48d8fd9d905784ec5',
            slave_running               => 'hash_0700138ae23d9b7b2f593774a0ab3e228a7974',
            slave_lag                   => 'hash_07001379a4a74739a9d8a1a158c464991900d8',
            Qcache_free_blocks          => 'hash_070013ef60bf6d7d4fd17b112b09b364430ab0',
            Qcache_free_memory          => 'hash_070013ee91f0cd96ad45f08b4792c0a8d1059a',
            Qcache_hits                 => 'hash_0700138da89cd1f21dab5ea12c0cc4b7701d5b',
            Qcache_inserts              => 'hash_0700131365c62fcc94ca0b21c794ca180d4230',
            Qcache_lowmem_prunes        => 'hash_0700133ac840ce2ed61d846498fd9b491140ff',
            Qcache_not_cached           => 'hash_070013731e989154c89df3299c53349abef2cb',
            Qcache_queries_in_cache     => 'hash_070013a83fff8fbab9d321b6507b7de9cc3f0b',
            Qcache_total_blocks         => 'hash_070013657857bf4b2f263566e7beaf95b487e8',
            query_cache_size            => 'hash_0700134120fd863eabefdf58dd98affcbcc551',
            slave_stopped               => 'hash_07001322d491113778e27af564a683bb7a9aaa',
            Questions                   => 'hash_0700137d78fbce8c4ce121ff9891e1fd897ac9',
            Com_update                  => 'hash_0700137f2ce11c4fd45b83beb44d6f2a892fff',
            Com_insert                  => 'hash_0700130c6d622de93e4e3ab8458519861acd48',
            Com_select                  => 'hash_0700132c4385f257e7384c58be804659009a46',
            Com_delete                  => 'hash_070013891099bd129763b3412d744092fcdbb4',
            Com_replace                 => 'hash_070013d54d723196fd07a6c0a75a0266102d31',
            Com_load                    => 'hash_070013bfaaaa13aaec878ddd0ff575390f65d0',
            Select_full_join            => 'hash_07001370d0234c09971d1a20e0d8bad319e532',
            Select_full_range_join      => 'hash_070013bf7ae11296a3c3cbf2cc39cbcded29da',
            Select_range                => 'hash_07001332b2a53c7b0615ebe5d44fc075ecc2bc',
            Select_range_check          => 'hash_0700137306a476765aa65150655e1332832234',
            Select_scan                 => 'hash_070013d5f491ed562a52ed6fe1789c0fc8b741',
            Sort_merge_passes           => 'hash_07001314323bed3477892bdff5a41bfdd62681',
            Sort_range                  => 'hash_07001365befa80dc277f27f1e833ad1a3b2457',
            Sort_rows                   => 'hash_0700132caa274e3e57b8dadbcdd0efb86528d7',
            Sort_scan                   => 'hash_070013c2ca75726d5fab8e4bb5d2309d339db6',
            Created_tmp_tables          => 'hash_070013bb72056a8d0d303a689c0fc2f0ce819d',
            Created_tmp_disk_tables     => 'hash_0700134065eb94dd7c608d5263733304fb4af2',
            Created_tmp_files           => 'hash_070013e743e79638fe54f83f02753b4fee904d',
            Slave_open_temp_tables      => 'hash_07001307074dcbc6e98894eb1d9716e4e734b7',
            Bytes_received              => 'hash_070013df10d36e573ba98662f6e0418640ae3d',
            Bytes_sent                  => 'hash_0700138690bb38429a73eaf7cd4f99d7fd6e89',
            pending_chkp_writes         => 'hash_0700134c77de01a2b867b2449054a995ffa86c',
            pending_log_writes          => 'hash_070013d59b515f6f10bf78315700e95f8b4d74',
            pending_normal_aio_reads    => 'hash_070013a792f9c07de8cd7fc11517d0ebbc17bd',
            pending_normal_aio_writes   => 'hash_070013eb60bf2127ad12b3adfbc4d3ca8f81ae',
            pending_ibuf_aio_reads      => 'hash_070013c9c24c937fc0efaed0e638d7fa10a394',
            pending_aio_log_ios         => 'hash_070013271505777b4d851f19e0a6fa4377a4fc',
            pending_aio_sync_ios        => 'hash_07001337aa9ae6504656e5f2ba6c598a11f304',
            pending_log_flushes         => 'hash_0700134922ad225498f768bbb67c7d1291816a',
            pending_buf_pool_flushes    => 'hash_0700139f629f86602278d8234b6b189ff3888f',
            innodb_log_buffer_size      => 'hash_07001319aa4b0546368636cbd482b6fdadf499',
            unflushed_log               => 'hash_07001313f0bccec0c2682a2dd1c0a0264496f2',
            log_bytes_flushed           => 'hash_0700135c8a253f867050eed551de5f6f09ffd8',
            log_bytes_written           => 'hash_0700134e446d1bce7eb301907ecb9eb583e463',
            binlog_cache_size           => 'hash_070013797852de169c3995a0123121b3b1ee7f',
            Binlog_cache_disk_use       => 'hash_0700130ff552934f7b897db8ed4097faecab41',
            Binlog_cache_use            => 'hash_0700136697a312ccb02b101c6e66cec76e648b',
            binary_log_space            => 'hash_070013a7f15a36a6f796eb883ffa7e32de98d6',
            innodb_transactions         => 'hash_070013e1808374ce89fd8f25cfa7fa25072b89',
            unpurged_txns               => 'hash_0700133f8a6e0a1bee3982f688212d28e6df5b',
            history_list                => 'hash_070013ae98e905a45b9298d9aac7eca6d73f2a',
            transaction_time            => 'hash_0700132f9d51ba1056039ebaa14b1a774c8878',
            transaction_lock_time       => 'hash_0700138c83ac7026cf4d67499da7c3e37bc027',
            read_views                  => 'hash_070013e748884fa51ecc1378b12dd92cdbfc0f',
            current_transactions        => 'hash_070013f5c87aa6244412ca753e87551d14af23',
            Slave_retried_transactions  => 'hash_0700139211e4b40b6d6e408537ede1edcb4733',
            Open_files                  => 'hash_0700131ef2adc0d376e3e1fdc4ce9259c2c196',
            Open_tables                 => 'hash_0700136b886ca6d3e23c6e4b1e105c524023ad',
            Opened_tables               => 'hash_070013b45b6f6e212413aef805156e68b25afe',
            innodb_open_files           => 'hash_07001334a01d83ff17e3d3a4b9e551d9f77e8c',
            open_files_limit            => 'hash_070013c89747fa81b0c27eaf3dfe1bc1cd565d',
            table_cache                 => 'hash_0700139c2ffd79f53ce8ddf309a6883c4064dc',
            Com_update_multi            => 'hash_0700130831a668b303b953e052de2f02b9d490',
            Com_insert_select           => 'hash_07001303f0f68e3b8b49668f7c9f0c4d7f1b78',
            Com_delete_multi            => 'hash_0700134571b33e73edc8a4ebefb8d2b6085a79',
            Com_replace_select          => 'hash_07001389e7f4c2ca696a0d4255d9b62ad8e5ad',
         },
      },
   },
   graphs => [
      {
         hash => 'hash_000013c870e809c16ac409190bcfbaf6c55624',
         dt   => {
            Key_reads => {
               hash => 'hash_0100130de2bf128eac0bc672d77085da38f8cf',
               data_source_type_id => '2'
            },
            hash => 'hash_01001329f0b43ffd723039d3428839ab9f5174',
            Key_write_requests => {
               hash => 'hash_010013039d69d0262c783f20b77fa3b3f62e88',
               data_source_type_id => '2'
            },
            input             => 'Get MySQL Stats',
            Key_read_requests => {
               hash => 'hash_010013b407e61e9948460c99116f7f6a72cf92',
               data_source_type_id => '2'
            },
            Key_writes => {
               hash => 'hash_010013f8851b46ed984a9e8fba454c48995230',
               data_source_type_id => '2'
            }
         },
         base_value => '1000',
         name       => 'MyISAM Indexes',
         items      => [
            {  color  => '157419',
               item   => 'Key_read_requests',
               task   => 'hash_0900135f6452acaf1e44638836412e2a701af5',
               type   => 'AREA',
               hashes => [
                  'hash_100013ac260a1434298e088f15f70cd1a5f726',
                  'hash_1000132880fe948b6912a3bbef6d572fc08c11',
                  'hash_1000137ad6f41485c166ba32e6d9e570e395f0',
                  'hash_100013c0e60c7d108ee721a537bb6e3c62a1d8'
               ]
            },
            {  color  => 'AFECED',
               item   => 'Key_reads',
               task   => 'hash_090013cf20ffcf42c91bb6f8e6d4cadc6b74a5',
               type   => 'LINE1',
               hashes => [
                  'hash_10001325df59422c805e4b85310ec3a4face3b',
                  'hash_100013f8b4402537c5b8f6fe87f025b66fa36d',
                  'hash_100013508445350edf7ebffcc53df8ca402cd4',
                  'hash_100013ce2c5b685c988e9ba283a5b26019a228'
               ]
            },
            {  color  => 'F51D30',
               item   => 'Key_write_requests',
               task   => 'hash_0900131d370e9a5914bc84d71e779814f357cb',
               type   => 'LINE1',
               hashes => [
                  'hash_100013c8ddc4e379739fa6860644b9ec73fd67',
                  'hash_100013eee6bf6b5627650df8625d88f333299f',
                  'hash_100013c13f3d345b73c7333254c1d3efcbd02f',
                  'hash_100013c1d97c83fc4b5cbed160c1530f937307'
               ]
            },
            {  color  => '862F2F',
               item   => 'Key_writes',
               task   => 'hash_090013b06844c326fac7ec50d9819b47b3430a',
               type   => 'LINE1',
               hashes => [
                  'hash_100013b05a1a789491c12bed93e2c610e72fa0',
                  'hash_100013c5621ec923c0e47f0603638f9fbb5815',
                  'hash_1000137e9cc68942f31c8de3788336f080166f',
                  'hash_100013c6da7f77308d3127ca7e18385c86ceeb'
               ]
            }
         ]
      },
      {  hash => 'hash_000013000d2d952ec15762ba04f6384dba51d2',
         dt   => {
            free_pages => {
               hash => 'hash_010013e00cdf7624957fb1206d92c65ea6fcc3',
               data_source_type_id => '1'
            },
            hash           => 'hash_01001371058b0c913ca3b1c3f4246c628731fb',
            modified_pages => {
               hash => 'hash_010013714b9bccd3200f6d46fb3ff36be3bf16',
               data_source_type_id => '1'
            },
            database_pages => {
               hash => 'hash_0100132ced436e455d14013f6d824e36295005',
               data_source_type_id => '1'
            },
            input     => 'Get MySQL Stats',
            pool_size => {
               hash => 'hash_01001368cc20ea3e77e990d749356e21a8ed01',
               data_source_type_id => '1'
            }
         },
         base_value => '1024',
         name       => 'InnoDB Buffer Pool',
         items      => [
            {  color  => 'FFD660',
               item   => 'pool_size',
               task   => 'hash_0900132cb12f1e0ce4b35cac3f026054f4bee4',
               type   => 'AREA',
               hashes => [
                  'hash_1000136820faaa15e407a4443588d8afc41fdb',
                  'hash_100013cb3addf6f0a3c3b7f4c7ffc2cffb73b9'
               ]
            },
            {  color  => '157419',
               item   => 'free_pages',
               task   => 'hash_090013b7800e17a4e0a97464eda1b373839eb7',
               type   => 'AREA',
               hashes => [
                  'hash_10001381b0c8274aecfa8a5e304eabdaa7f3a9',
                  'hash_100013cc3c68b2b4f7fb46913301aea0a6c1ae',
                  'hash_1000130e7d24bce7e20e0a0b393d529a55a15c',
                  'hash_100013ec9b15475d486e684c1e3c9c099cedf6'
               ]
            },
            {  color  => 'CDCFC4',
               item   => 'database_pages',
               task   => 'hash_090013d265fe62da24ab1ac26a4a15b3da438e',
               type   => 'STACK',
               hashes => [
                  'hash_100013f831741492af46b72bc0a63d11e72869',
                  'hash_1000137abd57dc40efb7827d1424f07b8e98be',
                  'hash_1000138143fa8b86d4cc3a87adc35dfc64628b',
                  'hash_100013cb634dc53fa8a86fa5ab0e3828d1fab9'
               ]
            },
            {  color  => '4668E4',
               item   => 'modified_pages',
               task   => 'hash_090013b79a39e463530e8ccb536ea79fa0be51',
               type   => 'LINE1',
               hashes => [
                  'hash_1000137053cc7687881295d23bc15f108e9433',
                  'hash_1000135ab29120a18ffd753145908aabcb0478',
                  'hash_10001362855c548aa45caba7040ee61cf02b56',
                  'hash_100013e2da9c2dbdae0035fbbcf11829f14b04'
               ]
            }
         ]
      },
      {  hash => 'hash_000013da247361e59f209d69be79ada9b05665',
         dt   => {
            log_writes => {
               hash => 'hash_010013506dc7cea79a8e9167a2961e4af16f4f',
               data_source_type_id => '2'
            },
            hash       => 'hash_010013c56de26b6cec34796af17026e8b1e1f5',
            file_reads => {
               hash => 'hash_0100139faa26c606b6b28778864d5081588c62',
               data_source_type_id => '2'
            },
            input       => 'Get MySQL Stats',
            file_writes => {
               hash => 'hash_0100131452aa7aa7147b5a81f90acf29e344a7',
               data_source_type_id => '2'
            },
            file_fsyncs => {
               hash => 'hash_0100131b83b09538bc14ae68e1e9a58d0ea4ce',
               data_source_type_id => '2'
            }
         },
         base_value => '1000',
         name       => 'InnoDB I/O',
         items      => [
            {  color  => 'ED7600',
               item   => 'file_reads',
               task   => 'hash_090013a7dc405b5920611b788cadc936442a0a',
               type   => 'LINE1',
               hashes => [
                  'hash_100013d444cf5b2282941e7a2095d0a8c6ed59',
                  'hash_100013910f8d7e8652692960dba852989d6f52',
                  'hash_100013906960013ebee0cae830a4f11f84891a',
                  'hash_10001344e429dac2b9310aee69450e868760c7'
               ]
            },
            {  color  => '157419',
               item   => 'file_writes',
               task   => 'hash_0900130bc38dd83b51bc28d900301642f264b3',
               type   => 'LINE1',
               hashes => [
                  'hash_100013a003f2270ea883d97dcf72d1af33f596',
                  'hash_10001334324f39d4a59acdf77d15b4a6959138',
                  'hash_100013dacf6b13991386eacf7e598ad906ceb9',
                  'hash_1000132b7efe0d49f15f3a010513c273a9409d'
               ]
            },
            {  color  => 'DA4725',
               item   => 'log_writes',
               task   => 'hash_0900132e5e7792fce3374c07688a917ee3e1d2',
               type   => 'LINE1',
               hashes => [
                  'hash_10001329e59d844c33344ee91e195ce60e8813',
                  'hash_100013bf128e2a5f554016dca014539dc9297e',
                  'hash_1000130f19e132baa24ea10c693c8af3557a78',
                  'hash_1000138fa4ae8356e1b417f23be3e23aa38527'
               ]
            },
            {  color  => '4444FF',
               item   => 'file_fsyncs',
               task   => 'hash_090013cafa2432856a45bb04ffdb7b7e8a2e52',
               type   => 'LINE1',
               hashes => [
                  'hash_1000136517b82d8f0c7510026ac494e83068ba',
                  'hash_1000137f5e1b9e217ef5abc70549cab905edd5',
                  'hash_1000131b0854695edc59bc72dfe94374dd93e3',
                  'hash_10001334f0b31f32801fccfc8a14e1f17c5f69'
               ]
            }
         ]
      },
      {  hash => 'hash_000013d9a54b856fe871e5724bc5bce7d02c62',
         dt   => {
            ibuf_merges => {
               hash => 'hash_010013db421787539f02497406cd293f1a522a',
               data_source_type_id => '2'
            },
            ibuf_inserts => {
               hash => 'hash_010013d4ee67c833d28a979599b71381360734',
               data_source_type_id => '2'
            },
            hash        => 'hash_01001341c5206e4ce414e2bda8b85db4da77dd',
            ibuf_merged => {
               hash => 'hash_010013c289a34d4c63e31f02be38ad26ffb077',
               data_source_type_id => '2'
            },
            input => 'Get MySQL Stats'
         },
         base_value => '1000',
         name       => 'InnoDB Insert Buffer',
         items      => [
            {  color  => '157419',
               item   => 'ibuf_inserts',
               task   => 'hash_090013e66d175343e13dcafdb0a86303a4b2b9',
               type   => 'LINE1',
               hashes => [
                  'hash_100013c393adc639076326c57fb39a50cd8db3',
                  'hash_1000135ddbbcb91dd2984dc6b469c0f7048bac',
                  'hash_100013ccd732e33781ddff8d71f15127474247',
                  'hash_1000138a97910b261420caf4f42acff0777b87'
               ]
            },
            {  color  => '0000FF',
               item   => 'ibuf_merged',
               task   => 'hash_09001312fc42a6c166f3c9559ec7d499d2c5df',
               type   => 'LINE1',
               hashes => [
                  'hash_100013feddbb6bfb063797d3521d171e42a0c4',
                  'hash_1000139a9bdf66c2f949d5cf569f2a21cfe788',
                  'hash_10001337328f3198bf826ec46d705a7108fae4',
                  'hash_1000130700f03352de66222852aab2c43c9395'
               ]
            },
            {  color  => '862F2F',
               item   => 'ibuf_merges',
               task   => 'hash_09001323fda91e9c1d26a47bd5125469827e16',
               type   => 'LINE1',
               hashes => [
                  'hash_1000130717fc25c141775450b5713c0fc1414f',
                  'hash_100013ada7b7213b47d99ae32a6dd7700d04f4',
                  'hash_10001386beb441a0cc11a71820664941b0c247',
                  'hash_1000139b530b21a1de4f01474ced8fe4f68d6b'
               ]
            }
         ]
      },
      {  hash => 'hash_0000139b3e0b4a8c49be86a7cb1486ba9ab88d',
         dt   => {
            os_waits => {
               hash => 'hash_010013522f5ed5373d54e612f2e2a32b58c8ca',
               data_source_type_id => '2'
            },
            hash       => 'hash_010013c74a58d5af8d4b98f99fa997c7c75480',
            input      => 'Get MySQL Stats',
            spin_waits => {
               hash => 'hash_010013d1a72d8ab6137fcf3df95b2e14a89a58',
               data_source_type_id => '2'
            },
            spin_rounds => {
               hash => 'hash_010013c88c11b5a4da84fd95ff088a4d815cd6',
               data_source_type_id => '2'
            }
         },
         base_value => '1000',
         name       => 'InnoDB Semaphores',
         items      => [
            {  color  => 'DE0056',
               item   => 'spin_rounds',
               task   => 'hash_090013761c1a5abd1ff12e51376809e0beb66c',
               type   => 'LINE1',
               hashes => [
                  'hash_100013000801874164cf6cf266929cc34d8462',
                  'hash_1000136b0538d65229502662c88ee69966f1f4',
                  'hash_1000134b2a9197fc6c30419c72dc3350e7eb6e',
                  'hash_10001389cf3819b4983d8e0256579e95bbc731'
               ]
            },
            {  color  => '4444FF',
               item   => 'spin_waits',
               task   => 'hash_0900136ab40fc1a3b483a09877ca15f6de8244',
               type   => 'LINE1',
               hashes => [
                  'hash_100013b5cc89b185f3deaad54ab5e44260b3e1',
                  'hash_100013e11c102185773f8ad8c5db1db44cccba',
                  'hash_10001365c208e36bebbcb1ea02813ac43b3ac2',
                  'hash_10001342cdf7d8263257532cc5c242e6ae7b06'
               ]
            },
            {  color  => '157419',
               item   => 'os_waits',
               task   => 'hash_09001368b0389a78299e5b6a8b61ff5bf6cb24',
               type   => 'LINE1',
               hashes => [
                  'hash_100013649ce38feea031b35dc7d92ec99c0434',
                  'hash_10001396483d64f581e7e37bd192813b672b4e',
                  'hash_100013247243bdb3bf137c3f985a260bc77beb',
                  'hash_1000139c5bb9a6c3683dff4c187061fb6951ae'
               ]
            }
         ]
      },
      {  hash => 'hash_0000135da7bba339cf1753b07e36c58185d7ee',
         dt   => {
            hash         => 'hash_0100138c0c000f2a5a0bef224c8c2cd3bdd9c9',
            rows_deleted => {
               hash => 'hash_0100139d6fb10c7a6fad13a42d29c5b77a26b1',
               data_source_type_id => '2'
            },
            input         => 'Get MySQL Stats',
            rows_inserted => {
               hash => 'hash_010013ac8e609e24e306fef2ec8ef425fe0ea6',
               data_source_type_id => '2'
            },
            rows_updated => {
               hash => 'hash_01001316c850e649dd91edf9d2241bc635377c',
               data_source_type_id => '2'
            },
            rows_read => {
               hash => 'hash_010013f643eab7bbcd11417e0685d138c2e4b4',
               data_source_type_id => '2'
            }
         },
         base_value => '1000',
         name       => 'InnoDB Row Operations',
         items      => [
            {  color  => 'AFECED',
               item   => 'rows_read',
               task   => 'hash_090013235ba142254df5662b822cbed8068429',
               type   => 'AREA',
               hashes => [
                  'hash_100013c3fb171c7118f9ccf1dfd17e7d7047cd',
                  'hash_1000138d6cb22f122886249d39b15b1c2080bf',
                  'hash_100013f581e6e9da84550bb44e30a79ea72b4d',
                  'hash_1000131bb952ec834b0902a2a769cfe1a0590c'
               ]
            },
            {  color  => 'DA4725',
               item   => 'rows_deleted',
               task   => 'hash_09001349b839f1111ee393d239eec323ee0b18',
               type   => 'STACK',
               hashes => [
                  'hash_100013d2573b0574fc966ece3c8001bb3c5203',
                  'hash_100013c237f0850c16775d2615a5cc5e24ec8b',
                  'hash_1000138ad3785f87c97fd96614d3c54bba3d96',
                  'hash_100013d3ed2a51bb32feaba600bc1b16ebc8cc'
               ]
            },
            {  color  => 'EA8F00',
               item   => 'rows_updated',
               task   => 'hash_090013eb20f60feac6a228d76cb7dfd64c4ff4',
               type   => 'STACK',
               hashes => [
                  'hash_10001334ad6cd1d33cf3bf027ff9a450336969',
                  'hash_100013277df4fce9190017917f8e92d61124dc',
                  'hash_100013cf0a710c5fe70b89967c97e44dcec1b2',
                  'hash_100013f310dd1da40fc7df9e7776c18ead315d'
               ]
            },
            {  color  => '35962B',
               item   => 'rows_inserted',
               task   => 'hash_0900139ec021b8fc01ba237c2531f1c5a68673',
               type   => 'STACK',
               hashes => [
                  'hash_100013e6ed2155d3ecd734f55db90259946590',
                  'hash_100013af62d028aa17acb2276e12be3ebb2c4e',
                  'hash_10001338e2fee5b5398f357145770aeb689420',
                  'hash_10001335406ab0284534690161c25ba3faa46d'
               ]
            }
         ]
      },
      {  hash => 'hash_0000136248f4622f34282739d13a496a26a244',
         dt   => {
            hash         => 'hash_010013a1940673b7c4f960688bbffa3c5cc9e7',
            Slow_queries => {
               hash => 'hash_0100134b92784bd5b866747c040580383d9619',
               data_source_type_id => '3'
            },
            input             => 'Get MySQL Stats',
            Table_locks_immediate => {
               hash => 'hash_010013cf7e7c469ad5eccae33784b96136f318',
               data_source_type_id => '3'
            },
            Table_locks_waited => {
               hash => 'hash_010013ce22d0d9368be9413c2a50c69861ec2b',
               data_source_type_id => '3'
            }
         },
         base_value => '1000',
         name       => 'MySQL Table Locks',
         items      => [
            {  color  => 'D2D8F9',
               item   => 'Table_locks_immediate',
               task   => 'hash_0900131f02f1af427e8fbab1bbc6f9f454a9de',
               type   => 'AREA',
               hashes => [
                  'hash_100013985c2c250576fa832083b7350b3ba43e',
               ],
            },
            {  color => '002A8F',
               item   => 'Table_locks_immediate',
               task   => 'hash_0900131f02f1af427e8fbab1bbc6f9f454a9de',
               type   => 'LINE1',
               hashes => [
                  'hash_1000136388f8353794e11c3ba3ca88ec8092b6',
                  'hash_100013195358fe082e80eea41714386c901af0',
                  'hash_1000132e180568d6e8324d8de0b5de18f9ace7',
                  'hash_10001348fe37efb3fe5559477598182c6ea902'
               ]
            },
            {  color  => 'FF3932',
               item   => 'Table_locks_waited',
               task   => 'hash_0900138444ffb6060be25f757298ee24137589',
               type   => 'AREA',
               hashes => [
                  'hash_100013df8eadeb3843d46eab8e41843d0999a1',
                  'hash_100013afc37040e3f206e690c42dc2baa16093',
                  'hash_100013859b6385daccd065a051285a4dcfb990',
                  'hash_100013b5e774b31844391679cfcf7a43e291c6'
               ]
            },
            {  color  => '35962B',
               item   => 'Slow_queries',
               task   => 'hash_090013e18fcc7dde1d7247dd8e450e38d93bbc',
               type   => 'LINE1',
               hashes => [
                  'hash_100013773a5bdc72b180711b6526d26a0dbcc1',
                  'hash_10001357fbac2bf9599e982f379909c8d9a5f1',
                  'hash_100013383655c97850192dc952ee0bd8192725',
                  'hash_100013cc80408b5852dd9178493fbf52c5b043'
               ]
            }
         ]
      },
      {  hash => 'hash_0000139c8df1d30e905156b0bf3767088ad583',
         dt   => {
            Connections => {
               hash => 'hash_0100133790fcbadbe72404d2826fc88c29b1d0',
               data_source_type_id => '2'
            },
            Threads_connected => {
               hash => 'hash_01001355ed0b81457150103747ca82141a7f13',
               data_source_type_id => '1'
            },
            hash            => 'hash_010013f12a4fdc2bbe8cee87181ba0feaf67ed',
            input           => 'Get MySQL Stats',
            max_connections => {
               hash => 'hash_01001352dcd9b60564823afc59da8762e9cf56',
               data_source_type_id => '1'
            },
            Max_used_connections => {
               hash => 'hash_0100130ecbbad784c6a0287cb138e0d101159b',
               data_source_type_id => '1'
            },
            Aborted_clients => {
               hash => 'hash_010013b9482e8e8f3a6d0e95978e19715ac447',
               data_source_type_id => '2'
            },
            Aborted_connects => {
               hash => 'hash_010013fc1dba80f47aacc5247d7a598bc79e85',
               data_source_type_id => '2'
            }
         },
         base_value => '1000',
         name       => 'MySQL Connections',
         items      => [
            {  color  => 'C0C0C0',
               item   => 'max_connections',
               task   => 'hash_0900133bbf05e063a396e76eedff37d7358634',
               type   => 'AREA',
               hashes => [
                  'hash_100013f8ed80fe154a67993f6677d2be37b0f1',
                  'hash_1000135caf92f9dc95270cae4c634069996643'
               ]
            },
            {  color  => 'FFD660',
               item   => 'Max_used_connections',
               task   => 'hash_0900131052774481daf3ea84f80406fd86bceb',
               type   => 'AREA',
               hashes => [
                  'hash_100013eb683da9f481d950413161c5334cb0a4',
                  'hash_100013e3934ec4b365c8ac565b7d593e583800'
               ]
            },
            {  color  => 'FF3932',
               item   => 'Aborted_clients',
               task   => 'hash_0900136551253b269d1becd08a82e95535d7c8',
               type   => 'LINE1',
               hashes => [
                  'hash_100013bac3422327a1ebb30e764c7dff9065cc',
                  'hash_100013f775dee2cfbf507846352aa4ca653c16',
                  'hash_100013ceb7ad7aa445d84747af3a82a493cb5d',
                  'hash_100013b90f98bc40c12f51cc6b06ce3afb6a3b'
               ]
            },
            {  color  => '00FF00',
               item   => 'Aborted_connects',
               task   => 'hash_090013e33396ba59228774dcedc9f1b857fe8c',
               type   => 'LINE1',
               hashes => [
                  'hash_1000134802eafebf24679dc8adf774c0c3a74e',
                  'hash_10001329288f73324e16f0e6762d50e896b7a4',
                  'hash_100013cf6ed7bcdf06e84c64714b8e317e981b',
                  'hash_100013c095ef6d8f6ed688143fa36034b7bf01'
               ]
            },
            {  color  => 'FF7D00',
               item   => 'Threads_connected',
               task   => 'hash_090013b7d58afdf5f705fe19733a816b3733c6',
               type   => 'LINE2',
               hashes => [
                  'hash_100013bb837bdc8139f9d9022a19511fc2b38e',
                  'hash_100013e2839637ce31f2557cf4274a28c3c101',
                  'hash_100013e25a4900df11b4e8a31aba82d21ca9db',
                  'hash_100013c77bd0b513b8a141437715c2883708c3'
               ]
            },
            {  color  => '4444FF',
               item   => 'Connections',
               task   => 'hash_0900137a7d7b5119584a1efe0ff8c9a4e0e0dd',
               type   => 'LINE1',
               hashes => [
                  'hash_100013e17d122913057806703ddd96478d62fc',
                  'hash_10001344c9d967001eb19145c3e9461fb52892',
                  'hash_100013838d420fad5e1264d752b74622040d38',
                  'hash_100013690a9a33fec432fe0d2bebd8357ebba6'
               ]
            }
         ]
      },
      {  hash => 'hash_000013b8ab36ff23571c4583154391183380c9',
         dt   => {
            Slave_retried_transactions => {
               hash => 'hash_010013bc1d5cacb2e2c6f0785f369f6baaa349',
               data_source_type_id => '2'
            },
            Slave_open_temp_tables => {
               hash => 'hash_01001325cf8ecc2e97a7de94bc1cb48151a5e2',
               data_source_type_id => '1'
            },
            input               => 'Get MySQL Stats',
            seconds_behind_master => {
               hash => 'hash_010013102549743bbd45d73dad64e40c5deabd',
               data_source_type_id => '1'
            },
            hash          => 'hash_010013b4e58a773aa9fb5b2b40c13850434ef5',
            slave_running => {
               hash => 'hash_010013a2b5fb54622eccf34fd7891c7dd846d9',
               data_source_type_id => '1'
            },
            slave_stopped => {
               hash => 'hash_01001360a66b3e8ee975927e0950be770e3210',
               data_source_type_id => '1'
            },
            slave_lag => {
               hash => 'hash_0100132f22ea85e927b9904204281cd730b9c7',
               data_source_type_id => '1'
            }
         },
         base_value => '1000',
         name       => 'MySQL Replication',
         items      => [
            {  color  => '96E78A',
               item   => 'slave_running',
               task   => 'hash_09001391e496c6fbb49b545fc8f2c2fc810d55',
               type   => 'AREA',
               hashes => [ 'hash_1000138e774a27bdcd687b74f59f7633261104' ]
            },
            {  color  => 'CDCFC4',
               item   => 'slave_stopped',
               task   => 'hash_090013408d1c93dd785e1c37853e715155357d',
               type   => 'AREA',
               hashes => [ 'hash_100013d86914f0587cc89b36795e15f6deb843' ]
            },
            {  color  => 'ED7600',
               item   => 'seconds_behind_master',
               task   => 'hash_090013eccdbf2fc2b3784ac5392a8438351d6d',
               type   => 'LINE1',
               hashes => [
                  'hash_100013e21668631327b37ef7598c6fb15a7cb1',
                  'hash_1000132e1ea72957dd1e63c398539de800f138',
                  'hash_1000131b440c837fc00f3d48a2bfc954f036d8',
                  'hash_100013d38edb63f55e33b65076a4e268be6391'
               ]
            },
            {  color  => '4444FF',
               item   => 'slave_lag',
               task   => 'hash_0900138929e6500dfc2213bf024c549c468ea9',
               type   => 'LINE1',
               hashes => [
                  'hash_100013caf39e137752bd9a38ecf7ceb5d53ce3',
                  'hash_1000136ec9f26cd661cef295cc1c76e4130b68',
                  'hash_1000137c1a9200037f834bd71010f1f7708aa6',
                  'hash_10001381aa16ca185a61f50f52d6d5342115a6'
               ]
            },
            {  color  => '8D00BA',
               item   => 'Slave_open_temp_tables',
               task   => 'hash_090013223448b07c87f678582c20b90b888d7b',
               type   => 'LINE1',
               hashes => [
                  'hash_1000139ef146d43565ac74eb3a14219e6a38f2',
                  'hash_10001331621db648be7acd543886ea43a02a89',
                  'hash_1000136cc5f7709b2390de0b8ee2580f91dba5',
                  'hash_100013991855b6e433018ad55edad34fdce9d4'
               ]
            },
            {  color  => 'FF0000',
               item   => 'Slave_retried_transactions',
               task   => 'hash_0900136d91d49c09ae744a110b7ade0c93e0af',
               type   => 'LINE1',
               hashes => [
                  'hash_100013bc17c6a7692fbb31c18a8d6e7c491f04',
                  'hash_100013876d9459ba58d69d04d78fa2d376c555',
                  'hash_100013491d413a794cac1a923d6c9988b75416',
                  'hash_100013348cd8082e7f7c6e28c2a82df019b4e0'
               ]
            }
         ]
      },
      {  hash => 'hash_000013410ce15a29ceea4510e211a0abf3c65b',
         dt   => {
            Qcache_inserts => {
               hash => 'hash_01001322845ea66b30de205a53b333a5a90164',
               data_source_type_id => '2'
            },
            hash => 'hash_010013758e5dfa7c1b43158c99c9ae8f5c9151',
            Qcache_lowmem_prunes => {
               hash => 'hash_01001314595905d0a5cd47d859662262beced7',
               data_source_type_id => '2'
            },
            input             => 'Get MySQL Stats',
            Qcache_not_cached => {
               hash => 'hash_010013bed31c9faf2bd44892d858ca786520ef',
               data_source_type_id => '2'
            },
            Qcache_queries_in_cache => {
               hash => 'hash_010013311c7406e805f1bba295d81af1d13fe0',
               data_source_type_id => '1'
            },
            Qcache_hits => {
               hash => 'hash_010013f07477338949616d6eea54ee637f6d4e',
               data_source_type_id => '2'
            }
         },
         base_value => '1024',
         name       => 'MySQL Query Cache',
         items      => [
            {  color  => '4444FF',
               item   => 'Qcache_queries_in_cache',
               task   => 'hash_0900138e9d3e5965f1de27395fce2bbc5f36d4',
               type   => 'LINE2',
               hashes => [
                  'hash_100013dfe1f04f9170570eb33149475b9dcbf5',
                  'hash_1000132adbdba626f781797f1e04716361c05f',
                  'hash_100013986ee7b27049fd1f09fc0b6128feab65',
                  'hash_1000131f637ddffa2a5b1407203abebe6a1774'
               ]
            },
            {  color  => 'EAAF00',
               item   => 'Qcache_hits',
               task   => 'hash_0900138fe099842b40da2abf4510817fdf2361',
               type   => 'LINE2',
               hashes => [
                  'hash_100013392b40ba2be12bed033d76fedbc965e2',
                  'hash_1000134dbb890527f3a12a7a44aa690f708181',
                  'hash_1000137db98c77393dcc0b27a554181393c054',
                  'hash_1000139203b1e3eea81a2f4346592181a60bf4'
               ]
            },
            {  color  => '157419',
               item   => 'Qcache_inserts',
               task   => 'hash_0900130a5267e11f8ac4b97e61b740f3f563f5',
               type   => 'LINE1',
               hashes => [
                  'hash_100013018b148bf47b8f3f929f7d946f650438',
                  'hash_100013671295bad476c0787e3b65fe5a1f0ab1',
                  'hash_100013653e15267565f3b39730af563efb2ecc',
                  'hash_100013d253a6c48288b333e891fc8e98180f5e'
               ]
            },
            {  color  => '00A0C1',
               item   => 'Qcache_not_cached',
               task   => 'hash_090013facc8d5695b7faa786414820e5243120',
               type   => 'LINE1',
               hashes => [
                  'hash_100013501740993f941ecef68e941d3c0e18cd',
                  'hash_1000133d4e8d1a600ca1a3bd915fade265341d',
                  'hash_100013ec30dc392bb86276d76b14b2dda60ea5',
                  'hash_1000138179f75822f4a0b13796786a5db5bd5b'
               ]
            },
            {  color  => 'FF0000',
               item   => 'Qcache_lowmem_prunes',
               task   => 'hash_0900131084c6b5757103795d1fec2c17ac9da7',
               type   => 'LINE1',
               hashes => [
                  'hash_100013cbdccd36fa165757f95c3312c375d873',
                  'hash_100013d91ad0c0e0469fa64b4af27d3c0a4849',
                  'hash_1000137596407cb1ba2bb0634c2e9301e49a36',
                  'hash_100013416d5119da9da1f006cd4cd530e68bb7'
               ]
            }
         ]
      },
      {  hash => 'hash_000013b81e0eeb0140438fe3752271c74fb32e',
         dt   => {
            hash             => 'hash_010013758e5dfa7c1b43158c99c9ae8f5c9151',
            query_cache_size => {
               hash => 'hash_01001376a39fdd8200142dcbc0a924c48d5579',
               data_source_type_id => '1'
            },
            input              => 'Get MySQL Stats',
            Qcache_free_blocks => {
               hash => 'hash_0100133e1726404b6d50a895f5809d1ad56a7f',
               data_source_type_id => '1'
            },
            Qcache_total_blocks => {
               hash => 'hash_0100138d7e8ced1b5e263e2bc8a85217cf0738',
               data_source_type_id => '1'
            },
            Qcache_free_memory => {
               hash => 'hash_010013de38cbf9720663357899748543fe5e6f',
               data_source_type_id => '1'
            }
         },
         base_value => '1024',
         name       => 'MySQL Query Cache Memory',
         items      => [
            {  color  => '74C366',
               item   => 'query_cache_size',
               task   => 'hash_09001356048c4af65e171ed16dbedcb8426f72',
               type   => 'AREA',
               hashes => [
                  'hash_100013ef8a3eca2ff1cfb073e6fd8f648f87aa',
                  'hash_100013004589ff2185c0f1e725602ca30cb57c',
                  'hash_10001347d61115549b565f271ff4f638610b71',
                  'hash_10001315a1953175f6a2f40db4d32dfeb8848d'
               ]
            },
            {  color  => 'FFC3C0',
               item   => 'Qcache_free_memory',
               task   => 'hash_090013cc342c321bed367deaf48111f9aa608d',
               type   => 'AREA',
               hashes => [
                  'hash_1000132fc86127606fca358c55a6a6c8a900dc',
                  'hash_100013c1a6ad1a1670f62c6b32f05309740578',
                  'hash_100013452a8285490a86891193c8fa4740b1e8',
                  'hash_100013c6f4cb65024c74ebb546b052974ef6a0'
               ]
            },
            {  color  => '8D00BA',
               item   => 'Qcache_total_blocks',
               task   => 'hash_0900136ede16e981e996a62ae2a831e26c4a65',
               type   => 'LINE1',
               hashes => [
                  'hash_1000132928f0a6dd9c1fb080a652154cd7b02c',
                  'hash_100013c16f93bea3c6a51aae0a6b3bdb5ac072',
                  'hash_1000132efaccedc1bab9f16e444402fe9c6843',
                  'hash_100013b975f9434b7653f5b9cb4b8abda44d7f'
               ]
            },
            {  color  => '837C04',
               item   => 'Qcache_free_blocks',
               task   => 'hash_090013347eeb0f45c30500cd94f413c2b5bdaf',
               type   => 'LINE1',
               hashes => [
                  'hash_100013afcbb4b9fc4fe0e171e2cd0c63cee438',
                  'hash_10001332328853193df6a6d820182bc04affb7',
                  'hash_100013dc6054b333a38f86d572617ad82efda6',
                  'hash_100013490d6b2291ce225cd742145d92365d5b'
               ]
            }
         ]
      },
      {  hash => 'hash_000013d62fdf10872359e69b44bc7e2aaf3533',
         dt   => {
            input      => 'Get MySQL Stats',
            Com_select => {
               hash => 'hash_010013196a931365006b70189f1252a7601ecb',
               data_source_type_id => '2'
            },
            Com_delete_multi => {
               hash => 'hash_010013149230bfe45c31f9f844e726a6fd4821',
               data_source_type_id => '2'
            },
            Com_delete => {
               hash => 'hash_010013338ab0cab8bfed0e33c57639bac678a2',
               data_source_type_id => '2'
            },
            Com_insert => {
               hash => 'hash_0100133d9a4c7361041aa0bcb36b4bb98e3853',
               data_source_type_id => '2'
            },
            Com_replace => {
               hash => 'hash_010013758bec4a0d6344ccd03f47e7be7068cf',
               data_source_type_id => '2'
            },
            hash             => 'hash_010013f8fa7fbf4c5d4ee7d82f7b4c22cc5c26',
            Com_update_multi => {
               hash => 'hash_010013caf6c3ae61650a2096daaca96b837bb0',
               data_source_type_id => '2'
            },
            Com_replace_select => {
               hash => 'hash_010013ab2e63aef3037b7c7d134fbba74d3c3e',
               data_source_type_id => '2'
            },
            Com_insert_select => {
               hash => 'hash_01001308217f95d7cd474051c926b7c5fbf6e7',
               data_source_type_id => '2'
            },
            Com_update => {
               hash => 'hash_0100132ded5946a4f8009c895f7416cbfa4c74',
               data_source_type_id => '2'
            },
            Questions => {
               hash => 'hash_010013542f25b1dd6cc52340253c02a3b8da1b',
               data_source_type_id => '2'
            },
            Com_load => {
               hash => 'hash_01001387cacd948ec07d17babbbf9f1ff0867e',
               data_source_type_id => '2'
            }
         },
         base_value => '1000',
         name       => 'MySQL Command Counters',
         items      => [
            {  color  => 'FFC3C0',
               item   => 'Questions',
               task   => 'hash_090013e20eb6d4ffbc4c2c5cc785e5b6d03ba3',
               type   => 'AREA',
               hashes => [
                  'hash_1000132e7a7135c1f50143371f113a80b1a981',
                  'hash_100013172a8d09c9caf4e7f67b666c1bed49ee',
                  'hash_100013e6be51aa2fc20b63014ea553836b7f43',
                  'hash_1000135a26ddd649c62a7af42dbec5df2bc7f8'
               ]
            },
            {  color  => 'FF0000',
               item   => 'Com_select',
               task   => 'hash_090013222789ffa6865751d120906e2b7cf79e',
               type   => 'AREA',
               hashes => [
                  'hash_10001302c62dc17dcaf4895e81b7ae5a2188cb',
                  'hash_100013d9209caec858e7e0bfafb576d92fc00c',
                  'hash_100013c370ca982ed86c323c1450d1ea4bd73d',
                  'hash_1000136fa4536316aa1861fc4de00345c6f185'
               ]
            },
            {  color  => 'FF7D00',
               item   => 'Com_delete',
               task   => 'hash_0900133d13473ba25d88c0f2278affb6ab7abf',
               type   => 'STACK',
               hashes => [
                  'hash_10001310555bbea2a239b2c80a6d7cd8167da7',
                  'hash_10001304302e25a021a2b07e5941b8a950c313',
                  'hash_100013f8ba1fd73bd7fc9cd4c34d29c43f7b0d',
                  'hash_1000131c7b3f173002fbb7535745b084a86bfa'
               ]
            },
            {  color  => 'FFF200',
               item   => 'Com_insert',
               task   => 'hash_090013d34468d7126bb1e14107062df8d5885f',
               type   => 'STACK',
               hashes => [
                  'hash_1000133af8d3ab9d28800e282afe4a21435652',
                  'hash_100013f0c149a27bd0713fe5ded911cb5fea3e',
                  'hash_1000139adc871ac35a1d299694ad98316f7d86',
                  'hash_100013860afadaed52b7db13b1753244639cad'
               ]
            },
            {  color  => '00CF00',
               item   => 'Com_update',
               task   => 'hash_0900138318b20ed13f682a27d933cdff22c6cb',
               type   => 'STACK',
               hashes => [
                  'hash_100013e0359e2df0190e1a9a09b13269dd7657',
                  'hash_1000136bd631c4e6180a001808e18e653ffdad',
                  'hash_100013d56c67c9204e0ef3930ad08c9f88f18e',
                  'hash_10001308fb1ac8a1a967ac7eb0d8e9448e5ee8'
               ]
            },
            {  color  => '2175D9',
               item   => 'Com_replace',
               task   => 'hash_090013a85de14079ffe09e6c5699f6a96eecab',
               type   => 'STACK',
               hashes => [
                  'hash_100013a88f1139043c3b7671adc09b6a07d86c',
                  'hash_100013430d27ff52c711a364612d16828871df',
                  'hash_10001336e7baceb425ad27c731928c76c9e45a',
                  'hash_100013100dbae77f81adb257efcbc1cc57ae3f'
               ]
            },
            {  color  => '55009D',
               item   => 'Com_load',
               task   => 'hash_090013fceb4d4326b284e543b1d9b689d2d8c9',
               type   => 'STACK',
               hashes => [
                  'hash_100013735f510ae982c05fa39793302cddda42',
                  'hash_100013058ee9da209b619b4bc2320a185e9074',
                  'hash_10001354c34f644ab432db574d6cc4210a17ae',
                  'hash_1000133acc64545edd38de731fdff21c45f790'
               ]
            },
            {  color  => '942D0C',
               item   => 'Com_delete_multi',
               task   => 'hash_090013a319edbd59b520e26897d2df34114a77',
               type   => 'STACK',
               hashes => [
                  'hash_100013ecb13ef9d128278ce48bc61ba63982e4',
                  'hash_10001371e775824e1d5b6665c701545a7ede25',
                  'hash_1000131080ce68620ac9ce974e1ee64432239a',
                  'hash_1000131d69fb349c635d51d220cf9f087346cc'
               ]
            },
            {  color  => 'AAABA1',
               item   => 'Com_insert_select',
               task   => 'hash_0900134096122a7e68ee8ce60690acd1c67fe4',
               type   => 'STACK',
               hashes => [
                  'hash_100013f15c596e1a03887d1ff35dff0066d7ff',
                  'hash_100013181238ca7a5de200f15bff26c9386eb0',
                  'hash_10001336208e3c88fe1dcbdb2d48367646db91',
                  'hash_100013e23f356983345f281cec523ce06b811d'
               ]
            },
            {  color  => 'D8ACE0',
               item   => 'Com_update_multi',
               task   => 'hash_090013cbe8888cd86b44d178b09789a3b1cd82',
               type   => 'STACK',
               hashes => [
                  'hash_100013f549d1913a868d26f56e82630e4d743b',
                  'hash_10001365ae55f6b3a1a95ed5e3469fbfd7e516',
                  'hash_10001339fd88b9507249a13b2ebeff8505567b',
                  'hash_100013dbc20ab2c1f40ed2d6b39b2bd3b3a17b'
               ]
            },
            {  color  => '00B99B',
               item   => 'Com_replace_select',
               task   => 'hash_09001309481fc0b0ef3ca7fa008080dd66d3cd',
               type   => 'STACK',
               hashes => [
                  'hash_1000139c07a00e281edeb5d8348b0ee2f5eab4',
                  'hash_10001396508bb2f618f79f1f5d8ef70aa42ae7',
                  'hash_10001382105088462f61eeac14f30245c6087f',
                  'hash_1000132a56292a9002a3eb03f718139b48b128'
               ]
            }
         ]
      },
      {  hash => 'hash_00001396dd6e8156d0a2e832427ee96623959e',
         dt   => {
            hash         => 'hash_010013a2121560753c5140690165f8c594b84b',
            Select_range => {
               hash => 'hash_01001361fff8036b63b07d8863feeacc81c1d4',
               data_source_type_id => '2'
            },
            Select_full_range_join => {
               hash => 'hash_010013c9a6d87d4df6f96364f7bc700fadbc45',
               data_source_type_id => '2'
            },
            Select_full_join => {
               hash => 'hash_0100135e6cf8e6439278754a5ffb80e3bdef57',
               data_source_type_id => '2'
            },
            Select_scan => {
               hash => 'hash_010013e71fb77d0613171bc9b0fc92f2e58326',
               data_source_type_id => '2'
            },
            input              => 'Get MySQL Stats',
            Select_range_check => {
               hash => 'hash_0100138245046cf427baa6fb2a253a533225f3',
               data_source_type_id => '2'
            }
         },
         base_value => '1000',
         name       => 'MySQL Select Types',
         items      => [
            {  color  => 'FF0000',
               item   => 'Select_full_join',
               task   => 'hash_090013169dfcc76da4df50c022eb0ad6112def',
               type   => 'AREA',
               hashes => [
                  'hash_100013c56eef30cb2750b8c160595048a6fd40',
                  'hash_1000137dddaf0db46aed1eed2da9b0af799bc3',
                  'hash_1000139992f7d108b3a046ccd3ff9a4c3ecdf7',
                  'hash_100013e8b78bd4b9eaf82a252a1982169363eb'
               ]
            },
            {  color  => 'FF7D00',
               item   => 'Select_full_range_join',
               task   => 'hash_090013a29699386c2b6da1f14155617f1ea669',
               type   => 'STACK',
               hashes => [
                  'hash_10001327daf8c1e7a9aebf985c44bc937646ec',
                  'hash_100013f23fbb5d3be74ee20efb914d08a849e8',
                  'hash_1000136aef22e6514cfe8a3489c012f0f85fb0',
                  'hash_100013239e1dacf1a673cae8000e7a22425c8f'
               ]
            },
            {  color  => 'FFF200',
               item   => 'Select_range',
               task   => 'hash_0900131a7978d046d330b372907602db5d2f81',
               type   => 'STACK',
               hashes => [
                  'hash_10001383f1b2dbdab4e2d780683f8a9014f451',
                  'hash_1000133ca5d0704e28b5c55bcb19325c12f101',
                  'hash_100013f99f49daf66e88096d7615f2b1131192',
                  'hash_100013b15bce4c94ef4df5ea1402105e458bd1'
               ]
            },
            {  color  => '00CF00',
               item   => 'Select_range_check',
               task   => 'hash_09001351aa1a3638bff236cd4e0d679a18ade4',
               type   => 'STACK',
               hashes => [
                  'hash_100013488c4bc114ba402b7ed472f7ceabccf2',
                  'hash_100013ffdc03f26f6f691f460458e0fcfe1bc4',
                  'hash_1000137b499ad32708b136c05842ad07f54896',
                  'hash_100013f4286ff70508f23c03d619b8f8722c33'
               ]
            },
            {  color  => '7CB3F1',
               item   => 'Select_scan',
               task   => 'hash_0900131e31b92fbf08a36b590adb68bfd78a07',
               type   => 'STACK',
               hashes => [
                  'hash_100013e23d1f843362c44acf88bcedb6de2a54',
                  'hash_1000133cb99e0ee36b28fc509f175201b90e4b',
                  'hash_100013e6adff914ad87f65130e21b800e95955',
                  'hash_1000139cb350c0003fc595cafd7095535b686a'
               ]
            }
         ]
      },
      {  hash => 'hash_0000131364ec394731487e98e09deea6550d55',
         dt   => {
            hash      => 'hash_010013bd1be5ddd62b90c9d5be5bfc592e7b95',
            Sort_rows => {
               hash => 'hash_010013362757dae7975981676b254896863a43',
               data_source_type_id => '2'
            },
            Sort_merge_passes => {
               hash => 'hash_0100138aa489c6bb70310d14a24e56e31c9592',
               data_source_type_id => '2'
            },
            input     => 'Get MySQL Stats',
            Sort_scan => {
               hash => 'hash_010013ef1c94da33bc5d6378f01bd4afdb7c1c',
               data_source_type_id => '2'
            },
            Sort_range => {
               hash => 'hash_010013b77c61e0c59b1210d4ab0d94efc3c49e',
               data_source_type_id => '2'
            }
         },
         base_value => '1000',
         name       => 'MySQL Sorts',
         items      => [
            {  color  => 'FFAB00',
               item   => 'Sort_rows',
               task   => 'hash_090013ff8994fc32c6bdf048593f7eac733b2a',
               type   => 'AREA',
               hashes => [
                  'hash_10001345e3c5e3c0d7701a0b56c430e6fdcab9',
                  'hash_1000133a41008db73a7cd74715875a8bd52451',
                  'hash_1000133a133f5d14e06fee170c8ad7ef8de5c4',
                  'hash_100013c2fa578d29043b002e2cae7ebd4736db'
               ]
            },
            {  color  => '157419',
               item   => 'Sort_range',
               task   => 'hash_09001313eb3665a4e49e0331d7c4156fc72ec1',
               type   => 'LINE1',
               hashes => [
                  'hash_1000136083ab752c56ac346dfea41c113ff7a3',
                  'hash_1000138f01a56eeba5440b2fa838553db59fcd',
                  'hash_10001323beafb7767a9a4f601e637972486958',
                  'hash_100013456117e3d41e0b0b079a415ad46ef523'
               ]
            },
            {  color  => 'DA4725',
               item   => 'Sort_merge_passes',
               task   => 'hash_090013bddcf6936609d2bfab6259af78716ac8',
               type   => 'LINE1',
               hashes => [
                  'hash_1000135ba3612031bfe6d070f78912b97c8d03',
                  'hash_1000138928744e7f6ac91022ba96fba38589e4',
                  'hash_100013ad5819a6628719e7a49fdd8ac7ae97db',
                  'hash_100013ffd49771ea557b9845ffc3f21169dfdf'
               ]
            },
            {  color  => '4444FF',
               item   => 'Sort_scan',
               task   => 'hash_090013e9ec5c2d2318b0f46893467dc81806fd',
               type   => 'LINE1',
               hashes => [
                  'hash_10001389ac96e847224611f4b23ebe3c687182',
                  'hash_1000131e640214365964c47ef1648a660b1b7c',
                  'hash_1000130dbca0e7c3b7dc3c4aaf94545f73780f',
                  'hash_100013505915e62a2a048e8e44697efc05685a'
               ]
            }
         ]
      },
      {  hash => 'hash_0000139f74469a04ea366f93adb382bf9feb0d',
         dt   => {
            Created_tmp_disk_tables => {
               hash => 'hash_0100135668ee63d100ff3e25f235b47099e56c',
               data_source_type_id => '2'
            },
            hash => 'hash_01001308d29df27f37a2c74559f48ff77905a0',
            Created_tmp_tables => {
               hash => 'hash_010013322a90733977c40c16f4ea07987e39c0',
               data_source_type_id => '2'
            },
            input             => 'Get MySQL Stats',
            Created_tmp_files => {
               hash => 'hash_01001310c2532bfb063c2795e0846f5c8466a1',
               data_source_type_id => '2'
            }
         },
         base_value => '1000',
         name       => 'MySQL Temporary Objects',
         items      => [
            {  color  => 'FFAB00',
               item   => 'Created_tmp_tables',
               task   => 'hash_09001336437272524ecb132ac818f6ab3c6276',
               type   => 'AREA',
               hashes => [
                  'hash_10001309a8c0e87dae4f0992ca91ab68ec5073',
               ],
            },
            {  color  => '837C04',
               item   => 'Created_tmp_tables',
               task   => 'hash_09001336437272524ecb132ac818f6ab3c6276',
               type   => 'LINE1',
               hashes => [
                  'hash_10001388983587ec40912f7323632c80c8d604',
                  'hash_1000133868c9f1c6a36578f03a37e589378ed5',
                  'hash_100013adfd30ecf4b2fbfca111cf83f597928b',
                  'hash_10001346d958f121c20c56e49e2649099ba494'
               ]
            },
            {  color  => 'F51D30',
               item   => 'Created_tmp_disk_tables',
               task   => 'hash_0900135eb6098c631183c1179a906a06f9bcf2',
               type   => 'LINE1',
               hashes => [
                  'hash_1000134931d6a0ed43bbeb26cf42b8be7af622',
                  'hash_100013b1ef407b7f6e0560296b6a1a8d6cf0cc',
                  'hash_100013a4f1beec017b91120d0b7c8256144bc2',
                  'hash_100013e12998eb863e61739ac92a950ea120d1'
               ]
            },
            {  color  => '157419',
               item   => 'Created_tmp_files',
               task   => 'hash_0900137d5d928963ff6387badc0b6a253ffd12',
               type   => 'LINE2',
               hashes => [
                  'hash_10001346267ac815f34fdabfa2229e4ceca4a3',
                  'hash_1000134e440d1c26bbb47bc12f42893c811691',
                  'hash_100013330a3ac3b383c1006dfa9abe85405ceb',
                  'hash_100013ef72b720c40ffcb1be23085b710457b1'
               ]
            }
         ]
      },
      {  hash => 'hash_0000130461c811ce958cecfb41bdbb16b2f72b',
         dt   => {
            hash           => 'hash_01001386055944cd5a58072ab8b2db2488a1ef',
            input          => 'Get MySQL Stats',
            Bytes_received => {
               hash => 'hash_0100130dc4474ee42f80143630b1c03f5292c6',
               data_source_type_id => '2'
            },
            Bytes_sent => {
               hash => 'hash_0100137fb4bf9ceb329586e4b503c1e1923ca8',
               data_source_type_id => '2'
            }
         },
         base_value => '1024',
         name       => 'MySQL Network Traffic',
         items      => [
            {  color  => '6DC8FE',
               item   => 'Bytes_received',
               task   => 'hash_09001310e148a3f5d6bb38c7b10cacc68c5e15',
               type   => 'AREA',
               hashes => [
                  'hash_1000132c3bc6cf1e7b659f900870349739fee2',
                  'hash_10001339e91e27c91788433d0aa45874ca4a73',
                  'hash_1000139e97e4b3c18e969f41f6996e8cca64e2',
                  'hash_100013d927842a2873737a5b088611da3efa6e'
               ]
            },
            {  color  => 'F9FD5F',
               item   => 'Bytes_sent',
               task   => 'hash_090013d8d287ac8a465386f8697bec412a2916',
               type   => 'STACK',
               hashes => [
                  'hash_100013f9276bc645b301cb7ed35be16bfbf863',
                  'hash_100013cc9fe030f9b3acf9ca42f030097b8d59',
                  'hash_100013061261483ac3a8baebd9e3f3e270002e',
                  'hash_1000135421724540377f8b0c11deb852325fdb'
               ]
            }
         ]
      },
      {  hash => 'hash_0000130769eb5b1fead3b8981e29659105bd17',
         dt   => {
            pages_written => {
               hash => 'hash_01001353c047bd9eadb7ad5e743d05cbaaf84b',
               data_source_type_id => '2'
            },
            hash          => 'hash_01001371058b0c913ca3b1c3f4246c628731fb',
            input         => 'Get MySQL Stats',
            pages_created => {
               hash => 'hash_0100139a01b6e087c3ef063799178d306feb97',
               data_source_type_id => '2'
            },
            pages_read => {
               hash => 'hash_010013c398c4cdc2f9c82448fa443a641b810d',
               data_source_type_id => '2'
            }
         },
         base_value => '1024',
         name       => 'InnoDB Buffer Pool Activity',
         items      => [
            {  color  => 'FFAB00',
               item   => 'pages_created',
               task   => 'hash_0900133f68d0dacb01ae52ee57d32845184b97',
               type   => 'AREA',
               hashes => [
                  'hash_100013462fc089f00bca62dd10b09b5862838f',
                  'hash_1000133c900059ae6cc8145ac328de111cc8a9',
                  'hash_100013eec5ae6bc3c3ce86ac0a4b9d9ad07e5a',
                  'hash_10001367e882593a3f67a8e3319cba1c881412'
               ]
            },
            {  color  => 'D8ACE0',
               item   => 'pages_read',
               task   => 'hash_090013a173cf9cad9ebd6394b220700c72887c',
               type   => 'STACK',
               hashes => [
                  'hash_100013edf22d9ba85d806adb691f9d79450da3',
                  'hash_100013c7fe57ccf638845a30d74557ed005e62',
                  'hash_1000138c232a2da0e09884bc124da80f451505',
                  'hash_100013765aabd73eb15beeb616f4aaba657818'
               ]
            },
            {  color  => '7CB3F1',
               item   => 'pages_written',
               task   => 'hash_090013bbd21b7341904b7f4e162dcdf7fe4bb0',
               type   => 'STACK',
               hashes => [
                  'hash_100013e0228f620c72daec30dcbdff9baa07da',
                  'hash_100013172bfa89f1bed5ce930a52737af78fa4',
                  'hash_1000134d1b82e9640177b4c7d74fc29265f1b3',
                  'hash_10001326cd06f682d8bd046412f1d3e2ec98d0'
               ]
            }
         ]
      },
      {  hash => 'hash_0000138d45ae00a3c6856c8cb4e27e0c10eae6',
         dt   => {
            pending_ibuf_aio_reads => {
               hash => 'hash_010013be22dfb8efd92b9fe309592dec10cc8d',
               data_source_type_id => '1'
            },
            input               => 'Get MySQL Stats',
            pending_chkp_writes => {
               hash => 'hash_010013800348e37be481771454d906c1d1d8de',
               data_source_type_id => '1'
            },
            pending_normal_aio_reads => {
               hash => 'hash_010013e21d7e99fa7ef26cacb7752e46a478cc',
               data_source_type_id => '1'
            },
            hash => 'hash_010013f1e9a48e5e5ee153ebee5aee529b46a6',
            pending_buf_pool_flushes => {
               hash => 'hash_0100138c57848b1f40239c68b01e0b66310d4a',
               data_source_type_id => '1'
            },
            pending_aio_log_ios => {
               hash => 'hash_010013fc152dab944cf8defb9abca88eca72ab',
               data_source_type_id => '1'
            },
            pending_log_writes => {
               hash => 'hash_01001325cc4d35043d3209f5c04d82757c93d2',
               data_source_type_id => '1'
            },
            pending_aio_sync_ios => {
               hash => 'hash_01001336c9b07cd0ae44be946eac9d2c5990f7',
               data_source_type_id => '1'
            },
            pending_normal_aio_writes => {
               hash => 'hash_010013fa7e7dd36bd47498841b103fb0d333a4',
               data_source_type_id => '1'
            },
            pending_log_flushes => {
               hash => 'hash_0100135375f9f3b8b479d403330074c5dd6b57',
               data_source_type_id => '1'
            }
         },
         base_value => '1000',
         name       => 'InnoDB I/O Pending',
         items      => [
            {  color  => 'FF0000',
               item   => 'pending_aio_log_ios',
               task   => 'hash_0900135aa2c17a7bb448e4180a1c28db51b591',
               type   => 'LINE1',
               hashes => [
                  'hash_100013d21a9951ba8813a4505f2572e2bef676',
                  'hash_100013f03e27a71b81610e839262a2fb8ec4b7',
                  'hash_1000131a0cbc1cba7bfd5cf5d641b6146c0c4b',
                  'hash_10001308e80ca0dc28c401920dbd3540cf765a'
               ]
            },
            {  color  => 'FF7D00',
               item   => 'pending_aio_sync_ios',
               task   => 'hash_09001365cc4c97240cf85f016eb669a1b4f354',
               type   => 'LINE1',
               hashes => [
                  'hash_100013ce67b7a964ab4c3bc8a1578e5dcc76f9',
                  'hash_100013dd876c2147e37ff976803a18ef40371a',
                  'hash_100013619e93ae2a74953949153852cc0621fe',
                  'hash_10001376c4e95626c9cc0cec44da88decb3925'
               ]
            },
            {  color  => 'FFF200',
               item   => 'pending_buf_pool_flushes',
               task   => 'hash_090013101a3323f1645a6d7edb5a0c37198240',
               type   => 'LINE1',
               hashes => [
                  'hash_1000138aa736fa01c628e975b41252e512ec94',
                  'hash_10001365b2e3b048397ed0e1480b7319fb3443',
                  'hash_100013c72917dfc5af5dd476f266520d425241',
                  'hash_100013fc81f3cb45d20d13316d69a8574917dd'
               ]
            },
            {  color  => '00A348',
               item   => 'pending_chkp_writes',
               task   => 'hash_0900133d596ee5a228b20433cc863155d03956',
               type   => 'LINE1',
               hashes => [
                  'hash_10001317582e94b4264ab817938c8bada78efa',
                  'hash_100013db72e7d89fea92ef3e9abc3706b27b36',
                  'hash_10001309946af875c05e210f8f70f01f24d93e',
                  'hash_100013027cb7c607a2e0f20227cf3ebc5341f2'
               ]
            },
            {  color  => '6DC8FE',
               item   => 'pending_ibuf_aio_reads',
               task   => 'hash_090013272b558c66014863c060908d89448961',
               type   => 'LINE1',
               hashes => [
                  'hash_1000139673dcdfd1f439cf6ca7a8871d0979c9',
                  'hash_100013e023366a6af291e1797b7c7d57fb7f79',
                  'hash_100013e63fe4d64fc6eb41ad1d8745b36a3d04',
                  'hash_1000132354e66e7c9a43f02c6b1e7d9e51dc91'
               ]
            },
            {  color  => '4444FF',
               item   => 'pending_log_flushes',
               task   => 'hash_09001379fd321f9acb3991efc056fdeb3cedb1',
               type   => 'LINE1',
               hashes => [
                  'hash_100013db06f04a06097376c0bed252423c8c6c',
                  'hash_1000139cb48a22ccd7bd680511fb702b1dcf71',
                  'hash_100013ad44daf07dfb9a2a4df14b3ec3ce8f58',
                  'hash_1000138f525137edd9df0006f1eef9bfa69401'
               ]
            },
            {  color  => '55009D',
               item   => 'pending_log_writes',
               task   => 'hash_0900132f205d604d825b8ba4894c6ccdb20ff4',
               type   => 'LINE1',
               hashes => [
                  'hash_100013fe3f897a75b84aee639e832063610f27',
                  'hash_1000139f014c0d51042ab5de5aa5dc04a35d87',
                  'hash_10001319197f10e9a007e1ae58dbe0881d01e0',
                  'hash_100013fbcf731f5ab559282403896740822952'
               ]
            },
            {  color  => 'B90054',
               item   => 'pending_normal_aio_reads',
               task   => 'hash_09001331023270b18d06a25de3b4e8d1f81988',
               type   => 'LINE1',
               hashes => [
                  'hash_10001315c67502eadf765f66179d6ca5d6761b',
                  'hash_1000131dff5f52f49d6ae236c856e23d85a8a3',
                  'hash_1000137542394e5b2210ee44e2f2fa5bef6042',
                  'hash_100013e11cf5f3587dcf6e066fdef5fbff7818'
               ]
            },
            {  color  => '8F9286',
               item   => 'pending_normal_aio_writes',
               task   => 'hash_090013c26c20a87d2cca682599b33fe3863c7e',
               type   => 'LINE1',
               hashes => [
                  'hash_100013b7525295600f757e9abaef973c74f418',
                  'hash_10001300b2d22372be4021532bddf9a7b93792',
                  'hash_100013ce1bb418cdf977ea49ceb48f2e6f6677',
                  'hash_100013564854fe731da9f47140e39d1fdcb027'
               ]
            }
         ]
      },
      {  hash => 'hash_0000136932388e4d279763fbb5aa8de2ae234f',
         dt   => {
            unflushed_log => {
               hash => 'hash_010013dbfd089a2e1f44392fcfa1c3499f1013',
               data_source_type_id => '2'
            },
            hash => 'hash_01001331dcfc560537b6f93ced9e6aa6c272e0',
            log_bytes_written => {
               hash => 'hash_010013dc4885299416ee40c40c96b36f1a0511',
               data_source_type_id => '2'
            },
            log_bytes_flushed => {
               hash => 'hash_010013de41286a9e5734185c7a4eac909a1580',
               data_source_type_id => '2'
            },
            innodb_log_buffer_size => {
               hash => 'hash_010013297edbf2eccbdf0dabda7d8166884cd5',
               data_source_type_id => '1'
            },
            input => 'Get MySQL Stats'
         },
         base_value => '1024',
         name       => 'InnoDB Log',
         items      => [
            {  color  => 'FAFD9E',
               item   => 'innodb_log_buffer_size',
               task   => 'hash_09001311fb91244cce5df61a0da010fb524445',
               type   => 'AREA',
               hashes => [
                  'hash_100013c423f770cd7c28ea828f07eafe8a0d8e',
                  'hash_100013944a7ba19cd050a8a7bf97eaf92e2abd'
               ]
            },
            {  color  => '4444FF',
               item   => 'log_bytes_written',
               task   => 'hash_09001347fac87eaf3a0b2ddaac47352c0e3396',
               type   => 'AREA',
               hashes => [
                  'hash_1000130b5c10093a46c828a111a7cec5a0185f',
                  'hash_100013acf3d6e8c8956e88c608785f45b3aaf3',
                  'hash_100013a65ab0ae13164a97f9a0ab34f157ef53',
                  'hash_100013502ad627f2520ca965e29e693ef0289e'
               ]
            },
            {  color  => '00FF00',
               item   => 'log_bytes_flushed',
               task   => 'hash_090013ccd834528645793e0f8c001dd24ef966',
               type   => 'LINE1',
               hashes => [
                  'hash_1000133e79586e910c279a76578637b0878d10',
                  'hash_100013c0966b24084c40ef5a85e0febd2f4052',
                  'hash_10001384554ec500c694be73d300733e1873a4',
                  'hash_1000133e65794f011f26f044b88b7bda7c51de'
               ]
            },
            {  color  => 'FF4105',
               item   => 'unflushed_log',
               task   => 'hash_09001341a98dfb81d93aad098e007e696143cb',
               type   => 'AREA',
               hashes => [
                  'hash_100013da80bd49abd1bdea5a9cea349b0b199c',
                  'hash_100013316e2c71816a5c05bf978f1d66c122fe',
                  'hash_100013ac65e2932e4436f728d862e1ffa4bff3',
                  'hash_100013998cb4617d6e1f967542e3bec06c3758'
               ]
            }
         ]
      },
      {  hash => 'hash_0000137625c8f2f05e861825644bc1832779a3',
         dt   => {
            Binlog_cache_use => {
               hash => 'hash_010013f787be2f29e6a6c727d51629d310dd4c',
               data_source_type_id => '2'
            },
            Binlog_cache_disk_use => {
               hash => 'hash_010013c5d1d5f676d73244c30e0d71c9324fd1',
               data_source_type_id => '2'
            },
            hash             => 'hash_010013e8dd5e9ae743b7b64c91aa09862c20cd',
            binary_log_space => {
               hash => 'hash_010013a4b9d1a7f255ad789d348354091cb475',
               data_source_type_id => '1'
            },
            input           => 'Get MySQL Stats',
            relay_log_space => {
               hash => 'hash_010013d17011029e29581769e5414579ca2f5c',
               data_source_type_id => '1'
            }
         },
         base_value => '1024',
         name       => 'MySQL Binary/Relay Logs',
         items      => [
            {  color  => '35962B',
               item   => 'Binlog_cache_use',
               task   => 'hash_090013845a2453632d3adb9c9a17ef7a7b2551',
               type   => 'LINE1',
               hashes => [
                  'hash_100013c5b05fc456a9cad2a69a58ee3e56118a',
                  'hash_10001394bd92fcfd69ebdb73c3a3577dc7ef58',
                  'hash_100013dd96f360449d720dbc16864dbb15e8fc',
                  'hash_1000131699c5a26d871b28b9d4eb51eef53f8a'
               ]
            },
            {  color  => 'FF0000',
               item   => 'Binlog_cache_disk_use',
               task   => 'hash_0900136269a13748fd88a1400b82d00a2c7f3c',
               type   => 'LINE1',
               hashes => [
                  'hash_1000138bad3e47d6fb153fbc99794918fe2512',
                  'hash_1000138032865a15e68e2e0555d22edd5ff42c',
                  'hash_100013632bda96bd1eac81024969c449f204d7',
                  'hash_1000130a539358313a62bfa639091d8517c498'
               ]
            },
            {  color  => '8D00BA',
               item   => 'binary_log_space',
               task   => 'hash_090013cea2aa6e1e341f8087a216c23828fd83',
               type   => 'LINE1',
               hashes => [
                  'hash_100013d6582cb06b9d448e2c3c3bb6e50c50d5',
                  'hash_100013cb4d8c2db6435a9ccfc5f53862f02a3d',
                  'hash_1000139d0b945724e324e22a604c72950b4ead',
                  'hash_100013cd0efca302f184dd204924ee64df2fdf'
               ]
            },
            {  color  => '8F005C',
               item   => 'relay_log_space',
               task   => 'hash_090013a438532286deb84c433682de21d31cf4',
               type   => 'LINE1',
               hashes => [
                  'hash_100013857d639ccb42443ae1f6f9760aa635bc',
                  'hash_100013aa2b804807ffbf1e9e43e9a352842b6c',
                  'hash_100013e785b7e00e316e6f4c32a0a377bf204d',
                  'hash_100013abb03054799f429bf4b4a6c19bf5dc2d'
               ]
            }
         ]
      },
      {  hash => 'hash_00001351903a7fa74d34dbbb9ab47203b7362b',
         dt   => {
            innodb_transactions => {
               hash => 'hash_0100134bb48cfeb0c6ba33cd0efc263f17d3d6',
               data_source_type_id => '2'
            },
            input            => 'Get MySQL Stats',
            transaction_time => {
               hash => 'hash_010013eebbc6aae3eae872da81fdf51cdf3b63',
               data_source_type_id => '1'
            },
            read_views => {
               hash => 'hash_01001324c6e5dcd3e22c73c19a3ff8eee9d6c2',
               data_source_type_id => '1'
            },
            hash         => 'hash_010013fbbf7f38a0a20613dc79003f0c702084',
            history_list => {
               hash => 'hash_010013d77d77348050b6a61f9df87f2cd0a47c',
               data_source_type_id => '1'
            },
            transaction_lock_time => {
               hash => 'hash_0100133a2b84efcc69304a9362a08cda9c1da2',
               data_source_type_id => '1'
            },
            current_transactions => {
               hash => 'hash_01001365dd57fbce5ead54134c6503c037db90',
               data_source_type_id => '1'
            }
         },
         base_value => '1000',
         name       => 'InnoDB Transactions',
         items      => [
            {  color  => '8F005C',
               item   => 'innodb_transactions',
               task   => 'hash_090013ed94196aac019b05e7d6dea85d2426ed',
               type   => 'LINE1',
               hashes => [
                  'hash_100013c3a080885091b936617afd51968e86fe',
                  'hash_1000138bbb9681ff7835d6d725f5f9de021f21',
                  'hash_100013acbd62720c59a24b72df434f5f997be5',
                  'hash_100013c2635e832f989960faa2710b780c48e8'
               ]
            },
            {  color  => '4444FF',
               item   => 'current_transactions',
               task   => 'hash_090013a34797ac2967209ac53511847683d493',
               type   => 'LINE1',
               hashes => [
                  'hash_1000131541676d140a4dac37656c772c56e83f',
                  'hash_1000130d2599eaa11fd4e3f1c1f56df279df0a',
                  'hash_100013a4557928a62844ccb487e73ec01aa6e0',
                  'hash_1000132818ffcfcceaa49d0d0f1f2315af2006'
               ]
            },
            {  color  => 'FF7D00',
               item   => 'history_list',
               task   => 'hash_090013e3f9eafa729269f2f1f0be84469739c4',
               type   => 'LINE1',
               hashes => [
                  'hash_100013b66a6d7a2ef6f29f92dd2cd07aa5ab55',
                  'hash_100013b68ced42be8345b14d16c9e9e714a93e',
                  'hash_100013b098dc91c0b51b21e318aaf2181238e4',
                  'hash_100013fd6f9a810514cfb9bdf5bc9638394538'
               ]
            },
            {  color  => '74C366',
               item   => 'read_views',
               task   => 'hash_0900132ec141f159d322bcc954561e4584ce44',
               type   => 'LINE1',
               hashes => [
                  'hash_1000136d6d7abff63a7a52a1ee61168f8320a1',
                  'hash_10001326bba3ca70e705b05186396a4379357f',
                  'hash_10001358e550f8923ae74195585e11270de50a',
                  'hash_1000138f81adca5b09f671a0ce364c66c910ad'
               ]
            },
            {  color  => '008A77',
               item   => 'transaction_time',
               task   => 'hash_0900139b7ede3cb56c016117f8ad798feca2f6',
               type   => 'LINE1',
               hashes => [
                  'hash_100013da7cc5076c20eb4dd7cd8b7005b5a78c',
                  'hash_10001308dbaa0ba9d48310029556ffc1694b70',
                  'hash_1000134e2f590c5dd7fde2b176181dc1cb6349',
                  'hash_1000134197391512332c371d61c0413845bbd1'
               ]
            },
            {  color  => '8D00BA',
               item   => 'transaction_lock_time',
               task   => 'hash_090013c4b2e1795809d0bf27a6605da2a29b2e',
               type   => 'LINE1',
               hashes => [
                  'hash_100013acab0ed39cc9248741adc1ea80ec73c1',
                  'hash_100013ac8025ab358d0d25dfbf6fb8fd733a67',
                  'hash_1000137fb1c36d3bc9c35317e868c0ff7ff103',
                  'hash_100013378bec8aeabd7610226342495813a139'
               ]
            }
         ]
      },
      {  hash => 'hash_0000134a866608a68455a7e007c6ed07b1389a',
         dt   => {
            hash       => 'hash_010013a9377536471aa6701b8fb1eeb264e1c0',
            Open_files => {
               hash => 'hash_0100139b2465446100422df23bc22189d93d49',
               data_source_type_id => '1'
            },
            Opened_tables => {
               hash => 'hash_010013b31d2e1ef1d9178247ce4e874ae88e33',
               data_source_type_id => '2'
            },
            Open_tables => {
               hash => 'hash_0100136a4c5bbc5e1010c27f25ae5099125a9b',
               data_source_type_id => '1'
            },
            input       => 'Get MySQL Stats',
            table_cache => {
               hash => 'hash_0100139576ab3e9c3b59b7806af18db882a6ec',
               data_source_type_id => '1'
            }
         },
         base_value => '1000',
         name       => 'MySQL Files and Tables',
         items      => [
            {  color  => '96E78A',
               item   => 'table_cache',
               task   => 'hash_09001398b2586579aa124db0a44157312cda88',
               type   => 'AREA',
               hashes => [
                  'hash_10001333a746dcc4a95dff1b433fee306e0684',
                  'hash_10001329c6a88d42f3f9bf18fd6d11ca87990d'
               ]
            },
            {  color  => '9FA4EE',
               item   => 'Open_tables',
               task   => 'hash_0900134b9f13b60f1047b67f585952fcdd523c',
               type   => 'LINE1',
               hashes => [
                  'hash_100013976798d4f86d71a171872e9f088885fc',
                  'hash_10001323f8dc021c342f1a836acc07dd9f6707',
                  'hash_100013b28206886165e05ae5f8d4e2f5b0dc94',
                  'hash_1000139890f3f876ae0ba5d63c7584c49899a5'
               ]
            },
            {  color  => 'FFD660',
               item   => 'Open_files',
               task   => 'hash_090013040612acab7300d2c6774e5f08b789e1',
               type   => 'LINE1',
               hashes => [
                  'hash_100013d9dfa15dcbd8c9e1f48e0e6791898f47',
                  'hash_10001380449a7ae5a282757b2b979be8390a2f',
                  'hash_10001378b40b8618a0580d2c860bb21f9c0a9e',
                  'hash_1000137ab18fafaba985d7dd05f1ecb320bee1'
               ]
            },
            {  color  => 'FF0000',
               item   => 'Opened_tables',
               task   => 'hash_0900132e51ebb8bb7188432bcc3f789d3bc8b0',
               type   => 'LINE1',
               hashes => [
                  'hash_100013e7bb489f5d3384b0100ac76c4448bc79',
                  'hash_100013ba5f7f8444ec9094a1db780cda473702',
                  'hash_1000131b78488e57bdd0d87f443d4588be6577',
                  'hash_1000135dbf7983e735e09f45d0e6ff19547089'
               ]
            }
         ]
      },
      {  hash => 'hash_000013f530abf34e8b5a64302b3bd0b5e910be',
         dt   => {
            hash            => 'hash_010013f12a4fdc2bbe8cee87181ba0feaf67ed',
            input           => 'Get MySQL Stats',
            Threads_created => {
               hash => 'hash_010013b46bed6846abf8d3061ff730d770d13e',
               data_source_type_id => '2'
            },
            thread_cache_size => {
               hash => 'hash_0100138983fa5dd8398bfa87abd22a32a1c849',
               data_source_type_id => '1'
            }
         },
         base_value => '1000',
         name       => 'MySQL Threads',
         items      => [
            {  color  => 'D8ACE0',
               item   => 'thread_cache_size',
               task   => 'hash_090013af84905979e09a5edb8aeb5548e1ef9f',
               type   => 'AREA',
               hashes => [
                  'hash_100013ad46b6a1aa4f388b3abe0c49ca447cae',
                  'hash_1000136585d5733853c43deb022b40ccfdbb30'
               ]
            },
            {  color  => 'DE0056',
               item   => 'Threads_created',
               task   => 'hash_090013465942b335de9c95920252ccacf9e21f',
               type   => 'LINE1',
               hashes => [
                  'hash_1000134b53caedc48f17e9c108b9e4f858b63a',
                  'hash_100013721c9388de416c984c2b58400c98cec0',
                  'hash_100013c88f9d4ffcdcef3df7d82628195b5d74',
                  'hash_1000134e64d92b5d72ef80783e7531a7af0912'
               ]
            }
         ]
      },
   ],
   rras => [
      {  hash           => 'hash_150013c21df5178e5c955013591239eb0afd47',
         name           => 'Daily (5 Minute Average)',
         x_files_factor => '0.5',
         steps          => 1,
         rows           => 600,
         timespan       => 86400,
         cf_items       => '1|3',
      },
      {  hash           => 'hash_1500130d9c0af8b8acdc7807943937b3208e30',
         name           => 'Weekly (30 Minute Average)',
         x_files_factor => '0.5',
         steps          => '6',
         rows           => '700',
         timespan       => '604800',
         cf_items       => '1|3',
      },
      {  hash           => 'hash_1500136fc2d038fb42950138b0ce3e9874cc61',
         name           => 'Monthly (2 Hour Average)',
         x_files_factor => '0.5',
         steps          => '24',
         rows           => '775',
         timespan       => '2678400',
         cf_items       => '1|3',
      },
      {  hash           => 'hash_150013e36f3adb9f152adfa5dc50fd2b23337f',
         name           => 'Yearly (1 Day Average)',
         x_files_factor => '0.5',
         steps          => '288',
         rows           => '797',
         timespan       => '33053184',
         cf_items       => '1|3',
      },
   ],
   gprints => {
      Normal => {
         hash        => 'hash_060013e9c43831e54eca8069317a2ce8c6f752',
         gprint_text => '%8.2lf %s',
      },
   }
};
