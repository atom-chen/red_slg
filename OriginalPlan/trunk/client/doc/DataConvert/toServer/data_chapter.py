#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
章节配置
@author: benqi
@deprecated: 2015-10-31
'''
import os
import __builtin__
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, gen_erl, gen_xml, prev, get_value, get_str

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"chapter")

# Erlang模块头说明，主要说明该文件作用，会自动添加-module(module_name).
# module_header函数隐藏了第三个参数，是指作者，因此也可以module_header(ur"礼包数据", module_name, "King")


# Erlang需要导出的函数接口, append与erlang的++也点类似，用于python的list操作
# Erlang函数一些注释，可以不写，但建议写出来

# 生成枚举的工具函数
def Field(module, str_enum):
    class_module = __builtin__.type(module, (object,), {})
    str_enum = str_enum.replace(" ", "")
    str_enum = str_enum.replace("\n", "")
    idx = 0
    for name in str_enum.split(","):  
        if '=' in name:  
            name,val = name.rsplit('=', 1)            
            if val.isalnum():               
                idx = eval(val)
        setattr(class_module, name.strip(), idx)  
        idx += 1
    return class_module

## 必须和excel里面的列保持一致的顺序
BaseColumn = """
    id,
    camp,
    name, 
    desc,
    reward,
    mapRes,
    roadRes,
    pos,
    dungeons,
    elites,
    level
"""

# 生成域枚举           
BaseField = Field('BaseField' , BaseColumn)

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

chapter_erl = "data_chapter"
data_chapter = module_header(ur"章节配置", chapter_erl, "bq", "chapter.xlsx", "data_chapter.py")
data_chapter.append("""

-export([get/1]).

""")


data_chapter.append("%% @doc 获得章节列表")
chapter_list = []
@load_sheel(work_book, ur"Sheet1")
def get_chapter_list(content):
    id = int(get_value(content[BaseField.id], 0))
    c_list = get_str(content[BaseField.dungeons], '')
    chapter_list.append("""get(%d) -> [%s];"""%(id, c_list))
    return []

get_chapter_list()
chapter_list.append("get(_) -> [].")
data_chapter.extend(chapter_list)


gen_erl(chapter_erl, data_chapter)
