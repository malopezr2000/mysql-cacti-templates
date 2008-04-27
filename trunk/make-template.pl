#!/usr/bin/perl

# This is a script that generates Cacti templates from a Perl data structure.
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

use strict;
use warnings FATAL => 'all';
use English qw(-no_match_vars);

# TODO: command-line options
# 64-bit max counter sizes for wrap detection
# Graph size
# polling interval
# Name prefix -- default P
# Number of samples to keep in the RRD files.

my $name_prefix   = 'X';
my $rrd_step      = 300;
my $rrd_heartbeat = 600;
my $rrd_maximum   = '18446744073709551615',
# TODO: 4294967295
# TODO: add cdefs

# #############################################################################
# Read the file given on the command line into a string and then into a
# variable.
# #############################################################################
my ($filename) = shift @ARGV;
open my $fh, '<', $filename or die "Can't open $filename: $OS_ERROR";
my $code = do { local $INPUT_RECORD_SEPARATOR = undef; <$fh>; };
close $fh;

# This should be a hashref now.
my $t = eval($code);
if ( $EVAL_ERROR ) {
   die $EVAL_ERROR;
}

# #############################################################################
# Global variables.
# #############################################################################
my $indent = 0;
my @stack  = ();
my $hashno = 0;

my %graph_types = (
   COMMENT => 1,
   HRULE => 2,
   VRULE => 3,
   LINE1 => 4,
   LINE2 => 5,
   LINE3 => 6,
   AREA  => 7,
   STACK => 8,
   GPRINT => 9,
   LEGEND => 10,
);

my @graph_texts = qw(UNUSED Cur: Avg: Max:);
my @consolidations = qw(1 4 1 3);

# The properties of a graph.
my @graph_props = qw( title image_format_id height width auto_scale
   auto_scale_opts auto_scale_log auto_scale_rigid auto_padding export
   upper_limit lower_limit base_value unit_value unit_exponent_value
   vertical_label);
my %graph_props = (
   image_format_id => 1,
   height          => 120,
   width           => 500,
   auto_scale      => 'on',
   auto_scale_opts => 2,
   auto_padding    => 'on',
   export          => 'on',
   base_value      => 1000,
);

# The properties of a data source item.
my @ds_props = qw(
   data_source_name rrd_minimum rrd_maximum data_source_type_id rrd_heartbeat
   data_input_field_id);
my %ds_props = (
   rrd_minimum         => 0,
   rrd_maximum         => $rrd_maximum,
   data_source_type_id => 2,
   rrd_heartbeat       => $rrd_heartbeat,
);

# The properties of a graph item (a line, area, gprint, etc)
my @gitem_props = qw(task_item_id color_id graph_type_id
   consolidation_function_id cdef_id value gprint_id text_format hard_return
   sequence);

# Magically named fields for input scripts
my $is_magic = qr{
   hostname
   |snmp_community
   |snmp_username
   |snmp_password
   |snmp_port
   |snmp_timeout
   |snmp_version}x;
# #############################################################################
# Subroutines.
# #############################################################################
sub es { # Element start
   my ( $name ) = @_;
   print(("\t" x $indent++), "<$name>\n");
   push @stack, $name;
}

sub ee { # Element end
   my ( $sanity ) = @_;
   my ( $name ) = pop @stack;
   if ( ($sanity || $name) ne $name ) {
      die "You tried to end the '$sanity' element but stack has '$name'";
   }
   print(("\t" x --$indent), "</$name>\n");
}

sub el { # Element plus contents
   my ( $name, $content ) = @_;
   die "Uninitialized content for '$name'" unless defined $content;
   print(("\t" x $indent), "<$name>", enc($content), "</$name>\n");
}

sub enc { # Entity encoding.
   my ( $val ) = @_;
   $val =~ s/&/&amp;/g;
   $val =~ s/>/&gt;/g;
   $val =~ s/</&lt;/g;
   $val =~ s/"/&quot;/g;
   return $val;
}

# Turn A_string_of_words into A String Of Words.
sub to_words {
   my ( $text ) = @_;
   return join(' ', map { ucfirst } split(/_/, $text));
}

