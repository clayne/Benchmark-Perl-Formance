package Benchmark::Perl::Formance::Plugin::MatrixReal;

use strict;
use warnings;

our $VERSION = "0.001";

#############################################################
#                                                           #
# Benchmark Code ahead - Don't touch without strong reason! #
#                                                           #
#############################################################

use Benchmark ':hireswallclock';
use Math::MatrixReal;

sub matrix_operations
{
        my ($options) = @_;

        my @sizes = $options->{fastmode} ? (5) : (30);
        my $count = 2000;

        srand(42); # ensure same data for benchmarking
        my %matrices = map { ( $_ => Math::MatrixReal->new_random($_) ) } @sizes;

        my %results;
        for my $size ( keys %matrices )
        {
                # TODO: seed random generator!
                my $sizestr = sprintf("%03d",$size);
                my $matrix = $matrices{$size};
                my ($r,$c) = $matrix->dim;

                # taken from https://metacpan.org/source/LETO/Math-MatrixReal-2.12/example/bench.pl
                $results{det}{$sizestr}                 = { goal => $size, Benchmark => [@{ timeit $count, sub { $matrix->det                     } }] };
                $results{det_LR}{$sizestr}              = { goal => $size, Benchmark => [@{ timeit $count, sub { $matrix->decompose_LR->det_LR    } }] };
                $results{inverse}{$sizestr}             = { goal => $size, Benchmark => [@{ timeit $count, sub { $matrix->inverse()               } }] };
                $results{invert_LR}{$sizestr}           = { goal => $size, Benchmark => [@{ timeit $count, sub { $matrix->decompose_LR->invert_LR } }] };
                $results{matrix_squared}{$sizestr}      = { goal => $size, Benchmark => [@{ timeit $count, sub { $matrix ** 2                     } }] };
                $results{to_negative_one}{$sizestr}     = { goal => $size, Benchmark => [@{ timeit $count, sub { $matrix ** -1                    } }] };
                $results{matrix_times_itself}{$sizestr} = { goal => $size, Benchmark => [@{ timeit $count, sub { $matrix * $matrix                } }] };
        }
        return \%results;
}

sub main
{
        my ($options) = @_;

        return matrix_operations($options)
}

1;

__END__

=head1 NAME

Benchmark::Perl::Formance::Plugin::MatrixReal - Pure Perl matrix operations

=head1 ABOUT

Benchmarks taken from L<https://metacpan.org/source/LETO/Math-MatrixReal-2.12/example/bench.pl>.

=cut
