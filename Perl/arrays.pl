#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dumper;

#array declaration
my @array1 = (1,'thishon', 1.2);
my @array2 = qw/one two three/;
#Accessing Array
print Dumper(@array1,$array2[0],$array1[-1]);
#overidding
$array2[0]='four';
print Dumper($array2[0]);
#find array size
my $size = @array1;
#Find last index
my $last_index = $#array1;
print Dumper($size,$last_index);
#continuos assignment
my @array3= (1..10);
print Dumper(@array3);
#push(add element at last)
push @array1,'Jayaraj';
#pop(Remove element from last)
pop @array2;
#shift(Remove element from front)
shift @array3;
#unshift(add element at first position)
unshift @array1, 10; 
print Dumper(@array1,@array2,@array3);
#Sorting Array
my @array4 = (1,4,10,2,5,6);
@array4 = sort @array4;
print Dumper(@array4);
@array4 = sort {$a<=>$b}@array4; #Ascending
print Dumper(@array4);
@array4 = sort {$b<=>$a}@array4; #Descending
print Dumper(@array4);
1;