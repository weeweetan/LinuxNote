1.模拟linnux登录shell

#/bin/bash
echo -n "login:" 
read name
echo -n "password:"
read passwd
if [ $name = "cht" -a $passwd = "abc" ];then
echo "the host and password is right!"
else echo "input is error!"
fi

2.比较两个数大小

#/bin/bash
echo "please enter two number"
read a
read b
if test $a -eq $b
then echo "NO.1 = NO.2"
elif test $a -gt $b
then echo "NO.1 > NO.2"
else echo "NO.1 < NO.2" 
fi

3.查找/root/目录下是否存在该文件

#/bin/bash
echo "enter a file name:"
read a
if test  -e /root/$a 
then echo "the file is exist!"
else echo "the file is not exist!"
fi

4.for循环的使用

#/bin/bash
clear
for num in 1 2 3 4 5 6 7 8 9 10
do
    echo "$num"
done

5.命令行输入

#/bin/bash
echo "Please enter a user:"
read a
b=$(whoami)
if test $a = $b
then echo "the user is running."
else echo "the user is not running."
fi

6.删除当前目录下大小为0的文件

#/bin/bash
for filename in `ls`
do
    if test -d $filename
    then b=0
    else    
       a=$(ls -l $filename | awk '{ print $5 }')
            if test $a -eq 0
             then rm $filename
             fi
        fi      
done

7.如果/export/um_lpp_source下有文件，那么将其文件系统大小改为3G

 #/bin/bash
while line=`ls /export/um_lpp_source`
do
        if test $line=""
        then  echo "NULL"
             sleep 1
        else echo $line
                chfs -a size=3G /export/um_lpp_source
                 exit 0
        fi
done

 

8.测试IP地址

#/bin/bash
for i in  1 2 3 4 5 6 7 8 9 
do
    echo "the number of $i computer is "
    ping -c 1 192.168.0.$i
done

9.如果test.log的大小大于0，那么将/opt目录下的*.tar.gz文件

 #/bin/sh
a=2
while name="test.log"
do
        sleep 1
        b=$(ls -l $name | awk '{print $5}')
        if test $b -ge $a
        #then echo "OK"
        then `cp /opt/*.tar.gz .`
        exit 0
        fi
done



10.打印读取的内容，为下面的例子做准备

#/bin/bash
while read name
do
echo $name
done

11.从0.sh中读取内容并打印

#/bin/bash
while read line
do
    echo $line
done < 0.sh

12.读取a.c中的内容并做加1运算

#/bin/bash
test -e a.c
while read line
do
    a=$(($line+1))
done < a.c
echo $a

13.普通无参数函数

#/bin/bash
p ()
{
    echo "hello"
}
p

14.给函数传递参数

#/bin/bash
p_num ()
{
    num=$1
    echo $num
}
for n in $@
do
    p_num $n
done

15.创建文件夹

#/bin/bash
while :
do
    echo "please input file's name:"
    read a
    if test -e /root/$a
    then
         echo "the file is existing Please input new file name:"
    else
        mkdir $a
        echo "you aye sussesful!"
        break 
    fi
done

16.获取本机IP地址

#/bin/bash
ifconfig | grep "inet addr:" | awk '{ print $2 }'| sed 's/addr://g'

17.查找最大文件

#/bin/bash
a=0
for  name in *.*
do
     b=$(ls -l $name | awk '{print $5}')
    if test $b -ge $a
    then a=$b
         namemax=$name
     fi
done
echo "the max file is $namemax"

18.查找当前网段内IP用户，重定向到ip.txt文件中

#/bin/bash
a=1
while :
do
    a=$(($a+1))
    if test $a -gt 255
    then break
    else
        echo $(ping -c 1 192.168.0.$a | grep "ttl" | awk '{print $4}'| sed 's/://g')
        ip=$(ping -c 1 192.168.0.$a | grep "ttl" | awk '{print $4}'| sed 's/://g')
        echo $ip >> ip.txt
    fi
done

19.打印当前用户

#/bin/bash
echo "Current User is :"
echo $(ps | grep "$$" | awk '{print $2}')

20.case语句练习

#!/bin/bash
clear
echo "enter a number from 1 to 5:"
read num
case $num in
    1) echo "you enter 1"
    ;;
    2) echo "you enter 2"
    ;;
    3) echo "you enter 3"
    ;;
    4) echo "you enter 4"
    ;;
    5) echo "you enter 5"
    ;;
    *) echo "error"
    ;;
esac

21.yes/no返回不同的结构

#!/bin/bash
clear
echo "enter [y/n]:"
read a
case $a in
    y|Y|Yes|YES) echo "you enter $a"
    ;;
    n|N|NO|no) echo "you enter $a"
    ;;
    *) echo "error"
    ;;
esac

22.杀进程

 #/bin/bash
pid=`ps -ef | grep '进程相关内容' | grep -v 'grep' | awk '{ print $2}'`
if [ -n "$pid" ]; then
        kill -9 $pid
fi

 23.内置命令的使用

#/bin/bash

    clear
        echo "Hello, $USER"
        echo
        
        echo "Today 's date id `date`"

        echo

        echo "the user is :"
        who
        echo

        echo "this is `uname -s`"
        echo

        echo "that's all folks! "

24.

 

 

25.

#/bin/bash


26.打印无密码用户

#/bin/bash
echo "No Password User are :"
echo $(cat /etc/shadow | grep "!!" | awk 'BEGIN { FS=":" }{print $1}')

27.

#/bin/bash

    clear
        echo "Hello, $USER"
        echo
        
        echo "Today 's date id `date`"

        echo

        echo "the user is :"
        who
        echo

        echo "this is `uname -s`"
        echo

        echo "that's all folks! "


28.检查端口号是否已启动
#!/bin/bash
n=1
echo "检查xxx服务..."
while true
do
        if test $n -gt 20
        then 
                echo "xxx服务启动失败"
                break
        fi
                
        sleep 5
        n=$(($n+1))
        port=`netstat -antp | grep "0.0.0.0:8080"`
        if [ ${#port} -gt 3 ]; then
                echo "xxx服务已经启动"
                break;
        fi
done