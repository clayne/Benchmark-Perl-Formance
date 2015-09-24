package Benchmark::Perl::Formance::Plugin::Skeleton;
# ABSTRACT: benchmark plugin - Skeleton - An example plugin

use strict;
use warnings;

our $VERSION = "0.001";

#############################################################
#                                                           #
# Benchmark Code ahead - Don't touch without strong reason! #
#                                                           #
#############################################################

use Benchmark ':hireswallclock';

our $goal;
our $count;

sub main {
        my ($options) = @_;

        $goal   = $options->{fastmode} ? 2 :  10; # benchmark parameter that influences single run duration
        $count  = $options->{fastmode} ? 1 :   5; # run that many iterations

        my $result;
        my $t = timeit $count, sub {
                                    # REAL CODE HERE
                                    sleep $goal;
                                    $result = 7;
                                   };
        return {
                Benchmark             => $t,        # "Benchmark" is the only important key
                goal                  => $goal,     # \
                count                 => $count,    #  | Just meta info for debugging / arguing / questioning.
                result                => $result,   # /
               };
}

1;

=head1 ABOUT

You can create your own plugins by just creating a module in the
namespace C<Benchmark::Perl::Formance::Plugin::*> which simply has to
provide a

 package Benchmark::Perl::Formance::Plugin::HotStuff;
 
 sub main {
     my ($options) = @_;
     
     # do something
     
     return { result_key1 => $value1,
              result_key2 => $value2,
            }
  }

To use it call the frontend tool and provide your pluginname via
--plugins:

  $ benchmark-perlformance --plugins=HotStuff

If your module should become a default part of the
Benchmark::Perl::Formance suite, then patch the C<$DEFAULT_PLUGINS> in
lib/Benchmark/Perl/Formance.pm and/or email me.

=cut
