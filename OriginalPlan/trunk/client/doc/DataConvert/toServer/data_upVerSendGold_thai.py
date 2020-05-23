#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
更新版本送元宝
@author: ZhaoMing
@deprecated: 2015年01月21日
'''
import os
import __builtin__
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, module_php_header, gen_erl, gen_xml, prev, get_value, gen_php, get_str

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"upVerSendGold_thai")

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
    ver,gold,title,content
"""

BaseField    = Field('BaseField'    , BaseIndex)

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

up_ver_send_gold_erl = "data_up_ver_send_gold_thai"
data_up_ver_send_gold = module_header(ur"更新版本配置", up_ver_send_gold_erl, "zm", "new_chest.xlsx", "data_up_ver_send_gold_thai.py")

data_up_ver_send_gold.append("""
-include("mail.hrl").

-export([
         can_send/1,
         send_mail/2
        ]).
"""
)

send_mail_list = []
send_mail_list.append("""
%% @doc 发送邮件
%% @spec send_mail(RoleID::int()) -> ok.  """)

can_send_list = []
can_send_list.append("""
%% @doc 是否可以发送邮件
%% @spec can_send(Ver::binary()) -> true | false """)

@load_sheel(work_book, ur"更新版本")
def get_base(content):
    ver = get_str(content[BaseField.ver], '')
    mail_title = get_str(content[BaseField.title], '')
    mail_content = get_str(content[BaseField.content], '')
    gold = int(content[BaseField.gold])

    if ver != '':
        can_send_list.append("can_send(Ver) when Ver =:= <<\"%s\">> -> true;"%(ver))
    
    send_mail_list.append("""send_mail(RoleID, Ver) when Ver =:= <<"%s">> ->
    catch lib_mail:send_mail(0, RoleID, <<"%s">>, <<"%s">>, [{gold, %d}], ?MAIL_TYPE_SYSTEM); """%(ver, mail_title, mail_content, gold))

    return []

get_base()
send_mail_list.append("send_mail(_, _) -> ok.")
can_send_list.append("can_send(_) -> false.")

data_up_ver_send_gold.extend(send_mail_list)
data_up_ver_send_gold.extend(can_send_list)


gen_erl(up_ver_send_gold_erl, data_up_ver_send_gold)
