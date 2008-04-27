# This is the template definition file.  To use it, see make-template.pl.
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
# Foundation, version 2.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, write to the Free Software Foundation, Inc., 59 Temple
# Place, Suite 330, Boston, MA  02111-1307  USA.

{  gprints => {
      Normal => {
         gprint_text => '%8.2lf %s',
         hash        => 'hash_060013e9c43831e54eca8069317a2ce8c6f752'
      }
   },
   graphs => [
      {  base_value => '1000',
         dt         => {
            Key_read_requests => {
               data_source_type_id => '2',
               hash => 'hash_080013b407e61e9948460c99116f7f6a72cf92'
            },
            Key_reads => {
               data_source_type_id => '2',
               hash => 'hash_0800130de2bf128eac0bc672d77085da38f8cf'
            },
            Key_write_requests => {
               data_source_type_id => '2',
               hash => 'hash_080013039d69d0262c783f20b77fa3b3f62e88'
            },
            Key_writes => {
               data_source_type_id => '2',
               hash => 'hash_080013f8851b46ed984a9e8fba454c48995230'
            },
            hash  => 'hash_01001329f0b43ffd723039d3428839ab9f5174',
            input => 'Get MySQL Stats'
         },
         hash  => 'hash_000013c870e809c16ac409190bcfbaf6c55624',
         items => [
            {  color  => '157419',
               hashes => [
                  'hash_100013ac260a1434298e088f15f70cd1a5f726',
                  'hash_1000132880fe948b6912a3bbef6d572fc08c11',
                  'hash_1000137ad6f41485c166ba32e6d9e570e395f0',
                  'hash_100013c0e60c7d108ee721a537bb6e3c62a1d8'
               ],
               item => 'Key_read_requests',
               task => 'hash_0900135f6452acaf1e44638836412e2a701af5',
               type => 'AREA'
            },
            {  color  => 'AFECED',
               hashes => [
                  'hash_10001325df59422c805e4b85310ec3a4face3b',
                  'hash_100013f8b4402537c5b8f6fe87f025b66fa36d',
                  'hash_100013508445350edf7ebffcc53df8ca402cd4',
                  'hash_100013ce2c5b685c988e9ba283a5b26019a228'
               ],
               item => 'Key_reads',
               task => 'hash_090013cf20ffcf42c91bb6f8e6d4cadc6b74a5',
               type => 'LINE1'
            },
            {  color  => 'F51D30',
               hashes => [
                  'hash_100013c8ddc4e379739fa6860644b9ec73fd67',
                  'hash_100013eee6bf6b5627650df8625d88f333299f',
                  'hash_100013c13f3d345b73c7333254c1d3efcbd02f',
                  'hash_100013c1d97c83fc4b5cbed160c1530f937307'
               ],
               item => 'Key_write_requests',
               task => 'hash_0900131d370e9a5914bc84d71e779814f357cb',
               type => 'LINE1'
            },
            {  color  => '862F2F',
               hashes => [
                  'hash_100013b05a1a789491c12bed93e2c610e72fa0',
                  'hash_100013c5621ec923c0e47f0603638f9fbb5815',
                  'hash_1000137e9cc68942f31c8de3788336f080166f',
                  'hash_100013c6da7f77308d3127ca7e18385c86ceeb'
               ],
               item => 'Key_writes',
               task => 'hash_090013b06844c326fac7ec50d9819b47b3430a',
               type => 'LINE1'
            }
         ],
         name => 'MyISAM Indexes'
      },
      {  base_value => '1024',
         name => 'InnoDB Buffer Pool',
         # Color palette: http://www.colourlovers.com/palette/354987/DSH
         dt         => {
            hash           => 'hash_01001371058b0c913ca3b1c3f4246c628731fc',
            input          => 'Get MySQL Stats',
            database_pages => {
               data_source_type_id => '1',
               hash => 'hash_0800132ced436e455d14013f6d824e36295005'
            },
            free_pages => {
               data_source_type_id => '1',
               hash => 'hash_080013e00cdf7624957fb1206d92c65ea6fcc3'
            },
            modified_pages => {
               data_source_type_id => '1',
               hash => 'hash_080013714b9bccd3200f6d46fb3ff36be3bf16'
            },
            pool_size => {
               data_source_type_id => '1',
               hash => 'hash_08001368cc20ea3e77e990d749356e21a8ed01'
            }
         },
         hash  => 'hash_000013000d2d952ec15762ba04f6384dba51d2',
         items => [
            {  color  => '3D1500',
               hashes => [
                  'hash_1000136820faaa15e407a4443588d8afc41fdb',
                  'hash_100013cb3addf6f0a3c3b7f4c7ffc2cffb73b9'
               ],
               item => 'pool_size',
               task => 'hash_0900132cb12f1e0ce4b35cac3f026054f4bee4',
               type => 'AREA'
            },
            {  color  => 'AA3B27',
               hashes => [
                  'hash_10001381b0c8274aecfa8a5e304eabdaa7f3a9',
                  'hash_100013cc3c68b2b4f7fb46913301aea0a6c1ae',
                  'hash_1000130e7d24bce7e20e0a0b393d529a55a15c',
                  'hash_100013ec9b15475d486e684c1e3c9c099cedf6'
               ],
               item => 'free_pages',
               task => 'hash_090013b7800e17a4e0a97464eda1b373839eb7',
               type => 'AREA'
            },
            {  color  => 'EDAA41',
               hashes => [
                  'hash_100013f831741492af46b72bc0a63d11e72869',
                  'hash_1000137abd57dc40efb7827d1424f07b8e98be',
                  'hash_1000138143fa8b86d4cc3a87adc35dfc64628b',
                  'hash_100013cb634dc53fa8a86fa5ab0e3828d1fab9'
               ],
               item => 'database_pages',
               task => 'hash_090013d265fe62da24ab1ac26a4a15b3da438e',
               type => 'STACK'
            },
            {  color  => '13343B',
               hashes => [
                  'hash_1000137053cc7687881295d23bc15f108e9433',
                  'hash_1000135ab29120a18ffd753145908aabcb0478',
                  'hash_10001362855c548aa45caba7040ee61cf02b56',
                  'hash_100013e2da9c2dbdae0035fbbcf11829f14b04'
               ],
               item => 'modified_pages',
               task => 'hash_090013b79a39e463530e8ccb536ea79fa0be51',
               type => 'LINE1'
            }
         ],
      },
      {  base_value => '1000',
         # Palette: http://www.colourlovers.com/palette/299787/What_Shall_I_Do
         name       => 'InnoDB I/O',
         dt         => {
            file_fsyncs => {
               data_source_type_id => '2',
               hash => 'hash_0800131b83b09538bc14ae68e1e9a58d0ea4ce'
            },
            file_reads => {
               data_source_type_id => '2',
               hash => 'hash_0800139faa26c606b6b28778864d5081588c62'
            },
            file_writes => {
               data_source_type_id => '2',
               hash => 'hash_0800131452aa7aa7147b5a81f90acf29e344a7'
            },
            hash       => 'hash_010013c56de26b6cec34796af17026e8b1e1f5',
            input      => 'Get MySQL Stats',
            log_writes => {
               data_source_type_id => '2',
               hash => 'hash_080013506dc7cea79a8e9167a2961e4af16f4f'
            }
         },
         hash  => 'hash_000013da247361e59f209d69be79ada9b05665',
         items => [
            {  color  => '402204',
               hashes => [
                  'hash_100013d444cf5b2282941e7a2095d0a8c6ed59',
                  'hash_100013910f8d7e8652692960dba852989d6f52',
                  'hash_100013906960013ebee0cae830a4f11f84891a',
                  'hash_10001344e429dac2b9310aee69450e868760c7'
               ],
               item => 'file_reads',
               task => 'hash_090013a7dc405b5920611b788cadc936442a0a',
               type => 'LINE1'
            },
            {  color  => 'B3092B',
               hashes => [
                  'hash_100013a003f2270ea883d97dcf72d1af33f596',
                  'hash_10001334324f39d4a59acdf77d15b4a6959138',
                  'hash_100013dacf6b13991386eacf7e598ad906ceb9',
                  'hash_1000132b7efe0d49f15f3a010513c273a9409d'
               ],
               item => 'file_writes',
               task => 'hash_0900130bc38dd83b51bc28d900301642f264b3',
               type => 'LINE1'
            },
            {  color  => 'FFBF00',
               hashes => [
                  'hash_10001329e59d844c33344ee91e195ce60e8813',
                  'hash_100013bf128e2a5f554016dca014539dc9297e',
                  'hash_1000130f19e132baa24ea10c693c8af3557a78',
                  'hash_1000138fa4ae8356e1b417f23be3e23aa38527'
               ],
               item => 'log_writes',
               task => 'hash_0900132e5e7792fce3374c07688a917ee3e1d2',
               type => 'LINE1'
            },
            {  color  => '0ABFCC',
               hashes => [
                  'hash_1000136517b82d8f0c7510026ac494e83068ba',
                  'hash_1000137f5e1b9e217ef5abc70549cab905edd5',
                  'hash_1000131b0854695edc59bc72dfe94374dd93e3',
                  'hash_10001334f0b31f32801fccfc8a14e1f17c5f69'
               ],
               item => 'file_fsyncs',
               task => 'hash_090013cafa2432856a45bb04ffdb7b7e8a2e52',
               type => 'LINE1'
            }
         ],
      },
      {  base_value => '1000',
         dt         => {
            hash         => 'hash_01001341c5206e4ce414e2bda8b85db4da77dd',
            ibuf_inserts => {
               data_source_type_id => '2',
               hash => 'hash_080013d4ee67c833d28a979599b71381360734'
            },
            ibuf_merged => {
               data_source_type_id => '2',
               hash => 'hash_080013c289a34d4c63e31f02be38ad26ffb077'
            },
            ibuf_merges => {
               data_source_type_id => '2',
               hash => 'hash_080013db421787539f02497406cd293f1a522a'
            },
            input => 'Get MySQL Stats'
         },
         hash  => 'hash_000013d9a54b856fe871e5724bc5bce7d02c62',
         items => [
            {  color  => '157419',
               hashes => [
                  'hash_100013c393adc639076326c57fb39a50cd8db3',
                  'hash_1000135ddbbcb91dd2984dc6b469c0f7048bac',
                  'hash_100013ccd732e33781ddff8d71f15127474247',
                  'hash_1000138a97910b261420caf4f42acff0777b87'
               ],
               item => 'ibuf_inserts',
               task => 'hash_090013e66d175343e13dcafdb0a86303a4b2b9',
               type => 'LINE1'
            },
            {  color  => '0000FF',
               hashes => [
                  'hash_100013feddbb6bfb063797d3521d171e42a0c4',
                  'hash_1000139a9bdf66c2f949d5cf569f2a21cfe788',
                  'hash_10001337328f3198bf826ec46d705a7108fae4',
                  'hash_1000130700f03352de66222852aab2c43c9395'
               ],
               item => 'ibuf_merged',
               task => 'hash_09001312fc42a6c166f3c9559ec7d499d2c5df',
               type => 'LINE1'
            },
            {  color  => '862F2F',
               hashes => [
                  'hash_1000130717fc25c141775450b5713c0fc1414f',
                  'hash_100013ada7b7213b47d99ae32a6dd7700d04f4',
                  'hash_10001386beb441a0cc11a71820664941b0c247',
                  'hash_1000139b530b21a1de4f01474ced8fe4f68d6b'
               ],
               item => 'ibuf_merges',
               task => 'hash_09001323fda91e9c1d26a47bd5125469827e16',
               type => 'LINE1'
            }
         ],
         name => 'InnoDB Insert Buffer'
      },
      {  base_value => '1000',
         dt         => {
            hash     => 'hash_010013c74a58d5af8d4b98f99fa997c7c75480',
            input    => 'Get MySQL Stats',
            os_waits => {
               data_source_type_id => '2',
               hash => 'hash_080013522f5ed5373d54e612f2e2a32b58c8ca'
            },
            spin_rounds => {
               data_source_type_id => '2',
               hash => 'hash_080013c88c11b5a4da84fd95ff088a4d815cd6'
            },
            spin_waits => {
               data_source_type_id => '2',
               hash => 'hash_080013d1a72d8ab6137fcf3df95b2e14a89a58'
            }
         },
         hash  => 'hash_0000139b3e0b4a8c49be86a7cb1486ba9ab88d',
         items => [
            {  color  => 'DE0056',
               hashes => [
                  'hash_100013000801874164cf6cf266929cc34d8462',
                  'hash_1000136b0538d65229502662c88ee69966f1f4',
                  'hash_1000134b2a9197fc6c30419c72dc3350e7eb6e',
                  'hash_10001389cf3819b4983d8e0256579e95bbc731'
               ],
               item => 'spin_rounds',
               task => 'hash_090013761c1a5abd1ff12e51376809e0beb66c',
               type => 'LINE1'
            },
            {  color  => '4444FF',
               hashes => [
                  'hash_100013b5cc89b185f3deaad54ab5e44260b3e1',
                  'hash_100013e11c102185773f8ad8c5db1db44cccba',
                  'hash_10001365c208e36bebbcb1ea02813ac43b3ac2',
                  'hash_10001342cdf7d8263257532cc5c242e6ae7b06'
               ],
               item => 'spin_waits',
               task => 'hash_0900136ab40fc1a3b483a09877ca15f6de8244',
               type => 'LINE1'
            },
            {  color  => '157419',
               hashes => [
                  'hash_100013649ce38feea031b35dc7d92ec99c0434',
                  'hash_10001396483d64f581e7e37bd192813b672b4e',
                  'hash_100013247243bdb3bf137c3f985a260bc77beb',
                  'hash_1000139c5bb9a6c3683dff4c187061fb6951ae'
               ],
               item => 'os_waits',
               task => 'hash_09001368b0389a78299e5b6a8b61ff5bf6cb24',
               type => 'LINE1'
            }
         ],
         name => 'InnoDB Semaphores'
      },
      {  base_value => '1000',
         dt         => {
            hash         => 'hash_0100138c0c000f2a5a0bef224c8c2cd3bdd9c9',
            input        => 'Get MySQL Stats',
            rows_deleted => {
               data_source_type_id => '2',
               hash => 'hash_0800139d6fb10c7a6fad13a42d29c5b77a26b1'
            },
            rows_inserted => {
               data_source_type_id => '2',
               hash => 'hash_080013ac8e609e24e306fef2ec8ef425fe0ea6'
            },
            rows_read => {
               data_source_type_id => '2',
               hash => 'hash_080013f643eab7bbcd11417e0685d138c2e4b4'
            },
            rows_updated => {
               data_source_type_id => '2',
               hash => 'hash_08001316c850e649dd91edf9d2241bc635377c'
            }
         },
         hash  => 'hash_0000135da7bba339cf1753b07e36c58185d7ee',
         items => [
            {  color  => 'AFECED',
               hashes => [
                  'hash_100013c3fb171c7118f9ccf1dfd17e7d7047cd',
                  'hash_1000138d6cb22f122886249d39b15b1c2080bf',
                  'hash_100013f581e6e9da84550bb44e30a79ea72b4d',
                  'hash_1000131bb952ec834b0902a2a769cfe1a0590c'
               ],
               item => 'rows_read',
               task => 'hash_090013235ba142254df5662b822cbed8068429',
               type => 'AREA'
            },
            {  color  => 'DA4725',
               hashes => [
                  'hash_100013d2573b0574fc966ece3c8001bb3c5203',
                  'hash_100013c237f0850c16775d2615a5cc5e24ec8b',
                  'hash_1000138ad3785f87c97fd96614d3c54bba3d96',
                  'hash_100013d3ed2a51bb32feaba600bc1b16ebc8cc'
               ],
               item => 'rows_deleted',
               task => 'hash_09001349b839f1111ee393d239eec323ee0b18',
               type => 'STACK'
            },
            {  color  => 'EA8F00',
               hashes => [
                  'hash_10001334ad6cd1d33cf3bf027ff9a450336969',
                  'hash_100013277df4fce9190017917f8e92d61124dc',
                  'hash_100013cf0a710c5fe70b89967c97e44dcec1b2',
                  'hash_100013f310dd1da40fc7df9e7776c18ead315d'
               ],
               item => 'rows_updated',
               task => 'hash_090013eb20f60feac6a228d76cb7dfd64c4ff4',
               type => 'STACK'
            },
            {  color  => '35962B',
               hashes => [
                  'hash_100013e6ed2155d3ecd734f55db90259946590',
                  'hash_100013af62d028aa17acb2276e12be3ebb2c4e',
                  'hash_10001338e2fee5b5398f357145770aeb689420',
                  'hash_10001335406ab0284534690161c25ba3faa46d'
               ],
               item => 'rows_inserted',
               task => 'hash_0900139ec021b8fc01ba237c2531f1c5a68673',
               type => 'STACK'
            }
         ],
         name => 'InnoDB Row Operations'
      },
      {  base_value => '1000',
         dt         => {
            Slow_queries => {
               data_source_type_id => '3',
               hash => 'hash_0800134b92784bd5b866747c040580383d9619'
            },
            Table_locks_immediate => {
               data_source_type_id => '3',
               hash => 'hash_080013cf7e7c469ad5eccae33784b96136f318'
            },
            Table_locks_waited => {
               data_source_type_id => '3',
               hash => 'hash_080013ce22d0d9368be9413c2a50c69861ec2b'
            },
            hash  => 'hash_010013a1940673b7c4f960688bbffa3c5cc9e7',
            input => 'Get MySQL Stats'
         },
         hash  => 'hash_0000136248f4622f34282739d13a496a26a244',
         items => [
            {  color  => 'D2D8F9',
               hashes => [ 'hash_100013985c2c250576fa832083b7350b3ba43e' ],
               item   => 'Table_locks_immediate',
               task   => 'hash_0900131f02f1af427e8fbab1bbc6f9f454a9de',
               type   => 'AREA'
            },
            {  color  => '002A8F',
               hashes => [
                  'hash_1000136388f8353794e11c3ba3ca88ec8092b6',
                  'hash_100013195358fe082e80eea41714386c901af0',
                  'hash_1000132e180568d6e8324d8de0b5de18f9ace7',
                  'hash_10001348fe37efb3fe5559477598182c6ea902'
               ],
               item => 'Table_locks_immediate',
               task => 'hash_0900131f02f1af427e8fbab1bbc6f9f454a9de',
               type => 'LINE1'
            },
            {  color  => 'FF3932',
               hashes => [
                  'hash_100013df8eadeb3843d46eab8e41843d0999a1',
                  'hash_100013afc37040e3f206e690c42dc2baa16093',
                  'hash_100013859b6385daccd065a051285a4dcfb990',
                  'hash_100013b5e774b31844391679cfcf7a43e291c6'
               ],
               item => 'Table_locks_waited',
               task => 'hash_0900138444ffb6060be25f757298ee24137589',
               type => 'AREA'
            },
            {  color  => '35962B',
               hashes => [
                  'hash_100013773a5bdc72b180711b6526d26a0dbcc1',
                  'hash_10001357fbac2bf9599e982f379909c8d9a5f1',
                  'hash_100013383655c97850192dc952ee0bd8192725',
                  'hash_100013cc80408b5852dd9178493fbf52c5b043'
               ],
               item => 'Slow_queries',
               task => 'hash_090013e18fcc7dde1d7247dd8e450e38d93bbc',
               type => 'LINE1'
            }
         ],
         name => 'MySQL Table Locks'
      },
      {  base_value => '1000',
         dt         => {
            hash            => 'hash_010013f12a4fdc2bbe8cee87181ba0feaf67ee',
            input           => 'Get MySQL Stats',
            Aborted_clients => {
               data_source_type_id => '2',
               hash => 'hash_080013b9482e8e8f3a6d0e95978e19715ac447'
            },
            Aborted_connects => {
               data_source_type_id => '2',
               hash => 'hash_080013fc1dba80f47aacc5247d7a598bc79e85'
            },
            Connections => {
               data_source_type_id => '2',
               hash => 'hash_0800133790fcbadbe72404d2826fc88c29b1d0'
            },
            Max_used_connections => {
               data_source_type_id => '1',
               hash => 'hash_0800130ecbbad784c6a0287cb138e0d101159b'
            },
            Threads_connected => {
               data_source_type_id => '1',
               hash => 'hash_08001355ed0b81457150103747ca82141a7f13'
            },
            max_connections => {
               data_source_type_id => '1',
               hash => 'hash_08001352dcd9b60564823afc59da8762e9cf56'
            }
         },
         hash  => 'hash_0000139c8df1d30e905156b0bf3767088ad583',
         items => [
            {  color  => 'C0C0C0',
               hashes => [
                  'hash_100013f8ed80fe154a67993f6677d2be37b0f1',
                  'hash_1000135caf92f9dc95270cae4c634069996643'
               ],
               item => 'max_connections',
               task => 'hash_0900133bbf05e063a396e76eedff37d7358634',
               type => 'AREA'
            },
            {  color  => 'FFD660',
               hashes => [
                  'hash_100013eb683da9f481d950413161c5334cb0a4',
                  'hash_100013e3934ec4b365c8ac565b7d593e583800'
               ],
               item => 'Max_used_connections',
               task => 'hash_0900131052774481daf3ea84f80406fd86bceb',
               type => 'AREA'
            },
            {  color  => 'FF3932',
               hashes => [
                  'hash_100013bac3422327a1ebb30e764c7dff9065cc',
                  'hash_100013f775dee2cfbf507846352aa4ca653c16',
                  'hash_100013ceb7ad7aa445d84747af3a82a493cb5d',
                  'hash_100013b90f98bc40c12f51cc6b06ce3afb6a3b'
               ],
               item => 'Aborted_clients',
               task => 'hash_0900136551253b269d1becd08a82e95535d7c8',
               type => 'LINE1'
            },
            {  color  => '00FF00',
               hashes => [
                  'hash_1000134802eafebf24679dc8adf774c0c3a74e',
                  'hash_10001329288f73324e16f0e6762d50e896b7a4',
                  'hash_100013cf6ed7bcdf06e84c64714b8e317e981b',
                  'hash_100013c095ef6d8f6ed688143fa36034b7bf01'
               ],
               item => 'Aborted_connects',
               task => 'hash_090013e33396ba59228774dcedc9f1b857fe8c',
               type => 'LINE1'
            },
            {  color  => 'FF7D00',
               hashes => [
                  'hash_100013bb837bdc8139f9d9022a19511fc2b38e',
                  'hash_100013e2839637ce31f2557cf4274a28c3c101',
                  'hash_100013e25a4900df11b4e8a31aba82d21ca9db',
                  'hash_100013c77bd0b513b8a141437715c2883708c3'
               ],
               item => 'Threads_connected',
               task => 'hash_090013b7d58afdf5f705fe19733a816b3733c6',
               type => 'LINE2'
            },
            {  color  => '4444FF',
               hashes => [
                  'hash_100013e17d122913057806703ddd96478d62fc',
                  'hash_10001344c9d967001eb19145c3e9461fb52892',
                  'hash_100013838d420fad5e1264d752b74622040d38',
                  'hash_100013690a9a33fec432fe0d2bebd8357ebba6'
               ],
               item => 'Connections',
               task => 'hash_0900137a7d7b5119584a1efe0ff8c9a4e0e0dd',
               type => 'LINE1'
            }
         ],
         name => 'MySQL Connections'
      },
      {  base_value => '1000',
         dt         => {
            Slave_open_temp_tables => {
               data_source_type_id => '1',
               hash => 'hash_08001325cf8ecc2e97a7de94bc1cb48151a5e2'
            },
            Slave_retried_transactions => {
               data_source_type_id => '2',
               hash => 'hash_080013bc1d5cacb2e2c6f0785f369f6baaa349'
            },
            hash  => 'hash_010013b4e58a773aa9fb5b2b40c13850434ef5',
            input => 'Get MySQL Stats',
            seconds_behind_master => {
               data_source_type_id => '1',
               hash => 'hash_080013102549743bbd45d73dad64e40c5deabd'
            },
            slave_lag => {
               data_source_type_id => '1',
               hash => 'hash_0800132f22ea85e927b9904204281cd730b9c7'
            },
            slave_running => {
               data_source_type_id => '1',
               hash => 'hash_080013a2b5fb54622eccf34fd7891c7dd846d9'
            },
            slave_stopped => {
               data_source_type_id => '1',
               hash => 'hash_08001360a66b3e8ee975927e0950be770e3210'
            }
         },
         hash  => 'hash_000013b8ab36ff23571c4583154391183380c9',
         items => [
            {  color  => '96E78A',
               hashes => [ 'hash_1000138e774a27bdcd687b74f59f7633261104' ],
               item   => 'slave_running',
               task   => 'hash_09001391e496c6fbb49b545fc8f2c2fc810d55',
               type   => 'AREA'
            },
            {  color  => 'CDCFC4',
               hashes => [ 'hash_100013d86914f0587cc89b36795e15f6deb843' ],
               item   => 'slave_stopped',
               task   => 'hash_090013408d1c93dd785e1c37853e715155357d',
               type   => 'AREA'
            },
            {  color  => 'ED7600',
               hashes => [
                  'hash_100013e21668631327b37ef7598c6fb15a7cb1',
                  'hash_1000132e1ea72957dd1e63c398539de800f138',
                  'hash_1000131b440c837fc00f3d48a2bfc954f036d8',
                  'hash_100013d38edb63f55e33b65076a4e268be6391'
               ],
               item => 'seconds_behind_master',
               task => 'hash_090013eccdbf2fc2b3784ac5392a8438351d6d',
               type => 'LINE1'
            },
            {  color  => '4444FF',
               hashes => [
                  'hash_100013caf39e137752bd9a38ecf7ceb5d53ce3',
                  'hash_1000136ec9f26cd661cef295cc1c76e4130b68',
                  'hash_1000137c1a9200037f834bd71010f1f7708aa6',
                  'hash_10001381aa16ca185a61f50f52d6d5342115a6'
               ],
               item => 'slave_lag',
               task => 'hash_0900138929e6500dfc2213bf024c549c468ea9',
               type => 'LINE1'
            },
            {  color  => '8D00BA',
               hashes => [
                  'hash_1000139ef146d43565ac74eb3a14219e6a38f2',
                  'hash_10001331621db648be7acd543886ea43a02a89',
                  'hash_1000136cc5f7709b2390de0b8ee2580f91dba5',
                  'hash_100013991855b6e433018ad55edad34fdce9d4'
               ],
               item => 'Slave_open_temp_tables',
               task => 'hash_090013223448b07c87f678582c20b90b888d7b',
               type => 'LINE1'
            },
            {  color  => 'FF0000',
               hashes => [
                  'hash_100013bc17c6a7692fbb31c18a8d6e7c491f04',
                  'hash_100013876d9459ba58d69d04d78fa2d376c555',
                  'hash_100013491d413a794cac1a923d6c9988b75416',
                  'hash_100013348cd8082e7f7c6e28c2a82df019b4e0'
               ],
               item => 'Slave_retried_transactions',
               task => 'hash_0900136d91d49c09ae744a110b7ade0c93e0af',
               type => 'LINE1'
            }
         ],
         name => 'MySQL Replication'
      },
      {  base_value => '1024',
         name       => 'MySQL Query Cache',
         dt         => {
            hash  => 'hash_010013758e5dfa7c1b43158c99c9ae8f5c9151',
            input => 'Get MySQL Stats',
            Qcache_hits => {
               data_source_type_id => '2',
               hash => 'hash_080013f07477338949616d6eea54ee637f6d4e'
            },
            Qcache_inserts => {
               data_source_type_id => '2',
               hash => 'hash_08001322845ea66b30de205a53b333a5a90164'
            },
            Qcache_lowmem_prunes => {
               data_source_type_id => '2',
               hash => 'hash_08001314595905d0a5cd47d859662262beced7'
            },
            Qcache_not_cached => {
               data_source_type_id => '2',
               hash => 'hash_080013bed31c9faf2bd44892d858ca786520ef'
            },
            Qcache_queries_in_cache => {
               data_source_type_id => '1',
               hash => 'hash_080013311c7406e805f1bba295d81af1d13fe0'
            },
         },
         hash  => 'hash_000013410ce15a29ceea4510e211a0abf3c65b',
         items => [
            {  color  => '4444FF',
               hashes => [
                  'hash_100013dfe1f04f9170570eb33149475b9dcbf5',
                  'hash_1000132adbdba626f781797f1e04716361c05f',
                  'hash_100013986ee7b27049fd1f09fc0b6128feab65',
                  'hash_1000131f637ddffa2a5b1407203abebe6a1774'
               ],
               item => 'Qcache_queries_in_cache',
               task => 'hash_0900138e9d3e5965f1de27395fce2bbc5f36d4',
               type => 'LINE2'
            },
            {  color  => 'EAAF00',
               hashes => [
                  'hash_100013392b40ba2be12bed033d76fedbc965e2',
                  'hash_1000134dbb890527f3a12a7a44aa690f708181',
                  'hash_1000137db98c77393dcc0b27a554181393c054',
                  'hash_1000139203b1e3eea81a2f4346592181a60bf4'
               ],
               item => 'Qcache_hits',
               task => 'hash_0900138fe099842b40da2abf4510817fdf2361',
               type => 'LINE2'
            },
            {  color  => '157419',
               hashes => [
                  'hash_100013018b148bf47b8f3f929f7d946f650438',
                  'hash_100013671295bad476c0787e3b65fe5a1f0ab1',
                  'hash_100013653e15267565f3b39730af563efb2ecc',
                  'hash_100013d253a6c48288b333e891fc8e98180f5e'
               ],
               item => 'Qcache_inserts',
               task => 'hash_0900130a5267e11f8ac4b97e61b740f3f563f5',
               type => 'LINE1'
            },
            {  color  => '00A0C1',
               hashes => [
                  'hash_100013501740993f941ecef68e941d3c0e18cd',
                  'hash_1000133d4e8d1a600ca1a3bd915fade265341d',
                  'hash_100013ec30dc392bb86276d76b14b2dda60ea5',
                  'hash_1000138179f75822f4a0b13796786a5db5bd5b'
               ],
               item => 'Qcache_not_cached',
               task => 'hash_090013facc8d5695b7faa786414820e5243120',
               type => 'LINE1'
            },
            {  color  => 'FF0000',
               hashes => [
                  'hash_100013cbdccd36fa165757f95c3312c375d873',
                  'hash_100013d91ad0c0e0469fa64b4af27d3c0a4849',
                  'hash_1000137596407cb1ba2bb0634c2e9301e49a36',
                  'hash_100013416d5119da9da1f006cd4cd530e68bb7'
               ],
               item => 'Qcache_lowmem_prunes',
               task => 'hash_0900131084c6b5757103795d1fec2c17ac9da7',
               type => 'LINE1'
            }
         ],
      },
      {  base_value => '1024',
         name       => 'MySQL Query Cache Memory',
         dt         => {
            Qcache_free_blocks => {
               data_source_type_id => '1',
               hash => 'hash_0800133e1726404b6d50a895f5809d1ad56a7f'
            },
            Qcache_free_memory => {
               data_source_type_id => '1',
               hash => 'hash_080013de38cbf9720663357899748543fe5e6f'
            },
            Qcache_total_blocks => {
               data_source_type_id => '1',
               hash => 'hash_0800138d7e8ced1b5e263e2bc8a85217cf0738'
            },
            hash             => 'hash_010013758e5dfa7c1b43158c99c9ae8f5c9152',
            input            => 'Get MySQL Stats',
            query_cache_size => {
               data_source_type_id => '1',
               hash => 'hash_08001376a39fdd8200142dcbc0a924c48d5579'
            }
         },
         hash  => 'hash_000013b81e0eeb0140438fe3752271c74fb32e',
         items => [
            {  color  => '74C366',
               hashes => [
                  'hash_100013ef8a3eca2ff1cfb073e6fd8f648f87aa',
                  'hash_100013004589ff2185c0f1e725602ca30cb57c',
                  'hash_10001347d61115549b565f271ff4f638610b71',
                  'hash_10001315a1953175f6a2f40db4d32dfeb8848d'
               ],
               item => 'query_cache_size',
               task => 'hash_09001356048c4af65e171ed16dbedcb8426f72',
               type => 'AREA'
            },
            {  color  => 'FFC3C0',
               hashes => [
                  'hash_1000132fc86127606fca358c55a6a6c8a900dc',
                  'hash_100013c1a6ad1a1670f62c6b32f05309740578',
                  'hash_100013452a8285490a86891193c8fa4740b1e8',
                  'hash_100013c6f4cb65024c74ebb546b052974ef6a0'
               ],
               item => 'Qcache_free_memory',
               task => 'hash_090013cc342c321bed367deaf48111f9aa608d',
               type => 'AREA'
            },
            {  color  => '8D00BA',
               hashes => [
                  'hash_1000132928f0a6dd9c1fb080a652154cd7b02c',
                  'hash_100013c16f93bea3c6a51aae0a6b3bdb5ac072',
                  'hash_1000132efaccedc1bab9f16e444402fe9c6843',
                  'hash_100013b975f9434b7653f5b9cb4b8abda44d7f'
               ],
               item => 'Qcache_total_blocks',
               task => 'hash_0900136ede16e981e996a62ae2a831e26c4a65',
               type => 'LINE1'
            },
            {  color  => '837C04',
               hashes => [
                  'hash_100013afcbb4b9fc4fe0e171e2cd0c63cee438',
                  'hash_10001332328853193df6a6d820182bc04affb7',
                  'hash_100013dc6054b333a38f86d572617ad82efda6',
                  'hash_100013490d6b2291ce225cd742145d92365d5b'
               ],
               item => 'Qcache_free_blocks',
               task => 'hash_090013347eeb0f45c30500cd94f413c2b5bdaf',
               type => 'LINE1'
            }
         ],
      },
      {  base_value => '1000',
         dt         => {
            Com_delete => {
               data_source_type_id => '2',
               hash => 'hash_080013338ab0cab8bfed0e33c57639bac678a2'
            },
            Com_delete_multi => {
               data_source_type_id => '2',
               hash => 'hash_080013149230bfe45c31f9f844e726a6fd4821'
            },
            Com_insert => {
               data_source_type_id => '2',
               hash => 'hash_0800133d9a4c7361041aa0bcb36b4bb98e3853'
            },
            Com_insert_select => {
               data_source_type_id => '2',
               hash => 'hash_08001308217f95d7cd474051c926b7c5fbf6e7'
            },
            Com_load => {
               data_source_type_id => '2',
               hash => 'hash_08001387cacd948ec07d17babbbf9f1ff0867e'
            },
            Com_replace => {
               data_source_type_id => '2',
               hash => 'hash_080013758bec4a0d6344ccd03f47e7be7068cf'
            },
            Com_replace_select => {
               data_source_type_id => '2',
               hash => 'hash_080013ab2e63aef3037b7c7d134fbba74d3c3e'
            },
            Com_select => {
               data_source_type_id => '2',
               hash => 'hash_080013196a931365006b70189f1252a7601ecb'
            },
            Com_update => {
               data_source_type_id => '2',
               hash => 'hash_0800132ded5946a4f8009c895f7416cbfa4c74'
            },
            Com_update_multi => {
               data_source_type_id => '2',
               hash => 'hash_080013caf6c3ae61650a2096daaca96b837bb0'
            },
            Questions => {
               data_source_type_id => '2',
               hash => 'hash_080013542f25b1dd6cc52340253c02a3b8da1b'
            },
            hash  => 'hash_010013f8fa7fbf4c5d4ee7d82f7b4c22cc5c26',
            input => 'Get MySQL Stats'
         },
         hash  => 'hash_000013d62fdf10872359e69b44bc7e2aaf3533',
         items => [
            {  color  => 'FFC3C0',
               hashes => [
                  'hash_1000132e7a7135c1f50143371f113a80b1a981',
                  'hash_100013172a8d09c9caf4e7f67b666c1bed49ee',
                  'hash_100013e6be51aa2fc20b63014ea553836b7f43',
                  'hash_1000135a26ddd649c62a7af42dbec5df2bc7f8'
               ],
               item => 'Questions',
               task => 'hash_090013e20eb6d4ffbc4c2c5cc785e5b6d03ba3',
               type => 'AREA'
            },
            {  color  => 'FF0000',
               hashes => [
                  'hash_10001302c62dc17dcaf4895e81b7ae5a2188cb',
                  'hash_100013d9209caec858e7e0bfafb576d92fc00c',
                  'hash_100013c370ca982ed86c323c1450d1ea4bd73d',
                  'hash_1000136fa4536316aa1861fc4de00345c6f185'
               ],
               item => 'Com_select',
               task => 'hash_090013222789ffa6865751d120906e2b7cf79e',
               type => 'AREA'
            },
            {  color  => 'FF7D00',
               hashes => [
                  'hash_10001310555bbea2a239b2c80a6d7cd8167da7',
                  'hash_10001304302e25a021a2b07e5941b8a950c313',
                  'hash_100013f8ba1fd73bd7fc9cd4c34d29c43f7b0d',
                  'hash_1000131c7b3f173002fbb7535745b084a86bfa'
               ],
               item => 'Com_delete',
               task => 'hash_0900133d13473ba25d88c0f2278affb6ab7abf',
               type => 'STACK'
            },
            {  color  => 'FFF200',
               hashes => [
                  'hash_1000133af8d3ab9d28800e282afe4a21435652',
                  'hash_100013f0c149a27bd0713fe5ded911cb5fea3e',
                  'hash_1000139adc871ac35a1d299694ad98316f7d86',
                  'hash_100013860afadaed52b7db13b1753244639cad'
               ],
               item => 'Com_insert',
               task => 'hash_090013d34468d7126bb1e14107062df8d5885f',
               type => 'STACK'
            },
            {  color  => '00CF00',
               hashes => [
                  'hash_100013e0359e2df0190e1a9a09b13269dd7657',
                  'hash_1000136bd631c4e6180a001808e18e653ffdad',
                  'hash_100013d56c67c9204e0ef3930ad08c9f88f18e',
                  'hash_10001308fb1ac8a1a967ac7eb0d8e9448e5ee8'
               ],
               item => 'Com_update',
               task => 'hash_0900138318b20ed13f682a27d933cdff22c6cb',
               type => 'STACK'
            },
            {  color  => '2175D9',
               hashes => [
                  'hash_100013a88f1139043c3b7671adc09b6a07d86c',
                  'hash_100013430d27ff52c711a364612d16828871df',
                  'hash_10001336e7baceb425ad27c731928c76c9e45a',
                  'hash_100013100dbae77f81adb257efcbc1cc57ae3f'
               ],
               item => 'Com_replace',
               task => 'hash_090013a85de14079ffe09e6c5699f6a96eecab',
               type => 'STACK'
            },
            {  color  => '55009D',
               hashes => [
                  'hash_100013735f510ae982c05fa39793302cddda42',
                  'hash_100013058ee9da209b619b4bc2320a185e9074',
                  'hash_10001354c34f644ab432db574d6cc4210a17ae',
                  'hash_1000133acc64545edd38de731fdff21c45f790'
               ],
               item => 'Com_load',
               task => 'hash_090013fceb4d4326b284e543b1d9b689d2d8c9',
               type => 'STACK'
            },
            {  color  => '942D0C',
               hashes => [
                  'hash_100013ecb13ef9d128278ce48bc61ba63982e4',
                  'hash_10001371e775824e1d5b6665c701545a7ede25',
                  'hash_1000131080ce68620ac9ce974e1ee64432239a',
                  'hash_1000131d69fb349c635d51d220cf9f087346cc'
               ],
               item => 'Com_delete_multi',
               task => 'hash_090013a319edbd59b520e26897d2df34114a77',
               type => 'STACK'
            },
            {  color  => 'AAABA1',
               hashes => [
                  'hash_100013f15c596e1a03887d1ff35dff0066d7ff',
                  'hash_100013181238ca7a5de200f15bff26c9386eb0',
                  'hash_10001336208e3c88fe1dcbdb2d48367646db91',
                  'hash_100013e23f356983345f281cec523ce06b811d'
               ],
               item => 'Com_insert_select',
               task => 'hash_0900134096122a7e68ee8ce60690acd1c67fe4',
               type => 'STACK'
            },
            {  color  => 'D8ACE0',
               hashes => [
                  'hash_100013f549d1913a868d26f56e82630e4d743b',
                  'hash_10001365ae55f6b3a1a95ed5e3469fbfd7e516',
                  'hash_10001339fd88b9507249a13b2ebeff8505567b',
                  'hash_100013dbc20ab2c1f40ed2d6b39b2bd3b3a17b'
               ],
               item => 'Com_update_multi',
               task => 'hash_090013cbe8888cd86b44d178b09789a3b1cd82',
               type => 'STACK'
            },
            {  color  => '00B99B',
               hashes => [
                  'hash_1000139c07a00e281edeb5d8348b0ee2f5eab4',
                  'hash_10001396508bb2f618f79f1f5d8ef70aa42ae7',
                  'hash_10001382105088462f61eeac14f30245c6087f',
                  'hash_1000132a56292a9002a3eb03f718139b48b128'
               ],
               item => 'Com_replace_select',
               task => 'hash_09001309481fc0b0ef3ca7fa008080dd66d3cd',
               type => 'STACK'
            }
         ],
         name => 'MySQL Command Counters'
      },
      {  base_value => '1000',
         dt         => {
            Select_full_join => {
               data_source_type_id => '2',
               hash => 'hash_0800135e6cf8e6439278754a5ffb80e3bdef57'
            },
            Select_full_range_join => {
               data_source_type_id => '2',
               hash => 'hash_080013c9a6d87d4df6f96364f7bc700fadbc45'
            },
            Select_range => {
               data_source_type_id => '2',
               hash => 'hash_08001361fff8036b63b07d8863feeacc81c1d4'
            },
            Select_range_check => {
               data_source_type_id => '2',
               hash => 'hash_0800138245046cf427baa6fb2a253a533225f3'
            },
            Select_scan => {
               data_source_type_id => '2',
               hash => 'hash_080013e71fb77d0613171bc9b0fc92f2e58326'
            },
            hash  => 'hash_010013a2121560753c5140690165f8c594b84b',
            input => 'Get MySQL Stats'
         },
         hash  => 'hash_00001396dd6e8156d0a2e832427ee96623959e',
         items => [
            {  color  => 'FF0000',
               hashes => [
                  'hash_100013c56eef30cb2750b8c160595048a6fd40',
                  'hash_1000137dddaf0db46aed1eed2da9b0af799bc3',
                  'hash_1000139992f7d108b3a046ccd3ff9a4c3ecdf7',
                  'hash_100013e8b78bd4b9eaf82a252a1982169363eb'
               ],
               item => 'Select_full_join',
               task => 'hash_090013169dfcc76da4df50c022eb0ad6112def',
               type => 'AREA'
            },
            {  color  => 'FF7D00',
               hashes => [
                  'hash_10001327daf8c1e7a9aebf985c44bc937646ec',
                  'hash_100013f23fbb5d3be74ee20efb914d08a849e8',
                  'hash_1000136aef22e6514cfe8a3489c012f0f85fb0',
                  'hash_100013239e1dacf1a673cae8000e7a22425c8f'
               ],
               item => 'Select_full_range_join',
               task => 'hash_090013a29699386c2b6da1f14155617f1ea669',
               type => 'STACK'
            },
            {  color  => 'FFF200',
               hashes => [
                  'hash_10001383f1b2dbdab4e2d780683f8a9014f451',
                  'hash_1000133ca5d0704e28b5c55bcb19325c12f101',
                  'hash_100013f99f49daf66e88096d7615f2b1131192',
                  'hash_100013b15bce4c94ef4df5ea1402105e458bd1'
               ],
               item => 'Select_range',
               task => 'hash_0900131a7978d046d330b372907602db5d2f81',
               type => 'STACK'
            },
            {  color  => '00CF00',
               hashes => [
                  'hash_100013488c4bc114ba402b7ed472f7ceabccf2',
                  'hash_100013ffdc03f26f6f691f460458e0fcfe1bc4',
                  'hash_1000137b499ad32708b136c05842ad07f54896',
                  'hash_100013f4286ff70508f23c03d619b8f8722c33'
               ],
               item => 'Select_range_check',
               task => 'hash_09001351aa1a3638bff236cd4e0d679a18ade4',
               type => 'STACK'
            },
            {  color  => '7CB3F1',
               hashes => [
                  'hash_100013e23d1f843362c44acf88bcedb6de2a54',
                  'hash_1000133cb99e0ee36b28fc509f175201b90e4b',
                  'hash_100013e6adff914ad87f65130e21b800e95955',
                  'hash_1000139cb350c0003fc595cafd7095535b686a'
               ],
               item => 'Select_scan',
               task => 'hash_0900131e31b92fbf08a36b590adb68bfd78a07',
               type => 'STACK'
            }
         ],
         name => 'MySQL Select Types'
      },
      {  base_value => '1000',
         dt         => {
            Sort_merge_passes => {
               data_source_type_id => '2',
               hash => 'hash_0800138aa489c6bb70310d14a24e56e31c9592'
            },
            Sort_range => {
               data_source_type_id => '2',
               hash => 'hash_080013b77c61e0c59b1210d4ab0d94efc3c49e'
            },
            Sort_rows => {
               data_source_type_id => '2',
               hash => 'hash_080013362757dae7975981676b254896863a43'
            },
            Sort_scan => {
               data_source_type_id => '2',
               hash => 'hash_080013ef1c94da33bc5d6378f01bd4afdb7c1c'
            },
            hash  => 'hash_010013bd1be5ddd62b90c9d5be5bfc592e7b95',
            input => 'Get MySQL Stats'
         },
         hash  => 'hash_0000131364ec394731487e98e09deea6550d55',
         items => [
            {  color  => 'FFAB00',
               hashes => [
                  'hash_10001345e3c5e3c0d7701a0b56c430e6fdcab9',
                  'hash_1000133a41008db73a7cd74715875a8bd52451',
                  'hash_1000133a133f5d14e06fee170c8ad7ef8de5c4',
                  'hash_100013c2fa578d29043b002e2cae7ebd4736db'
               ],
               item => 'Sort_rows',
               task => 'hash_090013ff8994fc32c6bdf048593f7eac733b2a',
               type => 'AREA'
            },
            {  color  => '157419',
               hashes => [
                  'hash_1000136083ab752c56ac346dfea41c113ff7a3',
                  'hash_1000138f01a56eeba5440b2fa838553db59fcd',
                  'hash_10001323beafb7767a9a4f601e637972486958',
                  'hash_100013456117e3d41e0b0b079a415ad46ef523'
               ],
               item => 'Sort_range',
               task => 'hash_09001313eb3665a4e49e0331d7c4156fc72ec1',
               type => 'LINE1'
            },
            {  color  => 'DA4725',
               hashes => [
                  'hash_1000135ba3612031bfe6d070f78912b97c8d03',
                  'hash_1000138928744e7f6ac91022ba96fba38589e4',
                  'hash_100013ad5819a6628719e7a49fdd8ac7ae97db',
                  'hash_100013ffd49771ea557b9845ffc3f21169dfdf'
               ],
               item => 'Sort_merge_passes',
               task => 'hash_090013bddcf6936609d2bfab6259af78716ac8',
               type => 'LINE1'
            },
            {  color  => '4444FF',
               hashes => [
                  'hash_10001389ac96e847224611f4b23ebe3c687182',
                  'hash_1000131e640214365964c47ef1648a660b1b7c',
                  'hash_1000130dbca0e7c3b7dc3c4aaf94545f73780f',
                  'hash_100013505915e62a2a048e8e44697efc05685a'
               ],
               item => 'Sort_scan',
               task => 'hash_090013e9ec5c2d2318b0f46893467dc81806fd',
               type => 'LINE1'
            }
         ],
         name => 'MySQL Sorts'
      },
      {  base_value => '1000',
         dt         => {
            Created_tmp_disk_tables => {
               data_source_type_id => '2',
               hash => 'hash_0800135668ee63d100ff3e25f235b47099e56c'
            },
            Created_tmp_files => {
               data_source_type_id => '2',
               hash => 'hash_08001310c2532bfb063c2795e0846f5c8466a1'
            },
            Created_tmp_tables => {
               data_source_type_id => '2',
               hash => 'hash_080013322a90733977c40c16f4ea07987e39c0'
            },
            hash  => 'hash_01001308d29df27f37a2c74559f48ff77905a0',
            input => 'Get MySQL Stats'
         },
         hash  => 'hash_0000139f74469a04ea366f93adb382bf9feb0d',
         items => [
            {  color  => 'FFAB00',
               hashes => [ 'hash_10001309a8c0e87dae4f0992ca91ab68ec5073' ],
               item   => 'Created_tmp_tables',
               task   => 'hash_09001336437272524ecb132ac818f6ab3c6276',
               type   => 'AREA'
            },
            {  color  => '837C04',
               hashes => [
                  'hash_10001388983587ec40912f7323632c80c8d604',
                  'hash_1000133868c9f1c6a36578f03a37e589378ed5',
                  'hash_100013adfd30ecf4b2fbfca111cf83f597928b',
                  'hash_10001346d958f121c20c56e49e2649099ba494'
               ],
               item => 'Created_tmp_tables',
               task => 'hash_09001336437272524ecb132ac818f6ab3c6276',
               type => 'LINE1'
            },
            {  color  => 'F51D30',
               hashes => [
                  'hash_1000134931d6a0ed43bbeb26cf42b8be7af622',
                  'hash_100013b1ef407b7f6e0560296b6a1a8d6cf0cc',
                  'hash_100013a4f1beec017b91120d0b7c8256144bc2',
                  'hash_100013e12998eb863e61739ac92a950ea120d1'
               ],
               item => 'Created_tmp_disk_tables',
               task => 'hash_0900135eb6098c631183c1179a906a06f9bcf2',
               type => 'LINE1'
            },
            {  color  => '157419',
               hashes => [
                  'hash_10001346267ac815f34fdabfa2229e4ceca4a3',
                  'hash_1000134e440d1c26bbb47bc12f42893c811691',
                  'hash_100013330a3ac3b383c1006dfa9abe85405ceb',
                  'hash_100013ef72b720c40ffcb1be23085b710457b1'
               ],
               item => 'Created_tmp_files',
               task => 'hash_0900137d5d928963ff6387badc0b6a253ffd12',
               type => 'LINE2'
            }
         ],
         name => 'MySQL Temporary Objects'
      },
      {  base_value => '1024',
         # Palette: http://www.colourlovers.com/palette/90901/le_pain_quotidien
         name => 'MySQL Network Traffic',
         dt         => {
            Bytes_received => {
               data_source_type_id => '2',
               hash => 'hash_0800130dc4474ee42f80143630b1c03f5292c6'
            },
            Bytes_sent => {
               data_source_type_id => '2',
               hash => 'hash_0800137fb4bf9ceb329586e4b503c1e1923ca8'
            },
            hash  => 'hash_01001386055944cd5a58072ab8b2db2488a1ef',
            input => 'Get MySQL Stats'
         },
         hash  => 'hash_0000130461c811ce958cecfb41bdbb16b2f72b',
         items => [
            {  color  => 'E4C576',
               hashes => [
                  'hash_1000132c3bc6cf1e7b659f900870349739fee2',
                  'hash_10001339e91e27c91788433d0aa45874ca4a73',
                  'hash_1000139e97e4b3c18e969f41f6996e8cca64e2',
                  'hash_100013d927842a2873737a5b088611da3efa6e'
               ],
               item => 'Bytes_received',
               task => 'hash_09001310e148a3f5d6bb38c7b10cacc68c5e15',
               type => 'AREA'
            },
            {  color  => '4B2744',
               hashes => [
                  'hash_100013f9276bc645b301cb7ed35be16bfbf863',
                  'hash_100013cc9fe030f9b3acf9ca42f030097b8d59',
                  'hash_100013061261483ac3a8baebd9e3f3e270002e',
                  'hash_1000135421724540377f8b0c11deb852325fdb'
               ],
               item => 'Bytes_sent',
               task => 'hash_090013d8d287ac8a465386f8697bec412a2916',
               type => 'STACK'
            }
         ],
      },
      {  base_value => '1024',
         # Color palette: http://www.colourlovers.com/palette/324729/Compliments
         name       => 'InnoDB Buffer Pool Activity',
         dt         => {
            hash          => 'hash_01001371058b0c913ca3b1c3f4246c628731fb',
            input         => 'Get MySQL Stats',
            pages_created => {
               data_source_type_id => '2',
               hash => 'hash_0800139a01b6e087c3ef063799178d306feb97'
            },
            pages_read => {
               data_source_type_id => '2',
               hash => 'hash_080013c398c4cdc2f9c82448fa443a641b810d'
            },
            pages_written => {
               data_source_type_id => '2',
               hash => 'hash_08001353c047bd9eadb7ad5e743d05cbaaf84b'
            }
         },
         hash  => 'hash_0000130769eb5b1fead3b8981e29659105bd17',
         items => [
            {  color  => 'D6883A',
               hashes => [
                  'hash_100013462fc089f00bca62dd10b09b5862838f',
                  'hash_1000133c900059ae6cc8145ac328de111cc8a9',
                  'hash_100013eec5ae6bc3c3ce86ac0a4b9d9ad07e5a',
                  'hash_10001367e882593a3f67a8e3319cba1c881412'
               ],
               item => 'pages_created',
               task => 'hash_0900133f68d0dacb01ae52ee57d32845184b97',
               type => 'AREA'
            },
            {  color  => 'E6D883',
               hashes => [
                  'hash_100013edf22d9ba85d806adb691f9d79450da3',
                  'hash_100013c7fe57ccf638845a30d74557ed005e62',
                  'hash_1000138c232a2da0e09884bc124da80f451505',
                  'hash_100013765aabd73eb15beeb616f4aaba657818'
               ],
               item => 'pages_read',
               task => 'hash_090013a173cf9cad9ebd6394b220700c72887c',
               type => 'STACK'
            },
            {  color  => '55AD84',
               hashes => [
                  'hash_100013e0228f620c72daec30dcbdff9baa07da',
                  'hash_100013172bfa89f1bed5ce930a52737af78fa4',
                  'hash_1000134d1b82e9640177b4c7d74fc29265f1b3',
                  'hash_10001326cd06f682d8bd046412f1d3e2ec98d0'
               ],
               item => 'pages_written',
               task => 'hash_090013bbd21b7341904b7f4e162dcdf7fe4bb0',
               type => 'STACK'
            }
         ],
      },
      {  base_value => '1000',
         dt         => {
            hash  => 'hash_010013f1e9a48e5e5ee153ebee5aee529b46a6',
            input => 'Get MySQL Stats',
            pending_aio_log_ios => {
               data_source_type_id => '1',
               hash => 'hash_080013fc152dab944cf8defb9abca88eca72ab'
            },
            pending_aio_sync_ios => {
               data_source_type_id => '1',
               hash => 'hash_08001336c9b07cd0ae44be946eac9d2c5990f7'
            },
            pending_buf_pool_flushes => {
               data_source_type_id => '1',
               hash => 'hash_0800138c57848b1f40239c68b01e0b66310d4a'
            },
            pending_chkp_writes => {
               data_source_type_id => '1',
               hash => 'hash_080013800348e37be481771454d906c1d1d8de'
            },
            pending_ibuf_aio_reads => {
               data_source_type_id => '1',
               hash => 'hash_080013be22dfb8efd92b9fe309592dec10cc8d'
            },
            pending_log_flushes => {
               data_source_type_id => '1',
               hash => 'hash_0800135375f9f3b8b479d403330074c5dd6b57'
            },
            pending_log_writes => {
               data_source_type_id => '1',
               hash => 'hash_08001325cc4d35043d3209f5c04d82757c93d2'
            },
            pending_normal_aio_reads => {
               data_source_type_id => '1',
               hash => 'hash_080013e21d7e99fa7ef26cacb7752e46a478cc'
            },
            pending_normal_aio_writes => {
               data_source_type_id => '1',
               hash => 'hash_080013fa7e7dd36bd47498841b103fb0d333a4'
            }
         },
         hash  => 'hash_0000138d45ae00a3c6856c8cb4e27e0c10eae6',
         items => [
            {  color  => 'FF0000',
               hashes => [
                  'hash_100013d21a9951ba8813a4505f2572e2bef676',
                  'hash_100013f03e27a71b81610e839262a2fb8ec4b7',
                  'hash_1000131a0cbc1cba7bfd5cf5d641b6146c0c4b',
                  'hash_10001308e80ca0dc28c401920dbd3540cf765a'
               ],
               item => 'pending_aio_log_ios',
               task => 'hash_0900135aa2c17a7bb448e4180a1c28db51b591',
               type => 'LINE1'
            },
            {  color  => 'FF7D00',
               hashes => [
                  'hash_100013ce67b7a964ab4c3bc8a1578e5dcc76f9',
                  'hash_100013dd876c2147e37ff976803a18ef40371a',
                  'hash_100013619e93ae2a74953949153852cc0621fe',
                  'hash_10001376c4e95626c9cc0cec44da88decb3925'
               ],
               item => 'pending_aio_sync_ios',
               task => 'hash_09001365cc4c97240cf85f016eb669a1b4f354',
               type => 'LINE1'
            },
            {  color  => 'FFF200',
               hashes => [
                  'hash_1000138aa736fa01c628e975b41252e512ec94',
                  'hash_10001365b2e3b048397ed0e1480b7319fb3443',
                  'hash_100013c72917dfc5af5dd476f266520d425241',
                  'hash_100013fc81f3cb45d20d13316d69a8574917dd'
               ],
               item => 'pending_buf_pool_flushes',
               task => 'hash_090013101a3323f1645a6d7edb5a0c37198240',
               type => 'LINE1'
            },
            {  color  => '00A348',
               hashes => [
                  'hash_10001317582e94b4264ab817938c8bada78efa',
                  'hash_100013db72e7d89fea92ef3e9abc3706b27b36',
                  'hash_10001309946af875c05e210f8f70f01f24d93e',
                  'hash_100013027cb7c607a2e0f20227cf3ebc5341f2'
               ],
               item => 'pending_chkp_writes',
               task => 'hash_0900133d596ee5a228b20433cc863155d03956',
               type => 'LINE1'
            },
            {  color  => '6DC8FE',
               hashes => [
                  'hash_1000139673dcdfd1f439cf6ca7a8871d0979c9',
                  'hash_100013e023366a6af291e1797b7c7d57fb7f79',
                  'hash_100013e63fe4d64fc6eb41ad1d8745b36a3d04',
                  'hash_1000132354e66e7c9a43f02c6b1e7d9e51dc91'
               ],
               item => 'pending_ibuf_aio_reads',
               task => 'hash_090013272b558c66014863c060908d89448961',
               type => 'LINE1'
            },
            {  color  => '4444FF',
               hashes => [
                  'hash_100013db06f04a06097376c0bed252423c8c6c',
                  'hash_1000139cb48a22ccd7bd680511fb702b1dcf71',
                  'hash_100013ad44daf07dfb9a2a4df14b3ec3ce8f58',
                  'hash_1000138f525137edd9df0006f1eef9bfa69401'
               ],
               item => 'pending_log_flushes',
               task => 'hash_09001379fd321f9acb3991efc056fdeb3cedb1',
               type => 'LINE1'
            },
            {  color  => '55009D',
               hashes => [
                  'hash_100013fe3f897a75b84aee639e832063610f27',
                  'hash_1000139f014c0d51042ab5de5aa5dc04a35d87',
                  'hash_10001319197f10e9a007e1ae58dbe0881d01e0',
                  'hash_100013fbcf731f5ab559282403896740822952'
               ],
               item => 'pending_log_writes',
               task => 'hash_0900132f205d604d825b8ba4894c6ccdb20ff4',
               type => 'LINE1'
            },
            {  color  => 'B90054',
               hashes => [
                  'hash_10001315c67502eadf765f66179d6ca5d6761b',
                  'hash_1000131dff5f52f49d6ae236c856e23d85a8a3',
                  'hash_1000137542394e5b2210ee44e2f2fa5bef6042',
                  'hash_100013e11cf5f3587dcf6e066fdef5fbff7818'
               ],
               item => 'pending_normal_aio_reads',
               task => 'hash_09001331023270b18d06a25de3b4e8d1f81988',
               type => 'LINE1'
            },
            {  color  => '8F9286',
               hashes => [
                  'hash_100013b7525295600f757e9abaef973c74f418',
                  'hash_10001300b2d22372be4021532bddf9a7b93792',
                  'hash_100013ce1bb418cdf977ea49ceb48f2e6f6677',
                  'hash_100013564854fe731da9f47140e39d1fdcb027'
               ],
               item => 'pending_normal_aio_writes',
               task => 'hash_090013c26c20a87d2cca682599b33fe3863c7e',
               type => 'LINE1'
            }
         ],
         name => 'InnoDB I/O Pending'
      },
      {  base_value => '1024',
         name => 'InnoDB Log',
         dt         => {
            hash => 'hash_01001331dcfc560537b6f93ced9e6aa6c272e0',
            innodb_log_buffer_size => {
               data_source_type_id => '1',
               hash => 'hash_080013297edbf2eccbdf0dabda7d8166884cd5'
            },
            input             => 'Get MySQL Stats',
            log_bytes_flushed => {
               data_source_type_id => '2',
               hash => 'hash_080013de41286a9e5734185c7a4eac909a1580'
            },
            log_bytes_written => {
               data_source_type_id => '2',
               hash => 'hash_080013dc4885299416ee40c40c96b36f1a0511'
            },
            unflushed_log => {
               data_source_type_id => '2',
               hash => 'hash_080013dbfd089a2e1f44392fcfa1c3499f1013'
            }
         },
         hash  => 'hash_0000136932388e4d279763fbb5aa8de2ae234f',
         items => [
            {  color  => '2E111A',
               hashes => [
                  'hash_100013c423f770cd7c28ea828f07eafe8a0d8e',
                  'hash_100013944a7ba19cd050a8a7bf97eaf92e2abd'
               ],
               item => 'innodb_log_buffer_size',
               task => 'hash_09001311fb91244cce5df61a0da010fb524445',
               type => 'AREA'
            },
            {  color  => '5B8257',
               hashes => [
                  'hash_1000130b5c10093a46c828a111a7cec5a0185f',
                  'hash_100013acf3d6e8c8956e88c608785f45b3aaf3',
                  'hash_100013a65ab0ae13164a97f9a0ab34f157ef53',
                  'hash_100013502ad627f2520ca965e29e693ef0289e'
               ],
               item => 'log_bytes_written',
               task => 'hash_09001347fac87eaf3a0b2ddaac47352c0e3396',
               type => 'AREA'
            },
            {  color  => 'AB4253',
               hashes => [
                  'hash_1000133e79586e910c279a76578637b0878d10',
                  'hash_100013c0966b24084c40ef5a85e0febd2f4052',
                  'hash_10001384554ec500c694be73d300733e1873a4',
                  'hash_1000133e65794f011f26f044b88b7bda7c51de'
               ],
               item => 'log_bytes_flushed',
               task => 'hash_090013ccd834528645793e0f8c001dd24ef966',
               type => 'LINE1'
            },
            {  color  => 'B99B59',
               hashes => [
                  'hash_100013da80bd49abd1bdea5a9cea349b0b199c',
                  'hash_100013316e2c71816a5c05bf978f1d66c122fe',
                  'hash_100013ac65e2932e4436f728d862e1ffa4bff3',
                  'hash_100013998cb4617d6e1f967542e3bec06c3758'
               ],
               item => 'unflushed_log',
               task => 'hash_09001341a98dfb81d93aad098e007e696143cb',
               type => 'AREA'
            }
         ],
      },
      {  base_value => '1024',
         dt         => {
            Binlog_cache_disk_use => {
               data_source_type_id => '2',
               hash => 'hash_080013c5d1d5f676d73244c30e0d71c9324fd1'
            },
            Binlog_cache_use => {
               data_source_type_id => '2',
               hash => 'hash_080013f787be2f29e6a6c727d51629d310dd4c'
            },
            binary_log_space => {
               data_source_type_id => '1',
               hash => 'hash_080013a4b9d1a7f255ad789d348354091cb475'
            },
            hash            => 'hash_010013e8dd5e9ae743b7b64c91aa09862c20cd',
            input           => 'Get MySQL Stats',
            relay_log_space => {
               data_source_type_id => '1',
               hash => 'hash_080013d17011029e29581769e5414579ca2f5c'
            }
         },
         hash  => 'hash_0000137625c8f2f05e861825644bc1832779a3',
         items => [
            {  color  => '35962B',
               hashes => [
                  'hash_100013c5b05fc456a9cad2a69a58ee3e56118a',
                  'hash_10001394bd92fcfd69ebdb73c3a3577dc7ef58',
                  'hash_100013dd96f360449d720dbc16864dbb15e8fc',
                  'hash_1000131699c5a26d871b28b9d4eb51eef53f8a'
               ],
               item => 'Binlog_cache_use',
               task => 'hash_090013845a2453632d3adb9c9a17ef7a7b2551',
               type => 'LINE1'
            },
            {  color  => 'FF0000',
               hashes => [
                  'hash_1000138bad3e47d6fb153fbc99794918fe2512',
                  'hash_1000138032865a15e68e2e0555d22edd5ff42c',
                  'hash_100013632bda96bd1eac81024969c449f204d7',
                  'hash_1000130a539358313a62bfa639091d8517c498'
               ],
               item => 'Binlog_cache_disk_use',
               task => 'hash_0900136269a13748fd88a1400b82d00a2c7f3c',
               type => 'LINE1'
            },
            {  color  => '8D00BA',
               hashes => [
                  'hash_100013d6582cb06b9d448e2c3c3bb6e50c50d5',
                  'hash_100013cb4d8c2db6435a9ccfc5f53862f02a3d',
                  'hash_1000139d0b945724e324e22a604c72950b4ead',
                  'hash_100013cd0efca302f184dd204924ee64df2fdf'
               ],
               item => 'binary_log_space',
               task => 'hash_090013cea2aa6e1e341f8087a216c23828fd83',
               type => 'LINE1'
            },
            {  color  => '8F005C',
               hashes => [
                  'hash_100013857d639ccb42443ae1f6f9760aa635bc',
                  'hash_100013aa2b804807ffbf1e9e43e9a352842b6c',
                  'hash_100013e785b7e00e316e6f4c32a0a377bf204d',
                  'hash_100013abb03054799f429bf4b4a6c19bf5dc2d'
               ],
               item => 'relay_log_space',
               task => 'hash_090013a438532286deb84c433682de21d31cf4',
               type => 'LINE1'
            }
         ],
         name => 'MySQL Binary/Relay Logs'
      },
      {  base_value => '1000',
         dt         => {
            current_transactions => {
               data_source_type_id => '1',
               hash => 'hash_08001365dd57fbce5ead54134c6503c037db90'
            },
            hash         => 'hash_010013fbbf7f38a0a20613dc79003f0c702084',
            history_list => {
               data_source_type_id => '1',
               hash => 'hash_080013d77d77348050b6a61f9df87f2cd0a47c'
            },
            innodb_transactions => {
               data_source_type_id => '2',
               hash => 'hash_0800134bb48cfeb0c6ba33cd0efc263f17d3d6'
            },
            input      => 'Get MySQL Stats',
            read_views => {
               data_source_type_id => '1',
               hash => 'hash_08001324c6e5dcd3e22c73c19a3ff8eee9d6c2'
            },
            transaction_lock_time => {
               data_source_type_id => '1',
               hash => 'hash_0800133a2b84efcc69304a9362a08cda9c1da2'
            },
            transaction_time => {
               data_source_type_id => '1',
               hash => 'hash_080013eebbc6aae3eae872da81fdf51cdf3b63'
            }
         },
         hash  => 'hash_00001351903a7fa74d34dbbb9ab47203b7362b',
         items => [
            {  color  => '8F005C',
               hashes => [
                  'hash_100013c3a080885091b936617afd51968e86fe',
                  'hash_1000138bbb9681ff7835d6d725f5f9de021f21',
                  'hash_100013acbd62720c59a24b72df434f5f997be5',
                  'hash_100013c2635e832f989960faa2710b780c48e8'
               ],
               item => 'innodb_transactions',
               task => 'hash_090013ed94196aac019b05e7d6dea85d2426ed',
               type => 'LINE1'
            },
            {  color  => '4444FF',
               hashes => [
                  'hash_1000131541676d140a4dac37656c772c56e83f',
                  'hash_1000130d2599eaa11fd4e3f1c1f56df279df0a',
                  'hash_100013a4557928a62844ccb487e73ec01aa6e0',
                  'hash_1000132818ffcfcceaa49d0d0f1f2315af2006'
               ],
               item => 'current_transactions',
               task => 'hash_090013a34797ac2967209ac53511847683d493',
               type => 'LINE1'
            },
            {  color  => 'FF7D00',
               hashes => [
                  'hash_100013b66a6d7a2ef6f29f92dd2cd07aa5ab55',
                  'hash_100013b68ced42be8345b14d16c9e9e714a93e',
                  'hash_100013b098dc91c0b51b21e318aaf2181238e4',
                  'hash_100013fd6f9a810514cfb9bdf5bc9638394538'
               ],
               item => 'history_list',
               task => 'hash_090013e3f9eafa729269f2f1f0be84469739c4',
               type => 'LINE1'
            },
            {  color  => '74C366',
               hashes => [
                  'hash_1000136d6d7abff63a7a52a1ee61168f8320a1',
                  'hash_10001326bba3ca70e705b05186396a4379357f',
                  'hash_10001358e550f8923ae74195585e11270de50a',
                  'hash_1000138f81adca5b09f671a0ce364c66c910ad'
               ],
               item => 'read_views',
               task => 'hash_0900132ec141f159d322bcc954561e4584ce44',
               type => 'LINE1'
            },
            {  color  => '008A77',
               hashes => [
                  'hash_100013da7cc5076c20eb4dd7cd8b7005b5a78c',
                  'hash_10001308dbaa0ba9d48310029556ffc1694b70',
                  'hash_1000134e2f590c5dd7fde2b176181dc1cb6349',
                  'hash_1000134197391512332c371d61c0413845bbd1'
               ],
               item => 'transaction_time',
               task => 'hash_0900139b7ede3cb56c016117f8ad798feca2f6',
               type => 'LINE1'
            },
            {  color  => '8D00BA',
               hashes => [
                  'hash_100013acab0ed39cc9248741adc1ea80ec73c1',
                  'hash_100013ac8025ab358d0d25dfbf6fb8fd733a67',
                  'hash_1000137fb1c36d3bc9c35317e868c0ff7ff103',
                  'hash_100013378bec8aeabd7610226342495813a139'
               ],
               item => 'transaction_lock_time',
               task => 'hash_090013c4b2e1795809d0bf27a6605da2a29b2e',
               type => 'LINE1'
            }
         ],
         name => 'InnoDB Transactions'
      },
      {  base_value => '1000',
         dt         => {
            Open_files => {
               data_source_type_id => '1',
               hash => 'hash_0800139b2465446100422df23bc22189d93d49'
            },
            Open_tables => {
               data_source_type_id => '1',
               hash => 'hash_0800136a4c5bbc5e1010c27f25ae5099125a9b'
            },
            Opened_tables => {
               data_source_type_id => '2',
               hash => 'hash_080013b31d2e1ef1d9178247ce4e874ae88e33'
            },
            hash        => 'hash_010013a9377536471aa6701b8fb1eeb264e1c0',
            input       => 'Get MySQL Stats',
            table_cache => {
               data_source_type_id => '1',
               hash => 'hash_0800139576ab3e9c3b59b7806af18db882a6ec'
            }
         },
         hash  => 'hash_0000134a866608a68455a7e007c6ed07b1389a',
         items => [
            {  color  => '96E78A',
               hashes => [
                  'hash_10001333a746dcc4a95dff1b433fee306e0684',
                  'hash_10001329c6a88d42f3f9bf18fd6d11ca87990d'
               ],
               item => 'table_cache',
               task => 'hash_09001398b2586579aa124db0a44157312cda88',
               type => 'AREA'
            },
            {  color  => '9FA4EE',
               hashes => [
                  'hash_100013976798d4f86d71a171872e9f088885fc',
                  'hash_10001323f8dc021c342f1a836acc07dd9f6707',
                  'hash_100013b28206886165e05ae5f8d4e2f5b0dc94',
                  'hash_1000139890f3f876ae0ba5d63c7584c49899a5'
               ],
               item => 'Open_tables',
               task => 'hash_0900134b9f13b60f1047b67f585952fcdd523c',
               type => 'LINE1'
            },
            {  color  => 'FFD660',
               hashes => [
                  'hash_100013d9dfa15dcbd8c9e1f48e0e6791898f47',
                  'hash_10001380449a7ae5a282757b2b979be8390a2f',
                  'hash_10001378b40b8618a0580d2c860bb21f9c0a9e',
                  'hash_1000137ab18fafaba985d7dd05f1ecb320bee1'
               ],
               item => 'Open_files',
               task => 'hash_090013040612acab7300d2c6774e5f08b789e1',
               type => 'LINE1'
            },
            {  color  => 'FF0000',
               hashes => [
                  'hash_100013e7bb489f5d3384b0100ac76c4448bc79',
                  'hash_100013ba5f7f8444ec9094a1db780cda473702',
                  'hash_1000131b78488e57bdd0d87f443d4588be6577',
                  'hash_1000135dbf7983e735e09f45d0e6ff19547089'
               ],
               item => 'Opened_tables',
               task => 'hash_0900132e51ebb8bb7188432bcc3f789d3bc8b0',
               type => 'LINE1'
            }
         ],
         name => 'MySQL Files and Tables'
      },
      {  base_value => '1000',
         dt         => {
            hash  => 'hash_010013f12a4fdc2bbe8cee87181ba0feaf67ed',
            input => 'Get MySQL Stats',
            Threads_created => {
               data_source_type_id => '2',
               hash => 'hash_080013b46bed6846abf8d3061ff730d770d13e'
            },
            thread_cache_size => {
               data_source_type_id => '1',
               hash => 'hash_0800138983fa5dd8398bfa87abd22a32a1c849'
            }
         },
         hash  => 'hash_000013f530abf34e8b5a64302b3bd0b5e910be',
         items => [
            {  color  => 'D8ACE0',
               hashes => [
                  'hash_100013ad46b6a1aa4f388b3abe0c49ca447cae',
                  'hash_1000136585d5733853c43deb022b40ccfdbb30'
               ],
               item => 'thread_cache_size',
               task => 'hash_090013af84905979e09a5edb8aeb5548e1ef9f',
               type => 'AREA'
            },
            {  color  => 'DE0056',
               hashes => [
                  'hash_1000134b53caedc48f17e9c108b9e4f858b63a',
                  'hash_100013721c9388de416c984c2b58400c98cec0',
                  'hash_100013c88f9d4ffcdcef3df7d82628195b5d74',
                  'hash_1000134e64d92b5d72ef80783e7531a7af0912'
               ],
               item => 'Threads_created',
               task => 'hash_090013465942b335de9c95920252ccacf9e21f',
               type => 'LINE1'
            }
         ],
         name => 'MySQL Threads'
      }
   ],
   hash   => 'hash_0200133df221ff7893faad48ecc15026687215',
   inputs => {
      'Get MySQL Stats' => {
         hash => 'hash_030013a7b8dc9089ba40cbb293524024e51129',
         input_string =>
            '<path_php_binary> -q <path_cacti>/scripts/ss_get_mysql_stats.php <hostname> <username><password>',
         inputs => [
            {  allow_nulls => '',
               hash        => 'hash_070013c89cbc8b1c987e050a310ee5414b2a02',
               name        => 'hostname'
            },
            {  allow_nulls => 'on',
               hash        => 'hash_070013181ee907dbb2bbfbfb3c6611f44e5625',
               name        => 'username'
            },
            {  allow_nulls => 'on',
               hash        => 'hash_070013e4ad68877c6e87087e52785d0a870282',
               name        => 'password'
            }
         ],
         name    => 'Get MySQL Stats',
         outputs => {
            Aborted_clients  => 'hash_070013c44a197ff40a95758cf75c0cade30652',
            Aborted_connects => 'hash_070013caf8529043654bbe8ecd836b5ba5025e',
            Binlog_cache_disk_use =>
               'hash_0700130ff552934f7b897db8ed4097faecab41',
            Binlog_cache_use => 'hash_0700136697a312ccb02b101c6e66cec76e648b',
            Bytes_received   => 'hash_070013df10d36e573ba98662f6e0418640ae3d',
            Bytes_sent       => 'hash_0700138690bb38429a73eaf7cd4f99d7fd6e89',
            Com_delete       => 'hash_070013891099bd129763b3412d744092fcdbb4',
            Com_delete_multi => 'hash_0700134571b33e73edc8a4ebefb8d2b6085a79',
            Com_insert       => 'hash_0700130c6d622de93e4e3ab8458519861acd48',
            Com_insert_select =>
               'hash_07001303f0f68e3b8b49668f7c9f0c4d7f1b78',
            Com_load    => 'hash_070013bfaaaa13aaec878ddd0ff575390f65d0',
            Com_replace => 'hash_070013d54d723196fd07a6c0a75a0266102d31',
            Com_replace_select =>
               'hash_07001389e7f4c2ca696a0d4255d9b62ad8e5ad',
            Com_select       => 'hash_0700132c4385f257e7384c58be804659009a46',
            Com_update       => 'hash_0700137f2ce11c4fd45b83beb44d6f2a892fff',
            Com_update_multi => 'hash_0700130831a668b303b953e052de2f02b9d490',
            Connections      => 'hash_0700138bc4cf68ea89224e7c328c9ad02cca53',
            Created_tmp_disk_tables =>
               'hash_0700134065eb94dd7c608d5263733304fb4af2',
            Created_tmp_files =>
               'hash_070013e743e79638fe54f83f02753b4fee904d',
            Created_tmp_tables =>
               'hash_070013bb72056a8d0d303a689c0fc2f0ce819d',
            Key_read_requests =>
               'hash_070013b1c52bc482f979e5098096f60a346d96',
            Key_reads => 'hash_070013744750ba74f76128825af0421da2fc5e',
            Key_write_requests =>
               'hash_070013f883de2e830958a1b3472f1bb8209b16',
            Key_writes => 'hash_070013edc5905b12c0765d8b244467bf90ef13',
            Max_used_connections =>
               'hash_0700132f241c0517d2360b95c7a4e77b02f566',
            Open_files    => 'hash_0700131ef2adc0d376e3e1fdc4ce9259c2c196',
            Open_tables   => 'hash_0700136b886ca6d3e23c6e4b1e105c524023ad',
            Opened_tables => 'hash_070013b45b6f6e212413aef805156e68b25afe',
            Qcache_free_blocks =>
               'hash_070013ef60bf6d7d4fd17b112b09b364430ab0',
            Qcache_free_memory =>
               'hash_070013ee91f0cd96ad45f08b4792c0a8d1059a',
            Qcache_hits    => 'hash_0700138da89cd1f21dab5ea12c0cc4b7701d5b',
            Qcache_inserts => 'hash_0700131365c62fcc94ca0b21c794ca180d4230',
            Qcache_lowmem_prunes =>
               'hash_0700133ac840ce2ed61d846498fd9b491140ff',
            Qcache_not_cached =>
               'hash_070013731e989154c89df3299c53349abef2cb',
            Qcache_queries_in_cache =>
               'hash_070013a83fff8fbab9d321b6507b7de9cc3f0b',
            Qcache_total_blocks =>
               'hash_070013657857bf4b2f263566e7beaf95b487e8',
            Questions        => 'hash_0700137d78fbce8c4ce121ff9891e1fd897ac9',
            Select_full_join => 'hash_07001370d0234c09971d1a20e0d8bad319e532',
            Select_full_range_join =>
               'hash_070013bf7ae11296a3c3cbf2cc39cbcded29da',
            Select_range => 'hash_07001332b2a53c7b0615ebe5d44fc075ecc2bc',
            Select_range_check =>
               'hash_0700137306a476765aa65150655e1332832234',
            Select_scan => 'hash_070013d5f491ed562a52ed6fe1789c0fc8b741',
            Slave_open_temp_tables =>
               'hash_07001307074dcbc6e98894eb1d9716e4e734b7',
            Slave_retried_transactions =>
               'hash_0700139211e4b40b6d6e408537ede1edcb4733',
            Slow_launch_threads =>
               'hash_0700136480fb6847f8590afbc71bd81d225c3a',
            Slow_queries => 'hash_07001373b510ddd4c5709d62169d01bc2a92d2',
            Sort_merge_passes =>
               'hash_07001314323bed3477892bdff5a41bfdd62681',
            Sort_range => 'hash_07001365befa80dc277f27f1e833ad1a3b2457',
            Sort_rows  => 'hash_0700132caa274e3e57b8dadbcdd0efb86528d7',
            Sort_scan  => 'hash_070013c2ca75726d5fab8e4bb5d2309d339db6',
            Table_locks_immediate =>
               'hash_07001399dfcebcfaa0a280eb131fb4d8a45f4b',
            Table_locks_waited =>
               'hash_070013841b475aa6f2a008eed6611f275b136f',
            Threads_cached => 'hash_070013a8b56906d6206d98f70dfc7ef46023f0',
            Threads_connected =>
               'hash_07001395162a78295564e41ef944f3a3187587',
            Threads_created  => 'hash_0700132f6575618e56c8347fdc06fe8202ec36',
            Threads_running  => 'hash_070013f1b71ba2bafde85d3da86e22bd299ec1',
            binary_log_space => 'hash_070013a7f15a36a6f796eb883ffa7e32de98d6',
            binlog_cache_size =>
               'hash_070013797852de169c3995a0123121b3b1ee7f',
            current_transactions =>
               'hash_070013f5c87aa6244412ca753e87551d14af23',
            database_pages => 'hash_0700131541608aedbc3f66f8964f545cfbadd3',
            file_fsyncs    => 'hash_070013338fe39f1812b7153d5f9cbb88d60a38',
            file_reads     => 'hash_070013e4419947e30b9bc7840b0dcfcc69e95a',
            file_writes    => 'hash_0700132d0066b72fa27a71d2b7fb17c6684533',
            free_pages     => 'hash_070013a20d995282519d16fc752a83eef5a3cc',
            history_list   => 'hash_070013ae98e905a45b9298d9aac7eca6d73f2a',
            ibuf_inserts   => 'hash_070013318e8cd8d2b8819a2b014907dfa2c518',
            ibuf_merged    => 'hash_0700134d89fa70976ef750c1cc791059ec7892',
            ibuf_merges    => 'hash_070013e64d32c93cfee9363a08a94bebeee12c',
            innodb_log_buffer_size =>
               'hash_07001319aa4b0546368636cbd482b6fdadf499',
            innodb_open_files =>
               'hash_07001334a01d83ff17e3d3a4b9e551d9f77e8c',
            innodb_transactions =>
               'hash_070013e1808374ce89fd8f25cfa7fa25072b89',
            log_bytes_flushed =>
               'hash_0700135c8a253f867050eed551de5f6f09ffd8',
            log_bytes_written =>
               'hash_0700134e446d1bce7eb301907ecb9eb583e463',
            log_writes       => 'hash_070013bd1957bb74760e72094707f078f44217',
            max_connections  => 'hash_07001311485b409d6dfabcad2dbc51091ace72',
            modified_pages   => 'hash_0700137fd4378c273fa2bd1a40fcee558169db',
            open_files_limit => 'hash_070013c89747fa81b0c27eaf3dfe1bc1cd565d',
            os_waits         => 'hash_070013cff71ad21c7d95ecf3043be784ec2502',
            pages_created    => 'hash_0700133405fec44aa54f12cc5714ac32ec89ce',
            pages_read       => 'hash_070013464d8fc2c9da8d0657979ac35df748f6',
            pages_written    => 'hash_070013a74fef18073e5f400ce9cc0440bcc58c',
            pending_aio_log_ios =>
               'hash_070013271505777b4d851f19e0a6fa4377a4fc',
            pending_aio_sync_ios =>
               'hash_07001337aa9ae6504656e5f2ba6c598a11f304',
            pending_buf_pool_flushes =>
               'hash_0700139f629f86602278d8234b6b189ff3888f',
            pending_chkp_writes =>
               'hash_0700134c77de01a2b867b2449054a995ffa86c',
            pending_ibuf_aio_reads =>
               'hash_070013c9c24c937fc0efaed0e638d7fa10a394',
            pending_log_flushes =>
               'hash_0700134922ad225498f768bbb67c7d1291816a',
            pending_log_writes =>
               'hash_070013d59b515f6f10bf78315700e95f8b4d74',
            pending_normal_aio_reads =>
               'hash_070013a792f9c07de8cd7fc11517d0ebbc17bd',
            pending_normal_aio_writes =>
               'hash_070013eb60bf2127ad12b3adfbc4d3ca8f81ae',
            pool_size        => 'hash_070013e8e63bb323d0fdad091c36c34175776d',
            query_cache_size => 'hash_0700134120fd863eabefdf58dd98affcbcc551',
            read_views       => 'hash_070013e748884fa51ecc1378b12dd92cdbfc0f',
            relay_log_space  => 'hash_0700135b2975e68247d14e05d9d362cdd78342',
            rows_deleted     => 'hash_0700130b5522e2956470a5ca78c0f1ce7f334d',
            rows_inserted    => 'hash_0700135b48ba3c3a988f25757cfe44c3741e50',
            rows_read        => 'hash_0700139f6faa993da08c83488ba60448256a44',
            rows_updated     => 'hash_07001379b393539feac8db3a0b993805f1b8f3',
            seconds_behind_master =>
               'hash_070013e58a27d656265dc48d8fd9d905784ec5',
            slave_lag     => 'hash_07001379a4a74739a9d8a1a158c464991900d8',
            slave_running => 'hash_0700138ae23d9b7b2f593774a0ab3e228a7974',
            slave_stopped => 'hash_07001322d491113778e27af564a683bb7a9aaa',
            spin_rounds   => 'hash_070013475d54378bf332f88341c03c73acd5f3',
            spin_waits    => 'hash_07001349230ca679f7ef5a0ddff3323eb9c46e',
            table_cache   => 'hash_0700139c2ffd79f53ce8ddf309a6883c4064dc',
            thread_cache_size =>
               'hash_070013a12707d396d3414a4ebed49ccc83b4d8',
            transaction_lock_time =>
               'hash_0700138c83ac7026cf4d67499da7c3e37bc027',
            transaction_time => 'hash_0700132f9d51ba1056039ebaa14b1a774c8878',
            unflushed_log    => 'hash_07001313f0bccec0c2682a2dd1c0a0264496f2',
            unpurged_txns    => 'hash_0700133f8a6e0a1bee3982f688212d28e6df5b'
         },
         type_id => 1
      }
   },
   name => 'DB Server',
   rras => [
      {  cf_items       => '1|3',
         hash           => 'hash_150013c21df5178e5c955013591239eb0afd47',
         name           => 'Daily (5 Minute Average)',
         rows           => 600,
         steps          => 1,
         timespan       => 86400,
         x_files_factor => '0.5'
      },
      {  cf_items       => '1|3',
         hash           => 'hash_1500130d9c0af8b8acdc7807943937b3208e30',
         name           => 'Weekly (30 Minute Average)',
         rows           => '700',
         steps          => '6',
         timespan       => '604800',
         x_files_factor => '0.5'
      },
      {  cf_items       => '1|3',
         hash           => 'hash_1500136fc2d038fb42950138b0ce3e9874cc61',
         name           => 'Monthly (2 Hour Average)',
         rows           => '775',
         steps          => '24',
         timespan       => '2678400',
         x_files_factor => '0.5'
      },
      {  cf_items       => '1|3',
         hash           => 'hash_150013e36f3adb9f152adfa5dc50fd2b23337f',
         name           => 'Yearly (1 Day Average)',
         rows           => '797',
         steps          => '288',
         timespan       => '33053184',
         x_files_factor => '0.5'
      }
   ]
};
