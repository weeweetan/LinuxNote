#!/bin/bash

s=0
i=0
read -p "Please input a number: " num
while [ "${i}" != "${num}" ]
do 
    i=$((${i}+1))
    s=$((${s}+${i}))
done

echo "the result of '1+2+3+...+${num}' is ==> "${s}
