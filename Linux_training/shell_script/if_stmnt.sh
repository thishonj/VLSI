#!/bin/bash

echo "Enter subject"
read subject
if [ $subject == "Maths" ]
then
echo "Enter marks:"
read mark
echo "you have scored: $mark"
	if [ $mark -ge 30 ]
	then
	echo "You passed"
	else
	echo "You Failed"
	fi
else
echo "Wrong subject"
fi
