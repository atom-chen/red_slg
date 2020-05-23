#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
精彩活动配置表
@author: ZhaoMing
@deprecated: 2015年01月21日
'''
import os
import __builtin__
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, module_php_header, gen_erl, gen_xml, prev, get_value, gen_php, get_str

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"fun_activity")

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

ChargeRebateIndex = """
    id
    ,name
    ,acc_charge_gold
    ,coin
    ,gold
    ,items
    ,title
    ,content
    ,icon
    ,acc_content
    """
CostRebateIndex   = """
    id
    ,name
    ,cost_gold
    ,coin
    ,gold
    ,items
    ,title
    ,content
    ,icon
    ,acc_content
    """
DoubleDropIndex   = """
    id
    ,name
    ,dungeon_id_list
    ,dungeon_type
    ,mul
    ,icon
    ,acc_content
    """
LoginRewardIndex  = """
    id
    ,name
    ,coin
    ,gold
    ,items
    ,title
    ,content
    ,icon
    ,acc_content
    """
ShopRebateIndex   = """
    id
    ,name
    ,shop_id
    ,item_id_list
    ,discount
    ,icon
    ,acc_content
    """
ArenaRewardIndex  = """
    id
    ,name
    ,mul
    ,icon
    ,acc_content
    """
ContLoginIndex    = """
    id
    ,name
    ,days
    ,coin
    ,gold
    ,items
    ,title
    ,content
    ,icon
    ,acc_content
    """
AccLoginIndex    = """
    id
    ,name
    ,days
    ,coin
    ,gold
    ,items
    ,title
    ,content
    ,icon
    ,acc_content
    """
HeroStarIndex = """
    id
    ,name
    ,star
    ,max_finish_count
    ,items
    ,icon
    ,acc_content
    ,desc
"""

HeroCollectIndex = """
    id
    ,name
    ,hero_num
    ,gold
    ,coin
    ,items
    ,icon
    ,acc_content
    ,desc
"""

PowerRankIndex =  """
    id
    ,name
    ,rank
    ,gold
    ,coin
    ,items
    ,title
    ,content
    ,icon
    ,acc_content
    ,desc
    ,index_title
"""

ArenaRankIndex =  """
    id
    ,name
    ,rank
    ,gold
    ,coin
    ,items
    ,title
    ,content
    ,icon
    ,acc_content
    ,desc
    ,index_title
"""


CoinDoubleIndex   = """
    id
    ,name
    ,dungeon_id_list
    ,dungeon_type
    ,mul
    ,icon
    ,acc_content
    """
FirstChargeIndex = """
    id
    ,name
    ,coin
    ,items
    ,title
    ,content
    ,icon
    ,acc_content
    ,desc
    ,hero_id
"""

RoleLevelIndex = """
    id
    ,name
    ,level
    ,coin
    ,gold
    ,items
    ,icon
    ,acc_content
    ,desc
    ,index_title
"""

TotalChargeIndex = """
    id
    ,name
    ,rmb
    ,coin
    ,gold
    ,items
    ,icon
    ,acc_content
    ,desc
    ,index_title
"""

TotalCostIndex = """
    id
    ,name
    ,cost_gold
    ,coin
    ,gold
    ,items
    ,icon
    ,acc_content
    ,desc
    ,index_title
"""

GrowthFundIndex = """
    id
    ,name
    ,cost_gold
    ,vip_lev
    ,level
    ,gold
    ,coin
    ,items
    ,icon
    ,acc_content
    ,desc
    ,index_title
"""

CollectIndex = """
    id
    ,name
    ,index
    ,need_items
    ,coin 
    ,gold
    ,items
    ,times 
    ,icon
    ,acc_content
    ,desc
"""

LuckyDialIndex = """
    id
    ,name
    ,free_times
    ,cost_item
    ,cost_gold
    ,items
    ,limit_list 
    ,icon
    ,acc_content
    ,desc 
"""

FortuneIndex = """
    id
    ,name
    ,index
    ,cost_gold
    ,get_gold
    ,vip_lev
    ,icon
    ,acc_content
    ,desc
"""

TreasureIndex = """
    id
    ,name
    ,free_item
    ,cost_gold
    ,buy_coin
    ,buy_item
    ,items
    ,extra_times
    ,extra_items
    ,hero_id
    ,rank_min_times
    ,rank
    ,gold
    ,coin
    ,rank_items
    ,title
    ,content
    ,icon
    ,acc_content
    ,desc
    ,index_title
"""

PublicTreasureIndex = """
    type
    ,item_id
    ,min
    ,max
    ,rate
    ,min_times
"""

PublicDrawIndex = """
    item_id
    ,rate 
    ,min_times
"""

SevenDayIndex = """
    id
    ,name
    ,day
    ,icon
    ,day_titile
    ,acc_titile
    ,acc_content
    ,desc
    ,index
    ,target
    ,items
    ,scores
    ,index_title
    ,panel
"""

SevenDayShopIndex = """
    id
    ,day
    ,index
    ,cost_items
    ,get_items
    ,max_times
"""

SevenDayRankIndex = """
    id
    ,rank
    ,items
    ,scores
    ,final_items
    ,titile
    ,content
"""

ChargeDiscountIndex = """
    id
    ,name
    ,day
    ,coin
    ,gold
    ,items
    ,icon
    ,acc_content
    ,desc
    ,index_title
    ,bonus
    ,hero_id
    ,picture
"""

SevenCoinIndex = """
    id
    ,name
    ,day
    ,coin_weight
    ,icon
    ,acc_content
    ,desc
"""

DailyChargeIndex = """
    id
    ,name
    ,charge_gold
    ,coin
    ,gold
    ,items
    ,icon
    ,acc_content
    ,desc
    ,index_title
    ,titile
    ,content
"""

DailyTChargeIndex = """
    id
    ,name
    ,rmb
    ,coin
    ,gold
    ,items
    ,icon
    ,acc_content
    ,desc
    ,index_title
"""

DailyTCostIndex = """
    id
    ,name
    ,cost_gold
    ,coin
    ,gold
    ,items
    ,icon
    ,acc_content
    ,desc
    ,index_title
"""

ChargeAwardIndex = """
    id
    ,name
    ,charge_day
    ,day
    ,coin
    ,gold
    ,items
    ,icon
    ,acc_content
    ,desc
    ,index_title
    ,hero_id
    ,picture
"""

PaperDialIndex = """
    id
    ,name
    ,change_time
    ,gold
    ,ten_gold
    ,score
    ,score_weight
    ,type
    ,items
    ,score_items
    ,icon
    ,acc_content
    ,desc 
"""

LimitedShopIndex = """
    id
    ,name
    ,index
    ,item_id
    ,item_num
    ,buy_times
    ,price
    ,reprice
    ,vip
    ,titile
    ,icon
    ,acc_content
    ,desc
"""

ChargeRewardIndex = """
    id
    ,name
    ,index
    ,gold
    ,item
    ,titile
    ,last_time
    ,icon
    ,acc_content
    ,desc
"""

HeroMaxNumIndex = """
    id
    ,name
    ,level
    ,icon
    ,acc_content
    ,desc
"""

HeroEliteIndex = """
    id
    ,name
    ,level
    ,icon
    ,acc_content
    ,desc
"""


ChargeRebateField = Field('ChargeRebateField' , ChargeRebateIndex)
CostRebateField   = Field('CostRebateField'   , CostRebateIndex)
DoubleDropField   = Field('DoubleDropField'   , DoubleDropIndex)
LoginRewardField  = Field('LoginRewardField'  , LoginRewardIndex)
ShopRebateField   = Field('ShopRebateField'   , ShopRebateIndex)
ArenaRewardField  = Field('ArenaRewardField'  , ArenaRewardIndex)
ContLoginField    = Field('ContLoginField'    , ContLoginIndex)
AccLoginField     = Field('ContLoginField'    , AccLoginIndex)
CoinDoubleField   = Field('CoinDoubleField'   , CoinDoubleIndex)
FirstChargeField  = Field('FirstChargeField'  , FirstChargeIndex)
HeroStarField     = Field('HeroStarField'     , HeroStarIndex)
HeroCollectField  = Field('HeroCollectField'  , HeroCollectIndex)
PowerRankField    = Field('PowerRankField'    , PowerRankIndex)
ArenaRankField    = Field('ArenaRankField'    , ArenaRankIndex)
RoleLevelField    = Field('RoleLevelField'    , RoleLevelIndex)
TotalChargeField  = Field('TotalChargeField'  , TotalChargeIndex)
DailyTChargeField = Field('DailyTChargeField' , DailyTChargeIndex)
DailyTCostField   = Field('DailyTCostField'   , DailyTCostIndex)
TotalCostField    = Field('TotalCostField'    , TotalCostIndex)
GrowthFundField   = Field('GrowthFundField'   , GrowthFundIndex)
CollectField      = Field('CollectField'      , CollectIndex)
LuckyDialField    = Field('LuckyDialField'    , LuckyDialIndex)
FortuneField      = Field('FortuneField'      , FortuneIndex)
TreasureField     = Field('TreasureField'     , TreasureIndex)
PublicTreasureField=Field('PublicTreasureField', PublicTreasureIndex)
PublicDrawField   = Field('PublicDrawField'   , PublicDrawIndex)
SevenDayField     = Field('SevenDayField'     , SevenDayIndex)
SevenDayShopField = Field('SevenDayShopField' , SevenDayShopIndex)
SevenDayRankField = Field('SevenDayRankField' , SevenDayRankIndex)
ChargeDiscountField=Field('ChargeDiscountField', ChargeDiscountIndex)
SevenCoinField    = Field('SevenCoinField'    , SevenCoinIndex)
DailyChargeField  = Field('DailyChargeField'  , DailyChargeIndex)
ChargeAwardField  = Field('ChargeAwardField'  , ChargeAwardIndex)
PaperDialField    = Field('PaperDialField'    , PaperDialIndex)
LimitedShopField  = Field('LimitedShopField'  , LimitedShopIndex)
ChargeRewardField = Field('ChargeRewardField' , ChargeRewardIndex)
HeroMaxNumField   = Field('HeroMaxNumField'   , HeroMaxNumIndex)
HeroEliteField    = Field('HeroEliteField'    , HeroEliteIndex)

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

fun_activity_erl = "data_fun_activity"
data_fun_activity = module_header(ur"精彩活动配置", fun_activity_erl, "zm", "fun_activity.xlsx", "data_fun_activity.py")

act_php = "base_act.cfg"
php_data_act = module_php_header(ur"活动配置", act_php, "zm", "fun_activity.xlsx", "data_fun_activity.py")

export = """
-export([
         charge_mail/2
         ,cost_mail/2
         ,drop_did_list/1
         ,drop_mul/1
         ,drop_type_list/1
         ,login_mail/1
         ,shop_discount_items/2
         ,shop_discount/2
         ,arena_mul/1
         ,cont_login_mail/2
         ,acc_login_mail/2
         ,double_coin_did_list/1
         ,double_coin_dungeon_type/1
         ,double_coin_mul/1
         ,get_type/1
         ,charge_rebate_steps/1
         ,cost_rebate_steps/1
         ,get_icon/1
         ,get_name/1
         ,first_charge_reward/1
         ,get_fun_content/1
         ,shop_discount_shop_list/1
         ,hero_star_reward/2
         ,hero_star_max_draw/2
         ,hero_stars/1
         ,hero_collect_reward/2
         ,hero_collect_num_list/1
         ,power_rank_reward/2
         ,power_rank_title/2
         ,power_rank_content/2
         ,power_max_rank/1
         ,power_rank_list/1
         ,power_rank_index_title/2
         ,arena_rank_reward/2
         ,arena_rank_title/2
         ,arena_rank_content/2
         ,arena_max_rank/1
         ,arena_rank_list/1
         ,arena_rank_index_title/2
         ,role_level_reward/2
         ,role_level_index_title/2
         ,role_level_list/1
         ,total_charge_reward/2
         ,total_charge_index_title/2
         ,total_charge_list/1
         ,total_cost_reward/2
         ,total_cost_index_title/2
         ,total_cost_list/1
         ,daily_t_charge_index_title/2
         ,daily_t_charge_reward/2
         ,daily_t_charge_list/1
         ,daily_t_cost_index_title/2
         ,daily_t_cost_reward/2
         ,daily_t_cost_list/1
         ,growth_fund_reward/2
         ,growth_fund_index_title/2
         ,growth_fund_list/1
         ,growth_fund_cost/1
         ,growth_fund_vip/1
         ,collect_reward_list/2
         ,collect_cost_list/2
         ,collect_max_times/2
         ,collect_list/1
         ,lucky_item_list/1
         ,lucky_cost/1
         ,lucky_limit_list/1
         ,lucky_free_times/1
         ,get_fortune_cost_gold/2
         ,get_fortune_reward_gold/2
         ,fortune_list/1
         ,get_fortune_vip/2
         ,treasure_rank_reward_list/2
         ,treasure_rank_title/2
         ,treasure_index_list/2
         ,treasure_content/2
         ,get_treasure_extra/1
         ,get_treasure_items/1
         ,get_treasure_hero_id/1
         ,treasure_buy_list/1
         ,treasure_min_rank_times/1
         ,public_treasure_list/1
         ,public_draw_list/0
         ,treasure_free_item/1
         ,treasure_rank_list/1
         ,get_seven_day_content/2
         ,get_seven_day_titile/2
         ,get_seven_day_target/3
         ,get_seven_day_items/3
         ,get_seven_day_scores/3
         ,get_seven_day_index_titile/3
         ,get_seven_day_day_titile/2
         ,seven_day_index_list/2
         ,seven_day_list/1
         ,get_seven_day_cost_item/3
         ,get_seven_day_get_item/3
         ,get_seven_day_shop_times/3
         ,seven_day_shop_index_list/2
         ,seven_day_rank_titile/1
         ,seven_day_rank_content/1
         ,seven_day_rank_reward/2
         ,seven_day_rank_list/1
         ,seven_day_final_reward/1
         ,seven_day_final_score/1
         ,get_seven_day_panel/3
         ,discount_reward_list/2
         ,discount_index_title/2
         ,get_discount_bonus/1
         ,discount_day_list/1
         ,get_discount_hero_id/1
         ,get_discount_picture/1
         ,get_seven_coin_weight/2
         ,seven_coin_day_list/1
         ,daily_charge_reward/2
         ,daily_charge_index_title/2
         ,daily_charge_mail_title/2
         ,daily_charge_mail_content/2
         ,daily_charge_list/1
         ,charge_award_reward/2
         ,charge_award_list/1
         ,charge_award_picture/1
         ,charge_award_hero_id/1
         ,charge_award_day/1
         ,first_charge_hero_id/1
         ,get_paper_dial_change_time/1
         ,get_paper_dial_gold/1
         ,get_paper_dial_ten_gold/1
         ,get_paper_dial_score/1
         ,get_paper_dial_score_weight/1
         ,get_paper_dial_item_list/2
         ,get_paper_dial_score_items/2
         ,paper_dial_type_list/1
         ,get_limited_shop/2
         ,limited_shop_list/1
         ,get_charge_reward/2
         ,charge_reward_list/1
         ,hero_max_num_level/1
         ,hero_elite_qua_level/1
        ]).

"""
data_fun_activity.append(export)

type_list = []
icon_list = []
name_list = []
fun_content_list = []

php_base_list = []
php_base_list.append("""
return $base_act = array(
    0 => array('id' => 0, 'name' => ''),""")
## ##################################
## 充值返利
## ##################################

charge_mail_list = []

charge_all_step = {}
@load_sheel(work_book, ur"充值返利")
def get_charge_rebate(content, all_content, row):
    id              = int(prev(all_content, row, ChargeRebateField.id))
    name            = get_str(content[ChargeRebateField.name], '')
    charge_gold     = int(content[ChargeRebateField.acc_charge_gold])
    coin            = int(get_value(content[ChargeRebateField.coin], 0))
    gold            = int(get_value(content[ChargeRebateField.gold], 0))
    item_list       = get_str(content[ChargeRebateField.items], '')
    title           = str(content[ChargeRebateField.title])
    mail_content    = str(content[ChargeRebateField.content])
    icon            = int(prev(all_content, row, ChargeRebateField.icon))
    fun_content     = get_str(content[ChargeRebateField.acc_content], '')

    charge_mail_list.append("charge_mail(%d, %d) -> {<<\"%s\">>, <<\"%s\">>, [{coin, %d}, {gold, %d}] ++ [%s]};"%(id, charge_gold, title, mail_content, coin, gold, item_list))
    type_list.append("get_type(%d) -> 1;"%(id))
    icon_list.append("get_icon(%d) -> %d;"%(id, icon))
    if name <> '': 
        name_list.append("get_name(%d) -> <<\"%s\">>;"%(id, name))
        php_base_list.append("    %d => array('id' => %d, 'name' => '%s'),"%(id, id, name))
    if fun_content <> '':
        fun_content_list.append("get_fun_content(%d) -> <<\"%s\">>;"%(id, fun_content))
    charge_all_step.setdefault(id, [])
    charge_all_step[id].append("%d"%(charge_gold))
    return []

get_charge_rebate()
charge_mail_list.append("charge_mail(_, _) -> false.")

for i in charge_all_step:
    data_fun_activity.append("charge_rebate_steps(%d) -> [%s];"%(i, ",".join(charge_all_step[i])))
data_fun_activity.append("charge_rebate_steps(_) -> [].")

data_fun_activity.extend(charge_mail_list)

## ##################################
## 消费返利
## ##################################

cost_list = []
cost_rebate_steps = {}
@load_sheel(work_book, ur"消费返利")
def get_cost_rebate(content, all_content, row):
    id = int(prev(all_content, row, CostRebateField.id))
    name = get_str(content[CostRebateField.name], '')
    cost_gold = int(content[CostRebateField.cost_gold])
    coin = int(get_value(content[CostRebateField.coin], 0))
    gold = int(get_value(content[CostRebateField.gold], 0))
    item_list = get_str(content[CostRebateField.items], '')
    title = str(content[CostRebateField.title])
    mail_content = str(content[CostRebateField.content])
    icon = int(prev(all_content, row, CostRebateField.icon))
    fun_content = get_str(content[CostRebateField.acc_content], '')

    cost_list.append("cost_mail(%d, %d) -> {<<\"%s\">>, <<\"%s\">>, [{coin, %d}, {gold, %d}] ++ [%s]};"%(id, cost_gold, title, mail_content, coin, gold, item_list))
    type_list.append("get_type(%d) -> 2;"%(id))
    icon_list.append("get_icon(%d) -> %d;"%(id, icon))
    if name <> '': 
        name_list.append("get_name(%d) -> <<\"%s\">>;"%(id, name))
        php_base_list.append("    %d => array('id' => %d, 'name' => '%s'),"%(id, id, name))
    if fun_content <> '':
        fun_content_list.append("get_fun_content(%d) -> <<\"%s\">>;"%(id, fun_content))
    cost_rebate_steps.setdefault(id, [])
    cost_rebate_steps[id].append("%d"%(cost_gold))
    return []
get_cost_rebate()
cost_list.append("cost_mail(_, _) -> false.")

for i in cost_rebate_steps:
    data_fun_activity.append("cost_rebate_steps(%d) -> [%s];"%(i, ",".join(cost_rebate_steps[i])))
data_fun_activity.append("cost_rebate_steps(_) -> [].")

data_fun_activity.extend(cost_list)

## ##################################
## 双倍掉落
## ##################################
drop_did_list = []
drop_mul_list = []
drop_type_list = []
@load_sheel(work_book, ur"双倍掉落")
def get_double_drop(content):
    id = int(content[DoubleDropField.id])
    name = get_str(content[DoubleDropField.name], '')
    dungeon_id_list = get_str(content[DoubleDropField.dungeon_id_list], '')
    dungeon_type = get_str(content[DoubleDropField.dungeon_type], '')
    mul = int(content[DoubleDropField.mul])
    icon = int(content[DoubleDropField.icon])
    fun_content = get_str(content[DoubleDropField.acc_content], '')
    drop_did_list.append("drop_did_list(%d) -> [%s];"%(id, dungeon_id_list))
    drop_mul_list.append("drop_mul(%d) -> %d;"%(id, mul))
    drop_type_list.append("drop_type_list(%d) -> [%s];"%(id, dungeon_type))
    type_list.append("get_type(%d) -> 3;"%(id))
    icon_list.append("get_icon(%d) -> %d;"%(id, icon))
    if name <> '': 
        name_list.append("get_name(%d) -> <<\"%s\">>;"%(id, name))
        php_base_list.append("    %d => array('id' => %d, 'name' => '%s'),"%(id, id, name))
    if fun_content <> '':
        fun_content_list.append("get_fun_content(%d) -> <<\"%s\">>;"%(id, fun_content))
    return []

get_double_drop()
drop_did_list.append("drop_did_list(_) -> [].")
drop_mul_list.append("drop_mul(_) -> 1.")
drop_type_list.append("drop_type_list(_) -> [].")

data_fun_activity.extend(drop_did_list)
data_fun_activity.extend(drop_mul_list)
data_fun_activity.extend(drop_type_list)

## ##################################
## 登陆奖励
## ##################################
login_mail_list = []
@load_sheel(work_book, ur"登录奖励")
def get_login_reward(content):
    id = int(content[LoginRewardField.id])
    name = get_str(content[LoginRewardField.name], '')
    coin = int(content[LoginRewardField.coin])
    gold = int(content[LoginRewardField.gold])
    item_list = get_str(content[LoginRewardField.items], '')
    title = str(content[LoginRewardField.title])
    mail_content = str(content[LoginRewardField.content])
    icon = int(content[LoginRewardField.icon])
    fun_content = get_str(content[LoginRewardField.acc_content], '')
    login_mail_list.append("login_mail(%d) -> {<<\"%s\">>, <<\"%s\">>, [{coin, %d}, {gold, %d}] ++ [%s]};"%(id, title, mail_content, coin, gold, item_list))
    type_list.append("get_type(%d) -> 4;"%(id))
    icon_list.append("get_icon(%d) -> %d;"%(id, icon))
    if name <> '': 
        name_list.append("get_name(%d) -> <<\"%s\">>;"%(id, name))
        php_base_list.append("    %d => array('id' => %d, 'name' => '%s'),"%(id, id, name))
    if fun_content <> '':
        fun_content_list.append("get_fun_content(%d) -> <<\"%s\">>;"%(id, fun_content))
    return []

get_login_reward()

login_mail_list.append("login_mail(_) -> false.")

data_fun_activity.extend(login_mail_list)

## #####################################
## 打折商店
## #####################################

shop_discount_items = []
shop_discount = []
shop_discount_shop_list = {}
@load_sheel(work_book, ur"商店打折")
def get_shop_discount(content, all_content, row):
    id = int(prev(all_content, row, ShopRebateField.id))
    name = get_str(content[ShopRebateField.name], '')
    shop_id = int(content[ShopRebateField.shop_id])
    item_id_list = get_str(content[ShopRebateField.item_id_list], '')
    discount = int(content[ShopRebateField.discount])
    icon = int(prev(all_content, row, ShopRebateField.icon))
    fun_content = get_str(content[ShopRebateField.acc_content], '')
    shop_discount_items.append("shop_discount_items(%d, %d) -> [%s];"%(id, shop_id, item_id_list))
    shop_discount.append("shop_discount(%d, %d) -> %d;"%(id, shop_id, discount))
    type_list.append("get_type(%d) -> 5;"%(id))
    icon_list.append("get_icon(%d) -> %d;"%(id, icon))
    if name <> '': 
        name_list.append("get_name(%d) -> <<\"%s\">>;"%(id, name))
        php_base_list.append("    %d => array('id' => %d, 'name' => '%s'),"%(id, id, name))
    if fun_content <> '':
        fun_content_list.append("get_fun_content(%d) -> <<\"%s\">>;"%(id, fun_content))
    shop_discount_shop_list.setdefault(id, [])
    shop_discount_shop_list[id].append("%d"%(shop_id))
    return []

get_shop_discount()
shop_discount_items.append("shop_discount_items(_, _) -> [].")
shop_discount.append("shop_discount(_, _) -> 10.")

for i in shop_discount_shop_list:
    data_fun_activity.append("shop_discount_shop_list(%d) -> [%s];"%(i, ",".join(shop_discount_shop_list[i])))
data_fun_activity.append("shop_discount_shop_list(_) -> [].")

data_fun_activity.extend(shop_discount_items)
data_fun_activity.extend(shop_discount)

## ######################################
## 竞技场奖励
## ######################################
arena_mul = []
@load_sheel(work_book, ur"竞技场奖励")
def get_arena_mul(content):
    id = int(content[ArenaRewardField.id])
    name = get_str(content[ArenaRewardField.name], '')
    mul = int(content[ArenaRewardField.mul])
    icon = int(content[ArenaRewardField.icon])
    fun_content = get_str(content[ArenaRewardField.acc_content], '')
    arena_mul.append("arena_mul(%d) -> %d;"%(id, mul))
    type_list.append("get_type(%d) -> 6;"%(id))
    icon_list.append("get_icon(%d) -> %d;"%(id, icon))
    if name <> '': 
        name_list.append("get_name(%d) -> <<\"%s\">>;"%(id, name))
        php_base_list.append("    %d => array('id' => %d, 'name' => '%s'),"%(id, id, name))
    if fun_content <> '':
        fun_content_list.append("get_fun_content(%d) -> <<\"%s\">>;"%(id, fun_content))
    return []
get_arena_mul()
arena_mul.append("arena_mul(_) -> 1.")

data_fun_activity.extend(arena_mul)

## ######################################
## 连续登陆奖励
## ######################################
cont_login_mail = []
@load_sheel(work_book, ur"连续登录")
def get_cont_login(content, all_content, row):
    id = int(prev(all_content, row, ContLoginField.id))
    name = get_str(content[ContLoginField.name], '')
    days = int(content[ContLoginField.days])
    coin = int(get_value(content[ContLoginField.coin], 0))
    gold = int(get_value(content[ContLoginField.gold], 0))
    item_list = get_str(content[ContLoginField.items], '')
    title = str(content[ContLoginField.title])
    mail_content = str(content[ContLoginField.content])
    icon = int(prev(all_content, row, ContLoginField.icon))
    fun_content = get_str(content[ContLoginField.acc_content], '')
    cont_login_mail.append("cont_login_mail(%d, %d) -> {<<\"%s\">>, <<\"%s\">>, [{coin, %d}, {gold, %d}] ++ [%s]};"%(id, days, title, mail_content, coin, gold, item_list))
    type_list.append("get_type(%d) -> 7;"%(id))
    icon_list.append("get_icon(%d) -> %d;"%(id, icon))
    if name <> '': 
        name_list.append("get_name(%d) -> <<\"%s\">>;"%(id, name))
        php_base_list.append("    %d => array('id' => %d, 'name' => '%s'),"%(id, id, name))
    if fun_content <> '':
        fun_content_list.append("get_fun_content(%d) -> <<\"%s\">>;"%(id, fun_content))
    return []
get_cont_login()
cont_login_mail.append("cont_login_mail(_, _) -> false.")

data_fun_activity.extend(cont_login_mail)

## ######################################
## 金币翻倍
## ######################################
double_coin_did_list = []
double_coin_dungeon_type = []
double_coin_mul = []
@load_sheel(work_book, ur"金币翻倍")
def get_dungeon_double_coin(content):
    id = int(content[CoinDoubleField.id])
    name = get_str(content[CoinDoubleField.name], '')
    dungeon_id_list = get_str(content[CoinDoubleField.dungeon_id_list], '')
    dungeon_type = get_str(content[CoinDoubleField.dungeon_type], '')
    mul = int(content[CoinDoubleField.mul])
    icon = int(content[CoinDoubleField.icon])
    fun_content = get_str(content[CoinDoubleField.acc_content], '')
    double_coin_did_list.append("double_coin_did_list(%d) -> [%s];"%(id, dungeon_id_list))
    double_coin_dungeon_type.append("double_coin_dungeon_type(%d) -> [%s];"%(id, dungeon_type))
    double_coin_mul.append("double_coin_mul(%d) -> %d;"%(id, mul))
    type_list.append("get_type(%d) -> 8;"%(id))
    icon_list.append("get_icon(%d) -> %d;"%(id, icon))
    if name <> '':  
        name_list.append("get_name(%d) -> <<\"%s\">>;"%(id, name))
        php_base_list.append("    %d => array('id' => %d, 'name' => '%s'),"%(id, id, name))
    if fun_content <> '':
        fun_content_list.append("get_fun_content(%d) -> <<\"%s\">>;"%(id, fun_content))
    return []
get_dungeon_double_coin()
double_coin_did_list.append("double_coin_did_list(_) -> [].")
double_coin_dungeon_type.append("double_coin_dungeon_type(_) -> [].")
double_coin_mul.append("double_coin_mul(_) -> 1.")

## ###########################
## 首次充值
## ###########################
first_charge_reward = []
first_charge_hero = []
old_id = 0
@load_sheel(work_book, ur"首次充值")
def get_first_charge(content):
    id = int(content[FirstChargeField.id])
    name = str(content[FirstChargeField.name])
    coin = int(get_value(content[FirstChargeField.coin], 0))
    items = get_str(content[FirstChargeField.items], '')
    title = get_str(content[FirstChargeField.title], '')
    mail_content = get_str(content[FirstChargeField.content], '')
    icon = int(content[FirstChargeField.icon])
    fun_content = get_str(content[FirstChargeField.acc_content], '')
    hero_id = int(content[FirstChargeField.hero_id])
    first_charge_reward.append("first_charge_reward(%d) -> [{coin, %s}, %s];"%(id, coin, items))
    global old_id 
    if old_id != id:
        first_charge_hero.append("first_charge_hero_id(%d) -> %d;"%(id, hero_id))
    type_list.append("get_type(%d) -> 9;"%(id))
    icon_list.append("get_icon(%d) -> %d;"%(id, icon))
    if name <> '':
        name_list.append("get_name(%d) -> <<\"%s\">>;"%(id, name))
        php_base_list.append("    %d => array('id' => %d, 'name' => '%s'),"%(id, id, name))
    if fun_content <> '':
        fun_content_list.append("get_fun_content(%d) -> <<\"%s\">>;"%(id, fun_content))
    return []

get_first_charge()
first_charge_reward.append("first_charge_reward(_) -> [].")
first_charge_hero.append("first_charge_hero_id(_) -> 0.")
data_fun_activity.extend(first_charge_reward)
data_fun_activity.extend(first_charge_hero)

## ######################################
## 累计登陆奖励
## ######################################
acc_login_mail = []
@load_sheel(work_book, ur"累计登录")
def get_acc_login(content, all_content, row):
    id = int(prev(all_content, row, AccLoginField.id))
    name = get_str(content[AccLoginField.name], '')
    days = int(content[AccLoginField.days])
    coin = int(get_value(content[AccLoginField.coin], 0))
    gold = int(get_value(content[AccLoginField.gold], 0))
    item_list = get_str(content[AccLoginField.items], '')
    title = str(content[AccLoginField.title])
    mail_content = str(content[AccLoginField.content])
    icon = int(prev(all_content, row, AccLoginField.icon))
    fun_content = get_str(content[AccLoginField.acc_content], '')
    acc_login_mail.append("acc_login_mail(%d, %d) -> {<<\"%s\">>, <<\"%s\">>, [{coin, %d}, {gold, %d}] ++ [%s]};"%(id, days, title, mail_content, coin, gold, item_list))
    type_list.append("get_type(%d) -> 10;"%(id))
    icon_list.append("get_icon(%d) -> %d;"%(id, icon))
    if name <> '': 
        name_list.append("get_name(%d) -> <<\"%s\">>;"%(id, name))
        php_base_list.append("    %d => array('id' => %d, 'name' => '%s'),"%(id, id, name))
    if fun_content <> '':
        fun_content_list.append("get_fun_content(%d) -> <<\"%s\">>;"%(id, fun_content))
    return []
get_acc_login()
acc_login_mail.append("acc_login_mail(_, _) -> false.")

data_fun_activity.extend(acc_login_mail)


## ######################################
## 英雄升星
## ######################################
hero_star_list = {}
hero_star_reward_list = []
hero_star_max_draw_list = []
@load_sheel(work_book, ur"英雄升星")
def get_hero_star(content, all_content, row):
    id = int(prev(all_content, row, HeroStarField.id))
    name = get_str(content[HeroStarField.name], '')
    star = int(content[HeroStarField.star])
    max_finish_count = int(content[HeroStarField.max_finish_count])
    item_list = get_str(content[HeroStarField.items], '')
    icon = int(prev(all_content, row, HeroStarField.icon))
    fun_content = get_str(content[HeroStarField.acc_content], '')
    type_list.append("get_type(%d) -> 11;"%(id))
    icon_list.append("get_icon(%d) -> %d;"%(id, icon))
    hero_star_reward_list.append("hero_star_reward(%d, %d) -> [{add_items, [%s]}];"%(id, star, item_list))
    hero_star_max_draw_list.append("hero_star_max_draw(%d, %d) -> %d;"%(id, star, max_finish_count))
    if name <> '': 
        name_list.append("get_name(%d) -> <<\"%s\">>;"%(id, name))
        php_base_list.append("    %d => array('id' => %d, 'name' => '%s'),"%(id, id, name))
    if fun_content <> '':
        fun_content_list.append("get_fun_content(%d) -> <<\"%s\">>;"%(id, fun_content))
    hero_star_list.setdefault(id, [])
    hero_star_list[id].append("%d"%(star))
    return []
get_hero_star()
hero_star_reward_list.append("hero_star_reward(_, _) -> [].")
hero_star_max_draw_list.append("hero_star_max_draw(_, _) -> 0.")

data_fun_activity.extend(hero_star_reward_list)
data_fun_activity.extend(hero_star_max_draw_list)

for i in hero_star_list:
    data_fun_activity.append("hero_stars(%d) -> [%s];"%(i, ",".join(hero_star_list[i])))
data_fun_activity.append("hero_stars(_) -> [].")


## ######################################
## 英雄招募
## ######################################
hero_collect_list = {}
hero_collect_reward_list = []
@load_sheel(work_book, ur"英雄招募")
def get_hero_collect(content, all_content, row):
    id = int(prev(all_content, row, HeroCollectField.id))
    name = get_str(content[HeroCollectField.name], '')
    hero_num = int(content[HeroCollectField.hero_num])
    gold = int(content[HeroCollectField.gold])
    coin = int(content[HeroCollectField.coin])
    item_list = get_str(content[HeroCollectField.items], '')
    icon = int(prev(all_content, row, HeroCollectField.icon))
    fun_content = get_str(content[HeroCollectField.acc_content], '')
    type_list.append("get_type(%d) -> 12;"%(id))
    icon_list.append("get_icon(%d) -> %d;"%(id, icon))
    hero_collect_reward_list.append("hero_collect_reward(%d, %d) -> [{add_gold, %d}, {add_coin, %d}, {add_items, [%s]}];"%(id, hero_num, gold, coin, item_list))
    if name <> '': 
        name_list.append("get_name(%d) -> <<\"%s\">>;"%(id, name))
        php_base_list.append("    %d => array('id' => %d, 'name' => '%s'),"%(id, id, name))
    if fun_content <> '':
        fun_content_list.append("get_fun_content(%d) -> <<\"%s\">>;"%(id, fun_content))

    hero_collect_list.setdefault(id, [])
    hero_collect_list[id].append("%d"%(hero_num))
    return []
get_hero_collect()
hero_collect_reward_list.append("hero_collect_reward(_, _) -> [].")

data_fun_activity.extend(hero_collect_reward_list)

for i in hero_collect_list:
    data_fun_activity.append("hero_collect_num_list(%d) -> [%s];"%(i, ",".join(hero_collect_list[i])))
data_fun_activity.append("hero_collect_num_list(_) -> [].")

## ######################################
## 等级礼包
## ######################################
role_level_list = {}
role_level_reward_list = []
role_level_title_list = []
@load_sheel(work_book, ur"等级礼包")
def get_role_level(content, all_content, row):
    id = int(prev(all_content, row, RoleLevelField.id))
    name = get_str(content[RoleLevelField.name], '')
    level = int(content[RoleLevelField.level])
    gold = int(content[RoleLevelField.gold])
    coin = int(content[RoleLevelField.coin])
    item_list = get_str(content[RoleLevelField.items], '')
    icon = int(prev(all_content, row, RoleLevelField.icon))
    fun_content = get_str(content[RoleLevelField.acc_content], '')
    index_title = get_str(content[RoleLevelField.index_title], '')
    type_list.append("get_type(%d) -> 18;"%(id))
    icon_list.append("get_icon(%d) -> %d;"%(id, icon))
    role_level_title_list.append("role_level_index_title(%d, %d) -> <<\"%s\">>;"%(id, level, index_title))
    role_level_reward_list.append("role_level_reward(%d, %d) -> [{add_gold, %d}, {add_coin, %d}, {add_items, [%s]}];"%(id, level, gold, coin, item_list))
    if name <> '': 
        name_list.append("get_name(%d) -> <<\"%s\">>;"%(id, name))
        php_base_list.append("    %d => array('id' => %d, 'name' => '%s'),"%(id, id, name))
    if fun_content <> '':
        fun_content_list.append("get_fun_content(%d) -> <<\"%s\">>;"%(id, fun_content))
    role_level_list.setdefault(id, [])
    role_level_list[id].append("%d"%(level))
    return []
get_role_level()
role_level_reward_list.append("role_level_reward(_, _) -> [].")
role_level_title_list.append("role_level_index_title(_, _) -> <<\"\">>.")

data_fun_activity.extend(role_level_reward_list)
data_fun_activity.extend(role_level_title_list)

for i in role_level_list:
    data_fun_activity.append("role_level_list(%d) -> [%s];"%(i, ",".join(role_level_list[i])))
data_fun_activity.append("role_level_list(_) -> [].")

## ######################################
## 累计充值
## ######################################
total_charge_list = {}
total_charge_reward_list = []
total_charge_title_list = []
@load_sheel(work_book, ur"累计充值")
def get_total_charge(content, all_content, row):
    id = int(prev(all_content, row, TotalChargeField.id))
    name = get_str(content[TotalChargeField.name], '')
    level = int(content[TotalChargeField.rmb])
    gold = int(content[TotalChargeField.gold])
    coin = int(content[TotalChargeField.coin])
    item_list = get_str(content[TotalChargeField.items], '')
    icon = int(prev(all_content, row, TotalChargeField.icon))
    fun_content = get_str(content[TotalChargeField.acc_content], '')
    index_title = get_str(content[TotalChargeField.index_title], '')
    type_list.append("get_type(%d) -> 22;"%(id))
    icon_list.append("get_icon(%d) -> %d;"%(id, icon))
    total_charge_title_list.append("total_charge_index_title(%d, %d) -> <<\"%s\">>;"%(id, level, index_title))
    total_charge_reward_list.append("total_charge_reward(%d, %d) -> [{add_gold, %d}, {add_coin, %d}, {add_items, [%s]}];"%(id, level, gold, coin, item_list))
    if name <> '': 
        name_list.append("get_name(%d) -> <<\"%s\">>;"%(id, name))
        php_base_list.append("    %d => array('id' => %d, 'name' => '%s'),"%(id, id, name))
    if fun_content <> '':
        fun_content_list.append("get_fun_content(%d) -> <<\"%s\">>;"%(id, fun_content))
    total_charge_list.setdefault(id, [])
    total_charge_list[id].append("%d"%(level))
    return []
get_total_charge()
total_charge_reward_list.append("total_charge_reward(_, _) -> [].")
total_charge_title_list.append("total_charge_index_title(_, _) -> <<\"\">>.")

data_fun_activity.extend(total_charge_reward_list)
data_fun_activity.extend(total_charge_title_list)

for i in total_charge_list:
    data_fun_activity.append("total_charge_list(%d) -> [%s];"%(i, ",".join(total_charge_list[i])))
data_fun_activity.append("total_charge_list(_) -> [].")

## ######################################
## 累计消费
## ######################################
total_cost_list = {}
total_cost_reward_list = []
total_cost_title_list = []
@load_sheel(work_book, ur"累计消费")
def get_total_cost(content, all_content, row):
    id = int(prev(all_content, row, TotalCostField.id))
    name = get_str(content[TotalCostField.name], '')
    level = int(content[TotalCostField.cost_gold])
    gold = int(content[TotalCostField.gold])
    coin = int(content[TotalCostField.coin])
    item_list = get_str(content[TotalCostField.items], '')
    icon = int(prev(all_content, row, TotalCostField.icon))
    fun_content = get_str(content[TotalCostField.acc_content], '')
    index_title = get_str(content[TotalCostField.index_title], '')
    type_list.append("get_type(%d) -> 23;"%(id))
    icon_list.append("get_icon(%d) -> %d;"%(id, icon))
    total_cost_title_list.append("total_cost_index_title(%d, %d) -> <<\"%s\">>;"%(id, level, index_title))
    total_cost_reward_list.append("total_cost_reward(%d, %d) -> [{add_gold, %d}, {add_coin, %d}, {add_items, [%s]}];"%(id, level, gold, coin, item_list))
    if name <> '': 
        name_list.append("get_name(%d) -> <<\"%s\">>;"%(id, name))
        php_base_list.append("    %d => array('id' => %d, 'name' => '%s'),"%(id, id, name))
    if fun_content <> '':
        fun_content_list.append("get_fun_content(%d) -> <<\"%s\">>;"%(id, fun_content))
    total_cost_list.setdefault(id, [])
    total_cost_list[id].append("%d"%(level))
    return []
get_total_cost()
total_cost_reward_list.append("total_cost_reward(_, _) -> [].")
total_cost_title_list.append("total_cost_index_title(_, _) -> <<\"\">>.")

data_fun_activity.extend(total_cost_reward_list)
data_fun_activity.extend(total_cost_title_list)

for i in total_cost_list:
    data_fun_activity.append("total_cost_list(%d) -> [%s];"%(i, ",".join(total_cost_list[i])))
data_fun_activity.append("total_cost_list(_) -> [].")

## ######################################
## 每日累计充值
## ######################################
daily_t_charge_list = {}
daily_t_charge_reward_list = []
daily_t_charge_title_list = []
@load_sheel(work_book, ur"每日累计充值")
def get_daily_t_charge(content, all_content, row):
    id = int(prev(all_content, row, DailyTChargeField.id))
    name = get_str(content[DailyTChargeField.name], '')
    level = int(content[DailyTChargeField.rmb])
    gold = int(content[DailyTChargeField.gold])
    coin = int(content[DailyTChargeField.coin])
    item_list = get_str(content[DailyTChargeField.items], '')
    icon = int(prev(all_content, row, DailyTChargeField.icon))
    fun_content = get_str(content[DailyTChargeField.acc_content], '')
    index_title = get_str(content[DailyTChargeField.index_title], '')
    type_list.append("get_type(%d) -> 32;"%(id))
    icon_list.append("get_icon(%d) -> %d;"%(id, icon))
    daily_t_charge_title_list.append("daily_t_charge_index_title(%d, %d) -> <<\"%s\">>;"%(id, level, index_title))
    daily_t_charge_reward_list.append("daily_t_charge_reward(%d, %d) -> [{add_gold, %d}, {add_coin, %d}, {add_items, [%s]}];"%(id, level, gold, coin, item_list))
    if name <> '': 
        name_list.append("get_name(%d) -> <<\"%s\">>;"%(id, name))
        php_base_list.append("    %d => array('id' => %d, 'name' => '%s'),"%(id, id, name))
    if fun_content <> '':
        fun_content_list.append("get_fun_content(%d) -> <<\"%s\">>;"%(id, fun_content))
    daily_t_charge_list.setdefault(id, [])
    daily_t_charge_list[id].append("%d"%(level))
    return []
get_daily_t_charge()
daily_t_charge_reward_list.append("daily_t_charge_reward(_, _) -> [].")
daily_t_charge_title_list.append("daily_t_charge_index_title(_, _) -> <<\"\">>.")

data_fun_activity.extend(daily_t_charge_reward_list)
data_fun_activity.extend(daily_t_charge_title_list)

for i in daily_t_charge_list:
    data_fun_activity.append("daily_t_charge_list(%d) -> [%s];"%(i, ",".join(daily_t_charge_list[i])))
data_fun_activity.append("daily_t_charge_list(_) -> [].")

## ######################################
## 每日累计消费
## ######################################
daily_t_cost_list = {}
daily_t_cost_reward_list = []
daily_t_cost_title_list = []
@load_sheel(work_book, ur"每日累计消费")
def get_daily_t_cost(content, all_content, row):
    id = int(prev(all_content, row, DailyTCostField.id))
    name = get_str(content[DailyTCostField.name], '')
    level = int(content[DailyTCostField.cost_gold])
    gold = int(content[DailyTCostField.gold])
    coin = int(content[DailyTCostField.coin])
    item_list = get_str(content[DailyTCostField.items], '')
    icon = int(prev(all_content, row, DailyTCostField.icon))
    fun_content = get_str(content[DailyTCostField.acc_content], '')
    index_title = get_str(content[DailyTCostField.index_title], '')
    type_list.append("get_type(%d) -> 33;"%(id))
    icon_list.append("get_icon(%d) -> %d;"%(id, icon))
    daily_t_cost_title_list.append("daily_t_cost_index_title(%d, %d) -> <<\"%s\">>;"%(id, level, index_title))
    daily_t_cost_reward_list.append("daily_t_cost_reward(%d, %d) -> [{add_gold, %d}, {add_coin, %d}, {add_items, [%s]}];"%(id, level, gold, coin, item_list))
    if name <> '': 
        name_list.append("get_name(%d) -> <<\"%s\">>;"%(id, name))
        php_base_list.append("    %d => array('id' => %d, 'name' => '%s'),"%(id, id, name))
    if fun_content <> '':
        fun_content_list.append("get_fun_content(%d) -> <<\"%s\">>;"%(id, fun_content))
    daily_t_cost_list.setdefault(id, [])
    daily_t_cost_list[id].append("%d"%(level))
    return []
get_daily_t_cost()
daily_t_cost_reward_list.append("daily_t_cost_reward(_, _) -> [].")
daily_t_cost_title_list.append("daily_t_cost_index_title(_, _) -> <<\"\">>.")

data_fun_activity.extend(daily_t_cost_reward_list)
data_fun_activity.extend(daily_t_cost_title_list)

for i in daily_t_cost_list:
    data_fun_activity.append("daily_t_cost_list(%d) -> [%s];"%(i, ",".join(daily_t_cost_list[i])))
data_fun_activity.append("daily_t_cost_list(_) -> [].")

## ######################################
## 成长计划
## ######################################
growth_fund_list = {}
growth_fund_reward_list = []
growth_fund_title_list = []
growth_fund_cost = []
growth_fund_vip = []
growth_fund_vip_num = 0
growth_fund_gold_num = 0
@load_sheel(work_book, ur"成长计划")
def get_growth_fund(content, all_content, row):
    id = int(prev(all_content, row, GrowthFundField.id))
    name = get_str(content[GrowthFundField.name], '')
    cost_gold = int(prev(all_content, row, GrowthFundField.cost_gold))
    vip_lev = int(prev(all_content, row, GrowthFundField.vip_lev))
    level = int(content[GrowthFundField.level])
    gold = int(content[GrowthFundField.gold])
    coin = int(content[GrowthFundField.coin])
    item_list = get_str(content[GrowthFundField.items], '')
    icon = int(prev(all_content, row, GrowthFundField.icon))
    fun_content = get_str(content[GrowthFundField.acc_content], '')
    index_title = get_str(content[GrowthFundField.index_title], '')
    type_list.append("get_type(%d) -> 24;"%(id))
    icon_list.append("get_icon(%d) -> %d;"%(id, icon))
    global growth_fund_gold_num
    if cost_gold <> growth_fund_gold_num: 
        growth_fund_cost.append("growth_fund_cost(%d) -> [{del_gold, %d}];"%(id, cost_gold))
        growth_fund_gold_num = cost_gold
    global growth_fund_vip_num
    if vip_lev <> growth_fund_vip_num:
        growth_fund_vip.append("growth_fund_vip(%d) -> %d;"%(id, vip_lev))
        growth_fund_vip_num = vip_lev
    growth_fund_title_list.append("growth_fund_index_title(%d, %d) -> <<\"%s\">>;"%(id, level, index_title))
    growth_fund_reward_list.append("growth_fund_reward(%d, %d) -> [{add_gold, %d}, {add_coin, %d}, {add_items, [%s]}];"%(id, level, gold, coin, item_list))
    if name <> '': 
        name_list.append("get_name(%d) -> <<\"%s\">>;"%(id, name))
        php_base_list.append("    %d => array('id' => %d, 'name' => '%s'),"%(id, id, name))
    if fun_content <> '':
        fun_content_list.append("get_fun_content(%d) -> <<\"%s\">>;"%(id, fun_content))
    growth_fund_list.setdefault(id, [])
    growth_fund_list[id].append("%d"%(level))
    return []
get_growth_fund()
growth_fund_reward_list.append("growth_fund_reward(_, _) -> [].")
growth_fund_title_list.append("growth_fund_index_title(_, _) -> <<\"\">>.")
growth_fund_cost.append("growth_fund_cost(_) -> [].")
growth_fund_vip.append("growth_fund_vip(_) -> 99.")

data_fun_activity.extend(growth_fund_reward_list)
data_fun_activity.extend(growth_fund_title_list)
data_fun_activity.extend(growth_fund_cost)
data_fun_activity.extend(growth_fund_vip)

for i in growth_fund_list:
    data_fun_activity.append("growth_fund_list(%d) -> [%s];"%(i, ",".join(growth_fund_list[i])))
data_fun_activity.append("growth_fund_list(_) -> [].")

## ######################################
## 收集兑换
## ######################################
collect_reward_list = []
collect_cost_list = []
collect_times_list = []
collect_list = {}

@load_sheel(work_book, ur"收集兑换")
def get_collect(content, all_content, row):
    id          = int(prev(all_content, row, CollectField.id))
    name        = get_str(content[CollectField.name], '')
    index       = int(content[CollectField.index])
    need_items  = get_str(content[CollectField.need_items], '')
    gold        = int(content[CollectField.gold])
    coin        = int(content[CollectField.coin])
    item_list   = get_str(content[CollectField.items], '')
    max_num     = int(content[CollectField.times])
    icon        = int(prev(all_content, row, CollectField.icon))
    fun_content = get_str(content[CollectField.acc_content], '')
    type_list.append("get_type(%d) -> 21;"%(id))
    icon_list.append("get_icon(%d) -> %d;"%(id, icon))
    collect_reward_list.append("collect_reward_list(%d, %d) -> [{gold, %d}, {coin, %d}, %s];"%(id, index, gold, coin, item_list))
    collect_cost_list.append("collect_cost_list(%d, %d) -> [%s];"%(id, index, need_items))
    collect_times_list.append("collect_max_times(%d, %d) -> %d;"%(id, index, max_num))

    collect_list.setdefault(id, [])
    collect_list[id].append("%d"%(index))

    if name <> '': 
        name_list.append("get_name(%d) -> <<\"%s\">>;"%(id, name))
        php_base_list.append("    %d => array('id' => %d, 'name' => '%s'),"%(id, id, name))
    if fun_content <> '':
        fun_content_list.append("get_fun_content(%d) -> <<\"%s\">>;"%(id, fun_content))
    return []

get_collect()

collect_reward_list.append("collect_reward_list(_, _) -> [].")
collect_cost_list.append("collect_cost_list(_, _) -> [].")
collect_times_list.append("collect_max_times(_, _) -> 0.")

data_fun_activity.extend(collect_reward_list)
data_fun_activity.extend(collect_cost_list)
data_fun_activity.extend(collect_times_list)

for i in collect_list:
    data_fun_activity.append("collect_list(%d) -> [%s];"%(i, ",".join(collect_list[i])))
data_fun_activity.append("collect_list(_) -> [].")

## ######################################
## 幸运大转盘
## ######################################
limit_list = []
cost_gold_list = []
reward_times_list = []
free_times_list = []

@load_sheel(work_book, ur"幸运大转盘")
def get_lucky_dial(content):
    id          = int(get_value(content[LuckyDialField.id], 0))
    name        = get_str(content[LuckyDialField.name], '')
    gold        = int(content[LuckyDialField.cost_gold])
    free_times  = int(content[LuckyDialField.free_times])
    cost_item   = get_str(content[LuckyDialField.cost_item], '')
    items       = get_str(content[LuckyDialField.items], '')
    limits      = get_str(content[LuckyDialField.limit_list], '')
    icon        = int(content[LuckyDialField.icon])
    fun_content = get_str(content[LuckyDialField.acc_content], '')

    type_list.append("get_type(%d) -> 20;"%(id))
    icon_list.append("get_icon(%d) -> %d;"%(id, icon))

    reward_times_list.append("lucky_item_list(%d) -> [%s];"%(id, items))
    if cost_item == '':
        cost_gold_list.append("lucky_cost(%d) -> [{gold, %d}];"%(id, gold))
    else:
        cost_gold_list.append("lucky_cost(%d) -> [{gold, %d}, %s];"%(id, gold, cost_item))
    limit_list.append("lucky_limit_list(%d) -> [%s];"%(id, limits))
    free_times_list.append("lucky_free_times(%d) -> %d;"%(id, free_times))

    if name <> '': 
        name_list.append("get_name(%d) -> <<\"%s\">>;"%(id, name))
        php_base_list.append("    %d => array('id' => %d, 'name' => '%s'),"%(id, id, name))
    if fun_content <> '':
        fun_content_list.append("get_fun_content(%d) -> <<\"%s\">>;"%(id, fun_content))
    return []

get_lucky_dial()

reward_times_list.append("lucky_item_list(_) -> [].")
cost_gold_list.append("lucky_cost(_) -> [].")
limit_list.append("lucky_limit_list(_) -> [].")
free_times_list.append("lucky_free_times(_) -> 0.")

data_fun_activity.extend(reward_times_list)
data_fun_activity.extend(cost_gold_list)
data_fun_activity.extend(limit_list)
data_fun_activity.extend(free_times_list)

## ######################################
## 战力排行
## ######################################
power_rank_max_list = {}
power_rank_reward_list = []
power_rank_title_list = []
power_rank_index_list = []
power_rank_content_list = []
power_rank_list = {}
@load_sheel(work_book, ur"战力排行")
def get_hero_rank(content, all_content, row):
    id = int(prev(all_content, row, PowerRankField.id))
    name = get_str(content[PowerRankField.name], '')
    rank = int(content[PowerRankField.rank])
    gold = int(content[PowerRankField.gold])
    coin = int(content[PowerRankField.coin])
    item_list = get_str(content[PowerRankField.items], '')
    mail_title = str(prev(all_content, row, PowerRankField.title))
    mail_content = str(prev(all_content, row, PowerRankField.content))
    icon = int(prev(all_content, row, PowerRankField.icon))
    fun_content = get_str(content[PowerRankField.acc_content], '')
    index_title = get_str(content[PowerRankField.index_title], '')
    type_list.append("get_type(%d) -> 13;"%(id))
    icon_list.append("get_icon(%d) -> %d;"%(id, icon))
    power_rank_reward_list.append("power_rank_reward(%d, %d) -> [{gold, %d}, {coin, %d}] ++ [%s];"%(id, rank, gold, coin, item_list))
    power_rank_title_list.append("power_rank_title(%d, %d) -> <<\"%s\">>;"%(id, rank, mail_title))
    power_rank_index_list.append("power_rank_index_title(%d, %d) -> <<\"%s\">>;"%(id, rank, index_title))
    power_rank_content_list.append("power_rank_content(%d, %d) -> <<\"%s\">>;"%(id, rank, mail_content))
    if name <> '': 
        name_list.append("get_name(%d) -> <<\"%s\">>;"%(id, name))
        php_base_list.append("    %d => array('id' => %d, 'name' => '%s'),"%(id, id, name))
    if fun_content <> '':
        fun_content_list.append("get_fun_content(%d) -> <<\"%s\">>;"%(id, fun_content))
    power_rank_max_list.setdefault(id, 0)
    if power_rank_max_list[id] < rank:
        power_rank_max_list[id] = rank
    power_rank_list.setdefault(id, [])
    power_rank_list[id].append("%d"%(rank))
    return []
get_hero_rank()
power_rank_reward_list.append("power_rank_reward(_, _) -> [].")
power_rank_title_list.append("power_rank_title(_, _) -> <<>>.")
power_rank_content_list.append("power_rank_content(_, _) -> <<>>.")
power_rank_index_list.append("power_rank_index_title(_, _) -> <<\"\">>.")

data_fun_activity.extend(power_rank_reward_list)
data_fun_activity.extend(power_rank_title_list)
data_fun_activity.extend(power_rank_content_list)
data_fun_activity.extend(power_rank_index_list)


for i in power_rank_max_list:
    data_fun_activity.append("power_max_rank(%d) -> %d;"%(i, power_rank_max_list[i]))
data_fun_activity.append("power_max_rank(_) -> 0.")


for i in power_rank_list:
    data_fun_activity.append("power_rank_list(%d) -> [%s];"%(i, ",".join(power_rank_list[i])))
data_fun_activity.append("power_rank_list(_) -> [].")



## ######################################
## 竞技排行
## ######################################
arena_rank_max_list = {}
arena_rank_reward_list = []
arena_rank_title_list = []
arena_rank_index_list = []
arena_rank_content_list = []
arena_rank_list = {}
@load_sheel(work_book, ur"竞技排行")
def get_arena_rank(content, all_content, row):
    id = int(prev(all_content, row, ArenaRankField.id))
    name = get_str(content[ArenaRankField.name], '')
    rank = int(content[ArenaRankField.rank])
    gold = int(content[ArenaRankField.gold])
    coin = int(content[ArenaRankField.coin])
    item_list = get_str(content[ArenaRankField.items], '')
    mail_title = str(prev(all_content, row, ArenaRankField.title))
    mail_content = str(prev(all_content, row, ArenaRankField.content))
    icon = int(prev(all_content, row, ArenaRankField.icon))
    fun_content = get_str(content[ArenaRankField.acc_content], '')
    index_title = get_str(content[ArenaRankField.index_title], '')
    type_list.append("get_type(%d) -> 19;"%(id))
    icon_list.append("get_icon(%d) -> %d;"%(id, icon))
    arena_rank_reward_list.append("arena_rank_reward(%d, %d) -> [{gold, %d}, {coin, %d}] ++ [%s];"%(id, rank, gold, coin, item_list))
    arena_rank_title_list.append("arena_rank_title(%d, %d) -> <<\"%s\">>;"%(id, rank, mail_title))
    arena_rank_index_list.append("arena_rank_index_title(%d, %d) -> <<\"%s\">>;"%(id, rank, index_title))
    arena_rank_content_list.append("arena_rank_content(%d, %d) -> <<\"%s\">>;"%(id, rank, mail_content))
    if name <> '': 
        name_list.append("get_name(%d) -> <<\"%s\">>;"%(id, name))
        php_base_list.append("    %d => array('id' => %d, 'name' => '%s'),"%(id, id, name))
    if fun_content <> '':
        fun_content_list.append("get_fun_content(%d) -> <<\"%s\">>;"%(id, fun_content))
    arena_rank_max_list.setdefault(id, 0)
    if arena_rank_max_list[id] < rank:
        arena_rank_max_list[id] = rank
    arena_rank_list.setdefault(id, [])
    arena_rank_list[id].append("%d"%(rank))
    return []
get_arena_rank()
arena_rank_reward_list.append("arena_rank_reward(_, _) -> [].")
arena_rank_title_list.append("arena_rank_title(_, _) -> <<>>.")
arena_rank_content_list.append("arena_rank_content(_, _) -> <<>>.")
arena_rank_index_list.append("arena_rank_index_title(_, _) -> <<\"\">>.")

data_fun_activity.extend(arena_rank_reward_list)
data_fun_activity.extend(arena_rank_title_list)
data_fun_activity.extend(arena_rank_content_list)
data_fun_activity.extend(arena_rank_index_list)


for i in arena_rank_max_list:
    data_fun_activity.append("arena_max_rank(%d) -> %d;"%(i, arena_rank_max_list[i]))
data_fun_activity.append("arena_max_rank(_) -> 0.")


for i in arena_rank_list:
    data_fun_activity.append("arena_rank_list(%d) -> [%s];"%(i, ",".join(arena_rank_list[i])))
data_fun_activity.append("arena_rank_list(_) -> [].")


## ######################################
## 招财猫
## ######################################
fortune_gold_list = []
fortune_reward_list = []
fortune_vip_list = []
fortune_list = {}

@load_sheel(work_book, ur"招财猫")
def get_fortune(content, all_content, row):
    id          = int(prev(all_content, row, FortuneField.id))
    name        = get_str(content[FortuneField.name], '')
    index       = int(content[FortuneField.index])
    cost_gold   = int(content[FortuneField.cost_gold])
    get_gold    = get_str(content[FortuneField.get_gold], '')
    vip_lev     = int(content[FortuneField.vip_lev])
    icon        = int(prev(all_content, row, FortuneField.icon))
    fun_content = get_str(content[FortuneField.acc_content], '')

    type_list.append("get_type(%d) -> 25;"%(id))
    icon_list.append("get_icon(%d) -> %d;"%(id, icon))

    fortune_list.setdefault(id, [])
    fortune_list[id].append("%d"%(index))
    if name <> '': 
        name_list.append("get_name(%d) -> <<\"%s\">>;"%(id, name))
        php_base_list.append("    %d => array('id' => %d, 'name' => '%s'),"%(id, id, name))
    if fun_content <> '':
        fun_content_list.append("get_fun_content(%d) -> <<\"%s\">>;"%(id, fun_content))


    fortune_gold_list.append("get_fortune_cost_gold(%d, %d) -> %d;"%(id, index, cost_gold))
    fortune_reward_list.append("get_fortune_reward_gold(%d, %d) -> %s;"%(id, index, get_gold))
    fortune_vip_list.append("get_fortune_vip(%d, %d) -> %d;"%(id, index, vip_lev))
    return []

get_fortune()

fortune_gold_list.append("get_fortune_cost_gold(_, _) -> 0.")
fortune_reward_list.append("get_fortune_reward_gold(_, _) -> {0, 0}.")
fortune_vip_list.append("get_fortune_vip(_, _) -> 0.")

data_fun_activity.extend(fortune_gold_list)
data_fun_activity.extend(fortune_reward_list)
data_fun_activity.extend(fortune_vip_list)

for i in fortune_list:
    data_fun_activity.append("fortune_list(%d) -> [%s];"%(i, ",".join(fortune_list[i])))
data_fun_activity.append("fortune_list(_) -> [].")

## ######################################
## 限时探宝
## ######################################
treasure_rank_reward_list = []
treasure_title_list = []
treasure_index_list = []
treasure_content_list = []
treasure_extra_list = []
treasure_item_list = []
treasure_min_rank_times = []
treasure_rank_list = {}
treasure_buy_list = []
treasure_free_list = []
treasure_hero_list = []
old_id = 0
@load_sheel(work_book, ur"限时探宝")
def get_treasure(content, all_content, row):
    id      = int(prev(all_content, row, TreasureField.id))
    name    = str(prev(all_content, row, TreasureField.name))
    items   = str(prev(all_content, row, TreasureField.items))
    extra_times = int(prev(all_content, row, TreasureField.extra_times))
    extra_items = get_str(content[TreasureField.extra_items], '')
    hero_id = int(prev(all_content, row, TreasureField.hero_id))
    rank = int(content[TreasureField.rank])
    gold = int(content[TreasureField.gold])
    coin = int(content[TreasureField.coin])
    rank_items = get_str(content[TreasureField.rank_items], '')
    mail_title = str(prev(all_content, row, TreasureField.title))
    mail_content = str(prev(all_content, row, TreasureField.content))
    icon = int(prev(all_content, row, TreasureField.icon))
    fun_content = get_str(content[TreasureField.acc_content], '')
    index_title = get_str(content[TreasureField.index_title], '')
    cost_gold = int(prev(all_content, row, TreasureField.cost_gold))
    buy_item  = str(prev(all_content, row, TreasureField.buy_item))
    buy_coin  = int(prev(all_content, row, TreasureField.buy_coin))
    rank_min_times = int(prev(all_content, row, TreasureField.rank_min_times))
    free_item = str(prev(all_content, row, TreasureField.free_item))

    type_list.append("get_type(%d) -> 26;"%(id))
    icon_list.append("get_icon(%d) -> %d;"%(id, icon))
    treasure_rank_reward_list.append("treasure_rank_reward_list(%d, %d) -> [{gold, %d}, {coin, %d}] ++ [%s];"%(id, rank, gold, coin, rank_items))
    treasure_title_list.append("treasure_rank_title(%d, %d) -> <<\"%s\">>;"%(id, rank, mail_title))
    treasure_index_list.append("treasure_index_list(%d, %d) -> <<\"%s\">>;"%(id, rank, index_title))
    treasure_content_list.append("treasure_content(%d, %d) -> <<\"%s\">>;"%(id, rank, mail_content))
    if name <> '': 
        name_list.append("get_name(%d) -> <<\"%s\">>;"%(id, name))
        php_base_list.append("    %d => array('id' => %d, 'name' => '%s'),"%(id, id, name))
    if fun_content <> '':
        fun_content_list.append("get_fun_content(%d) -> <<\"%s\">>;"%(id, fun_content))
    global old_id
    if id <> old_id:
        treasure_extra_list.append("get_treasure_extra(%d) -> {%d, [%s]};"%(id, extra_times, extra_items))
        treasure_item_list.append("get_treasure_items(%d) -> [%s];"%(id, items))
        treasure_buy_list.append("treasure_buy_list(%d) -> [{del_gold, %d}, {add_coin, %d}, {add_items, [%s]}];"%(id, cost_gold, buy_coin, buy_item))
        treasure_min_rank_times.append("treasure_min_rank_times(%d) -> %d;"%(id, rank_min_times))
        treasure_free_list.append("treasure_free_item(%d) -> [%s];"%(id, free_item))
        treasure_hero_list.append("get_treasure_hero_id(%d) -> %d;"%(id, hero_id))
    old_id = id
    treasure_rank_list.setdefault(id, [])
    treasure_rank_list[id].append("%d"%(rank))  
    return []
get_treasure()

treasure_rank_reward_list.append("treasure_rank_reward_list(_, _) -> [].")
treasure_title_list.append("treasure_rank_title(_, _) -> <<>>.")
treasure_index_list.append("treasure_index_list(_, _) -> <<\"\">>.")
treasure_content_list.append("treasure_content(_, _) -> <<>>.")
treasure_extra_list.append("get_treasure_extra(_) -> {0, []}.")
treasure_item_list.append("get_treasure_items(_) -> [].")
treasure_buy_list.append("treasure_buy_list(_) -> [].")
treasure_min_rank_times.append("treasure_min_rank_times(_) -> 0.")
treasure_free_list.append("treasure_free_item(_) -> [].")
treasure_hero_list.append("get_treasure_hero_id(_) -> 0.")

data_fun_activity.extend(treasure_rank_reward_list)
data_fun_activity.extend(treasure_title_list)
data_fun_activity.extend(treasure_index_list)
data_fun_activity.extend(treasure_content_list)
data_fun_activity.extend(treasure_extra_list)
data_fun_activity.extend(treasure_item_list)
data_fun_activity.extend(treasure_buy_list)
data_fun_activity.extend(treasure_min_rank_times)
data_fun_activity.extend(treasure_free_list)
data_fun_activity.extend(treasure_hero_list)

for i in treasure_rank_list:
    data_fun_activity.append("treasure_rank_list(%d) -> [%s];"%(i, ",".join(treasure_rank_list[i])))
data_fun_activity.append("treasure_rank_list(_) -> [].")

## ######################################
## 限时探宝共用库
## ######################################
public_treasure_list = {}
@load_sheel(work_book, ur"限时探宝共用库")
def get_public_treasure(content, all_content, row):
    type        = int(prev(all_content, row, PublicTreasureField.type))
    item_id     = int(content[PublicTreasureField.item_id])
    min_num     = int(content[PublicTreasureField.min])
    max_num     = int(content[PublicTreasureField.max])
    rate        = int(content[PublicTreasureField.rate])
    min_times   = int(content[PublicTreasureField.min_times])
    public_treasure_list.setdefault(type, [])
    public_treasure_list[type].append("{%d,%d,%d,%d,%d}"%(item_id, min_num, max_num, rate, min_times))
    return []

get_public_treasure()

for i in public_treasure_list:
    data_fun_activity.append("public_treasure_list(%d) -> [%s];"%(i, ",".join(public_treasure_list[i])))
data_fun_activity.append("public_treasure_list(_) -> [].")

## ######################################
## 限时探宝附赠共用库
## ######################################
public_draw = []
public_draw_list = []
@load_sheel(work_book, ur"限时探宝附赠共用库")
def get_draw_treasure(content, all_content, row):
    item_id     = int(content[PublicDrawField.item_id])
    rate        = int(content[PublicDrawField.rate])
    min_times   = int(content[PublicDrawField.min_times])
    public_draw.append("{%d, %d, %d}"%(item_id, rate, min_times))
    return []

get_draw_treasure()

public_draw_list.append("public_draw_list() -> [%s]."%(",".join(public_draw)))
data_fun_activity.extend(public_draw_list)

## ######################################
## 七日特训
## ######################################
seven_day_list          = {}
seven_day_index_list    = {}
seven_day_titile_list   = []
seven_day_content_list  = []
seven_day_target_list   = []
seven_day_items_list    = []
seven_day_scores_list   = []
seven_day_index_titile_list = []
seven_day_day_titile_list = []
seven_day_panel_list    = []

old_day = 0
@load_sheel(work_book, ur"七日特训")
def get_seven_day(content, all_content, row):
    id      = int(prev(all_content, row, SevenDayField.id))
    name    = str(prev(all_content, row, TreasureField.name))
    day     = int(prev(all_content, row, SevenDayField.day))
    icon    = int(prev(all_content, row, SevenDayField.icon))
    day_titile = get_str(content[SevenDayField.day_titile], '')
    index   = int(content[SevenDayField.index])
    target  = get_str(content[SevenDayField.target], '')
    items   = get_str(content[SevenDayField.items], '')
    scores  = int(content[SevenDayField.scores])
    acc_titile  = str(prev(all_content, row, SevenDayField.acc_titile))
    acc_content = str(prev(all_content, row, SevenDayField.acc_content))
    index_title = get_str(content[SevenDayField.index_title], '')
    panel   = get_str(content[SevenDayField.panel], '')

    type_list.append("get_type(%d) -> 27;"%(id))
    icon_list.append("get_icon(%d) -> %d;"%(id, icon))
    if name <> '': 
        name_list.append("get_name(%d) -> <<\"%s\">>;"%(id, name))
        php_base_list.append("    %d => array('id' => %d, 'name' => '%s'),"%(id, id, name))

    day_key = str("%d, %d"%(id, day))
    seven_day_index_list.setdefault(day_key, [])
    seven_day_index_list[day_key].append("%d"%(index))

    seven_day_target_list.append("get_seven_day_target(%d, %d, %d) -> %s;"%(id, day, index, target))
    seven_day_items_list.append("get_seven_day_items(%d, %d, %d) -> [%s];"%(id, day, index, items))
    seven_day_scores_list.append("get_seven_day_scores(%d, %d, %d) -> %d;"%(id, day, index, scores))
    seven_day_index_titile_list.append("get_seven_day_index_titile(%d, %d, %d) -> <<\"%s\">>;"%(id, day, index, index_title))
    seven_day_panel_list.append("get_seven_day_panel(%d, %d, %d) -> <<\"%s\">>;"%(id, day, index, panel))

    global old_day
    if day <> old_day:
        seven_day_list.setdefault(id, [])
        seven_day_list[id].append("%d"%(day))
        seven_day_day_titile_list.append("get_seven_day_day_titile(%d, %d) -> <<\"%s\">>;"%(id, day, day_titile))
        seven_day_titile_list.append("get_seven_day_titile(%d, %d) -> <<\"%s\">>;"%(id, day, acc_titile))
        seven_day_content_list.append("get_seven_day_content(%d, %d) -> <<\"%s\">>;"%(id, day, acc_content))

    old_day = day
    return []
get_seven_day()

seven_day_content_list.append("get_seven_day_content(_, _) -> <<\"\">>.")
seven_day_titile_list.append("get_seven_day_titile(_, _) -> <<\"\">>.")
seven_day_target_list.append("get_seven_day_target(_, _, _) -> false.")
seven_day_items_list.append("get_seven_day_items(_, _, _) -> [].")
seven_day_scores_list.append("get_seven_day_scores(_, _, _) -> 0.")
seven_day_index_titile_list.append("get_seven_day_index_titile(_, _, _) -> <<\"\">>.")
seven_day_day_titile_list.append("get_seven_day_day_titile(_, _) -> <<\"\">>.")
seven_day_panel_list.append("get_seven_day_panel(_, _, _) -> <<\"\">>.")

data_fun_activity.extend(seven_day_content_list)
data_fun_activity.extend(seven_day_titile_list)
data_fun_activity.extend(seven_day_target_list)
data_fun_activity.extend(seven_day_items_list)
data_fun_activity.extend(seven_day_scores_list)
data_fun_activity.extend(seven_day_index_titile_list)
data_fun_activity.extend(seven_day_day_titile_list)
data_fun_activity.extend(seven_day_panel_list)

for i in seven_day_index_list:
    data_fun_activity.append("seven_day_index_list(%s) -> [%s];"%(i, ",".join(seven_day_index_list[i])))
data_fun_activity.append("seven_day_index_list(_, _) -> [].")

for i in seven_day_list:
    data_fun_activity.append("seven_day_list(%d) -> [%s];"%(i, ",".join(seven_day_list[i])))
data_fun_activity.append("seven_day_list(_) -> [].")

## ######################################
## 七日特训兑换商店
## ######################################
seven_day_shop_index_list = {}
seven_day_cost_item_list = []
seven_day_get_item_list = []
seven_day_shop_times_list = []

@load_sheel(work_book, ur"七日特训兑换商店")
def get_seven_day_shop(content, all_content, row):
    id          = int(prev(all_content, row, SevenDayShopField.id))
    day         = int(prev(all_content, row, SevenDayShopField.day))
    index       = int(content[SevenDayShopField.index])
    cost_items  = get_str(content[SevenDayShopField.cost_items], '')
    get_items   = get_str(content[SevenDayShopField.get_items], '')
    max_times   = int(content[SevenDayShopField.max_times])

    day_key = str("%d, %d"%(id, day))
    seven_day_shop_index_list.setdefault(day_key, [])
    seven_day_shop_index_list[day_key].append("%d"%(index))
    seven_day_cost_item_list.append("get_seven_day_cost_item(%d, %d, %d) -> [%s];"%(id, day, index, cost_items))
    seven_day_get_item_list.append("get_seven_day_get_item(%d, %d, %d) -> [%s];"%(id, day, index, get_items))
    seven_day_shop_times_list.append("get_seven_day_shop_times(%d, %d, %d) -> %d;"%(id, day, index, max_times))
    
    return []
get_seven_day_shop()

seven_day_cost_item_list.append("get_seven_day_cost_item(_, _, _) -> [].")
seven_day_get_item_list.append("get_seven_day_get_item(_, _, _) -> [].")
seven_day_shop_times_list.append("get_seven_day_shop_times(_, _, _) -> 0.")

data_fun_activity.extend(seven_day_cost_item_list)
data_fun_activity.extend(seven_day_get_item_list)
data_fun_activity.extend(seven_day_shop_times_list)

for i in seven_day_shop_index_list:
    data_fun_activity.append("seven_day_shop_index_list(%s) -> [%s];"%(i, ",".join(seven_day_shop_index_list[i])))
data_fun_activity.append("seven_day_shop_index_list(_, _) -> [].")

## ######################################
## 七日特训排行榜
## ######################################
seven_day_rank_list = {}
seven_day_rank_reward = []
seven_day_rank_titile = []
seven_day_rank_content = []
seven_day_final_score = []
seven_day_final_reward = []

old_id = 0
@load_sheel(work_book, ur"七日特训排行榜")
def get_seven_day_rank(content, all_content, row):
    id          = int(prev(all_content, row, SevenDayRankField.id))
    rank        = int(content[SevenDayRankField.rank])
    items       = get_str(content[SevenDayRankField.items], '')
    scores      = int(prev(all_content, row, SevenDayRankField.scores))
    final_items = get_str(content[SevenDayRankField.final_items], '')
    titile      = str(prev(all_content, row, SevenDayRankField.titile))
    content     = str(prev(all_content, row, SevenDayRankField.content))

    seven_day_rank_list.setdefault(id, [])
    seven_day_rank_list[id].append("%d"%(rank))

    seven_day_rank_reward.append("seven_day_rank_reward(%d, %d) -> [%s];"%(id, rank, items))
    global old_id
    if id <> old_id:
        seven_day_rank_titile.append("seven_day_rank_titile(%d) -> <<\"%s\">>;"%(id, titile))
        seven_day_rank_content.append("seven_day_rank_content(%d) -> <<\"%s\">>;"%(id, content))
        seven_day_final_score.append("seven_day_final_score(%d) -> %d;"%(id, scores))
        seven_day_final_reward.append("seven_day_final_reward(%d) -> [%s];"%(id, final_items))

    old_id = id
    return []
get_seven_day_rank()

seven_day_rank_titile.append("seven_day_rank_titile(_) -> <<"">>.")
seven_day_rank_content.append("seven_day_rank_content(_) -> <<"">>.")
seven_day_rank_reward.append("seven_day_rank_reward(_, _) -> [].")
seven_day_final_score.append("seven_day_final_score(_) -> 0.")
seven_day_final_reward.append("seven_day_final_reward(_) -> [].")


data_fun_activity.extend(seven_day_rank_titile)
data_fun_activity.extend(seven_day_rank_content)
data_fun_activity.extend(seven_day_rank_reward)
data_fun_activity.extend(seven_day_final_score)
data_fun_activity.extend(seven_day_final_reward)

for i in seven_day_rank_list:
    data_fun_activity.append("seven_day_rank_list(%d) -> [%s];"%(i, ",".join(seven_day_rank_list[i])))
data_fun_activity.append("seven_day_rank_list(_) -> [].")

## ######################################
## 充值特惠
## ######################################
discount_index_title = []
discount_reward_list = []
discount_day_list    = {}
discount_bonus_list  = []
discount_hero_id     = []
discount_picture     = []

old_id = 0

@load_sheel(work_book, ur"充值特惠")
def get_discount(content, all_content, row):
    id          = int(prev(all_content, row, ChargeDiscountField.id))
    name        = get_str(content[ChargeDiscountField.name], '')
    day         = int(content[ChargeDiscountField.day])
    gold        = int(content[ChargeDiscountField.gold])
    coin        = int(content[ChargeDiscountField.coin])
    item_list   = get_str(content[ChargeDiscountField.items], '')
    icon        = int(prev(all_content, row, ChargeDiscountField.icon))
    fun_content = get_str(content[ChargeDiscountField.acc_content], '')
    index_title = get_str(content[ChargeDiscountField.index_title], '')
    bonus       = str(prev(all_content, row, ChargeDiscountField.bonus))
    hero_id     = int(prev(all_content, row, ChargeDiscountField.hero_id))
    picture     = int(prev(all_content, row, ChargeDiscountField.picture))

    type_list.append("get_type(%d) -> 28;"%(id))
    icon_list.append("get_icon(%d) -> %d;"%(id, icon))
    discount_reward_list.append("discount_reward_list(%d, %d) -> [{gold, %d}, {coin, %d}]++ [%s];"%(id, day, gold, coin, item_list))
    discount_index_title.append("discount_index_title(%d, %d) -> <<\"%s\">>;"%(id, day, index_title))

    discount_day_list.setdefault(id, [])
    discount_day_list[id].append("%d"%(day))

    global old_id
    if id <> old_id:
        discount_bonus_list.append("get_discount_bonus(%d) -> [%s];"%(id, bonus))
        discount_hero_id.append("get_discount_hero_id(%d) -> %d;"%(id, hero_id))
        discount_picture.append("get_discount_picture(%d) -> <<\"%d\">>;"%(id, picture))
    if name <> '': 
        name_list.append("get_name(%d) -> <<\"%s\">>;"%(id, name))
        php_base_list.append("    %d => array('id' => %d, 'name' => '%s'),"%(id, id, name))
    if fun_content <> '':
        fun_content_list.append("get_fun_content(%d) -> <<\"%s\">>;"%(id, fun_content))
    old_id = id
    return []

get_discount()

discount_reward_list.append("discount_reward_list(_, _) -> [].")
discount_index_title.append("discount_index_title(_, _) -> [].")
discount_bonus_list.append("get_discount_bonus(_) -> [].")
discount_hero_id.append("get_discount_hero_id(_) -> 0.")
discount_picture.append("get_discount_picture(_) -> <<\"\">>.")

data_fun_activity.extend(discount_reward_list)
data_fun_activity.extend(discount_index_title)
data_fun_activity.extend(discount_bonus_list)
data_fun_activity.extend(discount_hero_id)
data_fun_activity.extend(discount_picture)

for i in discount_day_list:
    data_fun_activity.append("discount_day_list(%d) -> [%s];"%(i, ",".join(discount_day_list[i])))
data_fun_activity.append("discount_day_list(_) -> [].")

## ######################################
## 七日转盘
## ######################################
seven_coin_list        = []
seven_coin_day_list    = {}

@load_sheel(work_book, ur"七日转盘")
def get_seven_coin(content, all_content, row):
    id          = int(prev(all_content, row, SevenCoinField.id))
    name        = get_str(content[SevenCoinField.name], '')
    day         = int(content[SevenCoinField.day])
    coin_weight = get_str(content[SevenCoinField.coin_weight], '{}')
    icon        = int(prev(all_content, row, SevenCoinField.icon))
    fun_content = get_str(content[SevenCoinField.acc_content], '')

    type_list.append("get_type(%d) -> 29;"%(id))
    icon_list.append("get_icon(%d) -> %d;"%(id, icon))
    seven_coin_list.append("get_seven_coin_weight(%d, %d) -> tuple_to_list(%s);"%(id, day, coin_weight))

    seven_coin_day_list.setdefault(id, [])
    seven_coin_day_list[id].append("%d"%(day))

    if name <> '': 
        name_list.append("get_name(%d) -> <<\"%s\">>;"%(id, name))
        php_base_list.append("    %d => array('id' => %d, 'name' => '%s'),"%(id, id, name))
    if fun_content <> '':
        fun_content_list.append("get_fun_content(%d) -> <<\"%s\">>;"%(id, fun_content))
    old_id = id
    return []

get_seven_coin()

seven_coin_list.append("get_seven_coin_weight(_, _) -> [].")

data_fun_activity.extend(seven_coin_list)

for i in seven_coin_day_list:
    data_fun_activity.append("seven_coin_day_list(%d) -> [%s];"%(i, ",".join(seven_coin_day_list[i])))
data_fun_activity.append("seven_coin_day_list(_) -> [].")

## ######################################
## 每日充值返利
## ######################################
daily_charge_list = {}
daily_charge_reward_list = []
daily_charge_title_list = []
daily_charge_mail_title = []
daily_charge_mail_content = []

@load_sheel(work_book, ur"每日充值返利")
def get_daily_charge(content, all_content, row):
    id      = int(prev(all_content, row, DailyChargeField.id))
    name    = get_str(content[DailyChargeField.name], '')
    level   = int(content[DailyChargeField.charge_gold])
    gold    = int(content[DailyChargeField.gold])
    coin    = int(content[DailyChargeField.coin])
    item_list = get_str(content[DailyChargeField.items], '')
    icon    = int(prev(all_content, row, DailyChargeField.icon))
    fun_content = get_str(content[DailyChargeField.acc_content], '')
    index_title = get_str(content[DailyChargeField.index_title], '')
    titile  = get_str(content[DailyChargeField.titile], '')
    content = get_str(content[DailyChargeField.content], '')

    type_list.append("get_type(%d) -> 30;"%(id))
    icon_list.append("get_icon(%d) -> %d;"%(id, icon))
    daily_charge_title_list.append("daily_charge_index_title(%d, %d) -> <<\"%s\">>;"%(id, level, index_title))
    daily_charge_mail_title.append("daily_charge_mail_title(%d, %d) -> <<\"%s\">>;"%(id, level, titile))
    daily_charge_mail_content.append("daily_charge_mail_content(%d, %d) -> <<\"%s\">>;"%(id, level, content))
    daily_charge_reward_list.append("daily_charge_reward(%d, %d) -> [%s] ++ [{gold, %d}, {coin, %d}];"%(id, level, item_list, gold, coin))
    if name <> '': 
        name_list.append("get_name(%d) -> <<\"%s\">>;"%(id, name))
        php_base_list.append("    %d => array('id' => %d, 'name' => '%s'),"%(id, id, name))
    if fun_content <> '':
        fun_content_list.append("get_fun_content(%d) -> <<\"%s\">>;"%(id, fun_content))
    daily_charge_list.setdefault(id, [])
    daily_charge_list[id].append("%d"%(level))
    return []
get_daily_charge()
daily_charge_reward_list.append("daily_charge_reward(_, _) -> [].")
daily_charge_title_list.append("daily_charge_index_title(_, _) -> <<\"\">>.")
daily_charge_mail_title.append("daily_charge_mail_title(_, _) -> <<\"\">>.")
daily_charge_mail_content.append("daily_charge_mail_content(_, _) -> <<\"\">>.")

data_fun_activity.extend(daily_charge_reward_list)
data_fun_activity.extend(daily_charge_title_list)
data_fun_activity.extend(daily_charge_mail_title)
data_fun_activity.extend(daily_charge_mail_content)

for i in daily_charge_list:
    data_fun_activity.append("daily_charge_list(%d) -> [%s];"%(i, ",".join(daily_charge_list[i])))
data_fun_activity.append("daily_charge_list(_) -> [].")


## ######################################
## 首充豪礼
## ######################################
charge_award_list = {}
charge_award_reward_list = []
charge_award_hero_id = []
charge_award_picture = []
charge_award_start_day = []

old_id = 0
@load_sheel(work_book, ur"首充豪礼")
def get_charge_award(content, all_content, row):
    id      = int(prev(all_content, row, ChargeAwardField.id))
    name    = get_str(content[ChargeAwardField.name], '')
    charge_day = int(prev(all_content, row, ChargeAwardField.charge_day))
    day   = int(content[ChargeAwardField.day])
    gold    = int(content[ChargeAwardField.gold])
    coin    = int(content[ChargeAwardField.coin])
    item_list = get_str(content[ChargeAwardField.items], '')
    icon    = int(prev(all_content, row, ChargeAwardField.icon))
    fun_content = get_str(content[ChargeAwardField.acc_content], '')
    hero_id = int(prev(all_content, row, ChargeAwardField.hero_id))
    picture = get_str(content[ChargeAwardField.picture], '<<>>')
    global old_id
    if old_id != id:
        charge_award_hero_id.append("charge_award_hero_id(%d) -> %d;"%(id, hero_id))
        charge_award_picture.append("charge_award_picture(%d) -> <<\"%s\">>;"%(id, picture))
        charge_award_start_day.append("charge_award_day(%d) -> %d;"%(id, charge_day))
    old_id = id
    type_list.append("get_type(%d) -> 31;"%(id))
    icon_list.append("get_icon(%d) -> %d;"%(id, icon))

    charge_award_reward_list.append("charge_award_reward(%d, %d) -> [%s] ++ [{gold, %d}, {coin, %d}];"%(id, day, item_list, gold, coin))
    
    if name <> '': 
        name_list.append("get_name(%d) -> <<\"%s\">>;"%(id, name))
        php_base_list.append("    %d => array('id' => %d, 'name' => '%s'),"%(id, id, name))
    if fun_content <> '':
        fun_content_list.append("get_fun_content(%d) -> <<\"%s\">>;"%(id, fun_content))
    charge_award_list.setdefault(id, [])
    charge_award_list[id].append("%d"%(day))
    return []
get_charge_award()
charge_award_reward_list.append("charge_award_reward(_, _) -> [].")
charge_award_hero_id.append("charge_award_hero_id(_) -> 0.")
charge_award_picture.append("charge_award_picture(_) -> <<\"\">>.")
charge_award_start_day.append("charge_award_day(_) -> 0.")

data_fun_activity.extend(charge_award_reward_list)
data_fun_activity.extend(charge_award_hero_id)
data_fun_activity.extend(charge_award_picture)
data_fun_activity.extend(charge_award_start_day)
for i in charge_award_list:
    data_fun_activity.append("charge_award_list(%d) -> [%s];"%(i, ",".join(charge_award_list[i])))
data_fun_activity.append("charge_award_list(_) -> [].")

## ######################################
## 图纸转盘
## ######################################
paper_dial_type_list = {}

paper_dial_change_time = []
paper_dial_gold = []
paper_dial_ten_gold = []
paper_dial_score = []
paper_dial_score_weight = []
paper_dial_items_list = []
paper_dial_score_items = []

old_id = 0
@load_sheel(work_book, ur"图纸转盘")
def get_paper_dial(content, all_content, row):
    id          = int(prev(all_content, row, PaperDialField.id))
    change_time = int(prev(all_content, row, PaperDialField.change_time))
    gold        = int(prev(all_content, row, PaperDialField.gold))
    ten_gold    = int(prev(all_content, row, PaperDialField.ten_gold))
    score       = int(prev(all_content, row, PaperDialField.score))
    score_weight= str(prev(all_content, row, PaperDialField.score_weight))
    type        = int(content[PaperDialField.type])
    items       = get_str(content[PaperDialField.items], '')
    score_items = get_str(content[PaperDialField.score_items], '')
    name    = get_str(content[PaperDialField.name], '')
    icon    = int(prev(all_content, row, PaperDialField.icon))
    fun_content = get_str(content[PaperDialField.acc_content], '')

    global old_id
    if id <> old_id:
        paper_dial_change_time.append("get_paper_dial_change_time(%d) -> %d;"%(id, change_time))
        paper_dial_gold.append("get_paper_dial_gold(%d) -> %d;"%(id, gold))
        paper_dial_ten_gold.append("get_paper_dial_ten_gold(%d) -> %d;"%(id, ten_gold))
        paper_dial_score.append("get_paper_dial_score(%d) -> %d;"%(id, score))
        paper_dial_score_weight.append("get_paper_dial_score_weight(%d) -> [%s];"%(id, score_weight))

    old_id = id
    paper_dial_type_list.setdefault(id, [])
    paper_dial_type_list[id].append("%d"%(type))

    paper_dial_items_list.append("get_paper_dial_item_list(%d, %d) -> [%s];"%(id, type, items))
    paper_dial_score_items.append("get_paper_dial_score_items(%d, %d) -> [%s];"%(id, type, score_items))

    type_list.append("get_type(%d) -> 34;"%(id))
    icon_list.append("get_icon(%d) -> %d;"%(id, icon))
    if name <> '': 
        name_list.append("get_name(%d) -> <<\"%s\">>;"%(id, name))
        php_base_list.append("    %d => array('id' => %d, 'name' => '%s'),"%(id, id, name))
    if fun_content <> '':
        fun_content_list.append("get_fun_content(%d) -> <<\"%s\">>;"%(id, fun_content))

    return []
get_paper_dial()

paper_dial_change_time.append("get_paper_dial_change_time(_) -> 999999.")
paper_dial_gold.append("get_paper_dial_gold(_) -> 99999.")
paper_dial_ten_gold.append("get_paper_dial_ten_gold(_) -> 9999999.")
paper_dial_score.append("get_paper_dial_score(_) -> 0.")
paper_dial_score_weight.append("get_paper_dial_score_weight(_) -> [].")
paper_dial_items_list.append("get_paper_dial_item_list(_, _) -> [].")
paper_dial_score_items.append("get_paper_dial_score_items(_, _) -> [].")

data_fun_activity.extend(paper_dial_change_time)
data_fun_activity.extend(paper_dial_gold)
data_fun_activity.extend(paper_dial_ten_gold)
data_fun_activity.extend(paper_dial_score)
data_fun_activity.extend(paper_dial_score_weight)
data_fun_activity.extend(paper_dial_items_list)
data_fun_activity.extend(paper_dial_score_items)

for i in paper_dial_type_list:
    data_fun_activity.append("paper_dial_type_list(%d) -> [%s];"%(i, ",".join(paper_dial_type_list[i])))
data_fun_activity.append("paper_dial_type_list(_) -> [].")

## ######################################
## 限时特卖
## ######################################
limited_shop_list = {}
get_limited_shop_list = []

@load_sheel(work_book, ur"限时特卖")
def get_limited_shop(content, all_content, row):
    id          = int(prev(all_content, row, LimitedShopField.id))
    name        = get_str(content[LimitedShopField.name], '')
    index       = int(content[LimitedShopField.index])
    item_id     = int(content[LimitedShopField.item_id])
    item_num    = int(content[LimitedShopField.item_num])
    buy_times   = int(content[LimitedShopField.buy_times]) 
    price       = int(content[LimitedShopField.price])
    reprice     = int(content[LimitedShopField.reprice])
    vip         = int(content[LimitedShopField.vip])
    icon          = int(prev(all_content, row, LimitedShopField.icon))
    fun_content = get_str(content[LimitedShopField.acc_content], '')
    titile      = get_str(content[LimitedShopField.titile], '')

    get_limited_shop_list.append("get_limited_shop(%d, %d) -> {%d, %d, %d, %d, %d, %d, <<\"%s\">>};"%(id, index, item_id, item_num, buy_times, price, reprice, vip, titile))

    limited_shop_list.setdefault(id, [])
    limited_shop_list[id].append("%d"%(index))

    type_list.append("get_type(%d) -> 35;"%(id))
    icon_list.append("get_icon(%d) -> %d;"%(id, icon))
    if name <> '': 
        name_list.append("get_name(%d) -> <<\"%s\">>;"%(id, name))
        php_base_list.append("    %d => array('id' => %d, 'name' => '%s'),"%(id, id, name))
    if fun_content <> '':
        fun_content_list.append("get_fun_content(%d) -> <<\"%s\">>;"%(id, fun_content))

    return []
get_limited_shop()

get_limited_shop_list.append("get_limited_shop(_, _) -> false.")
data_fun_activity.extend(get_limited_shop_list)


for i in limited_shop_list:
    data_fun_activity.append("limited_shop_list(%d) -> [%s];"%(i, ",".join(limited_shop_list[i])))
data_fun_activity.append("limited_shop_list(_) -> [].")

## ######################################
## 橙色风暴
## ######################################
charge_reward_list = {}
get_charge_reward_list = []

@load_sheel(work_book, ur"橙色风暴")
def get_charge_reward(content, all_content, row):
    id          = int(prev(all_content, row, ChargeRewardField.id))
    name        = get_str(content[ChargeRewardField.name], '')
    index       = int(content[ChargeRewardField.index])
    gold        = int(content[ChargeRewardField.gold])
    item        = get_str(content[ChargeRewardField.item], '')
    titile      = get_str(content[ChargeRewardField.titile], '')
    last_time   = int(content[ChargeRewardField.last_time])
    icon        = int(prev(all_content, row, ChargeRewardField.icon))
    fun_content = get_str(content[ChargeRewardField.acc_content], '')

    get_charge_reward_list.append("get_charge_reward(%d, %d) -> {%d, %d, [%s], <<\"%s\">>};"%(id, index, gold, last_time, item, titile))

    charge_reward_list.setdefault(id, [])
    charge_reward_list[id].append("%d"%(index))

    type_list.append("get_type(%d) -> 36;"%(id))
    icon_list.append("get_icon(%d) -> %d;"%(id, icon))
    if name <> '': 
        name_list.append("get_name(%d) -> <<\"%s\">>;"%(id, name))
        php_base_list.append("    %d => array('id' => %d, 'name' => '%s'),"%(id, id, name))
    if fun_content <> '':
        fun_content_list.append("get_fun_content(%d) -> <<\"%s\">>;"%(id, fun_content))

    return []
get_charge_reward()

get_charge_reward_list.append("get_charge_reward(_, _) -> false.")
data_fun_activity.extend(get_charge_reward_list)

for i in charge_reward_list:
    data_fun_activity.append("charge_reward_list(%d) -> [%s];"%(i, ",".join(charge_reward_list[i])))
data_fun_activity.append("charge_reward_list(_) -> [].")

## ######################################
## 扩充返还
## ######################################
hero_max_num_list = []
@load_sheel(work_book, ur"扩充返还")
def get_hero_max_num(content, all_content, row):
    id          = int(content[HeroMaxNumField.id])
    name        = get_str(content[HeroMaxNumField.name], '')
    icon        = int(content[HeroMaxNumField.icon])
    fun_content = get_str(content[HeroMaxNumField.acc_content], '')
    level       = int(content[HeroMaxNumField.level])

    hero_max_num_list.append("hero_max_num_level(%d) -> %d;"%(id, level))

    type_list.append("get_type(%d) -> 37;"%(id))
    icon_list.append("get_icon(%d) -> %d;"%(id, icon))
    if name <> '': 
        name_list.append("get_name(%d) -> <<\"%s\">>;"%(id, name))
        php_base_list.append("    %d => array('id' => %d, 'name' => '%s'),"%(id, id, name))
    if fun_content <> '':
        fun_content_list.append("get_fun_content(%d) -> <<\"%s\">>;"%(id, fun_content))

    return []
get_hero_max_num()

hero_max_num_list.append("hero_max_num_level(_) -> 99999999.")
data_fun_activity.extend(hero_max_num_list)

## ######################################
## 精英特训返还
## ######################################
hero_elite_qua_list = []
@load_sheel(work_book, ur"精英特训返还")
def get_hero_elite_qua(content, all_content, row):
    id          = int(content[HeroEliteField.id])
    name        = get_str(content[HeroEliteField.name], '')
    icon        = int(content[HeroEliteField.icon])
    fun_content = get_str(content[HeroEliteField.acc_content], '')
    level       = int(content[HeroEliteField.level])

    hero_elite_qua_list.append("hero_elite_qua_level(%d) -> %d;"%(id, level))

    type_list.append("get_type(%d) -> 38;"%(id))
    icon_list.append("get_icon(%d) -> %d;"%(id, icon))
    if name <> '': 
        name_list.append("get_name(%d) -> <<\"%s\">>;"%(id, name))
        php_base_list.append("    %d => array('id' => %d, 'name' => '%s'),"%(id, id, name))
    if fun_content <> '':
        fun_content_list.append("get_fun_content(%d) -> <<\"%s\">>;"%(id, fun_content))

    return []
get_hero_elite_qua()

hero_elite_qua_list.append("hero_elite_qua_level(_) -> 99999999.")
data_fun_activity.extend(hero_elite_qua_list)

######################################################################################

type_list.append("get_type(_) -> 0.")
icon_list.append("get_icon(_) -> 0.")
name_list.append("get_name(_) -> <<>>.")
fun_content_list.append("get_fun_content(_) -> <<>>.")
php_base_list.append(");")
data_fun_activity.extend(double_coin_did_list)
data_fun_activity.extend(double_coin_dungeon_type)
data_fun_activity.extend(double_coin_mul)
data_fun_activity.extend(unique_list(type_list))
data_fun_activity.extend(unique_list(icon_list))
data_fun_activity.extend(unique_list(name_list))
data_fun_activity.extend(unique_list(fun_content_list))
gen_erl(fun_activity_erl, data_fun_activity)

php_data_act.extend(php_base_list)
gen_php(act_php, php_data_act)
