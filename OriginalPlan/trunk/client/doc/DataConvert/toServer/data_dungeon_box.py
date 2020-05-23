#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
vip配置表
@author: ZhaoMing
@deprecated: 2014年7月31日
'''
import os
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, gen_erl, gen_xml, prev, get_value

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"dungeon_box")

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

dungeon_box_erl = "data_dungeon_box"
data_dungeon_box = module_header(ur"vip配置表", dungeon_box_erl, "zm", "vip.xlsx", "data_dungeon_box.py")
data_dungeon_box.append("""
-include("box.hrl").

-export([get/2, mail_list/1]).
""")

box_conf = []
box_conf.append("%% @spec get(BoxID, IsVip :: 0-普通 1-vip) -> #dungeon_box{} | false")
@load_sheel(work_book, ur"工会副本宝箱")
def get_box_conf(content):
    box_id         = int(content[0])
    vip            = int(content[1])
    pre_dungeon_id = int(content[2])
    try:
        item_drop_list = str(int(content[3]))
    except:
        item_drop_list = str(content[3])
    try:
        hero_drop_list = str(int(content[4]))
    except:
        item_drop_list = str(content[4])
    union_coin     = int(content[5])
    coin           = str(content[6])
    box_conf.append("""get({0}, {1}) ->
    #dungeon_box{{
        box_id = {0}
        ,is_vip = {1}
        ,pre_dungeon_id = {2}
        ,item_drop_list = get_item_list({{{0}, {1}}})
        ,hero_drop_list = [{4}]
        ,union_coin = {5}
        ,coin = {{{6}}}
    }};""".format(box_id, vip, pre_dungeon_id, item_drop_list, hero_drop_list, union_coin, coin))
    return []

get_box_conf()
box_conf.append("get(_, _) -> false.")
data_dungeon_box.extend(box_conf)

item_drop_conf = {}
@load_sheel(work_book, ur"宝箱物品掉落")
def get_item_drop(content):
    item_id = int(content[0])
    name    = str(content[1])
    min_num = int(content[2])
    max_num = int(content[3])
    weight  = int(content[4])
    try:
        box_id_list = str(int(content[5]))
    except:
        box_id_list = str(content[5])

    for box_id in box_id_list.split("+"):
        box_id = box_id.strip()
        item_list = item_drop_conf.get(box_id, [])
        item_list.append("{%d, %d, %d, %d}"%(item_id, min_num, max_num, weight))
        item_drop_conf[box_id] = item_list
    return []
get_item_drop()

item_drop_list = []
for key in item_drop_conf.keys():
    item_drop_list.append("get_item_list(%s) -> [%s];"%(key, ",".join(item_drop_conf[key])))
item_drop_list.append("get_item_list(_) -> [].")
data_dungeon_box.extend(item_drop_list)

mail_list = []
mail_list.append("%% mail_list(DungeonID::int()) -> list()")
@load_sheel(work_book, ur"通关第一人奖励")
def get_mail_list(content):
    dungeon_id = int(content[0])
    coin       = int(content[1])
    union_coin = int(content[2])
    item       = str(get_value(content[3], ''))
    mail_list.append("mail_list(%d) -> [{coin, %d}, {union_coin, %d}] ++ [%s];"%(dungeon_id, coin, union_coin, item))
    return []
get_mail_list()
mail_list.append("mail_list(_) -> [].")
data_dungeon_box.extend(mail_list)


gen_erl(dungeon_box_erl, data_dungeon_box)
