#!/bin/bash

counter=1
while [ $counter -le 10 ]
do
	echo "$counter"
	((counter++))
done
echo "Completed Printing numbers from 1 to 10"


