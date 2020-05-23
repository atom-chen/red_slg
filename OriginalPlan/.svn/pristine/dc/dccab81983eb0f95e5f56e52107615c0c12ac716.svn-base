#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
vip礼包配置表
@author: ZhaoMing
@deprecated: 2015年01月21日
'''
import os
import __builtin__
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, module_php_header, gen_erl, gen_xml, prev, get_value, gen_php, get_str

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"vip_gift_thai")

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

Index = """
    id
    ,name
    ,icon
    ,cost_gold
    ,need_vip
    ,max_buy_num
    ,gold
    ,coin
    ,show_gold
    ,items
    ,desc
    ,item
    """

VipField = Field('VipField' , Index)

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

vip_gift_erl = "data_vip_gift_thai"
data_vip_gift = module_header(ur"VIP礼包配置表", vip_gift_erl, "zm", "vip_gift_thai.xlsx", "data_vip_gift_thai.py")

data_vip_gift.append("""
-include("vip_gift.hrl").

-export([get/1, get_all/0]).
""")

vip_conf = []
all_vip = []
@load_sheel(work_book, ur"VIP礼包")
def get_conf(content):
    id = int(content[VipField.id])
    name = str(content[VipField.name])
    icon = int(content[VipField.icon])
    cost_gold = int(get_value(content[VipField.cost_gold], 0))
    need_vip = int(content[VipField.need_vip])
    max_buy_num = int(get_value(content[VipField.max_buy_num], 0))
    gold = int(get_value(content[VipField.gold], 0))
    coin = int(get_value(content[VipField.coin], 0))
    items = str(content[VipField.items])
    show_gold = int(get_value(content[VipField.show_gold], 0))
    desc = str(get_value(content[VipField.desc], ''))
    gift_id = int(content[VipField.item])

    vip_conf.append("""get(%d) -> #vip_gift{
    id = %d
    ,name = <<"%s">>
    ,icon = %d
    ,cost_gold = %d
    ,need_vip = %d
    ,max_buy_num = %d
    ,gold = %d
    ,coin = %d
    ,show_gold = %d
    ,items = [%s]
    ,desc = <<"%s">>
    ,gift_id = %d
    };"""%(id, id, name, icon, cost_gold, need_vip, max_buy_num, gold, coin, show_gold, items, desc, gift_id))
    all_vip.append("%d"%(id))
    return []

get_conf()
vip_conf.append("get(_) -> false.")
data_vip_gift.extend(vip_conf)
data_vip_gift.append("get_all() -> [%s]."%(",".join(all_vip)))

gen_erl(vip_gift_erl, data_vip_gift)
