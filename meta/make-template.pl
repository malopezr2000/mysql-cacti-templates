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

our $VERSION = '@VERSION@';
our $DISTRIB = '@DISTRIB@';
our $SVN_REV = sprintf("%d", map { $_ || 0 } q$Revision$ =~ m/(\d*)/g);

# ###########################################################################
# OptionParser package 1844
# ###########################################################################
use strict;
use warnings FATAL => 'all';

package OptionParser;

use Getopt::Long;
use List::Util qw(max);
use English qw(-no_match_vars);

sub new {
   my ( $class, @opts ) = @_;
   my %key_seen;
   my %long_seen;
   my %key_for;
   my %defaults;
   my @mutex;
   my @atleast1;
   my %long_for;
   my %disables;
   my %copyfrom;
   unshift @opts,
      { s => 'help',    d => 'Show this help message' },
      { s => 'version', d => 'Output version information and exit' };
   foreach my $opt ( @opts ) {
      if ( ref $opt ) {
         my ( $long, $short ) = $opt->{s} =~ m/^([\w-]+)(?:\|([^!+=]*))?/;
         $opt->{k} = $short || $long;
         $key_for{$long} = $opt->{k};
         $long_for{$opt->{k}} = $long;
         $long_for{$long} = $long;
         $opt->{l} = $long;
         die "Duplicate option $opt->{k}" if $key_seen{$opt->{k}}++;
         die "Duplicate long option $opt->{l}" if $long_seen{$opt->{l}}++;
         $opt->{t} = $short;
         $opt->{n} = $opt->{s} =~ m/!/;
         $opt->{g} ||= 'o';
         if ( (my ($y) = $opt->{s} =~ m/=([mdHhAaz])/) ) {
            $ENV{MKDEBUG} && _d("Option $opt->{k} type: $y");
            $opt->{y} = $y;
            $opt->{s} =~ s/=./=s/;
         }
         if ( $opt->{d} =~ m/required/ ) {
            $opt->{r} = 1;
            $ENV{MKDEBUG} && _d("Option $opt->{k} is required");
         }
         if ( (my ($def) = $opt->{d} =~ m/default\b(?: ([^)]+))?/) ) {
            $defaults{$opt->{k}} = defined $def ? $def : 1;
            $ENV{MKDEBUG} && _d("Option $opt->{k} has a default");
         }
         if ( (my ($dis) = $opt->{d} =~ m/(disables .*)/) ) {
            $disables{$opt->{k}} = [ $class->get_participants($dis) ];
            $ENV{MKDEBUG} && _d("Option $opt->{k} $dis");
         }
      }
      else { # It's an instruction.

         if ( $opt =~ m/at least one|mutually exclusive|one and only one/ ) {
            my @participants = map {
                  die "No such option '$_' in $opt" unless $long_for{$_};
                  $long_for{$_};
               } $class->get_participants($opt);
            if ( $opt =~ m/mutually exclusive|one and only one/ ) {
               push @mutex, \@participants;
               $ENV{MKDEBUG} && _d(@participants, ' are mutually exclusive');
            }
            if ( $opt =~ m/at least one|one and only one/ ) {
               push @atleast1, \@participants;
               $ENV{MKDEBUG} && _d(@participants, ' require at least one');
            }
         }
         elsif ( $opt =~ m/default to/ ) {
            my @participants = map {
                  die "No such option '$_' in $opt" unless $long_for{$_};
                  $key_for{$_};
               } $class->get_participants($opt);
            $copyfrom{$participants[0]} = $participants[1];
            $ENV{MKDEBUG} && _d(@participants, ' copy from each other');
         }

      }
   }

   if ( $ENV{MKDEBUG} ) {
      my $text = do {
         local $RS = undef;
         open my $fh, "<", $PROGRAM_NAME
            or die "Can't open $PROGRAM_NAME: $OS_ERROR";
         <$fh>;
      };
      my %used = map { $_ => 1 } $text =~ m/\$opts\{'?([\w-]+)'?\}/g;
      my @unused;
      my @undefined;
      my %option_exists;
      foreach my $opt ( @opts ) {
         next unless ref $opt;
         my $key = $opt->{k};
         $option_exists{$key}++;
         next if $opt->{l} =~ m/^(?:help|version|defaults-file|database|charset
                                    |password|port|socket|user|host)$/x
              || $disables{$key};
         push @unused, $key unless $used{$key};
      }
      foreach my $key ( keys %used ) {
         push @undefined, $key unless $option_exists{$key};
      }
      if ( @unused || @undefined ) {
         die "The following command-line options are unused: "
            . join(',', @unused)
            . ' The following are undefined: '
            . join(',', @undefined);
      }
   }

   foreach my $dis ( keys %disables ) {
      $disables{$dis} = [ map {
            die "No such option '$_' while processing $dis" unless $long_for{$_};
            $long_for{$_};
         } @{$disables{$dis}} ];
   }

   return bless {
      specs => [ grep { ref $_ } @opts ],
      notes => [],
      instr => [ grep { !ref $_ } @opts ],
      mutex => \@mutex,
      defaults => \%defaults,
      long_for => \%long_for,
      atleast1 => \@atleast1,
      disables => \%disables,
      key_for  => \%key_for,
      copyfrom => \%copyfrom,
      strict   => 1,
      groups   => [ { k => 'o', d => 'Options' } ],
   }, $class;
}

