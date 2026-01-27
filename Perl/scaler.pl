#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dumper;
# Scalars
my $name1 = 'Thishon';
my $name2 = 'Jayaraj';
my $a = 2;
my $b = 1.2;
print Dumper($name1,$a,$b);
#concatenation(Either strings or data types can only be concatenated)
print $name1.$name2;


1;