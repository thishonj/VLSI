#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dumper;

my %hash = (a=>10,b=>20);
my @array = qw/one two three/;
my $Scalar = 30;
#Referencing(Gives the address location)
print \%hash;
#Dereferencing
my $ref1 = \@array;
push $ref1->@*, 'four';
print Dumper (\@array); #Array Reference is created
#constructor HASH Reference
my $hash_ref = {'a'=>1,'b'=>2};
print Dumper($hash_ref->{a}); #Deferencing key a
#constructors ARRAY Reference
my $array_ref = ['c','d'];
print Dumper($array_ref->[0]); #Dereferncing Index position 0
#Dereferencing all values
print Dumper($hash_ref->%*);
print Dumper(%{$hash_ref});
print Dumper($array_ref->@*);
#Nesting References
my $hash_ref1 = {'A'=>3,'B'=>4, 'C'=>{'new'=>3,"new1"=>[1,2,3]}};
print Dumper($hash_ref1->{C}->{new1}->[0]);   #gives value at index 0 at new1, hash key C
#Ref functiom
print Dumper(ref($hash_ref1)); #HASH ->Returns the type
#Take only the keys
print Dumper(keys $hash_ref->%*);
1;