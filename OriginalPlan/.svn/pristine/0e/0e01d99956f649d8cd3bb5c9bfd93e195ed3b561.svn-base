#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
ip配置表
@author: ZhaoMing
@deprecated: 2014年7月31日
'''
import os
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, gen_erl, gen_xml, prev, get_value, get_str

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"ip")

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

## 必须和excel里面的列保持一致的顺序
 
class FieldClassBase:
    def __init__(self):
        enum(FieldClassBase, BaseColumn)

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

ip_erl = "data_ip"
data_ip = module_header(ur"ip配置表", ip_erl, "zm", "vip.xlsx", "data_ip.py")
data_ip.append("""
-export([ip2addr/1]).

ip2addr(IPStr) ->
    case inet_parse:ipv4_address(IPStr) of
        {ok, {A, B, C, D}} ->
            IPNum = A * 16777216 + B * 65536 + C * 256 + D,
            ip(IPNum);
        {error, _} -> <<"unknown">>
    end.
""")


num = 0

all_ip_list = []
ip_list = []
ip_list.append("-module(data_ip_%d)."%(num / 500 + 1))
ip_list.append("-export([ip/1]).")


min_ip_num = 4294967296
max_ip_num = 0
ip_arr = {}
## ###################################
## 手动修改为ip
## ###################################
@load_sheel(work_book, ur"_bak")
def get_ip(content):
    global num, min_ip_num, max_ip_num, ip_list
    
    num += 1
    if num % 500 == 0:
        ip_list.append("ip(_) -> <<\"unknown\">>.")
        erl_name = "data_ip_%d"%(num / 500)
        gen_erl("ip\\" + erl_name, ip_list)
        all_ip_list.append("ip(IPNum) when IPNum >= %d andalso IPNum =< %d -> %s:ip(IPNum);"%(min_ip_num, max_ip_num, erl_name))
        ip_list = []
        ip_list.append("-module(data_ip_%d)."%(num / 500 + 1))
        ip_list.append("-export([ip/1]).")
        min_ip_num = 4294967296
        max_ip_num = 0

    ip_str_begin = get_str(content[0], '')
    ip_str_end = get_str(content[1], '')
    area = get_str(content[2], 'unknown')

    ip_begin = ip_str_begin.split(".")
    ip_end = ip_str_end.split(".")
    ip_num_begin = int(ip_begin[0]) *  16777216 + int(ip_begin[1]) *  65536 + int(ip_begin[2]) * 256 + int(ip_begin[3]) 
    ip_num_end = int(ip_end[0]) *  16777216 + int(ip_end[1]) *  65536 + int(ip_end[2]) * 256 + int(ip_end[3]) 

    ip_list.append("ip(IPNum) when IPNum >= %d andalso IPNum =< %d -> <<\"%s\">>;"%(ip_num_begin, ip_num_end, area))

    if ip_num_begin < min_ip_num:
        min_ip_num = ip_num_begin
    if ip_num_end > max_ip_num:
        max_ip_num = ip_num_end
    
    return []

get_ip()

ip_list.append("ip(_) -> <<\"unknown\">>.")
erl_name = "data_ip_%d"%(num / 500 + 1)
gen_erl("ip\\" + erl_name, ip_list)
all_ip_list.append("ip(IPNum) when IPNum >= %d andalso IPNum =< %d -> %s:ip(IPNum);"%(min_ip_num, max_ip_num, erl_name))
all_ip_list.append("ip(_) -> <<\"unknown\">>.")

data_ip.extend(all_ip_list)

gen_erl(ip_erl, data_ip)
