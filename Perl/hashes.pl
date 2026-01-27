#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dumper;

my %map = (
    a=>10,
    b=>20,
    c=>30,
    '1_%'=>50 #speacial characters any should be a string
);
#Access a specific Key
print "$map{b}";
#Assign key and value
$map{d}=40;
print Dumper(@map{'a','b'});
#Assign Arrays to keys
my @array = keys %map;
#Get size of Hash
my $size = keys %map;
print "$size"   ;
print Dumper(%map);
#check if value exists
$map{e}=undef;
my $exists = exists $map{e}?'yes':'no'; #Conditional Operator
print Dumper($exists);
#Deleting a Hash
delete $map{c};
print Dumper(%map);
1;