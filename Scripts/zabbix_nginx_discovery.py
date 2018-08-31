# -*- coding: utf-8 -*-
#! /usr/bin/env python

import json
import commands

def GetCmd(comand):
    try:
        stat, proStr = commands.getstatusoutput(comand)
    except:
        print "command %s execute failed, exit" % comand
    return proStr

def Service_discovery():
    # 获取监听端口和服务名称
    Cmd = GetCmd("sudo ss -ntpl|awk '{print $4,$NF}'|egrep -v '^::|^127'|sed 1d")
    CmdList = Cmd.split("\n")
    NewList = []
    for port in CmdList:
        val = port.split()
        # 提取监听端口
        valTmp = val[0].split(":")
        val[0] = valTmp[1]
        # 提取服务名称
        valTmp = val[1].split(',')[0]
        val[1] = valTmp.split('"')[1]
        if val[1] != '-' and val[0] not in NewList:
            # 创建一个字典
            DataDict = {}
            # 创建一个端口字典,键: #TCP_PORT 值: val[0]
            DataDict['{#TCP_PORT}'] = val[0]
            # 创建一个NAME字典,键: #TCP_NAME 值: val[1]
            DataDict['{#TCP_NAME}'] = val[1]
            NewList.append(DataDict)
    DataDicts = {}
    DataDicts['data'] = NewList
    jsonStr = json.dumps(DataDicts, sort_keys=True, indent=4)
    print jsonStr

if __name__ == "__main__":
    Service_discovery()
