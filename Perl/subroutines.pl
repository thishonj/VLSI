#!/usr/bin/env perl

use strict;
use warnings;
use feature qw/signatures/;

use Data::Dumper;
#passing vlaues to a subroutine
sub test{
    my $name = $_[0];
    print "Thishon\t$name\n";
}
test('Jayaraj');

#passing as arguments
sub test1{
    my @args = @_; # $_(Scalar), @_(Array), %_(Hash)
    # my $name1 = shift @_; #passing all values at once
    my $name1 = $args[0];
    print "Name:$name1\n";
}
test1('John');

#passing Array
my @array= qw/a b c/;
sub test2{
    my $args1 = shift @_;
    push @array,'d';
}
test2(@array);
print Dumper(@array);

#return Statements
sub add($a,$b){
    my $c = $a+$b;
    if(1){
        return $c;
    }
    else{
        return undef;
    }
    }
print Dumper(add(2,3)); #last value used will be returned

#slurpee Capture
sub test3($name,@array){
    print Dumper $name;
    print Dumper @array;
}
test3('Thishon', 1,2,3);

#Named Arguments
sub test4(%inputs){
print Dumper \%inputs;
}
test(1=>'one',2=>'two');
1;