# This is the template definition file.  To use it, see make-template.pl.  This
# one goes with the ss_get_by_ssh.php script.
#
# This program is copyright (c) 2008 Baron Schwartz. Feedback and improvements
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

# Autobuild: ss_get_by_ssh.php

{
   name   => 'GNU/Linux Server',
   hash   => 'hash_02_VER_0a83853ee620998961253e285c00406a',
   version => {
      version => '1.1.8',
      hash    => 'hash_06_VER_ac10705723a27cae224aa85dc7e38cdb',
   },
   checksum => 'hash_06_VER_3abb0ee2e833b9157f8caaaa3b027e9c',
   graphs => [
      {  name       => 'Interrupts',
         base_value => '1000',
         hash       => 'hash_00_VER_24c02c90d0b7b82d9d01c5064050cf46',
         dt         => {
            hash       => 'hash_01_VER_3cd70fcd5fa165fcad84b3b54803ed86',
            input      => 'Get Proc Stats',
            STAT_interrupts => {
               data_source_type_id => '3',
               hash => 'hash_08_VER_5856aae85ebd429a27c01c95a7a41e8a'
            },
         },
         items => [
            {  item   => 'STAT_interrupts',
               color  => 'BF4E15',
               task   => 'hash_09_VER_e2a72b5aa0b06ad05dcd368ae0a131cf',
               type   => 'AREA',
               hashes => [
                  'hash_10_VER_3eae0c8f769939bb30c407d4edcee0c0',
                  'hash_10_VER_25aaadab40c1c8e12c45ce61693099b7',
                  'hash_10_VER_43f90f7f26a7c6b3ca41c7219afaa50c',
                  'hash_10_VER_df9555d08c88c6c0336fe37ffe2ad74a'
               ],
            },
         ],
      },
      {  name       => 'Context Switches',
         base_value => '1000',
         hash       => 'hash_00_VER_be9d70cf28f1fd074471484dd7615973',
         dt         => {
            hash       => 'hash_01_VER_98d7a3b21446fd1fcee4e8ec7e0bb352',
            input      => 'Get Proc Stats',
            STAT_context_switches => {
               data_source_type_id => '3',
               hash => 'hash_08_VER_cd257aa0c6d27dd53587d361f00c5f42'
            },
         },
         items => [
            {  item   => 'STAT_context_switches',
               color  => '91204D',
               task   => 'hash_09_VER_58efa55c5f72514a7eddd86bacb2faf7',
               type   => 'AREA',
               hashes => [
                  'hash_10_VER_8a1798df960e16ef00b801838e030323',
                  'hash_10_VER_69fde691f4a5184e3eb145d4431f9835',
                  'hash_10_VER_3996b595248c69e8430d1b68944fb7c2',
                  'hash_10_VER_6f72abf6ee2fd28bcbf05af601f9c1ce'
               ],
            },
         ],
      },
      {  name       => 'Forks',
         base_value => '1000',
         hash       => 'hash_00_VER_93fe40661ff2f7ebc56111d6b5c12b57',
         dt         => {
            hash       => 'hash_01_VER_493ed41bd1f902d083f80d8d673f151d',
            input      => 'Get Proc Stats',
            STAT_forks => {
               data_source_type_id => '3',
               hash => 'hash_08_VER_e41ee66c659ed1afe2a6faeea17390ef'
            },
         },
         items => [
            {  item   => 'STAT_forks',
               color  => '9E8655',
               task   => 'hash_09_VER_8f535aa13a1d1b80611c0b0db54ac8c2',
               type   => 'AREA',
               hashes => [
                  'hash_10_VER_ce614a9d654daa276c123609cf055f5f',
                  'hash_10_VER_c18352a4c9f3a11043833d733ad07bef',
                  'hash_10_VER_0a2dc0307aed002e0a51fcec3ef7391b',
                  'hash_10_VER_014727870ff082dced2ab72a0881be47'
               ],
            },
         ],
      },
      {  name       => 'CPU Usage',
         base_value => '1000',
         hash       => 'hash_00_VER_43659d6f7ddcdd39f8382554b1122968',
         dt         => {
            hash       => 'hash_01_VER_a23b607098aca1e8985765ffe0577aca',
            input      => 'Get Proc Stats',
            STAT_CPU_user => {
               data_source_type_id => '3',
               hash => 'hash_08_VER_0536a8683791c498e0e2acc3d0311504'
            },
            STAT_CPU_nice => {
               data_source_type_id => '3',
               hash => 'hash_08_VER_6aaeb871f3d46d19f9b3fc5aa7c902f3'
            },
            STAT_CPU_system => {
               data_source_type_id => '3',
               hash => 'hash_08_VER_fe1a5642a47b67eee7371a24d1d1c1d3'
            },
            STAT_CPU_idle => {
               data_source_type_id => '3',
               hash => 'hash_08_VER_8a21a24a887a03ea128c642af38b3a71'
            },
            STAT_CPU_iowait => {
               data_source_type_id => '3',
               hash => 'hash_08_VER_d3199f78dafc5c469c97cd56991126ad'
            },
            STAT_CPU_irq => {
               data_source_type_id => '3',
               hash => 'hash_08_VER_118f47b0457c032ca8b2483af7fa7421'
            },
            STAT_CPU_softirq => {
               data_source_type_id => '3',
               hash => 'hash_08_VER_583d5902dc2f3af737d580eb38b3b99a'
            },
            STAT_CPU_steal => {
               data_source_type_id => '3',
               hash => 'hash_08_VER_c5e2813e5c38e221a9e307d709ac49c8'
            },
            STAT_CPU_guest => {
               data_source_type_id => '3',
               hash => 'hash_08_VER_e5f9bec5d8b5e6b12222558f97692476'
            },
         },
         items => [
            {  item   => 'STAT_CPU_user',
               color  => '941342',
               task   => 'hash_09_VER_bcd1d3627f1722dfc4d34a0101abfb14',
               type   => 'AREA',
               hashes => [
                  'hash_10_VER_9771d7f468c85bbb04e3364d3250238a',
                  'hash_10_VER_069f4915e2a8a395004e9455b10f9ab4',
                  'hash_10_VER_706d5478f7940aee3c09fb7a685d5ca5',
                  'hash_10_VER_d661f25c3097957471bd9665ce4c05d5'
               ],
            },
            {  item   => 'STAT_CPU_nice',
               color  => '435247',
               task   => 'hash_09_VER_fb8ac638fa7dffbed5107e498371aadf',
               type   => 'STACK',
               hashes => [
                  'hash_10_VER_06511a68a1817adc4efb58302786a0ba',
                  'hash_10_VER_bb4754405f630e3990527d88d0d68824',
                  'hash_10_VER_a59faab5b33149d2ba69db1a727737fa',
                  'hash_10_VER_a59020353135fd7d50552dcfba519038'
               ],
            },
            {  item   => 'STAT_CPU_system',
               color  => '00CBF6',
               task   => 'hash_09_VER_aaf7cd4a13ccbf0df457c3e6dc6c7c36',
               type   => 'STACK',
               hashes => [
                  'hash_10_VER_c65fbd13dbf302241f3671c602eeb2e6',
                  'hash_10_VER_4ef17a2eb1a0d54af15992e54adffea1',
                  'hash_10_VER_99d61b66773be58885971e1a048039ee',
                  'hash_10_VER_6e5b9085b24d2ed18414ba70f9580686'
               ],
            },
            {  item   => 'STAT_CPU_idle',
               color  => 'BFBD82',
               task   => 'hash_09_VER_9839470a495fe4d8fcbe9d0a69687b53',
               type   => 'STACK',
               hashes => [
                  'hash_10_VER_0317005db11fa5608e482ac770c8c0f7',
                  'hash_10_VER_ecbd9c58b5bac0a770a383b654dc5e73',
                  'hash_10_VER_8f1791a55c1594a802ad259b7ce7ce49',
                  'hash_10_VER_1aec02484c1357ed12e138669eac1d77'
               ],
            },
            {  item   => 'STAT_CPU_iowait',
               color  => 'C5031A',
               task   => 'hash_09_VER_4cf48b70e4a5ad7167d75f75ee09c2d6',
               type   => 'STACK',
               hashes => [
                  'hash_10_VER_b90a07141bccb60619251e7c4b8d7b3b',
                  'hash_10_VER_8d15bacbe09c21c7ec97bff64aa90b17',
                  'hash_10_VER_a27b37db4f994f777c369dd7c902f870',
                  'hash_10_VER_ff35f7f27d2018eb6de1b9849370e0fb'
               ],
            },
            {  item   => 'STAT_CPU_irq',
               color  => 'F39034',
               task   => 'hash_09_VER_807de7fb40f93e68ca95f9e007db2d34',
               type   => 'STACK',
               hashes => [
                  'hash_10_VER_adaa3da56b0a9fcbfca02320506870a4',
                  'hash_10_VER_589f0771653b0562b6dccb87ba41c7db',
                  'hash_10_VER_9263089bbd698a5613a77f9134f75bd1',
                  'hash_10_VER_73af29c6228bcc09b6c65751d129a4f0'
               ],
            },
            {  item   => 'STAT_CPU_softirq',
               color  => '3D282A',
               task   => 'hash_09_VER_1fafae6e8f08d9d8607771c4cf2f80a3',
               type   => 'STACK',
               hashes => [
                  'hash_10_VER_d8a9daf0112277dc7fc3719b44fa76ed',
                  'hash_10_VER_2ffb59553b833bb83c3de54b38f6062d',
                  'hash_10_VER_7cbc30c03b71ff19c306ae6783221ff1',
                  'hash_10_VER_cf91867f240163fcb712646f2d1b1512'
               ],
            },
            {  item   => 'STAT_CPU_steal',
               color  => '33369E',
               task   => 'hash_09_VER_e9a428d265e2ba2aaa8e6392f0a259fd',
               type   => 'STACK',
               hashes => [
                  'hash_10_VER_ed83a988d35ccbbad3d324a56ead35ae',
                  'hash_10_VER_afd0bd45565bdd2291933153bd9e3554',
                  'hash_10_VER_755c27a95bb23392fbf58f6c3a99c875',
                  'hash_10_VER_d70e624212e0bf9336ce2e8f72eaee06'
               ],
            },
            {  item   => 'STAT_CPU_guest',
               color  => '08A000',
               task   => 'hash_09_VER_dc4d6789244897e058b7f81176ce0110',
               type   => 'STACK',
               hashes => [
                  'hash_10_VER_6311cf7692585c6fcc6686f9358f1ce9',
                  'hash_10_VER_b229f7630527eba43022dcd4ca091061',
                  'hash_10_VER_a7ba75b32d34aeb974d01a7c671c6c45',
                  'hash_10_VER_832d805ca2a8390c1b3b335effc32b15'
               ],
            },
         ],
      },
      {  name       => 'Load Average',
         base_value => '1000',
         hash       => 'hash_00_VER_8f65f7434580fedac32c569072e5542a',
         dt         => {
            hash       => 'hash_01_VER_472e14fc7e17ffbdbb20e48e4d7eeef3',
            input      => 'Get W',
            STAT_loadavg => {
               data_source_type_id => '1',
               hash => 'hash_08_VER_3743abc62f57cad148636275d2f6ab4e'
            },
         },
         items => [
            {  item   => 'STAT_loadavg',
               color  => '803405',
               task   => 'hash_09_VER_503e6e1741c7612155abbcbf10741e68',
               type   => 'AREA',
               hashes => [
                  'hash_10_VER_911ceb71fc3b9a46d034fcbad90a2161',
                  'hash_10_VER_8f6960ff594aa50293a905eea5162dcf',
                  'hash_10_VER_9db59ef55d1df8813687fc83f0c6817b',
                  'hash_10_VER_44943da7a803c6748655fb18186eea18'
               ],
            },
         ],
      },
      {  name       => 'Number of Users',
         base_value => '1000',
         hash       => 'hash_00_VER_60bfa8002bdb1f5e82007eaf4db83a15',
         dt         => {
            hash       => 'hash_01_VER_f5ff0b3d033a134332bb8aa79418d300',
            input      => 'Get W',
            STAT_numusers => {
               data_source_type_id => '1',
               hash => 'hash_08_VER_087a8db48b8b7110d7a706bf37a6a9e1'
            },
         },
         items => [
            {  item   => 'STAT_numusers',
               color  => '540202',
               task   => 'hash_09_VER_0e11a634103ecf9a3a3e09b3bfb65f7b',
               type   => 'AREA',
               hashes => [
                  'hash_10_VER_166bd36383f182fe92100a2073c8ddf7',
                  'hash_10_VER_50ce3e3fb714fea4c28a2cf0c79b57fc',
                  'hash_10_VER_5fc7e2ff856ed17612ad7be140a13a3b',
                  'hash_10_VER_88ede38e933d09edae08cf78fd230cc2'
               ],
            },
         ],
      },
      {  name       => 'Memory',
         base_value => '1024',
         hash       => 'hash_00_VER_1856b3925a19e33fb1095647ceaf4b30',
         dt         => {
            hash       => 'hash_01_VER_8859f78dffbaebd90065f808511a7cf7',
            input      => 'Get Memory',
            STAT_memused   => {
               data_source_type_id => '1',
               hash => 'hash_08_VER_63d42500eb8a6e95532472edb2105cd6'
            },
            STAT_memcached => {
               data_source_type_id => '1',
               hash => 'hash_08_VER_425a2b253b64a8c8a6d2c71ebd538b24'
            },
            STAT_membuffer => {
               data_source_type_id => '1',
               hash => 'hash_08_VER_2b13cf4c17827713bc8f316843dbc1ef'
            },
            STAT_memshared => {
               data_source_type_id => '1',
               hash => 'hash_08_VER_9dab3b282d4234efc1d9d222e45cf5f7'
            },
            STAT_memfree   => {
               data_source_type_id => '1',
               hash => 'hash_08_VER_ee2349d8f7b88a3407a6cd91d93d925c'
            },
	    STAT_memtotal  => {
               data_source_type_id => '1',
               hash => 'hash_08_VER_b0f77cad230de2e6f778b1579ab13211'
	    },
         },
         items => [
            {  item   => 'STAT_memused',
               color  => '850707',
               task   => 'hash_09_VER_22ba03e69959acc58cc92dec6e22c177',
               type   => 'AREA',
               hashes => [
                  'hash_10_VER_b6a214498184ac468874f69264aea894',
                  'hash_10_VER_cfaa6b6bcc4db69e0858c733d3ef758f',
                  'hash_10_VER_ee01db9cef0132fb28cf8bc0823321c9',
                  'hash_10_VER_f16abe3b636b44d629051277592e340a'
               ],
            },
            {  item   => 'STAT_memcached',
               color  => 'FFDB87',
               task   => 'hash_09_VER_0bd704575ef42344d997cdb21ba4078c',
               type   => 'STACK',
               hashes => [
                  'hash_10_VER_68b413420bd42b0a89c952372cfff3c7',
                  'hash_10_VER_cca8658b90be758c4616e18d12214fac',
                  'hash_10_VER_eae4c8f0503d9e63e10733471c30bbfc',
                  'hash_10_VER_a506bd208353325fc519656b709abde1'
               ],
            },
            {  item   => 'STAT_membuffer',
               color  => '25345C',
               task   => 'hash_09_VER_7a5041bc76b4f32c2bf1e25a6660c09a',
               type   => 'STACK',
               hashes => [
                  'hash_10_VER_ec9c061ea67ad29083bf8846770e8bf5',
                  'hash_10_VER_82a8e59c1e6a599acb32b80801a91579',
                  'hash_10_VER_443481f0100b5d96e32aebc02815776f',
                  'hash_10_VER_6ab6aeb98df59c82773118cd92e0a2df'
               ],
            },
            {  item   => 'STAT_memshared',
               color  => '88008A',
               task   => 'hash_09_VER_da3d4557815d0686d48fbfe1357188e9',
               type   => 'STACK',
               hashes => [
                  'hash_10_VER_68d442fde88ef011be93b6979c9d8429',
                  'hash_10_VER_67dab0ec15e351639e9b5df4eda11afd',
                  'hash_10_VER_4f261666d52fc1f5619f1bf6e12382dd',
                  'hash_10_VER_f2e6bdf6153d32f7dd2daf0eb10f38b2'
               ],
            },
            {  item   => 'STAT_memfree',
               color  => '4F7774',
               task   => 'hash_09_VER_07abfc96b62903dcb95af40b3c926ed6',
               type   => 'STACK',
               hashes => [
                  'hash_10_VER_17b008c435976feebc9a2aca1c012cdc',
                  'hash_10_VER_25106dbbed6a034131bfb7ba2c5c0de3',
                  'hash_10_VER_9eedc6353b73308fb701277e28db1721',
                  'hash_10_VER_a87d701efbd187992dc7c51227c900bb'
               ],
            },
         ],
      },
      {  name       => 'Disk Operations',
         base_value => '1000',
         hash       => 'hash_00_VER_252adf181557beb81563c542c737f1c8',
         override   => { title => 1 },
         dt         => {
            hash       => 'hash_01_VER_1cac931efcc07f7875f6d44febc79ab5',
            input      => 'Get Disk Stats',
            DISK_reads                    => {
               data_source_type_id => '3',
               hash => 'hash_08_VER_f03abec3626d9fae8bb2459e9f7248fc',
            },
            DISK_reads_merged             => {
               data_source_type_id => '3',
               hash => 'hash_08_VER_d4a2e43f4a6c6478e3d6451a05840c5d',
            },
            DISK_writes                   => {
               data_source_type_id => '3',
               hash => 'hash_08_VER_cc6085f71f97288a87fb37bfd707498f',
            },
            DISK_writes_merged            => {
               data_source_type_id => '3',
               hash => 'hash_08_VER_b571044cb24b77bcabeb29f1b9652bbe',
            },
         },
         items => [
            # Colors from
            # http://www.colourlovers.com/palette/903157/Entrapped_InAPalette
            {  item   => 'DISK_reads',
               color  => '2A2829',
               task   => 'hash_09_VER_8075028fd4be854bc996dac375e82e90',
               type   => 'AREA',
               hashes => [
                  'hash_10_VER_c2ef347373a55cc9cd98deffb75a9499',
                  'hash_10_VER_9d3934a94b05d3fd010a3ed25f6d8884',
                  'hash_10_VER_e32112cd27ea9fd1471fcf09a921a7e1',
                  'hash_10_VER_348c8be51c5afe993fc0a9c2e09c7385'
               ],
            },
            {  item   => 'DISK_reads_merged',
               color  => '668284',
               task   => 'hash_09_VER_554572c6fdc83bf683e33fedcbda11a7',
               type   => 'STACK',
               hashes => [
                  'hash_10_VER_67b6b05a8f42568fcc15a627ed8e24aa',
                  'hash_10_VER_35b35ffee6f0aae48211e8aba27c7994',
                  'hash_10_VER_28b68cd50c8304519ad178e58a2ec04b',
                  'hash_10_VER_35ed19d2111590bf381e7139d71387be'
               ],
            },
            {  item   => 'DISK_writes',
               color  => '493736',
               task   => 'hash_09_VER_09973a8ffdda5c60ed1120fa05a70bcb',
               type   => 'AREA',
               cdef   => 'Negate',
               hashes => [
                  'hash_10_VER_dbfa429e02f524e8bf2387b6d6aa2a1c',
                  'hash_10_VER_ed609922b0642eef8da782edb7dc3a81',
                  'hash_10_VER_f6277a7fffd08190d4240e3a10352871',
                  'hash_10_VER_279ef431a03c400c849f140558f7fa68'
               ],
            },
            {  item   => 'DISK_writes_merged',
               color  => '7B3B3B',
               task   => 'hash_09_VER_5ccd9eec4f4329c7f0fea571d19e0487',
               type   => 'STACK',
               cdef   => 'Negate',
               hashes => [
                  'hash_10_VER_b113ba3a059343a69276f4a8234f9287',
                  'hash_10_VER_085057affe0cbb00cceac0749cbd8504',
                  'hash_10_VER_8ed1cc9622a85678d9333df3bd75007a',
                  'hash_10_VER_1754655b31df88eba280bc3236946509'
               ],
            },
         ],
      },
      {  name       => 'Disk Sectors Read/Written',
         base_value => '1024',
         hash       => 'hash_00_VER_9fad7377daacfd611dae46b14cc4f67e',
         override   => { title => 1 },
         dt         => {
            hash       => 'hash_01_VER_67811065b100a543ddeadf7464ae017c',
            input      => 'Get Disk Stats',
            DISK_sectors_read             => {
               data_source_type_id => '3',
               hash => 'hash_08_VER_80929ee708f7755d09443d3d930a29cc',
            },
            DISK_sectors_written          => {
               data_source_type_id => '3',
               hash => 'hash_08_VER_f5d85616af1e03a679042978c938a7ee',
            },
         },
         items => [
            # Colors from
            # http://www.colourlovers.com/palette/694737/Thought_Provoking
            {  item   => 'DISK_sectors_read',
               color  => '542437',
               task   => 'hash_09_VER_38f255216fd118d6d88a46d42357323c',
               type   => 'AREA',
               hashes => [
                  'hash_10_VER_7fe10cf273b9917b2bd9d4185c95c17d',
                  'hash_10_VER_bf9926c2b2141684183bf54c53024c67',
                  'hash_10_VER_93929e0d701da516c2c00b2a986f4afb',
                  'hash_10_VER_61e3158871ff83b947fa61dd55bf0e62'
               ],
            },
            {  item   => 'DISK_sectors_written',
               color  => '53777A',
               task   => 'hash_09_VER_b5085578cca9a7fa280edef3196bbf53',
               type   => 'AREA',
               cdef   => 'Negate',
               hashes => [
                  'hash_10_VER_f1b8a498e6aa39016e875946005468ca',
                  'hash_10_VER_53f05855224d069625ee58c490ed1fb3',
                  'hash_10_VER_4ac5653988f3493af2e4fa9550546a86',
                  'hash_10_VER_43ca42b3dcd41d7cf16e2ef109931a0c'
               ],
            },
         ],
      },
      {  name       => 'Disk Read/Write Time (ms)',
         base_value => '1000',
         hash       => 'hash_00_VER_81b3d762b30209f194ea927ed53ccd7b',
         override   => { title => 1 },
         dt         => {
            hash       => 'hash_01_VER_09a56a72a1de71f43e2974190c43c28f',
            input      => 'Get Disk Stats',
            DISK_time_spent_reading       => {
               data_source_type_id => '3',
               hash => 'hash_08_VER_e5e740da0d9a119c9e12b503f82aa73f',
            },
            DISK_time_spent_writing       => {
               data_source_type_id => '3',
               hash => 'hash_08_VER_4d637254e94e9f70606d324e90164486',
            },
         },
         items => [
            # Colors from
            # http://www.colourlovers.com/palette/694737/Thought_Provoking
            {  item   => 'DISK_time_spent_reading',
               color  => '755E5E',
               task   => 'hash_09_VER_ca5c56c8d7b3188012fafc29e09eabd7',
               type   => 'AREA',
               hashes => [
                  'hash_10_VER_0481ae7431a4ed9de69dec8d840fe865',
                  'hash_10_VER_08362e34a4e87bcdd6098c1180cbbaa6',
                  'hash_10_VER_50b7d9a1e6f069eb0132587c8038fe25',
                  'hash_10_VER_05c7a1ebaf85b43ce521e784f5ce41bc'
               ],
            },
            {  item   => 'DISK_time_spent_writing',
               color  => 'C02942',
               task   => 'hash_09_VER_89d13a35dd51073e0bc4206b1dd8c29a',
               type   => 'AREA',
               cdef   => 'Negate',
               hashes => [
                  'hash_10_VER_0e183e1ab70abf4eb2ed1249a5ce918b',
                  'hash_10_VER_b5c18ffc743490c159b68deaf957c251',
                  'hash_10_VER_bd1bae0d78002efeef676530cbfc6f8e',
                  'hash_10_VER_570c3dcd3c0782372031de748751b6db'
               ],
            },
         ],
      },
      {  name       => 'Disk Elapsed IO Time (ms)',
         base_value => '1000',
         hash       => 'hash_00_VER_3f8d2cdca4117539c0aa5046019335e0',
         override   => { title => 1 },
         dt         => {
            hash       => 'hash_01_VER_55e420939c886691b4b851f71805c048',
            input      => 'Get Disk Stats',
            DISK_io_time          => {
               data_source_type_id => '3',
               hash => 'hash_08_VER_179149f87390bdd5a70a1a5f7ff073a9',
            },
            DISK_io_time_weighted => {
               data_source_type_id => '3',
               hash => 'hash_08_VER_cabbd5b55ccefa0daccd43c8f24fb14b',
            },
         },
         items => [
            # Colors from
            # http://www.colourlovers.com/palette/194715/Crueberry_Shake
            {  item   => 'DISK_io_time',
               color  => '4E3F30',
               task   => 'hash_09_VER_ffe96530ddb9204dd1818b957292cfcf',
               type   => 'LINE1',
               hashes => [
                  'hash_10_VER_7498182ddb44f7f0b5d51c798b05d5de',
                  'hash_10_VER_d3b457875ff91bcbc1bb478a855193db',
                  'hash_10_VER_769307477beee977791b79b4c47f30b1',
                  'hash_10_VER_e0af8cc8499ad7f4057c5865c85af482'
               ],
            },
            {  item   => 'DISK_io_time_weighted',
               color  => '2C5043',
               task   => 'hash_09_VER_ce630ea4757485bc08fb8f5df59ab5e7',
               type   => 'LINE1',
               hashes => [
                  'hash_10_VER_e6ec4f6cc1d6ebc215b7889e282076fa',
                  'hash_10_VER_78dcbdd3aa89a5414bdc6ce4f89fa2bc',
                  'hash_10_VER_9bdb75198240df09dc3686f9e452c2d5',
                  'hash_10_VER_dfbe2db442e6cd07d8297dfa5c7cd3da'
               ],
            },
         ],
      },
   ],
   inputs => {
      'Get W' => {
         type_id      => 1,
         hash         => 'hash_03_VER_fa2de72657e3da275805db2572271392',
         input_string => '<path_php_binary> -q <path_cacti>/scripts/ss_get_by_ssh.php '
                       . '--host <hostname> --type w --items <items>',
         inputs => [
            {  allow_nulls => '',
               hash        => 'hash_07_VER_29fdf20a8b44e7391d852a29747235ba',
               name        => 'hostname'
            },
         ],
         outputs => {
            STAT_loadavg          => 'hash_07_VER_114521354ca46482eaed91495ec69870',
            STAT_numusers         => 'hash_07_VER_1bcb533e7385434351f3e64b982266a8',
         },
      },
      'Get Proc Stats' => {
         type_id      => 1,
         hash         => 'hash_03_VER_b8d0468c0737dcd0863f2a181484f878',
         input_string => '<path_php_binary> -q <path_cacti>/scripts/ss_get_by_ssh.php '
                       . '--host <hostname> --type proc_stat --items <items>',
         inputs => [
            {  allow_nulls => '',
               hash        => 'hash_07_VER_509a24f84c924e9252be9a82c6674a6f',
               name        => 'hostname'
            },
         ],
         outputs => {
            STAT_interrupts       => 'hash_07_VER_cf50d22f8b5814fbb9e42d1b46612679',
            STAT_context_switches => 'hash_07_VER_49aa057a3935a96fb25fb511b16a75fa',
            STAT_forks            => 'hash_07_VER_d5e03c6e39717cc6a58e85e5f25608c6',
            STAT_CPU_user         => 'hash_07_VER_edfd4ac62e1e43ec35b3f5dc10ae2510',
            STAT_CPU_nice         => 'hash_07_VER_474ae20e35b85ca08645c018bd4c29c4',
            STAT_CPU_system       => 'hash_07_VER_89c1f51e8cbf6df135e4446e9c656e9b',
            STAT_CPU_idle         => 'hash_07_VER_f8ad00b68144973373281261a5100656',
            STAT_CPU_iowait       => 'hash_07_VER_e2d5a3ef480bb8ed8546fe48c3496717',
            STAT_CPU_irq          => 'hash_07_VER_a8ff7438a031f05bd223e5a016d443b2',
            STAT_CPU_softirq      => 'hash_07_VER_b7055f7e8e745ab6c0c7bbd85f7aff03',
            STAT_CPU_steal        => 'hash_07_VER_5686b4b2d255e674f46932ae60da92af',
            STAT_CPU_guest        => 'hash_07_VER_367fbfbb15a0bbd73fae5366d02e0c9b',
         },
      },
      'Get Disk Stats' => {
         type_id      => 1,
         hash         => 'hash_03_VER_da6fa9ee8283a483d4dea777fd69c629',
         input_string => '<path_php_binary> -q <path_cacti>/scripts/ss_get_by_ssh.php '
                       . '--host <hostname> --type diskstats --items <items> '
                       . '--device <device>',
         prompt_title => 1,
         inputs => [
            {  allow_nulls => '',
               hash        => 'hash_07_VER_280cd9c759c52b2477b972334210f920',
               name        => 'hostname'
            },
            {  allow_nulls => '',
               hash        => 'hash_07_VER_e89872554729dcd0695528adec190dd2',
               name        => 'device',
               override    => 1,
            },
         ],
         outputs => {
            DISK_reads              => 'hash_07_VER_00e4dd20a4e29c673a4471b2ee173ac9',
            DISK_reads_merged       => 'hash_07_VER_8af205c19a7439e83cee53059096b8e3',
            DISK_sectors_read       => 'hash_07_VER_9c5a554f4d62343e5aaaf9f0d784ada0',
            DISK_time_spent_reading => 'hash_07_VER_e8fd959febe8cdd5b20b8282ba340f19',
            DISK_writes             => 'hash_07_VER_1384e83ff216c0377a5f213f9a88c6fa',
            DISK_writes_merged      => 'hash_07_VER_c9cb7f45fa6ad943c377efb3ba2e661d',
            DISK_sectors_written    => 'hash_07_VER_43f100a2f54d5b18c3cdc5e8b8a02293',
            DISK_time_spent_writing => 'hash_07_VER_e1886d79cfa3c526c899de03db6e07ee',
            DISK_io_time            => 'hash_07_VER_cad0f7e9d765ba4e9341de72c0366575',
            DISK_io_time_weighted   => 'hash_07_VER_d7ebd195f6d9048b8e1e84114e8a0b6d',
         },
      },
      'Get Memory' => {
         type_id      => 1,
         hash         => 'hash_03_VER_0e7b35f01128b55711233c892f76dd5a',
         input_string => '<path_php_binary> -q <path_cacti>/scripts/ss_get_by_ssh.php '
                       . '--host <hostname> --type memory --items <items>',
         inputs => [
            {  allow_nulls => '',
               hash        => 'hash_07_VER_b777870d5cf5202137a8a02faf0b8ff9',
               name        => 'hostname'
            },
         ],
         outputs => {
            STAT_memused   => 'hash_07_VER_9ee0645b563ef81d53c2ec761e76de83',
            STAT_memcached => 'hash_07_VER_dae47ac818a580fb2a63576dff746736',
            STAT_membuffer => 'hash_07_VER_4941a2e704df750ed26816635e2b60e0',
            STAT_memshared => 'hash_07_VER_fac0993a72e5873c61ad51c864e23a3f',
            STAT_memfree   => 'hash_07_VER_23347c2c0ca8abf1b054324106a4b5b6',
            STAT_memtotal  => 'hash_07_VER_a2ae90873473fc4b43f23734219f3620',
         },
      },
   },
};
