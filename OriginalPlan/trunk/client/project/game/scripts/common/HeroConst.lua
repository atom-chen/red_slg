--
-- Author: wdx
-- Date: 2014-05-27 17:33:43
--

local HeroConst = {}

HeroConst.HP = "hp"
HeroConst.MAXHP = "maxHp"
HeroConst.SPEED = "speed"

HeroConst.MAINY_ATK = "main_atk"
HeroConst.MINOR_ATK  = "minor_atk"
HeroConst.DEF = "def"

HeroConst.CRIT_FACTOR = "crit_factor"
HeroConst.ANTI_CRIT = "anti_crit"
HeroConst.CRIT = "crit"
HeroConst.HIT = "hit"
HeroConst.DODGE = "dodge"

HeroConst.MAIN_ATK_CD = "main_atkCD"
HeroConst.MINOR_ATK_CD = "minor_atkCD"

HeroConst.PHY_CRIT = "phy_crit_lev"
HeroConst.MG_CRIT = "mp_crit_lev"
HeroConst.PHY_DODGE = "phy_dodge_lev"
HeroConst.MG_DODGE = "mp_dodge_lev"

HeroConst.CAREER = "career"

HeroConst.Attribute = {HeroConst.HP,HeroConst.MAXHP,HeroConst.SPEED,HeroConst.MAINY_ATK,HeroConst.MINOR_ATK
					,HeroConst.MAIN_ATK_CD,HeroConst.MINOR_ATK_CD,HeroConst.DEF,HeroConst.CRIT_FACTOR
					,HeroConst.ANTI_CRIT,HeroConst.CRIT,HeroConst.HIT,HeroConst.DODGE }

HeroConst.opposeImage1 = {[1]='#role_shitou1.png', [2]='#role_jiandao1.png', [3]='#role_bu1.png'}
HeroConst.opposeImage = {[1]='#role_shitou.png', [2]='#role_jiandao.png', [3]='#role_bu.png'}

HeroConst.careerImage1 = {[1]='#role_001.png', [2]='#role_002.png', [3]='#role_003.png',
						[4]='#role_004.png', [5]='#role_005.png', [6]='#role_006.png',
						[7]='#role_007.png', [8]='#role_008.png', [9]='#role_009.png',}


HeroConst.careerImage = {[1]='#com_career_1.png', [2]='#com_career_2.png', [3]='#com_career_3.png',
						[4]='#com_career_4.png', [5]='#com_career_5.png', [6]='#com_career_6.png',
						[7]='#com_career_7.png', [8]='#com_career_8.png', [9]='#com_career_9.png',}
HeroConst.careerImage2 = {[1]='#com_career_1a.png', [2]='#com_career_2a.png', [3]='#com_career_3a.png',
						[4]='#com_career_4a.png', [5]='#com_career_5a.png', [6]='#com_career_6a.png',
						[7]='#com_career_7a.png', [8]='#com_career_8a.png', [9]='#com_career_9a.png',}

HeroConst.opposeImage_2 = {[1]='#role_shitou1.png', [2]='#role_jiandao1.png', [3]='#role_bu1.png'}

return HeroConst
