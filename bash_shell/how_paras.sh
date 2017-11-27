#!/bin/bash

echo "The srcipt name is          ==>${0}"
echo "Total parameters is         ==>$#"
[ "$#" -lt 2 ] && echo "The number of parameter less than 2,stop here" && exit 0
echo "Your whole parameter is     ==>'$@'"
echo "The 1st parameter is        ==>${1}"
echo "The 2nd parameter is        ==>${2}"
