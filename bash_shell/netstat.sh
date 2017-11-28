#!/bin/bash

echo "Now, I will detect your linux server's services."
echo -e "The www, ssh mail and ftp will be detect.\n"

testfile=/dev/shm/netstat_checking.txt
netstat -tunl>${testfile}

testing=$(grep ":80" ${testfile})
if [ "${testing}" != "" ]; then
    echo "www is running on your server"
fi

testing=$(grep ":22" ${testfile})
if [ "${testing}" != "" ]; then
    echo "ssh is running on your server"
fi


testing=$(grep ":25" ${testfile})
if [ "${testing}" != "" ]; then
    echo "mail is running on your server"
fi


testing=$(grep ":21" ${testfile})
if [ "${testing}" != "" ]; then
    echo "ftp is running on your server"
fi