sub get_participants {
   my ( $self, $str ) = @_;
   my @participants;
   foreach my $thing ( $str =~ m/(--?[\w-]+)/g ) {
      if ( (my ($long) = $thing =~ m/--(.+)/) ) {
         push @participants, $long;
      }
      else {
         foreach my $short ( $thing =~ m/([^-])/g ) {
            push @participants, $short;
         }
      }
   }
   $ENV{MKDEBUG} && _d("Participants for $str: ", @participants);
   return @participants;
}

sub parse {
   my ( $self, %defaults ) = @_;
   my @specs = @{$self->{specs}};
   my %factor_for = (k => 1_024, M => 1_048_576, G => 1_073_741_824);

   my %opt_seen;
   my %vals = %{$self->{defaults}};
   @vals{keys %defaults} = values %defaults;
   foreach my $spec ( @specs ) {
      $vals{$spec->{k}} = undef unless defined $vals{$spec->{k}};
      $opt_seen{$spec->{k}} = 1;
   }

   foreach my $key ( keys %defaults ) {
      die "Cannot set default for non-existent option '$key'\n"
         unless $opt_seen{$key};
   }

   Getopt::Long::Configure('no_ignore_case', 'bundling');
   GetOptions( map { $_->{s} => \$vals{$_->{k}} } @specs )
      or $self->error('Error parsing options');

   if ( $vals{version} ) {
      my $prog = $self->prog;
      printf("%s  Ver %s Distrib %s Changeset %s\n",
         $prog, $main::VERSION, $main::DISTRIB, $main::SVN_REV);
      exit(0);
   }

   if ( @ARGV && $self->{strict} ) {
      $self->error("Unrecognized command-line options @ARGV");
   }

   foreach my $dis ( grep { defined $vals{$_} } keys %{$self->{disables}} ) {
      my @disses = map { $self->{key_for}->{$_} } @{$self->{disables}->{$dis}};
      $ENV{MKDEBUG} && _d("Unsetting options: ", @disses);
      @vals{@disses} = map { undef } @disses;
   }

   foreach my $spec ( grep { $_->{r} } @specs ) {
      if ( !defined $vals{$spec->{k}} ) {
         $self->error("Required option --$spec->{l} must be specified");
      }
   }

   foreach my $mutex ( @{$self->{mutex}} ) {
      my @set = grep { defined $vals{$self->{key_for}->{$_}} } @$mutex;
      if ( @set > 1 ) {
         my $note = join(', ',
            map { "--$self->{long_for}->{$_}" }
                @{$mutex}[ 0 .. scalar(@$mutex) - 2] );
         $note .= " and --$self->{long_for}->{$mutex->[-1]}"
               . " are mutually exclusive.";
         $self->error($note);
      }
   }

   foreach my $required ( @{$self->{atleast1}} ) {
      my @set = grep { defined $vals{$self->{key_for}->{$_}} } @$required;
      if ( !@set ) {
         my $note = join(', ',
            map { "--$self->{long_for}->{$_}" }
                @{$required}[ 0 .. scalar(@$required) - 2] );
         $note .= " or --$self->{long_for}->{$required->[-1]}";
         $self->error("Specify at least one of $note");
      }
   }

   foreach my $spec ( grep { $_->{y} && defined $vals{$_->{k}} } @specs ) {
      my $val = $vals{$spec->{k}};
      if ( $spec->{y} eq 'm' ) {
         my ( $num, $suffix ) = $val =~ m/(\d+)([a-z])?$/;
         if ( !$suffix ) {
            my ( $s ) = $spec->{d} =~ m/\(suffix (.)\)/;
            $suffix = $s || 's';
            $ENV{MKDEBUG} && _d("No suffix given; using $suffix for $spec->{k} "
               . "(value: '$val')");
         }
         if ( $suffix =~ m/[smhd]/ ) {
            $val = $suffix eq 's' ? $num            # Seconds
                 : $suffix eq 'm' ? $num * 60       # Minutes
                 : $suffix eq 'h' ? $num * 3600     # Hours
                 :                  $num * 86400;   # Days
            $vals{$spec->{k}} = $val;
            $ENV{MKDEBUG} && _d("Setting option $spec->{k} to $val");
         }
         else {
            $self->error("Invalid --$spec->{l} argument");
         }
      }
      elsif ( $spec->{y} eq 'd' ) {
         $ENV{MKDEBUG} && _d("Parsing option $spec->{y} as a DSN");
         my $from_key = $self->{copyfrom}->{$spec->{k}};
         my $default = {};
         if ( $from_key ) {
            $ENV{MKDEBUG} && _d("Option $spec->{y} DSN copies from option $from_key");
            $default = $self->{dsn}->parse($self->{dsn}->as_string($vals{$from_key}));
         }
         $vals{$spec->{k}} = $self->{dsn}->parse($val, $default);
      }
      elsif ( $spec->{y} eq 'z' ) {
         my ($pre, $num, $factor) = $val =~ m/^([+-])?(\d+)([kMG])?$/;
         if ( defined $num ) {
            if ( $factor ) {
               $num *= $factor_for{$factor};
               $ENV{MKDEBUG} && _d("Setting option $spec->{y} to num * factor");
            }
            $vals{$spec->{k}} = ($pre || '') . $num;
         }
         else {
            $self->error("Invalid --$spec->{l} argument");
         }
      }
   }

   foreach my $spec ( grep { $_->{y} } @specs ) {
      $ENV{MKDEBUG} && _d("Treating option $spec->{k} as a list");
      my $val = $vals{$spec->{k}};
      if ( $spec->{y} eq 'H' || (defined $val && $spec->{y} eq 'h') ) {
         $vals{$spec->{k}} = { map { $_ => 1 } split(',', ($val || '')) };
      }
      elsif ( $spec->{y} eq 'A' || (defined $val && $spec->{y} eq 'a') ) {
         $vals{$spec->{k}} = [ split(',', ($val || '')) ];
      }
   }

   return %vals;
}

