#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
游戏广播配置
@author: csh
@deprecated: 2015-03-06
'''
import os
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, gen_erl, gen_xml, prev, get_value

import time

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"string")

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
BaseColumn = """
    id
    ,func_id
    ,condition
    ,param_list
    ,viewPos
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

broadcast_erl = "data_broadcast"
data_broadcast = module_header(ur"游戏广播配置", broadcast_erl, "csh", "string.xlsx", "data_string.py")
data_broadcast.append("""
-export([
        get_condition_list/1
        ,get_content_id/2
        ,get_view_pos/1
        ]).
""")

broadcast_list = []
func_id_list = []
view_pos_list = []
view_pos_list.append("""
%% @doc 显示位置
%% @spec get_view_pos(ContentID :: int()) -> ViewPos :: int() """)

@load_sheel(work_book, ur"游戏广播配置")
def load_broadcast_to_list(content):
    temp = []
    id = int(get_value(content[BaseField.id], 0))
    # content_str = int(get_value(content[BaseField, content], 0))
    func_id = int(get_value(content[BaseField.func_id], 0))
    condition = int(get_value(content[BaseField.condition], 0))
    param_list = str(get_value(content[BaseField.param_list], ''))
    view_pos = int(get_value(content[BaseField.viewPos], 1))
    temp.append(id)
    # temp.append(content_str)
    temp.append(func_id)
    temp.append(condition)
    temp.append(param_list)
    broadcast_list.append(temp)
    view_pos_list.append("get_view_pos(ContentID) when ContentID =:= %d -> %d;"%(id, view_pos))
    if (func_id not in func_id_list) :
        func_id_list.append(func_id)
    return []
load_broadcast_to_list()

view_pos_list.append("get_view_pos(_) -> 1.")

# 根据功能ID获取条件列表
condition_list = []
condition_list.append("\n\n%% 根据功能ID获取条件列表")
condition_list.append("%% @spec get_condition_list(func_id :: int()) -> condition_list :: list.")
def get_condition_list():
    temp_list = []
    for temp_func_id in func_id_list :
        row = 0
        while row < len(broadcast_list):
            if (temp_func_id == broadcast_list[row][1]) :
                temp_list.append("""{{{0}}}""".format(broadcast_list[row][2]))
            row = row + 1
        condition_list.append("""get_condition_list({0}) -> {1};""".format(temp_func_id, '[' + ', '.join(temp_list) + ']' ))
        del temp_list[:]
    return []
get_condition_list()
condition_list.append("get_condition_list(_) -> false.")
data_broadcast.extend(condition_list)

# 根据功能ID和条件获取字符串ID
content_id_list = []
content_id_list.append("\n\n%% 根据功能ID和条件获取字符串ID")
content_id_list.append("%% @spec get_content_id(func_id :: int() , condition :: int()) -> content_id :: int()")
def get_content_id():
    row = 0
    while row < len(broadcast_list) :
        content_id_list.append("""get_content_id({0}, {1}) -> {2};""".
            format(broadcast_list[row][1], broadcast_list[row][2], broadcast_list[row][0], broadcast_list[row][3]))
        # content_id_list.append("""get_content_id({0}, {1}) -> {{{2}, <<"{3}">>}};""".
            # format(broadcast_list[row][1], broadcast_list[row][2], broadcast_list[row][0], broadcast_list[row][3]))
        row = row + 1
    return []
get_content_id()
content_id_list.append("get_content_id(_, _) -> 0.")
# content_id_list.append("get_content_id(_, _) -> {0, <<>>}.")
data_broadcast.extend(content_id_list)

data_broadcast.extend(view_pos_list)

gen_erl(broadcast_erl, data_broadcast)
