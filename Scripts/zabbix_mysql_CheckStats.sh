#!/bin/bash

MYSQL_USER='zabbix'
MYSQL_HOST='127.0.0.1'
MYSQL_PWD='zabbix_passwd'
MYSQL_PORT=$2
MYSQL_CONN="/usr/bin/mysqladmin -u${MYSQL_USER} -p${MYSQL_PWD} -h${MYSQL_HOST} -P${MYSQL_PORT}"

# help函数
help() {
    echo "Usage:$0  [ping|Uptime|Com_update|Slow_queries|Com_select|Com_rollback|Questions|Com_insert|Com_delete|Com_commit|Bytes_sent|Bytes_received|Com_begin] port"
}

# 参数是否正确
if [ $# -lt "2" ];then 
    echo "参数缺失!"
    help 
    exit 2
fi 
 
# 获取数据
case $1 in 
    ping) 
        result=`${MYSQL_CONN} ping 2> /dev/null|grep -c alive` 
        echo $result 
        ;; 
    Uptime) 
        result=`${MYSQL_CONN} status 2> /dev/null|cut -f2 -d":"|cut -f1 -d"T"` 
        echo $result 
        ;; 
    Com_update) 
        result=`${MYSQL_CONN} extended-status 2> /dev/null|grep -w "Com_update"|cut -d"|" -f3` 
        echo $result 
        ;; 
    Slow_queries) 
        result=`${MYSQL_CONN} status 2> /dev/null|cut -f5 -d":"|cut -f1 -d"O"` 
        echo $result 
        ;; 
    Com_select) 
        result=`${MYSQL_CONN} extended-status 2> /dev/null|grep -w "Com_select"|cut -d"|" -f3` 
        echo $result 
        ;; 
    Com_rollback) 
        result=`${MYSQL_CONN} extended-status 2> /dev/null|grep -w "Com_rollback"|cut -d"|" -f3` 
        echo $result 
        ;; 
    Questions) 
        result=`${MYSQL_CONN} status 2> /dev/null|cut -f4 -d":"|cut -f1 -d"S"` 
        echo $result 
        ;; 
    Com_insert) 
        result=`${MYSQL_CONN} extended-status 2> /dev/null|grep -w "Com_insert"|cut -d"|" -f3` 
        echo $result 
        ;; 
    Com_delete) 
        result=`${MYSQL_CONN} extended-status 2> /dev/null|grep -w "Com_delete"|cut -d"|" -f3` 
        echo $result 
        ;; 
    Com_commit) 
        result=`${MYSQL_CONN} extended-status 2> /dev/null|grep -w "Com_commit"|cut -d"|" -f3` 
        echo $result 
        ;; 
    Bytes_sent) 
        result=`${MYSQL_CONN} extended-status 2> /dev/null|grep -w "Bytes_sent" |cut -d"|" -f3` 
        echo $result 
        ;; 
    Bytes_received) 
        result=`${MYSQL_CONN} extended-status 2> /dev/null|grep -w "Bytes_received" |cut -d"|" -f3` 
        echo $result 
        ;; 
    Com_begin) 
        result=`${MYSQL_CONN} extended-status 2> /dev/null|grep -w "Com_begin"|cut -d"|" -f3` 
        echo $result 
        ;; 
                        
    *) 
        help 
        ;; 
esac