sub error {
   my ( $self, $note ) = @_;
   $self->{__error__} = 1;
   push @{$self->{notes}}, $note;
}

sub prog {
   (my $prog) = $PROGRAM_NAME =~ m/([.A-Za-z-]+)$/;
   return $prog || $PROGRAM_NAME;
}

sub prompt {
   my ( $self ) = @_;
   my $prog   = $self->prog;
   my $prompt = $self->{prompt} || '<options>';
   return "Usage: $prog $prompt\n";
}

sub descr {
   my ( $self ) = @_;
   my $prog = $self->prog;
   my $descr  = $prog . ' ' . ($self->{descr} || '')
          . "  For more details, please use the --help option, "
          . "or try 'perldoc $prog' for complete documentation.";
   $descr = join("\n", $descr =~ m/(.{0,80})(?:\s+|$)/g);
   $descr =~ s/ +$//mg;
   return $descr;
}

sub usage_or_errors {
   my ( $self, %opts ) = @_;
   if ( $opts{help} ) {
      print $self->usage(%opts);
      exit(0);
   }
   elsif ( $self->{__error__} ) {
      print $self->errors();
      exit(0);
   }
}

sub errors {
   my ( $self ) = @_;
   my $usage = $self->prompt() . "\n";
   if ( (my @notes = @{$self->{notes}}) ) {
      $usage .= join("\n  * ", 'Errors in command-line arguments:', @notes) . "\n";
   }
   return $usage . "\n" . $self->descr();
}

