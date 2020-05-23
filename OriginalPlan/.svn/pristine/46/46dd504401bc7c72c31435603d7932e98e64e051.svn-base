#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
服务端文字
@author: ZhaoMing
@deprecated: 2014年7月31日
'''
import os
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, gen_erl, gen_xml, prev, get_value

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"server_text")

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

text_erl = "data_text"
data_text = module_header(ur"服务端文字", text_erl, "zm", "server_text.xlsx", "data_text.py")
data_text.append("""
-export([get/2]).
""")

text_list = []
text_list.append("""
%% @doc 语言文字
%% @spec get(Lang::cn|tw|en,ID::string()) -> binary() """)
@load_sheel(work_book, ur"服务端文字")
def get_text(content):
    id = str(content[0])
    cn = str(content[1])
    tw = str(content[2])
    en = str(content[3])
    th = str(content[4])
    text_list.append("""get(cn, "%s") -> <<"%s">>;"""%(id, cn))
    text_list.append("""get(tw, "%s") -> <<"%s">>;"""%(id, tw))
    text_list.append("""get(en, "%s") -> <<"%s">>;"""%(id, en))
    text_list.append("""get(th, "%s") -> <<"%s">>;"""%(id, th))
    return []

get_text()

text_list.append("get(_, _) -> <<>>.")

data_text.extend(text_list)

gen_erl(text_erl, data_text)
