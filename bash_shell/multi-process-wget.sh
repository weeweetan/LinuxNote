#!/bin/bash
date
for i in `seq 1 100`
do
    {
            wget --limit-rate=100k http://192.168.116.1/temp1/109.ts
            sleep 5

    } &
done
wait  ##等待所有子后台进程结束
date