# Removes vowels and compacts repeated letters to shorten text.  In this case,
# to 19 characters, which is RRDTool's internal limit.  This lets the data
# source (script) output long variable names, which can then be used as nice
# descriptive labels, while translating them into crunched text when needed for
# an RRA.
sub crunch {
   my ( $text ) = @_;
   my $len = 19;
   return $text if $len && length($text) <= $len;
   $text = reverse $text; # work from the end backwards
   1 while ( length($text) > $len && $text =~ s/(?<![_ ])[aeiou]// );
   1 while ( length($text) > $len && $text =~ s/(.)\1+/$1/ );
   $text = reverse $text;
   die "Can't shorten $text enough" if length($text) > $len;
   return $text;
}

# Do the work.
# #############################################################################

# Check that nothing is unused, and that everything used exists.
my @key_not_in_dt;
my @key_not_in_script;
my @key_not_used_in_graph;
foreach my $g ( @{ $t->{graphs} } ) {
   my %key_used_in_it;
   foreach my $it ( @{ $g->{items} } ) {
      my $item = $it->{item};
      $key_used_in_it{$item}++;
      if ( !$g->{dt}->{$item} ) {
         push @key_not_in_dt, $item;
      }
   }
   foreach my $key ( keys %{$g->{dt}} ) {
      my $val = $g->{dt}->{$key};
      next unless ref $val eq 'HASH';
      if ( !$t->{inputs}->{$g->{dt}->{input}}->{outputs}->{$key} ) {
         push @key_not_in_script, $key;
      }
      if ( !$key_used_in_it{$key} ) {
         push @key_not_used_in_graph, $key;
      }
   }
}
if ( @key_not_used_in_graph || @key_not_in_dt || @key_not_in_script ) {
   print "Keys in GT not in DT: " . join(',', @key_not_in_dt), "\n";
   print "Keys in DT not in DS: " . join(',', @key_not_in_script), "\n";
   print "Keys in DT not in GT: " . join(',', @key_not_used_in_graph), "\n";
   exit;
}
=pod
foreach my $h ( values %{$t->{inputs}} ) {
   foreach my $key ( keys %{$h->{outputs}} ) {
      if ( !$key_used_in_dt{$key} ) {
         push @key_not_used_in_script, $key;
      }
   }
}
=cut


es('cacti');

# Print the beginning of the host template
es($t->{hash});
el('name', "$name_prefix $t->{name} HT");
el('graph_templates',
   join('|', map { $_->{hash} } @{$t->{graphs}} ));
el('data_queries', '');
ee($t->{hash});

# Graph templates
foreach my $g ( @{ $t->{graphs} } ) {
   # Set the graph's title
   $g->{title} = "|host_description| - $g->{name}";

   # Print the graph template and the graph items
   es($g->{hash});
   el('name', "$name_prefix $g->{name} GT");
   es('graph');
   foreach my $p ( @graph_props ) {
      el("t_$p", ''); # No idea what this is for, it's always empty.
      el($p, $g->{$p} || $graph_props{$p} || '');
   }
   ee('graph');

   # Now add the items (lines, gprints...) to the graph
   es('items');
   my $seq = 0;
   foreach my $it ( @{ $g->{items} } ) {
      my $i = 0;
      my $color = $it->{color} || 0;
      my $hash_count = scalar(@{ $it->{hashes} });

      # Each bit of data can have several items.
      foreach my $h ( @{ $it->{hashes} } ) {
         my $type = $i ? 'GPRINT' : ($it->{type} || 'LINE1');
         my $text = $i ? $graph_texts[$i] : to_words($it->{item});
         es($h);
         el('task_item_id', $g->{dt}->{$it->{item}}->{hash});
         el('color_id', $i ? 0 : $color);
         el('graph_type_id', $graph_types{$type});
         el('consolidation_function_id', $consolidations[$i]);
         el('cdef_id', 0);
         el('value', '');
         el('gprint_id',
            $t->{gprints}->{ $it->{gprint_id} || 'Normal' }->{hash});
         el('text_format', $text);
         el('hard_return', ($i == $hash_count - 1) ? 'on' : '');
         el('sequence', ++$seq);
         ee($h);
         $i++;
      }
   }
   ee('items');

   # Now add the inputs.
   es('inputs');
   foreach my $it ( @{ $g->{items} } ) {
      es($it->{task});
      el('name', "Data Source [" . crunch($it->{item}) . "]");
      el('description', '');
      el('column_name', 'task_item_id');
      # NOTE: The refererred-to items are not referred to correctly in my
      # version of Cacti.  To make the items import exactly as they're exported,
      # I need to zero out the type part of the hash.
      el('items', join('|', map {s/hash_1/hash_0/; $_} @{ $it->{hashes} }));
      ee($it->{task});
   }
   ee('inputs');

   ee($g->{hash});
}

# Data templates
foreach my $g ( @{ $t->{graphs} } ) {
   my $d = $g->{dt};
   es($d->{hash});
   my $i = $t->{inputs}->{$d->{input}};

   # The <ds> data source element.
   el('name', "$name_prefix $g->{name} DT");
   es('ds');
   el('t_name', '');
   el('name', "|host_description| - $g->{name}");
   el('data_input_id', $t->{inputs}->{$d->{input}}->{hash} );
   el('t_rra_id', '');
   el('t_rrd_step', '');
   el('rrd_step', $rrd_step);
   el('t_active', '');
   el('active', 'on');
   el('rra_items', join('|', map { $_->{hash} } @{ $t->{rras} }) );
   ee('ds');

   # The items that go into the RRA.
   es('items');
   foreach my $k ( keys %$d ) {
      my $v = $d->{$k};
      next unless ref $v eq 'HASH';
      $v->{data_source_name} = crunch($k);
      $v->{data_input_field_id} = $i->{outputs}->{$k};
      es($v->{hash});
      foreach my $prop ( @ds_props ) {
         el("t_$prop", '');
         el($prop, $v->{$prop} || $ds_props{$prop});
      }
      ee($v->{hash});
   }
   ee('items');

   # The inputs to the script that fills the RRA.
   es('data');
   my $cnt = 0;
   foreach my $input ( @{ $i->{inputs} } ) {
      es(sprintf('item_%03d', $cnt));
      el('data_input_field_id', $input->{hash});
      el('t_value', '');
      el('value', '');
      ee(sprintf('item_%03d', $cnt));
      $cnt++;
   }
   ee('data');

   ee($d->{hash});
}

# Input script definitions
foreach my $k ( keys %{$t->{inputs}} ) {
   my $v = $t->{inputs}->{$k};
   es($v->{hash});
   el('name', "$name_prefix $v->{name}");
   el('type_id', $v->{type_id});
   el('input_string', $v->{input_string});

   es('fields');

   # Input fields (arguments) to the script
   foreach my $i ( @{$v->{inputs}} ) {
      es($i->{hash});
      el('name', to_words($i->{name}));
      el('update_rra', '');
      el('regexp_match', '');
      el('allow_nulls', $i->{allow_nulls});
      el('type_code', ($i->{name} =~ m/$is_magic/ ? $i->{name} : ''));
      el('input_output', 'in');
      el('data_name', $i->{name});
      ee($i->{hash});
   }

   # Data returned by the script
   foreach my $k ( keys %{ $v->{outputs} } ) {
      es($v->{outputs}->{$k});
      el('name', to_words($k));
      el('update_rra', 'on');
      el('regexp_match', '');
      el('allow_nulls', '');
      el('type_code', '');
      el('input_output', 'out');
      el('data_name', $k);
      ee($v->{outputs}->{$k});
   }

   ee('fields');
   ee($v->{hash});
}

# GPRINT formats
foreach my $k ( keys %{ $t->{gprints} } ) {
   es($t->{gprints}->{$k}->{hash});
   el('name', "$name_prefix $k");
   el('gprint_text', $t->{gprints}->{$k}->{gprint_text});
   ee($t->{gprints}->{$k}->{hash});
}

# TODO: CDEF definitions.

# RRA (Round-Robin Archive) definitions
foreach my $r ( @{$t->{rras}} ) {
   es($r->{hash});
   el('name', "$name_prefix $r->{name} RRA");
   foreach my $thing ( qw(x_files_factor steps rows timespan cf_items) ) {
      el($thing, $r->{$thing});
   }
   ee($r->{hash});
}

ee('cacti');
