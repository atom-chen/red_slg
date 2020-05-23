#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
副本星星
@author: ZhaoMing
@deprecated: 2014-11-25
'''
import os
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, gen_erl, gen_xml, prev, get_value

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"dungeon_star")

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
    index
    ,id
    ,dungeonType
    ,dungeons
    ,stars
    ,drawType1
    ,itemList1
    ,gold1
    ,coin1
    ,drawType2
    ,itemList2
    ,gold2
    ,coin2
    ,drawType3
    ,itemList3
    ,gold3
    ,coin3
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

star_erl = "data_dungeon_star"
data_star = module_header(ur"副本星星", star_erl, "zm", "dungeon_star.xlsx", "data_dungeon_star.py")
data_star.append("""
-export([get_all_chapter/0, get_all_draw_list/0, get_draw_list/1, get_dungeonid_list/1, get_reward_list/2, get_chapter/1]).
""")

all_chapter = []

draw_list = []

all_draw_list = []

dungeon_id_list = []

reward_list = []

get_chapter = []

@load_sheel(work_book, ur"Sheet1")
def get_star(content):
    chapter_id = int(content[BaseField.id])
    dungeon_type = int(content[BaseField.dungeonType])

    dungeon_list = str(content[BaseField.dungeons])
    draw_type_1 = int(content[BaseField.drawType1])
    item_list_1 = str(content[BaseField.itemList1])
    gold_1 = int(content[BaseField.gold1])
    coin_1 = int(content[BaseField.coin1])
    draw_type_2 = int(content[BaseField.drawType2])
    item_list_2 = str(content[BaseField.itemList2])
    gold_2 = int(content[BaseField.gold2])
    coin_2 = int(content[BaseField.coin2])
    draw_type_3 = int(content[BaseField.drawType3])
    item_list_3 = str(content[BaseField.itemList3])
    gold_3 = int(content[BaseField.gold3])
    coin_3 = int(content[BaseField.coin3])
    all_chapter.append("{%d, %d}"%(chapter_id, dungeon_type))
    draw_list.append("get_draw_list({%d, %d}) -> [{%d, %d}, {%d, %d}, {%d, %d}];"%(chapter_id, dungeon_type, draw_type_1, draw_type_1, draw_type_2, draw_type_2, draw_type_3, draw_type_3))
    all_draw_list.append("{{{0}, {1}}}, {{{0}, {2}}}, {{{0}, {3}}}".format("{%d, %d}"%(chapter_id, dungeon_type), draw_type_1, draw_type_2, draw_type_3))
    dungeon_id_list.append("get_dungeonid_list({%d, %d}) -> [%s];"%(chapter_id, dungeon_type, dungeon_list))
    reward_list.append("get_reward_list({%d, %d}, %d) -> [{add_items, [%s]}, {add_gold, %d}, {add_coin, %d}];"%(chapter_id, dungeon_type, draw_type_1, item_list_1, gold_1, coin_1))
    reward_list.append("get_reward_list({%d, %d}, %d) -> [{add_items, [%s]}, {add_gold, %d}, {add_coin, %d}];"%(chapter_id, dungeon_type, draw_type_2, item_list_2, gold_2, coin_2))
    reward_list.append("get_reward_list({%d, %d}, %d) -> [{add_items, [%s]}, {add_gold, %d}, {add_coin, %d}];"%(chapter_id, dungeon_type, draw_type_3, item_list_3, gold_3, coin_3))
    get_chapter.append("get_chapter(DungeonID) when DungeonID =:= %s -> {%d, %d};"%(dungeon_list.replace(",", "\n" + " " * 21 + "orelse DungeonID =:= "), chapter_id, dungeon_type))
    return []

get_star()
data_star.append("get_all_chapter() -> [%s]."%(", ".join(all_chapter)))
data_star.append("get_all_draw_list() -> [%s]."%(", ".join(all_draw_list)))

draw_list.append("get_draw_list(_) -> [].")
dungeon_id_list.append("get_dungeonid_list(_) -> [].")
reward_list.append("get_reward_list(_, _) -> [].")
get_chapter.append("get_chapter(_) -> {0, 0}.")

data_star.extend(draw_list)
data_star.extend(dungeon_id_list)
data_star.extend(reward_list)
data_star.extend(get_chapter)

gen_erl(star_erl, data_star)