sub usage {
   my ( $self, %vals ) = @_;
   my @specs = @{$self->{specs}};

   my $maxl = max(map { length($_->{l}) + ($_->{n} ? 4 : 0)} @specs);

   my $maxs = max(0,
      map { length($_->{l}) + ($_->{n} ? 4 : 0)}
      grep { $_->{t} } @specs);

   my $lcol = max($maxl, ($maxs + 3));
   my $rcol = 80 - $lcol - 6;
   my $rpad = ' ' x ( 80 - $rcol );

   $maxs = max($lcol - 3, $maxs);

   my $usage = $self->descr() . "\n" . $self->prompt();
   foreach my $g ( @{$self->{groups}} ) {
      $usage .= "\n$g->{d}:\n";
      foreach my $spec (
         sort { $a->{l} cmp $b->{l} } grep { $_->{g} eq $g->{k} } @specs )
      {
         my $long  = $spec->{n} ? "[no]$spec->{l}" : $spec->{l};
         my $short = $spec->{t};
         my $desc  = $spec->{d};
         if ( $spec->{y} && $spec->{y} eq 'm' ) {
            my ($s) = $desc =~ m/\(suffix (.)\)/;
            $s    ||= 's';
            $desc =~ s/\s+\(suffix .\)//;
            $desc .= ".  Optional suffix s=seconds, m=minutes, h=hours, "
                   . "d=days; if no suffix, $s is used.";
         }
         $desc = join("\n$rpad", grep { $_ } $desc =~ m/(.{0,$rcol})(?:\s+|$)/g);
         $desc =~ s/ +$//mg;
         if ( $short ) {
            $usage .= sprintf("  --%-${maxs}s -%s  %s\n", $long, $short, $desc);
         }
         else {
            $usage .= sprintf("  --%-${lcol}s  %s\n", $long, $desc);
         }
      }
   }

   if ( (my @instr = @{$self->{instr}}) ) {
      $usage .= join("\n", map { "  $_" } @instr) . "\n";
   }
   if ( $self->{dsn} ) {
      $usage .= "\n" . $self->{dsn}->usage();
   }
   $usage .= "\nOptions and values after processing arguments:\n";
   foreach my $spec ( sort { $a->{l} cmp $b->{l} } @specs ) {
      my $val   = $vals{$spec->{k}};
      my $type  = $spec->{y} || '';
      my $bool  = $spec->{s} =~ m/^[\w-]+(?:\|[\w-])?!?$/;
      $val      = $bool                     ? ( $val ? 'TRUE' : 'FALSE' )
                : !defined $val             ? '(No value)'
                : $type eq 'd'              ? $self->{dsn}->as_string($val)
                : $type =~ m/H|h/           ? join(',', sort keys %$val)
                : $type =~ m/A|a/           ? join(',', @$val)
                :                             $val;
      $usage .= sprintf("  --%-${lcol}s  %s\n", $spec->{l}, $val);
   }
   return $usage;
}

sub prompt_noecho {
   shift @_ if ref $_[0] eq __PACKAGE__;
   my ( $prompt ) = @_;
   local $OUTPUT_AUTOFLUSH = 1;
   print $prompt;
   my $response;
   eval {
      require Term::ReadKey;
      Term::ReadKey::ReadMode('noecho');
      chomp($response = <STDIN>);
      Term::ReadKey::ReadMode('normal');
      print "\n";
   };
   if ( $EVAL_ERROR ) {
      die "Cannot read response; is Term::ReadKey installed? $EVAL_ERROR";
   }
   return $response;
}

sub groups {
   my ( $self, @groups ) = @_;
   push @{$self->{groups}}, @groups;
}

sub _d {
   my ( $line ) = (caller(0))[2];
   print "# OptionParser:$line $PID ", @_, "\n";
}

