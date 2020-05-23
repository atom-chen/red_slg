#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
开服活动初始化配置表
@author: ZhaoMing
@deprecated: 2015年01月21日
'''
import os
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, module_php_header, gen_erl, gen_xml, prev, get_value, gen_php, get_str

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"openingactivity")

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

BaseColumn = """
    name, act_id, cont_day, time, pos
"""
 
class FieldClassBase:
    def __init__(self):
        enum(FieldClassBase, BaseColumn)

# 生成域枚举           
BaseField = FieldClassBase()

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

## ##################################
## 大陆配置
## ##################################

act_erl = "data_open_fun_act"
data_open_fun_act = module_header(ur"开服初始化活动配置", act_erl, "zm", "openingactivity.xlsx", "data_openingactivity.py")
data_open_fun_act.append("""
-export([
         get_all/0
        ]).
""")

conf = []
@load_sheel(work_book, ur"大陆")
def get_conf(content):
    name = str(content[BaseField.name])
    act_id = int(content[BaseField.act_id])
    cont_day = int(content[BaseField.cont_day])
    pos = int(content[BaseField.pos])
    time = get_str(content[BaseField.time], '23:59:59')
    time_list =time.split(":")
    conf.append("{<<\"%s\">>, %d, %d, {%s, %s, %s}, %d }"%(name, act_id, cont_day, time_list[0], time_list[1], time_list[2], pos))
    return []

get_conf()

data_open_fun_act.append("""
%% @doc 开服活动配置
%% @spec get_all() -> list() 
get_all() -> 
    [
     %s
    ].  """%(",\n\t ".join(conf)))

gen_erl(act_erl, data_open_fun_act)


## ##################################
## 大陆配置
## ##################################

act_erl = "data_open_fun_act_tw"
data_open_fun_act = module_header(ur"开服初始化活动配置", act_erl, "zm", "openingactivity.xlsx", "data_openingactivity.py")
data_open_fun_act.append("""
-export([
         get_all/0
        ]).
""")

conf = []
@load_sheel(work_book, ur"台湾")
def get_conf(content):
    name = str(content[BaseField.name])
    act_id = int(content[BaseField.act_id])
    cont_day = int(content[BaseField.cont_day])
    pos = int(content[BaseField.pos])
    time = get_str(content[BaseField.time], '23:59:59')
    time_list =time.split(":")
    conf.append("{<<\"%s\">>, %d, %d, {%s, %s, %s}, %d }"%(name, act_id, cont_day, time_list[0], time_list[1], time_list[2], pos))
    return []

get_conf()

data_open_fun_act.append("""
%% @doc 开服活动配置
%% @spec get_all() -> list() 
get_all() -> 
    [
     %s
    ].  """%(",\n\t ".join(conf)))

gen_erl(act_erl, data_open_fun_act)

## ##################################
## 泰国配置
## ##################################

act_erl = "data_open_fun_act_thai"
data_open_fun_act = module_header(ur"开服初始化活动配置", act_erl, "zm", "openingactivity.xlsx", "data_openingactivity.py")
data_open_fun_act.append("""
-export([
         get_all/0
        ]).
""")

conf = []
@load_sheel(work_book, ur"泰国")
def get_conf(content):
    name = str(content[BaseField.name])
    act_id = int(content[BaseField.act_id])
    cont_day = int(content[BaseField.cont_day])
    pos = int(content[BaseField.pos])
    time = get_str(content[BaseField.time], '23:59:59')
    time_list =time.split(":")
    conf.append("{<<\"%s\">>, %d, %d, {%s, %s, %s}, %d }"%(name, act_id, cont_day, time_list[0], time_list[1], time_list[2], pos))
    return []

get_conf()

data_open_fun_act.append("""
%% @doc 开服活动配置
%% @spec get_all() -> list() 
get_all() -> 
    [
     %s
    ].  """%(",\n\t ".join(conf)))

gen_erl(act_erl, data_open_fun_act)
