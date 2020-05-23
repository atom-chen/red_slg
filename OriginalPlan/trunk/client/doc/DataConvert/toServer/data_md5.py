#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
副本配置
@author: ZhaoMing
@deprecated: 2014-11-24
'''
import os
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, module_php_header, gen_erl, gen_xml, prev, get_value, gen_php

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"md5")

# Erlang模块头说明，主要说明该文件作用，会自动添加-module(module_name).
# module_header函数隐藏了第三个参数，是指作者，因此也可以module_header(ur"礼包数据", module_name, "King")


# Erlang需要导出的函数接口, append与erlang的++也点类似，用于python的list操作
# Erlang函数一些注释，可以不写，但建议写出来

# 生成枚举的工具函数
def enum(module, str_enum):
    str_enum = str_enum.replace(" ", "")
    str_enum = str_enum.replace("\n", "")
    idx = 0  
    for name in str_enum.split(","):  
        if '=' in name:  
            name,val = name.rsplit('=', 1)            
            if val.isalnum():               
                idx = eval(val)  
        setattr(module, name.strip(), idx)  
        idx += 1

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

md5_erl = "data_md5"
data_md5 = module_header(ur"协议加密配置", md5_erl, "zm", "md5.xlsx", "data_md5.py")
data_md5.append("-export([rule/1, key/1, is_encrypt/1]).")

md5 = []
md5_key = []
is_encrypt = []
@load_sheel(work_book, ur"协议加密")
def get_md5(content):
    cmd = int(content[0])
    try: 
        key = int(content[1])
    except:
        key = str(content[1])

    try:
        rule = int(content[2])
    except:
        rule = str(content[2])
    md5.append("rule(%d) -> [%s];"%(cmd, rule))
    md5_key.append("key(%d) -> \"%s\";"%(cmd, key))
    is_encrypt.append("is_encrypt(%d) -> true;"%(cmd))
    return []

get_md5()
md5.append("rule(_) -> [].")
md5_key.append('key(_) -> "".')
is_encrypt.append("is_encrypt(_) -> false.")
data_md5.extend(md5)
data_md5.extend(md5_key)
data_md5.extend(is_encrypt)

gen_erl(md5_erl, data_md5)
