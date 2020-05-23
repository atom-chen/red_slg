#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
战斗场景配置
@author: ZhaoMing
@deprecated: 2013-11-20
'''
import os
import __builtin__
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, gen_erl, gen_xml, prev, get_value, get_str

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"fight_scene")

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
    id,name,res,globalMagic,MapBlockNum,localMagic,sound,block
"""

# 生成域枚举           
BaseField = Field('BaseField' , BaseColumn)

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

fight_scene_erl = "data_fight_scene"
data_fight_scene = module_header(ur"战斗场景配置", fight_scene_erl, "zm", "fight_scene.xlsx", "data_fight_scene.py")
data_fight_scene.append("""
-include("fight_scene.hrl").

-export([get/1]).
""")

scene_base = []
@load_sheel(work_book, ur"Sheet1")
def get_fight_scene(content):
    id = int(content[BaseField.id])
    map_size = get_str(content[BaseField.MapBlockNum], '')
    block_list = get_str(content[BaseField.block], '')
    scene_base.append("""get({0}) ->
    #fight_scene{{
        scene_id = {0}
        ,block_list = [{1}]
        ,size = {{{2}}}
    }}; """.format(id,block_list,map_size))
    return []

get_fight_scene()
scene_base.append("get(_) -> false.")

data_fight_scene.extend(scene_base)

gen_erl(fight_scene_erl, data_fight_scene)
