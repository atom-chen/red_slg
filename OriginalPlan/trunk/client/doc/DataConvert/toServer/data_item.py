#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
副本配置
@author: ZhaoMing
@deprecated: 2013-11-20
'''
import os
import __builtin__
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, module_php_header, gen_erl, gen_xml, prev, get_value, gen_php, get_str

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"item")

# Erlang模块头说明，主要说明该文件作用，会自动添加-module(module_name).
# module_header函数隐藏了第三个参数，是指作者，因此也可以module_header(ur"礼包数据", module_name, "kingwen")


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
    id
    ,icon
    ,name
    ,desc
    ,type
    ,quality
    ,level
    ,star
    ,sale_coin
    ,drop_dungeon
    ,useType
    ,useObtainType
    ,obtainValue
    ,get
    ,isGift
    ,giftContent
    ,giftNum
    ,giftTip
    ,giftUseLevel
    ,maxStar
    ,useItem
"""
# 生成域枚举           
BaseField = Field('BaseField', BaseColumn)

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

item_erl = "data_item"
data_item = module_header(ur"物品配置", item_erl, "zm", "item.xlsx", "data_item.py")
data_item.append("""
-include("item.hrl").

-export([get/1, get_type/1, get_quality/1, get_item_ids_by_quality/1]).

get_type(ItemID) ->
    case ?MODULE:get(ItemID) of
        #item{type = Type} -> Type;
        _ -> 0
    end.

get_quality(ItemID) ->
    case ?MODULE:get(ItemID) of
        #item{quality = Quality} -> Quality;
        _ -> 0
    end.


""")

item_php = "base_item.cfg"
data_php_item = module_php_header(ur"物品配置", item_php, "zm", "item.xlsx", "data_item.py")

item_base = []
php_item_base = []
php_item_base.append("""return $base_item = array(
    0 => array('id' => 0, 'name'=> '', 'type' => '0', 'quality' => '0'),""")
item_base.append("%% @spec get(ItemID :: int()) -> #item{} | false")

item_quality = {}

@load_sheel(work_book, ur"Sheet1")
def get_item(content):
    item_id = int(content[BaseField.id])
    item_name = str(content[BaseField.name])
    sale_coin = int(get_value(content[BaseField.sale_coin], 0))
    use_obtain_type = int(get_value(content[BaseField.useObtainType], 0))
    use_obtain_value = int(get_value(content[BaseField.obtainValue], 0))
    item_type = int(content[BaseField.type])
    level = int(get_value(content[BaseField.level], 1))
    star = int(get_value(content[BaseField.star], 0))
    quality = int(get_value(content[BaseField.quality], 0))
    is_gift = int(get_value(content[BaseField.isGift], 0))
    gift_content = str(get_value(content[BaseField.giftContent], ''))
    gift_num = int(get_value(content[BaseField.giftNum], 0))
    use_lev = int(get_value(content[BaseField.giftUseLevel], 0))
    use_type = int(get_value(content[BaseField.useType], 0))
    use_item_list = get_str(content[BaseField.useItem], '')
    item_quality.setdefault(quality, [])
    item_quality[quality].append("%d"%(item_id))

    item_base.append("""get({0}) ->
    #item{{
        item_id = {0}
        ,sale_coin = {1}
        ,use_obtain_type = {2}
        ,use_obtain_value = {3}
        ,type = {4}
        ,quality = {5}
        ,is_gift = {6}
        ,item_list = [{7}]
        ,open_num = {8}
        ,use_lev = {9}
        ,use_type = {10}
        ,default_lev = {11}
        ,default_star = {12}
        ,unlock_item_list = [{13}]
    }}; """.format(item_id, sale_coin, use_obtain_type, use_obtain_value, item_type, quality, is_gift, gift_content, gift_num, use_lev, use_type, level, star, use_item_list))
    php_item_base.append("""    {0} => array('id' => {0}, 'name' => '{1}', 'type' => '{2}', 'quality' => '{3}'),""".format(item_id, item_name, item_type, quality))
    php_item_base.append("""    '{1}' => array('id' => {0}, 'name' => '{1}', 'type' => '{2}', 'quality' => '{3}'),""".format(item_id, item_name, item_type, quality))
    return []

get_item()
item_base.append("get(_) -> false.")
data_item.extend(item_base)

data_item.append("""
%% @doc 根据Quality获得ItemID
%% @spec get_item_ids_by_quality(Quality::int()) -> [ItemID::int()] """)
for i in item_quality:
    data_item.append("get_item_ids_by_quality(%d) -> [%s];"%(i, ",".join(item_quality[i]) ) )
data_item.append("get_item_ids_by_quality(_) -> [].")

php_item_base.append(");")
data_php_item.extend(php_item_base)

gen_erl(item_erl, data_item)
gen_php(item_php, data_php_item)
