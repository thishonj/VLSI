#!/bin/bash
#Arithematic
read -p "Enter a:" a
read -p "Enter b:" b
add=$((a+b))
echo "Addition of a and b are $add"
#Relational
if (($a>$b))
then
echo "a greater than b"
else
	echo "b greater than a"
fi
#Logical
if (($a==1 && $b==1))
then
	echo "A&B is true"
else
	echo "A&B is false"
fi
#Bitwise
bitor=$((a|b))
echo "A|B is: $bitor"
