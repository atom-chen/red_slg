#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
Facebook邀请
@author: ZhaoMing
@deprecated: 2015年01月21日
'''
import os
import __builtin__
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, module_php_header, gen_erl, gen_xml, prev, get_value, gen_php, get_str

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"fb_invite")

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

BaseIndex = """
    id,name,items,gold,coin,title,content
"""

BaseField    = Field('BaseField'    , BaseIndex)

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

fb_invite_php = "base_fb_invite.cfg"
data_php_fb_invite = module_php_header(ur"Facebook渠道", fb_invite_php, "zm", "fb_invite.xlsx", "data_fb_invite.py")

php_fb_invite_base = []
php_fb_invite_base.append("""return $base_fb_invite = array(
    0 => array('id' => 0, 'items' => '[]', 'gold' => 0, 'coin' => 0, 'mail_title' => '', 'mail_content' => ''), """)

@load_sheel(work_book, ur"Sheet1")
def get_base(content):
    id = get_str(content[BaseField.id], '')
    items = get_str(content[BaseField.items], '')
    gold = int(get_value(content[BaseField.gold], 0))
    coin = int(get_value(content[BaseField.coin], 0))
    mail_title = get_str(content[BaseField.title], '')
    mail_content = get_str(content[BaseField.content], '')

    php_fb_invite_base.append("    '{0}' => array('id' => '{0}', 'items' => '[{1}]', 'gold' => {2}, 'coin'=> {3}, 'mail_title'=> '{4}', 'mail_content' => '{5}'),".format(id, items, gold, coin, mail_title, mail_content))
    return []

get_base()

php_fb_invite_base.append(");")

data_php_fb_invite.extend(php_fb_invite_base)

gen_php(fb_invite_php, data_php_fb_invite)
