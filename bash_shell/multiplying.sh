#!/bin/bash

echo -e "you should 2 numerbs, I will multiplying them!"
read -p "first number:" firstnu
read -p "second number:" secondnu

total=$((${firstnu}*${secondnu}))

echo -e "\nthe result of ${firstnu} * ${secondnu} ==> ${total}"