if ( $ENV{MKDEBUG} ) {
   print '# ', $^X, ' ', $], "\n";
   my $uname = `uname -a`;
   if ( $uname ) {
      $uname =~ s/\s+/ /g;
      print "# $uname\n";
   }
   printf("# %s  Ver %s Distrib %s Changeset %s line %d\n",
      $PROGRAM_NAME, ($main::VERSION || ''), ($main::DISTRIB || ''),
      ($main::SVN_REV || ''), __LINE__);
}

1;

# ###########################################################################
# End OptionParser package
# ###########################################################################

package main;

use English qw(-no_match_vars);
use List::Util qw(max);

my @opt_spec = (
   { s => 'cactiver=s',     d => 'Create templates for this Cacti version' },
   { s => 'graph_height=i', d => 'Height of generated graphs (default 120)' },
   { s => 'graph_width=i',  d => 'Width of generated graphs (default 500)' },
   { s => 'poll_interval=i',d => 'Polling interval (default 300)' },
   { s => 'name_prefix=s',  d => 'Template name prefix (default X)' },
   { s => 'smallint',       d => 'Create templates for 32-bit MySQL' },
);

my $opt_parser = OptionParser->new(@opt_spec);
$opt_parser->{prompt} = '<options> FILE';
$opt_parser->{strict} = 0;
$opt_parser->{descr}  = q{generates a Cacti template from a definition file.};
my %opts = $opt_parser->parse();
if ( !$opts{help} && !@ARGV ) {
   $opt_parser->error('You must specify a FILE to parse');
}
$opt_parser->usage_or_errors(%opts);

my $name_prefix   = $opts{name_prefix} . ' ';
my $rrd_step      = $opts{poll_interval};
my $rrd_heartbeat = $opts{poll_interval} * 2;
my $rrd_maximum   = $opts{smallint} ? '4294967295' : '18446744073709551615';

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

my %hash_version_codes = (
   "0.8.4"  => "0000",
   "0.8.5"  => "0001",
   "0.8.5a" => "0002",
   "0.8.6"  => "0003",
   "0.8.6a" => "0004",
   "0.8.6b" => "0005",
   "0.8.6c" => "0006",
   "0.8.6d" => "0007",
   "0.8.6e" => "0008",
   "0.8.6f" => "0009",
   "0.8.6g" => "0010",
   "0.8.6h" => "0011",
   "0.8.6i" => "0012",
   "0.8.6j" => "0013"
);
my $ver;
if ( $opts{cactiver} ) {
   if ( defined $hash_version_codes{$opts{cactiver}} ) {
      $ver = $hash_version_codes{$opts{cactiver}};
   }
   else {
      die "No such version '$opts{cactiver}', try one of "
         . join(' ', sort keys %hash_version_codes);
   }
}
else {
   $ver = max(values %hash_version_codes);
}

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
   height          => $opts{graph_height},
   width           => $opts{graph_width},
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
   $name =~ s/_VER_/$ver/g;
   print(("\t" x $indent++), "<$name>\n");
   push @stack, $name;
}

sub ee { # Element end
   my ( $sanity ) = @_;
   $sanity =~ s/_VER_/$ver/g;
   my ( $name ) = pop @stack;
   if ( ($sanity || $name) ne $name ) {
      die "You tried to end the '$sanity' element but stack has '$name'";
   }
   print(("\t" x --$indent), "</$name>\n");
}

sub el { # Element plus contents
   my ( $name, $content ) = @_;
   $name =~ s/_VER_/$ver/g;
   $content =~ s/_VER_/$ver/g;
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
el('name', "$name_prefix$t->{name} HT");
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
   el('name', "$name_prefix$g->{name} GT");
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
   el('name', "$name_prefix$g->{name} DT");
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
   el('name', "$name_prefix$v->{name}");
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
   el('name', "$name_prefix$k");
   el('gprint_text', $t->{gprints}->{$k}->{gprint_text});
   ee($t->{gprints}->{$k}->{hash});
}

# TODO: CDEF definitions.

# RRA (Round-Robin Archive) definitions
foreach my $r ( @{$t->{rras}} ) {
   es($r->{hash});
   el('name', "$name_prefix$r->{name} RRA");
   foreach my $thing ( qw(x_files_factor steps rows timespan cf_items) ) {
      el($thing, $r->{$thing});
   }
   ee($r->{hash});
}

ee('cacti');
