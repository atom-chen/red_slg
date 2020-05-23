#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
任务配置
@author: ZhaoMing
@deprecated: 2013-11-20
'''
import os
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, module_php_header, gen_erl, gen_xml, prev, get_value, gen_php

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"task")

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
    task_id
    ,name
    ,needCount
    ,desc
    ,task_icon
    ,pre_task_id
    ,min_role_lev
    ,camp
    ,achieve
    ,exp_reward
    ,coin_reward
    ,gold_reward
    ,item_reward
    ,task_content
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

task_erl = "data_task"
data_task = module_header(ur"任务配置", task_erl, "zm", "task.xlsx", "data_task.py")
data_task.append("""
-include("task.hrl").

-export([get/1, get_all/0, get_max_id/1]).
""")

task_php = "base_task.cfg"
php_data_task = module_php_header(ur"任务配置", task_php, "zm", "task.xlsx", "data_task.py")

task_base = []
task_base.append("%% @spec get(TaskID :: int()) -> #task_base{} | false")
php_task_base = []
php_task_base.append("""return $base_task = array(
    0 => array('id' => 0, 'name' => ''),""")
task_id_list = []
max_id_list = []
@load_sheel(work_book, ur"任务配置")
def get_task(content):
    task_id = int(content[BaseField.task_id])
    task_name = str(content[BaseField.name])
    #pre_task_id = int(content[BaseField.pre_task_id])
    try:
        pre_task_id = str(int(content[BaseField.pre_task_id]))
    except:
        pre_task_id = str(get_value(content[BaseField.pre_task_id], ''))
    camp        = str(get_value(content[BaseField.camp], ''))
    achieve     = int(get_value(content[BaseField.achieve], 0))
    min_role_lev= int(get_value(content[BaseField.min_role_lev], 0))
    item_reward = str(get_value(content[BaseField.item_reward], ''))
    coin_reward = int(get_value(content[BaseField.coin_reward], 0))
    gold_reward = int(get_value(content[BaseField.gold_reward], 0))
    exp_reward  = int(get_value(content[BaseField.exp_reward], 0))
    target = str(content[BaseField.task_content])
    task_base.append("""get({0}) ->
    #task_base{{
        task_id = {0}
        ,achieve = {7}
        ,realm = [{8}]
        ,pre_task_id = [{1}]
        ,min_role_lev = {2}
        ,reward = [{{add_items, [{3}]}}, {{add_coin, {4}}}, {{add_gold, {5}}}, {{add_exp, {9}}}]
        ,target = [{6}]
    }};""".format(task_id, pre_task_id, min_role_lev, item_reward, coin_reward, gold_reward, target, achieve, camp, exp_reward))
    task_id_list.append("%d"%(task_id))
    max_id_list.append("{%d,%d}"%(achieve, task_id))
    php_task_base.append("    {0} => array('id' => {0}, 'name' => '{1}'),".format(task_id, task_name))
    return []

get_task()
task_base.append("get(_) -> false.")
php_task_base.append(");")
php_data_task.extend(php_task_base)

data_task.extend(task_base)
data_task.append("%% @spec get_all() -> list(). ")
data_task.append("get_all() -> [%s]."%(",".join(task_id_list)))

data_task.append("%% @spec get_max_id(ID) -> integer()")
data_task.append("get_max_id(ID) -> lists:max(proplists:append_values(ID, [%s]))."%(",".join(max_id_list)))

gen_erl(task_erl, data_task)
gen_php(task_php, php_data_task)
