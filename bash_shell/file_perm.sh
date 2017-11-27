#!/bin/bash

echo -e "Please input a filename, I will check the file's type and permission.\n\n"
read -p "Input a filename: " filename
test -z ${filename} && echo -e "You must a filename" && exit 0

test ! -e ${filename} && echo -e "the filename ${filename} don't exist" && exit 0

test -f ${filename} && filetype="regular file"
test -d ${filename} && filetype="directory"
test -r ${filename} && perm="readable"
test -w ${filename} && perm="${perm} writeable"
test -x ${filename} && perm="${perm} executable"

echo "The filename:${filename} is ${filetype}"
echo "And permission for you are ${perm}"


