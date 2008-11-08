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

{
   name   => 'Memcached Server',
   hash   => 'hash_02_VER_f74237cf7fb53fc002b0215117856be3',
   graphs => [
      {  name       => 'Memcached Rusage',
         base_value => '1000',
         hash       => 'hash_00_VER_7dd582146162f1d9c61bc52bec83d2f8',
         dt         => {
            hash       => 'hash_01_VER_b126c9d16618d1cd99dc2d4eb27703c3',
            input      => 'Get Memcached Stats',
            MEMC_rusage_user => {
               data_source_type_id => '1',
               hash => 'hash_08_VER_9ab18f7a0cdc99e5a704af15dd0908cc'
            },
            MEMC_rusage_system => {
               data_source_type_id => '1',
               hash => 'hash_08_VER_9ab18f7a0cdc99e5a704af15dd0908cc'
            },
         },
         items => [
            {  item   => 'MEMC_rusage_user',
               color  => '91204D',
               task   => 'hash_09_VER_320385532fb7c191c962fdb9a1414479',
               type   => 'AREA',
               hashes => [
                  'hash_10_VER_c98bdbb53284805a8938d434041b9781',
                  'hash_10_VER_eb7b204a8beeae2f41193d4eecdbc54c',
                  'hash_10_VER_58d5ab7cbd19f1650bb08815a2d752ae',
                  'hash_10_VER_268eea107e7cb8c3b936a21bb0ce9236'
               ],
            },
            {  item   => 'MEMC_rusage_system',
               color  => 'E4844A',
               task   => 'hash_09_VER_320385532fb7c191c962fdb9a1414479',
               type   => 'STACK',
               hashes => [
                  'hash_10_VER_c98bdbb53284805a8938d434041b9781',
                  'hash_10_VER_eb7b204a8beeae2f41193d4eecdbc54c',
                  'hash_10_VER_58d5ab7cbd19f1650bb08815a2d752ae',
                  'hash_10_VER_268eea107e7cb8c3b936a21bb0ce9236'
               ],
            },
         ],
      },
      {  name       => 'Memcached Current Items',
         base_value => '1000',
         hash       => 'hash_00_VER_35fc5db4eda3fcb831ee4e66f2d758ed',
         dt         => {
            hash       => 'hash_01_VER_fcd7e3d3cfb9ff2086af3573da16c4bb',
            input      => 'Get Memcached Stats',
            MEMC_curr_items => {
               data_source_type_id => '1',
               hash => 'hash_08_VER_4f32e43daef6ae3e1423c80578c06ce1'
            },
         },
         items => [
            {  item   => 'MEMC_curr_items',
               color  => '452632',
               task   => 'hash_09_VER_f21ce020e6fab43d47cecf785340ab30',
               type   => 'LINE1',
               hashes => [
                  'hash_10_VER_94e067cb1e0cff9995cbdeec92a42932',
                  'hash_10_VER_1a5ccbed57de33186c1a003dd0a0f28e',
                  'hash_10_VER_37f077e6b4a61aea6ff0cc5dc6ec7db7',
                  'hash_10_VER_cc030ec16b2a03aebfee1d83a765d645'
               ],
            },
         ],
      },
      {  name       => 'Memcached Additions and Evictions',
         base_value => '1000',
         hash       => 'hash_00_VER_19dbe918854a4e549e48b172ad8b51b2',
         dt         => {
            hash       => 'hash_01_VER_a6ae963635e330621d67f3c1d680efb0',
            input      => 'Get Memcached Stats',
            MEMC_total_items => {
               data_source_type_id => '2',
               hash => 'hash_08_VER_4192deafb5ae488a21ae6cf33999fe82'
            },
            MEMC_evictions => {
               data_source_type_id => '2',
               hash => 'hash_08_VER_4192deafb5ae488a21ae6cf33999fe82'
            },
         },
         items => [
            {  item   => 'MEMC_total_items',
               color  => '324D88',
               task   => 'hash_09_VER_a20147e0e31048d256b063831641b2dc',
               type   => 'AREA',
               hashes => [
                  'hash_10_VER_d91eca467ac3b023964efb712d0d823a',
                  'hash_10_VER_2f6a43e23d7160e0a5b549e43fe0a4e9',
                  'hash_10_VER_dcd286268735b635bcab92c37704f759',
                  'hash_10_VER_42fd6384bc247e64271f8a6b3baee61c'
               ],
            },
            {  item   => 'MEMC_evictions',
               color  => 'A03333',
               task   => 'hash_09_VER_a5ab7839ad06a8b08c10e2eac17f2d46',
               type   => 'AREA',
               hashes => [
                  'hash_10_VER_ad3dbea90e53675c6a715fa70d80b425',
               ],
            },
         ],
      },
      {  name       => 'Memcached Current Items',
         base_value => '1000',
         hash       => 'hash_00_VER_9b65e677a20f742582b9985a208550b6',
         dt         => {
            hash       => 'hash_01_VER_6e1cc2e3365f385cf934e32b8a204138',
            input      => 'Get Memcached Stats',
            MEMC_curr_items => {
               data_source_type_id => '1',
               hash => 'hash_08_VER_6aa30e77d556e4f27b78e86d75d240ce'
            },
         },
         items => [
            {  item   => 'MEMC_curr_items',
               color  => 'EEB78E',
               task   => 'hash_09_VER_c607a8fc1798542b45d9db03821f5416',
               type   => 'LINE1',
               hashes => [
                  'hash_10_VER_79922e1752125c15992283338f02e41c',
                  'hash_10_VER_dc6d82130210fea4e442f4d449005bf0',
                  'hash_10_VER_999a3c9ca0b6052df9f684eb86349833',
                  'hash_10_VER_7af8dc449c88a166aae40048350281ff'
               ],
            },
         ],
      },
      {  name       => 'Memcached Memory',
         base_value => '1024',
         hash       => 'hash_00_VER_6a66771502a2ef127619d17a6510eaf3',
         dt         => {
            hash       => 'hash_01_VER_5dc334b912c46ab4c6d9af8ba8a62b18',
            input      => 'Get Memcached Stats',
            MEMC_bytes => {
               data_source_type_id => '1',
               hash => 'hash_08_VER_37696315ea6d63f72ff4369f8ce9d28f'
            },
         },
         items => [
            {  item   => 'MEMC_bytes',
               color  => '6E645A',
               task   => 'hash_09_VER_1555fa38c0124d776cc8e4810db0f3ec',
               type   => 'AREA',
               hashes => [
                  'hash_10_VER_5bc2da8fc57817b82413247f0c029607',
                  'hash_10_VER_4e9f134418a7f4e2b36e033d063ee585',
                  'hash_10_VER_1aa91553763234161676d15c6c9c0760',
                  'hash_10_VER_b189156869d85a4ebe01f805d5ea5b37'
               ],
            },
         ],
      },
      {  name       => 'Memcached Connections',
         base_value => '1000',
         hash       => 'hash_00_VER_6a66771502a2ef127619d17a6510eaf3',
         dt         => {
            hash       => 'hash_01_VER_5dc334b912c46ab4c6d9af8ba8a62b18',
            input      => 'Get Memcached Stats',
            MEMC_curr_connections => {
               data_source_type_id => '1',
               hash => 'hash_08_VER_37696315ea6d63f72ff4369f8ce9d28f'
            },
            MEMC_total_connections => {
               data_source_type_id => '2',
               hash => 'hash_08_VER_37696315ea6d63f72ff4369f8ce9d28f'
            },
         },
         items => [
            {  item   => 'MEMC_curr_connections',
               color  => '6E645A',
               task   => 'hash_09_VER_1555fa38c0124d776cc8e4810db0f3ec',
               type   => 'LINE1',
               hashes => [
                  'hash_10_VER_5bc2da8fc57817b82413247f0c029607',
                  'hash_10_VER_4e9f134418a7f4e2b36e033d063ee585',
                  'hash_10_VER_1aa91553763234161676d15c6c9c0760',
                  'hash_10_VER_b189156869d85a4ebe01f805d5ea5b37'
               ],
            },
            {  item   => 'MEMC_total_connections',
               color  => '6E645A',
               task   => 'hash_09_VER_1555fa38c0124d776cc8e4810db0f3ec',
               type   => 'LINE1',
               hashes => [
                  'hash_10_VER_5bc2da8fc57817b82413247f0c029607',
                  'hash_10_VER_4e9f134418a7f4e2b36e033d063ee585',
                  'hash_10_VER_1aa91553763234161676d15c6c9c0760',
                  'hash_10_VER_b189156869d85a4ebe01f805d5ea5b37'
               ],
            },
         ],
      },
      {  name       => 'Memcached Requests',
         base_value => '1000',
         hash       => 'hash_00_VER_6a66771502a2ef127619d17a6510eaf3',
         dt         => {
            hash       => 'hash_01_VER_5dc334b912c46ab4c6d9af8ba8a62b18',
            input      => 'Get Memcached Stats',
            MEMC_cmd_get => {
               data_source_type_id => '2',
               hash => 'hash_08_VER_37696315ea6d63f72ff4369f8ce9d28f'
            },
            MEMC_cmd_set => {
               data_source_type_id => '2',
               hash => 'hash_08_VER_37696315ea6d63f72ff4369f8ce9d28f'
            },
            MEMC_get_misses => {
               data_source_type_id => '2',
               hash => 'hash_08_VER_37696315ea6d63f72ff4369f8ce9d28f'
            },
         },
         items => [
            {  item   => 'MEMC_cmd_get',
               color  => '6E645A',
               task   => 'hash_09_VER_1555fa38c0124d776cc8e4810db0f3ec',
               type   => 'AREA',
               hashes => [
                  'hash_10_VER_5bc2da8fc57817b82413247f0c029607',
                  'hash_10_VER_4e9f134418a7f4e2b36e033d063ee585',
                  'hash_10_VER_1aa91553763234161676d15c6c9c0760',
                  'hash_10_VER_b189156869d85a4ebe01f805d5ea5b37'
               ],
            },
            {  item   => 'MEMC_cmd_set',
               color  => '6E645A',
               task   => 'hash_09_VER_1555fa38c0124d776cc8e4810db0f3ec',
               type   => 'STACK',
               hashes => [
                  'hash_10_VER_5bc2da8fc57817b82413247f0c029607',
                  'hash_10_VER_4e9f134418a7f4e2b36e033d063ee585',
                  'hash_10_VER_1aa91553763234161676d15c6c9c0760',
                  'hash_10_VER_b189156869d85a4ebe01f805d5ea5b37'
               ],
            },
            {  item   => 'MEMC_get_misses',
               color  => '6E645A',
               task   => 'hash_09_VER_1555fa38c0124d776cc8e4810db0f3ec',
               type   => 'AREA',
               hashes => [
                  'hash_10_VER_5bc2da8fc57817b82413247f0c029607',
                  'hash_10_VER_4e9f134418a7f4e2b36e033d063ee585',
                  'hash_10_VER_1aa91553763234161676d15c6c9c0760',
                  'hash_10_VER_b189156869d85a4ebe01f805d5ea5b37'
               ],
            },
         ],
      },
      {  name       => 'Memcached Traffic',
         base_value => '1024',
         hash       => 'hash_00_VER_6a66771502a2ef127619d17a6510eaf3',
         dt         => {
            hash       => 'hash_01_VER_5dc334b912c46ab4c6d9af8ba8a62b18',
            input      => 'Get Memcached Stats',
            MEMC_bytes_read => {
               data_source_type_id => '2',
               hash => 'hash_08_VER_37696315ea6d63f72ff4369f8ce9d28f'
            },
            MEMC_bytes_written => {
               data_source_type_id => '2',
               hash => 'hash_08_VER_37696315ea6d63f72ff4369f8ce9d28f'
            },
         },
         items => [
            {  item   => 'MEMC_bytes_read',
               color  => '6E645A',
               task   => 'hash_09_VER_1555fa38c0124d776cc8e4810db0f3ec',
               type   => 'AREA',
               hashes => [
                  'hash_10_VER_5bc2da8fc57817b82413247f0c029607',
                  'hash_10_VER_4e9f134418a7f4e2b36e033d063ee585',
                  'hash_10_VER_1aa91553763234161676d15c6c9c0760',
                  'hash_10_VER_b189156869d85a4ebe01f805d5ea5b37'
               ],
            },
            {  item   => 'MEMC_bytes_written',
               color  => '6E645A',
               task   => 'hash_09_VER_1555fa38c0124d776cc8e4810db0f3ec',
               type   => 'AREA',
               hashes => [
                  'hash_10_VER_5bc2da8fc57817b82413247f0c029607',
                  'hash_10_VER_4e9f134418a7f4e2b36e033d063ee585',
                  'hash_10_VER_1aa91553763234161676d15c6c9c0760',
                  'hash_10_VER_b189156869d85a4ebe01f805d5ea5b37'
               ],
            },
         ],
      },
   ],
   inputs => {
      'Get Memcached Stats' => {
         type_id      => 1,
         hash         => 'hash_03_VER_6d2a648161b8c79a67821046280dde43',
         input_string => '<path_php_binary> -q <path_cacti>/scripts/ss_get_by_ssh.php '
                       . '--host <hostname> --type apache --items <items>',
         inputs => [
            {  allow_nulls => '',
               hash        => 'hash_07_VER_9ede3b32324e1978bc938bbbcf99c7da',
               name        => 'hostname'
            },
         ],
         outputs => {
            Requests               => 'hash_07_VER_cff73d78a6870918b25fec9af9ba55d3',
            Bytes_sent             => 'hash_07_VER_9430882fbafec2abb63390553b47f6d8',
            CPU_Load               => 'hash_07_VER_254558f5aa21ff73ebe348612cca429e',
            Idle_workers           => 'hash_07_VER_8f45bda7f92b305ce53485bf349c74a2',
            Busy_workers           => 'hash_07_VER_37cae992ca15d54db89e5fbb4d55b5e3',
            Waiting_for_connection => 'hash_07_VER_b3882f9fad342ef4437389afe5a48255',
            Starting_up            => 'hash_07_VER_bca2a7f9e02eb1e0119b9901620213e0',
            Reading_request        => 'hash_07_VER_f55a3ab774898f05be545865ab08dc3d',
            Sending_reply          => 'hash_07_VER_ae55e6043b1e658090c3992b429ab772',
            Keepalive              => 'hash_07_VER_95432bea896bfe38ae8b02bfda3345ae',
            DNS_lookup             => 'hash_07_VER_d7708a0ebcdbd2c2d50e795c785607e4',
            Closing_connection     => 'hash_07_VER_65d90ec19f533d6dfd59b7e59a59a961',
            Logging                => 'hash_07_VER_1c9ae3f9d3f450274caf42acda243314',
            Gracefully_finishing   => 'hash_07_VER_e9ea07ba78ae485021e48f3d09d2fe51',
            Idle_cleanup           => 'hash_07_VER_cd3456d0c13abf6bd90ca951466508d6',
            Open_slot              => 'hash_07_VER_11e86aca3dd09262052d32571502349f',
         },
      },
   },
};
