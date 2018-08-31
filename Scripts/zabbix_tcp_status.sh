#!/bin/bash

function SYNRECV {
        res=`/usr/sbin/ss -ant | awk '{++s[$1]} END {for(k in s) print k,s[k]}' | grep 'SYN-RECV' | awk '{print $2}'`
        if [ -n "$res" ];then
                echo $res
        else
                echo 0
        fi
}

function ESTAB {
        res=`/usr/sbin/ss -ant | awk '{++s[$1]} END {for(k in s) print k,s[k]}' | grep 'ESTAB' | awk '{print $2}'`
        if [ -n "$res" ];then
                echo $res
        else
                echo 0
        fi
}

function FINWAIT1 {
        res=`/usr/sbin/ss -ant | awk '{++s[$1]} END {for(k in s) print k,s[k]}' | grep 'FIN-WAIT-1' | awk '{print $2}'`
        if [ -n "$res" ];then
                echo $res
        else
                echo 0
        fi
}

function FINWAIT2 {
        res=`/usr/sbin/ss -ant | awk '{++s[$1]} END {for(k in s) print k,s[k]}' | grep 'FIN-WAIT-2' | awk '{print $2}'`
        if [ -n "$res" ];then
                echo $res
        else
                echo 0
        fi
}

function TIMEWAIT {
        res=`/usr/sbin/ss -ant | awk '{++s[$1]} END {for(k in s) print k,s[k]}' | grep 'TIME-WAIT' | awk '{print $2}'`
        if [ -n "$res" ];then
                echo $res
        else
                echo 0
        fi
}

function LASTACK {
        res=`/usr/sbin/ss -ant | awk '{++s[$1]} END {for(k in s) print k,s[k]}' | grep 'LAST-ACK' | awk '{print $2}'`
        if [ -n "$res" ];then
                echo $res
        else
                echo 0
        fi
}

function LISTEN {
        res=`/usr/sbin/ss -ant | awk '{++s[$1]} END {for(k in s) print k,s[k]}' | grep 'LISTEN' | awk '{print $2}'`
        if [ -n "$res" ];then
                echo $res
        else
                echo 0
        fi
}
$1
