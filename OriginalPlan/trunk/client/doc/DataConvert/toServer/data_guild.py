#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
公会配置
@author: Benqi
@deprecated: 2015-10-24
'''
import os
import __builtin__
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, module_php_header, gen_erl, gen_xml, prev, get_value, gen_php, get_str

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"guild")

# Erlang模块头说明，主要说明该文件作用，会自动添加-module(module_name).
# module_header函数隐藏了第三个参数，是指作者，因此也可以module_header(ur"礼包数据", module_name, "King")


# Erlang需要导出的函数接口, append与erlang的++也点类似，用于python的list操作
# Erlang函数一些注释，可以不写，但建议写出来

# def enum(module, str_enum):
#     str_enum = str_enum.replace(" ", "")
#     str_enum = str_enum.replace("\n", "")
#     idx = 0  
#     for name in str_enum.split(","):  
#         if '=' in name:  
#             name,val = name.rsplit('=', 1)            
#             if val.isalnum():               
#                 idx = eval(val)  
#         setattr(module, name.strip(), idx)  
#         idx += 1

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

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

BaseColumn = """
    index
    ,type
    ,policy_title
    ,policy_bg
    ,policy_confirm
    ,tech_list
"""

BaseColumn1 = """
    INDEX
    ,ID
    ,LEV
    ,UnionLev
    ,policycost
    ,policy_efford
    ,task_content
"""

BaseColumn2 = """
    donate_times
    ,donate_diamond
    ,donate_crystal
    ,donate_iron
    ,donate_uranium
    ,member_exp
    ,tech_exp
"""

BaseColumn3 = """
    index
    ,Name
    ,contribute_requried
    ,salary_coin
    ,salary_diamond
    ,salary
"""

BaseColumn4 = """
    id
    ,help_times 
    ,help_numdroprate
    ,reward_coin
    ,reward_contribute
    ,help_reducecd
"""

BaseColumn5 = """
    tran_score01
    ,tran_score02
    ,tran_score03
"""

BaseColumn6 = """
    id
    ,name
    ,d_bg
    ,star
    ,attack_buff
    ,training_name
    ,training_bg
    ,gift_lev
    ,gift_name
    ,gift_price
    ,reward_item
    ,price2
    ,attack_reward
"""

# 生成域枚举           
BaseField = Field('BaseField', BaseColumn)
BaseField1 = Field('BaseField1', BaseColumn1)
BaseField2 = Field('BaseField2', BaseColumn2)
BaseField3 = Field('BaseField3', BaseColumn3)
BaseField4 = Field('BaseField4', BaseColumn4)
BaseField5 = Field('BaseField5', BaseColumn5)
BaseField6 = Field('BaseField6', BaseColumn6)


guild_erl = "data_guild"
data_guild = module_header(ur"公会配置", guild_erl, "bq", "guild.xlsx", "data_guild.py")
data_guild.append("""-export([
    max_member/0, 
    get_max_donate_times/0, 
    get_tech/2, 
    get_donate/1, 
    get_salary/1,
    get_help_reward/0,
    get_help_times/0,
    get_help_cd/0,
    name_list/0,
    get_tech_list/0,
    name_extra_list/0,
    get_union_lev/0,
    get_max_train_times/0,
    get_max_buy_times/0,
    get_train_gold/1,
    get_buy_train_count/1,
    get_train/1,
    get_train_dungeon_id/1,
    get_train_id_list/0
    ]).
-include("union.hrl").""")


max_member = []
max_member.append("""
%% @doc 当前等级的最大成员个数
%% @spec max_member() -> GuildMember::int() """)

max_donate_times = []
max_donate_times.append("""
%% @doc 每日最大捐献次数
%% @spec max_member() -> MaxTimes::int() """)

union_lev_list = []
union_lev_list.append("""
%% @doc 公会等级配置
%% @spec get_union_lev() -> LevList::list()""")

get_max_train_times = []
get_max_train_times.append("""
%% @doc 军团训练场每日攻击次数
%% @spec get_max_train_times() -> Times::int()""")

@load_sheel(work_book, ur"公会基础配置")
def get_guild_base(content):
    global max_lev
    people      = int(content[1])
    donate_times= int(content[2])
    union_lev   = get_str(content[3], '')
    c_times     = int(content[4])
    max_donate_times.append("get_max_donate_times() -> %d."%( donate_times))
    max_member.append("max_member() -> %d."%(people))
    union_lev_list.append("get_union_lev() -> [%s]."%(union_lev))
    get_max_train_times.append("get_max_train_times() -> %d."%(c_times))
    return []
get_guild_base()

data_guild.extend(max_donate_times)
data_guild.extend(max_member)
data_guild.extend(union_lev_list)
data_guild.extend(get_max_train_times)


# tech_list = []
# tech_list.append("""
# %% @doc 政策主题基础配置
# %% @spec get_tech_list(ID::int()) -> [tech_id::int()] """)

# @load_sheel(work_book, ur"政策主题基础配置")
# def get_tech_base(content):
#     tech_type     = int(content[BaseField.type])
#     techlist      = get_str(content[BaseField.tech_list], '')
#     tech_list.append("get_tech_list(%d) -> tuple_to_list(%s);"%(tech_type, techlist))
#     return []
# get_tech_base()
# tech_list.append("get_tech_list(_) -> [].")
# data_guild.extend(tech_list)

tech_up_list = []
tech_list = []
tech_up_list.append("""
%% @doc 科技效果
%% @spec get_tech(ID::int(), LEV::int()) -> #tech_base{} """)

old_tech_id = 0
@load_sheel(work_book, ur"科技效果")
def get_tech(content):
    tech_id     = int(content[BaseField1.ID])
    tech_lev    = int(content[BaseField1.LEV])
    union_lev   = int(content[BaseField1.UnionLev])
    tech_exp    = int(content[BaseField1.policycost])
    effect      = get_str(content[BaseField1.task_content], '')
    global old_tech_id 
    if old_tech_id <> tech_id:
        old_tech_id = tech_id
        tech_list.append("%d"%(old_tech_id))

    tech_up_list.append("""get_tech(%d, %d) -> 
        #tech_base{
          id        = %d,
          lev       = %d,
          union_lev = %d,
          exp       = %d,
          effect    = [%s]
        };"""%(tech_id, tech_lev, tech_id, tech_lev, union_lev, tech_exp, effect))
    return []
get_tech()
data_guild.append("""
%% @doc 科技ID列表
%% @spec get_tech_list() -> TechList :: List()""")
data_guild.append("get_tech_list() -> [%s]."%(",".join(tech_list)))
tech_up_list.append("get_tech(_, _) -> false.")
data_guild.extend(tech_up_list)

donate_list = []
donate_list.append("""
%% @doc 捐献
%% @spec get_donate(Times::int()) -> #donate_base{} """)

max_donate_times = 0
@load_sheel(work_book, ur"捐献")
def get_donate(content):
    times       = int(content[BaseField2.donate_times])
    gold        = int(content[BaseField2.donate_diamond])
    crystal     = int(content[BaseField2.donate_crystal])
    iron        = int(content[BaseField2.donate_iron])
    uranium     = int(content[BaseField2.donate_uranium])
    member_exp  = int(content[BaseField2.member_exp])
    tech_exp    = int(content[BaseField2.tech_exp])
    donate_list.append("""get_donate(%d) -> 
        #donate_base{
           times    = %d,
           crystal  = %d,
           iron     = %d,
           uranium  = %d,
           gold     = %d,
           member_exp= %d,
           tech_exp = %d
        };"""%(times, times, crystal, iron, uranium, gold, member_exp, tech_exp))
    global max_donate_times
    max_donate_times = times
    return []
get_donate()
donate_list.append("get_donate(_) -> get_donate(%d)."%(max_donate_times))
data_guild.extend(donate_list)

salary_list = []
last_exp = 0
@load_sheel(work_book, ur"官阶俸禄")
def get_salary(content):
    exp         = int(content[BaseField3.contribute_requried])
    coin        = int(content[BaseField3.salary_coin])
    gold        = int(content[BaseField3.salary_diamond])
    union_coin  = int(content[BaseField3.salary])
    global last_exp
    last_exp = exp
    salary_list.append("""get_salary(Exp) when Exp >= %d -> [{add_coin, %d}, {add_gold, %d}, {add_union_coin, %d}];"""%(exp, coin, gold, union_coin))
    return []
get_salary()
salary_list.append("""
%% @doc 官阶俸禄
%% @spec get_salary(Exp::int()) -> [{xxx, Num::int()}] """)

salary_list = list(reversed(salary_list))
salary_list.append("get_salary(_) -> [].")
data_guild.extend(salary_list)

help_list = []
help_times_list = []
help_cd_list = []
@load_sheel(work_book, ur"互助")
def get_help_reward(content):
    help_times  = int(content[BaseField4.help_times])
    coin        = int(content[BaseField4.reward_coin])
    gold        = get_str(content[BaseField4.help_numdroprate], '')
    member_exp  = int(content[BaseField4.reward_contribute])
    help_cd     = int(content[BaseField4.help_reducecd])
    help_list.append("""get_help_reward() -> [%s, %d, %d]."""%(gold, coin, member_exp))
    help_times_list.append("""get_help_times() -> %d."""%(help_times))
    help_cd_list.append("""get_help_cd() -> %d."""%(help_cd))
    return []
get_help_reward()

data_guild.extend(help_list)
data_guild.extend(help_cd_list)
data_guild.extend(help_times_list)

# tech_exp_list = []
# @load_sheel(work_book, ur"科技积分")
# def get_help_reward(content):
#     global tech_score_id
#     tran_score01  = int(content[BaseField5.tran_score01])
#     tran_score02  = int(content[BaseField5.tran_score02])
#     tran_score03  = int(content[BaseField5.tran_score03])

#     tech_exp_list.append("""get_tech_exp(Nth) -> try lists:nth(Nth, [%d, %d, %d]) catch _:_ -> 0 end."""%(tran_score01, tran_score02, tran_score03))
#     return []
# get_help_reward()

# data_guild.extend(tech_exp_list)

name_list = []
name_extra_list = []
name_extra_list.append("<<>>")

@load_sheel(work_book, ur"公会随机名字")
def get_rand_name(content):
    name = get_str(content[0], '')
    extra = get_str(content[1], '')
    if name != "": 
        name_list.append("<<\"%s\">>"%(name))

    if extra != "": 
        name_extra_list.append("<<\"%s\">>"%(extra))

    return []

get_rand_name()

data_guild.append("""
%% @doc 随机名字
%% name_list() -> list()
name_list() -> [%s]. """%(",".join(name_list)))

data_guild.append("""
%% @doc 随机名字后缀
%% name_extra_list() -> list()
name_extra_list() -> [%s]. """%(",".join(name_extra_list)))

get_train_gold_list = []
get_train_gold_list.append("""
%% @doc 全通宝箱
%% @spec get_train_gold(TrainID::int()) -> Gold::int() """)

@load_sheel(work_book, ur"全通宝箱")
def get_train_gold(content):
    times       = int(content[0])
    gold        = int(content[1])
    get_train_gold_list.append("get_train_gold(%d) -> %d;"%(times, gold))
    return []
get_train_gold()
get_train_gold_list.append("get_train_gold(_) -> 0.")
data_guild.extend(get_train_gold_list)

max_buy_times = 0
get_buy_train_count_list = []
get_buy_train_count_list.append("""
%% @doc 军团训练场购买次数
%% @spec get_buy_train_count(BuyCount::int()) -> Gold::int() """)

@load_sheel(work_book, ur"军团训练场购买次数")
def get_train_count(content):
    times       = int(content[0])
    gold        = int(content[1])
    get_buy_train_count_list.append("get_buy_train_count(%d) -> %d;"%(times, gold))
    global max_buy_times
    max_buy_times = times
    return []
get_train_count()
get_buy_train_count_list.append("get_buy_train_count(_) -> 0.")
data_guild.extend(get_buy_train_count_list)

data_guild.append("""
%% @doc 军团训练场购买最大次数
%% @spec get_max_buy_times() -> Num::int()""")
data_guild.append("get_max_buy_times() -> %d."%(max_buy_times))

train_dungeon_list = []
train_dungeon_list.append("""
%% @doc 军团训练场副本ID列表
%% @spec get_train_dungeon_id(TrainID::int()) -> [DungeonID::int()]""")

dungeon_id_list = []
dungeon_id_list.append("""
%% @doc 军团训练场副本ID列表
%% @spec get_train() -> [DungeonID::int()] """)

get_train_id_list = []
get_train_id_list.append("""
%% @doc 军团训练场ID列表
%% @spec get_train_id_list() -> [TrainID::int()] """)
train_dungeon = {}

train_list = []
train_list.append("""
%% @doc 军团训练场基本配置
%% @spec get_train(DungeonID::int()) -> #train_conf{} | false """)
@load_sheel(work_book, ur"军团训练场奖励配置")
def get_train(content):
    id       = int(content[BaseField6.id])
    train_id = int(content[BaseField6.star])
    reward   = get_str(content[BaseField6.reward_item], '')
    two_gold = int(content[BaseField6.price2])
    normal_reward = get_str(content[BaseField6.attack_reward], '{0, 0}')

    train_list.append("""get_train(%d) -> #train_conf{
            dungeon_id = %d,
            train_id   = %d,
            reward_item= [%s],
            two_gold   = %d,
            normal_reward = %s
        };"""%(id, id, train_id, reward, two_gold, normal_reward))

    train_dungeon.setdefault(train_id, [])
    train_dungeon[train_id].append("%d"%(id))
    return []
get_train()
train_list.append("get_train(_) -> false.")
for i in train_dungeon:
    train_dungeon_list.append("get_train_dungeon_id(%d) -> [%s];"%(i, ",".join(train_dungeon[i])))

get_train_id_list.append("get_train_id_list() -> %s."%(train_dungeon.keys()))

train_dungeon_list.append("get_train_dungeon_id(_) -> [].")
data_guild.extend(train_list)
data_guild.extend(train_dungeon_list)
data_guild.extend(get_train_id_list)


gen_erl(guild_erl, data_guild)
