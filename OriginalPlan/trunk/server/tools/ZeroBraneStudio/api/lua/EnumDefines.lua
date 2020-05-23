require "api/lua/cpprootdir"
require "api/lua/cppapi"

do return{
EServerDefine = {
	type = "lib",
	description = "EServerDefine",
	childs = {
		MAX_SKILL_COOL_DOWN_NUM = {
			type = "value",
			description = "value=20"
		},
		MAX_ITEM_COOL_DOWN_NUM = {
			type = "value",
			description = "value=20"
		},
		MAX_SKILL_COMM_COOL_DOWN_NUM = {
			type = "value",
			description = "value=20"
		},
		MAX_ITEM_COMM_COOL_DOWN_NUM = {
			type = "value",
			description = "value=20"
		},
		MAX_BUFF_PARAM_NUM = {
			type = "value",
			description = "value=10"
		},
		MAX_BUFF_DB_NUM = {
			type = "value",
			description = "value=30"
		},
		ITEM_APPEDN_ATTR_NUM = {
			type = "value",
			description = "value=5"
		},
		ITEM_MAX_HOLE_TOTAL_NUM = {
			type = "value",
			description = "value=10"
		},
		MAX_ITEM_CURR_HOLE_NUM = {
			type = "value",
			description = "value=6"
		},
		ITEM_MAX_EXTRA_ATTR_NUM = {
			type = "value",
			description = "value=20"
		},
		ITEM_BASE_ATTR_NUM = {
			type = "value",
			description = "value=9"
		},
		ITEM_MAX_STRE_LEVEL = {
			type = "value",
			description = "value=12"
		},
		ROLE_NAME_LEN = {
			type = "value",
			description = "value=32"
		},
		MAX_BASE_RATE = {
			type = "value",
			description = "value=10000"
		},
		MAX_PASSWORD_LEN = {
			type = "value",
			description = "value=50"
		},
		MAX_SCENE_NUM = {
			type = "value",
			description = "value=20"
		},
		MAX_MAP_SERVER = {
			type = "value",
			description = "value=10"
		},
		MAX_TRANS_SIZE = {
			type = "value",
			description = "value=65535"
		},
		MAX_SCENE_DATA_UPDATE_TIME = {
			type = "value",
			description = "value=3"
		},
		GUILD_NAME_LEN = {
			type = "value",
			description = "value=22"
		},
		MAX_AREA_IN_BLOCK = {
			type = "value",
			description = "value=10"
		},
		MAX_RAND_POS_NUM = {
			type = "value",
			description = "value=32"
		},
		MAX_SKILL_LEVEL = {
			type = "value",
			description = "value=100"
		},
		MAX_LEVEL = {
			type = "value",
			description = "value=80"
		},
		MIN_LEVEL = {
			type = "value",
			description = "value=1"
		},
		MAX_ROLE_NUM_SAVE_NUM = {
			type = "value",
			description = "value=13"
		},
		MAX_ROLE_SAVE_SEC = {
			type = "value",
			description = "value=600"
		},
		MAX_GM_CMD_LENGTH = {
			type = "value",
			description = "value=500"
		},
		GUAN_QIA_FAULT_LIMIT_NUM = {
			type = "value",
			description = "value=10000"
		},
		MAX_MISSION_EVENT_NUM = {
			type = "value",
			description = "value=256"
		},
		MIN_RECORDE_BUFF_SEND_SIZE = {
			type = "value",
			description = "value=50000"
		},
		MAX_RECORDE_BUFF_SIZE = {
			type = "value",
			description = "value=60000"
		},
		DEFAULT_RECORDE_UPDATE_TIME = {
			type = "value",
			description = "value=10000"
		},
		DEFAULT_RECORDE_MAX_TIMES = {
			type = "value",
			description = "value=30"
		},
		MAX_REOCRDE_SQL_LEN = {
			type = "value",
			description = "value=4096"
		},
		MAX_RECORDE_SECTION_SIZE = {
			type = "value",
			description = "value=8192"
		},
		MAX_RECORDE_SECTION_NUM = {
			type = "value",
			description = "value=8"
		},
		MAX_COMPRESS_LEN = {
			type = "value",
			description = "value=65000"
		},
		MAX_PLAYER_ACCOUNT_LEN = {
			type = "value",
			description = "value=15"
		},
		MAX_PLAYER_PASSWORD_LEN = {
			type = "value",
			description = "value=15"
		},
		MAX_ROLE_NUM = {
			type = "value",
			description = "value=50"
		},
		MAX_ATTACKOR_NUM = {
			type = "value",
			description = "value=50"
		},
		MAX_MOVE_STEP = {
			type = "value",
			description = "value=3"
		},
		MAX_ARRAY_NUM = {
			type = "value",
			description = "value=100"
		},
		MAX_ARRAY2_NUM = {
			type = "value",
			description = "value=100"
		},
		MAX_CHAR_ARRAY1_NUM = {
			type = "value",
			description = "value=250"
		},
		MAX_CHAR_ARRAY2_NUM = {
			type = "value",
			description = "value=250"
		},
		MAX_SYNC_DATA_LEN = {
			type = "value",
			description = "value=1024"
		},
		MAX_SEND_BUFFER_NUM = {
			type = "value",
			description = "value=500"
		},
		ATTR_CHAR_TOTAL_MAX = {
			type = "value",
			description = "value=30"
		},
		MAX_SKILL_NUM = {
			type = "value",
			description = "value=50"
		},
		MAX_MISSION_CURR_PARAM_NUM = {
			type = "value",
			description = "value=5"
		},
		MAX_MISSION_TOTAL_PARAM_NUM = {
			type = "value",
			description = "value=10"
		},
		MAX_CHAR_EXIST_MISSION_NUM = {
			type = "value",
			description = "value=50"
		},
		MAX_CHAR_FINISH_MISSION_NUM = {
			type = "value",
			description = "value=4000"
		},
		MAX_CHART_UPDATE_MOVE_TIME = {
			type = "value",
			description = "value=200"
		},
		MAX_SPEED_BASE_NUM = {
			type = "value",
			description = "value=560"
		},
		MAX_MOVE_STEP_PER_HUNDRED_SEC = {
			type = "value",
			description = "value=350"
		},
		MAX_MOVE_POS_NUM = {
			type = "value",
			description = "value=3"
		},
		MAX_CHECK_MOVE_TIME = {
			type = "value",
			description = "value=3"
		},
		ROLE_MANAGER_PROFILE_TIME = {
			type = "value",
			description = "value=10"
		},
		GUAN_QIA_GUA_JI_OVER_TIME = {
			type = "value",
			description = "value=3600"
		},
		MAX_ROLE_USER_DATA_UPDATE_TIME = {
			type = "value",
			description = "value=10000"
		},
		MAX_ALL_USER_NUM = {
			type = "value",
			description = "value=15000"
		},
		WORLD_PLAYER_MANGER_PROFILE_TIME = {
			type = "value",
			description = "value=10"
		},
		MAX_LOGIN_PLAYER_WAIT_SEC = {
			type = "value",
			description = "value=10"
		},
		CLOSE_SOCKET_WAIT_TIME = {
			type = "value",
			description = "value=2"
		},
		MAX_WORLD_MAPSERVER_ROLE_DIFF_NUM = {
			type = "value",
			description = "value=20"
		},
		MAX_RISK_SCENE_LAST_ENTER_TIME = {
			type = "value",
			description = "value=60"
		},
		DEFAULT_CHECK_ROLE_LIMIT_TIME = {
			type = "value",
			description = "value=10"
		},
		MAX_ROLE_LOGOUT_TIME = {
			type = "value",
			description = "value=20"
		},
		MAX_BUFF_NEED_SAVE_TIME = {
			type = "value",
			description = "value=10"
		},
		MAX_SYNC_SHAPE_TIME = {
			type = "value",
			description = "value=500"
		},
		MAX_MONSTER_RAND_MOVE_TIME = {
			type = "value",
			description = "value=10"
		},
		MAX_SKILL_ID = {
			type = "value",
			description = "value=1000"
		},
		SKILL_COMM_COOL_DOWN_ID = {
			type = "value",
			description = "value=0"
		},
	}
},
EPackType = {
	type = "lib",
	description = "EPackType",
	childs = {
		PACK_TYPE_INVALID = {
			type = "value",
			description = "value=0"
		},
		PACK_TYPE_BAG = {
			type = "value",
			description = "value=1"
		},
		PACK_TYPE_EQUIP = {
			type = "value",
			description = "value=2"
		},
		PACKET_TABLE_TYPE_NUMBER = {
			type = "value",
			description = "value=3"
		},
	}
},
EItemType = {
	type = "lib",
	description = "EItemType",
	childs = {
		ITEM_TYPE_INVALID = {
			type = "value",
			description = "value=0"
		},
		ITEM_TYPE_EQUIP = {
			type = "value",
			description = "value=1"
		},
		ITEM_TYPE_DRUG = {
			type = "value",
			description = "value=2"
		},
		ITEM_TYPE_CONSUME = {
			type = "value",
			description = "value=3"
		},
		ITEM_TYPE_SCROLL = {
			type = "value",
			description = "value=4"
		},
		ITEM_TYPE_SKILL_BOOK = {
			type = "value",
			description = "value=5"
		},
		ITEM_TYPE_GEM = {
			type = "value",
			description = "value=6"
		},
		ITEM_TYPE_BUFFER = {
			type = "value",
			description = "value=7"
		},
		ITEM_TYPE_NUMBER = {
			type = "value",
			description = "value=8"
		},
	}
},
EOptEquipType = {
	type = "lib",
	description = "EOptEquipType",
	childs = {
		OPT_EQUIP_INVALID = {
			type = "value",
			description = "value=0"
		},
		OPT_EQUIP_CAN = {
			type = "value",
			description = "value=1"
		},
		OPT_EQUIP_CAN_NOT = {
			type = "value",
			description = "value=2"
		},
	}
},
EDestroyType = {
	type = "lib",
	description = "EDestroyType",
	childs = {
		DESTROY_TYPE_CAN = {
			type = "value",
			description = "value=1"
		},
		DESTROY_TYPE_CANT = {
			type = "value",
			description = "value=2"
		},
	}
},
ESellLimit = {
	type = "lib",
	description = "ESellLimit",
	childs = {
		SELL_LIMIT_CAN = {
			type = "value",
			description = "value=1"
		},
		SELL_LIMIT_CANT = {
			type = "value",
			description = "value=2"
		},
	}
},
EJobLimit = {
	type = "lib",
	description = "EJobLimit",
	childs = {
		JOB_LIMIT_NORMAL = {
			type = "value",
			description = "value=4"
		},
	}
},
ESexLimit = {
	type = "lib",
	description = "ESexLimit",
	childs = {
		SEX_LIMIT_MALE = {
			type = "value",
			description = "value=1"
		},
		SEX_LIMIT_FEMALE = {
			type = "value",
			description = "value=2"
		},
		SEX_LIMIT_NORMAL = {
			type = "value",
			description = "value=3"
		},
	}
},
EEquipType = {
	type = "lib",
	description = "EEquipType",
	childs = {
		EQUIP_TYPE_INVALID = {
			type = "value",
			description = "value=0"
		},
		EQUIP_TYPE_START = {
			type = "value",
			description = "value=1"
		},
		EQUIP_TYPE_ARM = {
			type = "value",
			description = "value=1"
		},
		EQUIP_TYPE_ARMET = {
			type = "value",
			description = "value=2"
		},
		EQUIP_TYPE_SHOULDER = {
			type = "value",
			description = "value=3"
		},
		EQUIP_TYPE_ARMOR = {
			type = "value",
			description = "value=4"
		},
		EQUIP_TYPE_BELT = {
			type = "value",
			description = "value=5"
		},
		EQUIP_TYPE_LEG = {
			type = "value",
			description = "value=6"
		},
		EQUIP_TYPE_BOOTS = {
			type = "value",
			description = "value=7"
		},
		EQUIP_TYPE_NECKLACE = {
			type = "value",
			description = "value=8"
		},
		EQUIP_TYPE_GALLUS = {
			type = "value",
			description = "value=9"
		},
		EQUIP_TYPE_RING = {
			type = "value",
			description = "value=10"
		},
		EQUIP_TYPE_WRIST = {
			type = "value",
			description = "value=11"
		},
		EQUIP_TYPE_GLOVE = {
			type = "value",
			description = "value=12"
		},
		EQUIP_TYPE_FASHION = {
			type = "value",
			description = "value=13"
		},
		EQUIP_TYPE_NUMBER = {
			type = "value",
			description = "value=14"
		},
		EQUIP_TYPE_POS_NUM = {
			type = "value",
			description = "value=15"
		},
	}
},
EDrugSubClass = {
	type = "lib",
	description = "EDrugSubClass",
	childs = {
		DRUG_SUB_CLASS_HP = {
			type = "value",
			description = "value=1"
		},
		DRUG_SUB_CLASS_MP = {
			type = "value",
			description = "value=2"
		},
		DRUG_SUB_CLASS_PET_HP = {
			type = "value",
			description = "value=3"
		},
	}
},
EConsumeSubClass = {
	type = "lib",
	description = "EConsumeSubClass",
	childs = {
		CONSUME_SUB_CLASS_TASK = {
			type = "value",
			description = "value=1"
		},
		CONSUME_SUB_CLASS_RELIVE = {
			type = "value",
			description = "value=2"
		},
		CONSUME_SUB_CLASS_HORN = {
			type = "value",
			description = "value=3"
		},
		CONSUME_SUB_CLASS_FLY_SHOES = {
			type = "value",
			description = "value=4"
		},
		CONSUME_SUB_CLASS_TAN_HE_LING = {
			type = "value",
			description = "value=5"
		},
		CONSUME_SUB_CLASS_TONG_YA_LING = {
			type = "value",
			description = "value=6"
		},
		CONSUME_SUB_CLASS_TRAVEL_CARD = {
			type = "value",
			description = "value=7"
		},
		CONSUME_SUB_CLASS_CROP = {
			type = "value",
			description = "value=8"
		},
		CONSUME_SUB_CLASS_SHOVEL = {
			type = "value",
			description = "value=9"
		},
	}
},
ESkillBookSubClass = {
	type = "lib",
	description = "ESkillBookSubClass",
	childs = {
		SKILL_BOOK_SUB_CLASS_ROLE = {
			type = "value",
			description = "value=0"
		},
		SKILL_BOOK_SUB_CLASS_PET = {
			type = "value",
			description = "value=1"
		},
	}
},
EGemSubClass = {
	type = "lib",
	description = "EGemSubClass",
	childs = {
		GEM_SUB_CLASS_INVALID = {
			type = "value",
			description = "value=0"
		},
		GEM_SUB_CLASS_INLAY = {
			type = "value",
			description = "value=1"
		},
		GEM_SUB_CLASS_WASH = {
			type = "value",
			description = "value=2"
		},
		GEM_SUB_CLASS_RISE_STAR = {
			type = "value",
			description = "value=3"
		},
		GEM_SUB_CLASS_ATTR = {
			type = "value",
			description = "value=4"
		},
		GEM_SUB_CLASS_GROW_UP = {
			type = "value",
			description = "value=5"
		},
		GEM_SUB_CLASS_LOCK_ATTR = {
			type = "value",
			description = "value=6"
		},
	}
},
EBufferSubClass = {
	type = "lib",
	description = "EBufferSubClass",
	childs = {
		BUFF_SUB_INVALID = {
			type = "value",
			description = "value=0"
		},
		BUFF_SUB_ITEM = {
			type = "value",
			description = "value=1"
		},
		BUFF_SUB_ROLE_HP = {
			type = "value",
			description = "value=2"
		},
		BUFF_SUB_ROLE_MP = {
			type = "value",
			description = "value=3"
		},
		BUFF_SUB_PET_HP = {
			type = "value",
			description = "value=4"
		},
		BUFF_SUB_ROLE_EXP = {
			type = "value",
			description = "value=5"
		},
		BUFF_SUB_ROLE_GOLD = {
			type = "value",
			description = "value=6"
		},
	}
},
EScrollSubClass = {
	type = "lib",
	description = "EScrollSubClass",
	childs = {
		SCROLL_SUB_INVALID = {
			type = "value",
			description = "value=0"
		},
	}
},
EEquipQuality = {
	type = "lib",
	description = "EEquipQuality",
	childs = {
		EQUIP_QUALITY_INVALID = {
			type = "value",
			description = "value=0"
		},
		EQUIP_QUALITY_WRITE = {
			type = "value",
			description = "value=1"
		},
		EQUIP_QUALITY_GREEN = {
			type = "value",
			description = "value=2"
		},
		EQUIP_QUALITY_BLUE = {
			type = "value",
			description = "value=3"
		},
		EQUIP_QUALITY_PURPLE = {
			type = "value",
			description = "value=4"
		},
		EQUIP_QUALITY_NUMBER = {
			type = "value",
			description = "value=5"
		},
	}
},
EGemQuality = {
	type = "lib",
	description = "EGemQuality",
	childs = {
		GEM_QUALITY_ONE = {
			type = "value",
			description = "value=1"
		},
		GEM_QUALITY_TWO = {
			type = "value",
			description = "value=2"
		},
		GEM_QUALITY_THR = {
			type = "value",
			description = "value=3"
		},
		GEM_QUALITY_FOUR = {
			type = "value",
			description = "value=4"
		},
		GEM_QUALITY_FIVE = {
			type = "value",
			description = "value=5"
		},
		GEM_QUALITY_SIX = {
			type = "value",
			description = "value=6"
		},
		GEM_QUALITY_NUMBER = {
			type = "value",
			description = "value=7"
		},
	}
},
EItemExtremum = {
	type = "lib",
	description = "EItemExtremum",
	childs = {
		ITEM_EXTREMUM_MAX_STRE_LEVEL = {
			type = "value",
			description = "value=12"
		},
		ITEM_EXTREMUM_MAX_APPEND_NUM = {
			type = "value",
			description = "value=9"
		},
	}
},
EBindType = {
	type = "lib",
	description = "EBindType",
	childs = {
		BIND_TYPE_INVALID = {
			type = "value",
			description = "value=0"
		},
		BIND_TYPE_UNBIND = {
			type = "value",
			description = "value=1"
		},
		BIND_TYPE_BIND = {
			type = "value",
			description = "value=2"
		},
		BIND_TYPE_EQUIP = {
			type = "value",
			description = "value=3"
		},
	}
},
EItemAttrBindType = {
	type = "lib",
	description = "EItemAttrBindType",
	childs = {
		ITEM_ATTR_TYPE_INVALID = {
			type = "value",
			description = "value=0"
		},
		ITEM_ATTR_TYPE_UNBIND = {
			type = "value",
			description = "value=1"
		},
		ITEM_ATTR_TYPE_BIND = {
			type = "value",
			description = "value=2"
		},
		ITEM_ATTR_TYPE_BIND_ALL = {
			type = "value",
			description = "value=3"
		},
	}
},
EItemExtAttrType = {
	type = "lib",
	description = "EItemExtAttrType",
	childs = {
		ITEM_ATTR_EXT_TYPE_BIND = {
			type = "value",
			description = "value=1"
		},
		ITEM_ATTR_EXT_TYPE_STRE = {
			type = "value",
			description = "value=2"
		},
	}
},
EAwardType = {
	type = "lib",
	description = "EAwardType",
	childs = {
		AWARD_INVALID = {
			type = "value",
			description = "value=0"
		},
		AWARD_EXP = {
			type = "value",
			description = "value=1"
		},
		AWARD_MONEY = {
			type = "value",
			description = "value=2"
		},
		AWARD_RMB = {
			type = "value",
			description = "value=3"
		},
		AWARD_BIND_RMB = {
			type = "value",
			description = "value=4"
		},
		AWARD_ITEM = {
			type = "value",
			description = "value=5"
		},
	}
},
EBagOperateType = {
	type = "lib",
	description = "EBagOperateType",
	childs = {
		BAG_OPERATE_TYPE_INVALID = {
			type = "value",
			description = "value=0"
		},
		BAG_OPERATE_TYPE_DROP = {
			type = "value",
			description = "value=1"
		},
		BAG_OPERATE_TYPE_USE = {
			type = "value",
			description = "value=2"
		},
		BAG_OPERATE_TYPE_SELL = {
			type = "value",
			description = "value=3"
		},
		BAG_OPERATE_TYPE_PACK_UP = {
			type = "value",
			description = "value=4"
		},
		BAG_OPERATE_TYPE_REQ_ALL = {
			type = "value",
			description = "value=5"
		},
	}
},
tagConstant = {
	type = "lib",
	description = "tagConstant",
	childs = {
		INVALID_CONSTANTVAR = {
			type = "value",
			description = "value=0"
		},
		TREASUREHUNT_ITEM_COMCD = {
			type = "value",
			description = "value=1"
		},
		ROLE_MOVE_SPEED = {
			type = "value",
			description = "value=2"
		},
		BUY_GRID_PRICE = {
			type = "value",
			description = "value=3"
		},
		BAG_INIT_GRIDNUM = {
			type = "value",
			description = "value=4"
		},
		BAG_MAX_GRIDNUM = {
			type = "value",
			description = "value=5"
		},
		OT_SCENE_ROLE_NUM = {
			type = "value",
			description = "value=6"
		},
		MAX_CONSTANTVAR = {
			type = "value",
			description = "value=7"
		},
	}
},
EServerType = {
	type = "lib",
	description = "EServerType",
	childs = {
		INVALID_SERVER_TYPE = {
			type = "value",
			description = "value=0"
		},
		SERVER_TYPE_WORLD = {
			type = "value",
			description = "value=1"
		},
		SERVER_TYPE_MAP_NORMAL = {
			type = "value",
			description = "value=2"
		},
		SERVER_TYPE_MAP_DYNAMIC = {
			type = "value",
			description = "value=3"
		},
		SERVER_TYPE_MANAGER = {
			type = "value",
			description = "value=4"
		},
		SERVER_TYPE_RECORD = {
			type = "value",
			description = "value=5"
		},
		SERVER_TYPE_RESOURCE = {
			type = "value",
			description = "value=6"
		},
		SERVER_TYPE_CHARGE = {
			type = "value",
			description = "value=7"
		},
		SERVER_TYPE_LOGIN = {
			type = "value",
			description = "value=8"
		},
		SERVER_TYPE_NUM = {
			type = "value",
			description = "value=9"
		},
	}
},
EServerStatus = {
	type = "lib",
	description = "EServerStatus",
	childs = {
		INVALID_SERVER_STATUS = {
			type = "value",
			description = "value=0"
		},
		NORMAL_SERVER_STATUS = {
			type = "value",
			description = "value=1"
		},
		READY_CLOSE_SERVER_STATUS = {
			type = "value",
			description = "value=2"
		},
		URGENT_CLOSE_SERVER_STATUS = {
			type = "value",
			description = "value=3"
		},
		KICK_ROLE_SERVER_SATATUS = {
			type = "value",
			description = "value=4"
		},
		REAL_CLOSE_SERVER_STATUS = {
			type = "value",
			description = "value=5"
		},
	}
},
ESceneType = {
	type = "lib",
	description = "ESceneType",
	childs = {
		SCENE_TYPE_INVALID = {
			type = "value",
			description = "value=0"
		},
		SCENE_TYPE_NORMAL = {
			type = "value",
			description = "value=1"
		},
		SCENE_TYPE_PK_RISK = {
			type = "value",
			description = "value=2"
		},
		SCENE_TYPE_NUMBER = {
			type = "value",
			description = "value=3"
		},
	}
},
ELoadRoleType = {
	type = "lib",
	description = "ELoadRoleType",
	childs = {
		LOAD_ROLE_TYPE_INVALID = {
			type = "value",
			description = "value=0"
		},
		LOAD_ROLE_TYPE_LOGIN = {
			type = "value",
			description = "value=1"
		},
		LOAD_ROLE_TYPE_CHANGE_LINE = {
			type = "value",
			description = "value=2"
		},
		LOAD_ROLE_TYPE_CHANGE_MAP = {
			type = "value",
			description = "value=3"
		},
		LOAD_ROLE_TYPE_TELE = {
			type = "value",
			description = "value=4"
		},
	}
},
EUnloadRoleType = {
	type = "lib",
	description = "EUnloadRoleType",
	childs = {
		UNLOAD_ROLE_TYPE_INVALID = {
			type = "value",
			description = "value=0"
		},
		UNLOAD_ROLE_TYPE_ERROR = {
			type = "value",
			description = "value=1"
		},
		UNLOAD_ROLE_TYPE_QUIT = {
			type = "value",
			description = "value=2"
		},
		UNLOAD_ROLE_TYPE_KICK_BY_OTHER = {
			type = "value",
			description = "value=3"
		},
		UNLOAD_ROLE_TYPE_CHANGE_LINE = {
			type = "value",
			description = "value=4"
		},
		UNLOAD_ROLE_TYPE_SYS_CHECK = {
			type = "value",
			description = "value=5"
		},
		UNLOAD_ROLE_TYPE_GM = {
			type = "value",
			description = "value=6"
		},
	}
},
ERoleStatus = {
	type = "lib",
	description = "ERoleStatus",
	childs = {
		ROLE_STATUS_INVALID = {
			type = "value",
			description = "value=0"
		},
		ROLE_STATUS_LOAD = {
			type = "value",
			description = "value=1"
		},
		ROLE_STATUS_ENTER = {
			type = "value",
			description = "value=2"
		},
		ROLE_STATUS_ENTER_SCENE = {
			type = "value",
			description = "value=3"
		},
		ROLE_STATUS_CHANGE_MAP = {
			type = "value",
			description = "value=4"
		},
		ROLE_STATUS_SAVE = {
			type = "value",
			description = "value=5"
		},
		ROEL_STATUS_KICK_BY_OTHER = {
			type = "value",
			description = "value=6"
		},
		ROLE_STATUS_QUIT_REQ = {
			type = "value",
			description = "value=7"
		},
		ROLE_STATUS_QUTI = {
			type = "value",
			description = "value=8"
		},
	}
},
ESaveRoleType = {
	type = "lib",
	description = "ESaveRoleType",
	childs = {
		SAVE_ROLE_TYPE_DIFF = {
			type = "value",
			description = "value=0"
		},
		SAVE_ROLE_TYPE_TIMER = {
			type = "value",
			description = "value=1"
		},
		SAVE_ROEL_TYPE_OFFLINE = {
			type = "value",
			description = "value=2"
		},
		SAVE_ROLE_TYPE_RECHARGE = {
			type = "value",
			description = "value=3"
		},
		SAVE_ROLE_TYPE_SEND_RMB = {
			type = "value",
			description = "value=4"
		},
	}
},
EPlayerStatus = {
	type = "lib",
	description = "EPlayerStatus",
	childs = {
		PS_INVALID = {
			type = "value",
			description = "value=0"
		},
		PS_IDLE = {
			type = "value",
			description = "value=1"
		},
		PS_VERIFY_PASS = {
			type = "value",
			description = "value=2"
		},
		PS_CREATE_ROLE_REQ = {
			type = "value",
			description = "value=3"
		},
		PS_DELETE_ROLE_REQ = {
			type = "value",
			description = "value=4"
		},
		PS_LOGIN_GAME_REQ = {
			type = "value",
			description = "value=5"
		},
		PS_LOGIN_GAME = {
			type = "value",
			description = "value=6"
		},
		PS_PLAYING_GAME = {
			type = "value",
			description = "value=7"
		},
		PS_CHANGE_LINE_UNLOAD_REQ = {
			type = "value",
			description = "value=8"
		},
		PS_CHANGE_LINE_LOAD_REQ = {
			type = "value",
			description = "value=9"
		},
		PS_CHANGE_LINE_WAIT = {
			type = "value",
			description = "value=10"
		},
		PS_QUIT_REQ = {
			type = "value",
			description = "value=11"
		},
		PS_QUIT = {
			type = "value",
			description = "value=12"
		},
	}
},
EWPlayerActionType = {
	type = "lib",
	description = "EWPlayerActionType",
	childs = {
		PA_VERIFY = {
			type = "value",
			description = "value=0"
		},
		PA_DELETE_ROEL_REQ = {
			type = "value",
			description = "value=1"
		},
		PA_CREATE_ROLE_REQ = {
			type = "value",
			description = "value=2"
		},
		PA_LOGIN_GAME_REQ = {
			type = "value",
			description = "value=3"
		},
		PA_LOGIN_QUIT_REQ = {
			type = "value",
			description = "value=4"
		},
		PA_UNLOAD_ROLE_REQ = {
			type = "value",
			description = "value=5"
		},
		PA_CHANGE_LINE_REQ = {
			type = "value",
			description = "value=6"
		},
		PA_QUIT_GAME_REQ = {
			type = "value",
			description = "value=7"
		},
		PA_CREATE_ROLE_RES = {
			type = "value",
			description = "value=8"
		},
		PA_DELETE_ROLE_RES = {
			type = "value",
			description = "value=9"
		},
		PA_LOAD_ROLE_RES = {
			type = "value",
			description = "value=10"
		},
		PA_UNLOAD_ROLE_RES = {
			type = "value",
			description = "value=11"
		},
	}
},
ETeleportType = {
	type = "lib",
	description = "ETeleportType",
	childs = {
		TELEPORT_TYPE_INVALID = {
			type = "value",
			description = "value=0"
		},
		TELEPORT_TYPE_TRANSMIT = {
			type = "value",
			description = "value=1"
		},
		TELEPORT_TYPE_SYS = {
			type = "value",
			description = "value=2"
		},
		TELEPORT_TYPE_RISK_ENTER = {
			type = "value",
			description = "value=3"
		},
		TELEPORT_TYPE_RISK_QUIT = {
			type = "value",
			description = "value=4"
		},
		TELEPORT_TYPE_CHANGE_LINE = {
			type = "value",
			description = "value=5"
		},
	}
},
EAdultFlag = {
	type = "lib",
	description = "EAdultFlag",
	childs = {
		ADULT_FLAG_NONE = {
			type = "value",
			description = "value=0"
		},
		ADULT_FLAG_ADULT = {
			type = "value",
			description = "value=1"
		},
		ADULT_FLAG_NO_ADULT = {
			type = "value",
			description = "value=2"
		},
	}
},
EJobType = {
	type = "lib",
	description = "EJobType",
	childs = {
		INVALID_JOB_TYPE = {
			type = "value",
			description = "value=-1"
		},
		JOB_TYPE_PHYSIC = {
			type = "value",
			description = "value=0"
		},
		JOB_TYPE_MAGIC = {
			type = "value",
			description = "value=1"
		},
		JOB_TYPE_MONSTER = {
			type = "value",
			description = "value=4"
		},
		JOB_TYPE_PET = {
			type = "value",
			description = "value=5"
		},
		JOB_TYPE_NPC = {
			type = "value",
			description = "value=6"
		},
	}
},
ESexType = {
	type = "lib",
	description = "ESexType",
	childs = {
		INVALID_SEX_TYPE = {
			type = "value",
			description = "value=0"
		},
		SEX_TYPE_MALE = {
			type = "value",
			description = "value=1"
		},
		SEX_TYPE_FEMALE = {
			type = "value",
			description = "value=2"
		},
	}
},
EKickType = {
	type = "lib",
	description = "EKickType",
	childs = {
		KICK_TYPE_ERR = {
			type = "value",
			description = "value=1"
		},
		KICK_TYPE_BY_OTHER = {
			type = "value",
			description = "value=2"
		},
		KICK_TYPE_BY_GM = {
			type = "value",
			description = "value=3"
		},
		KICK_TYPE_GAME_STOP = {
			type = "value",
			description = "value=4"
		},
	}
},
EChatChannel = {
	type = "lib",
	description = "EChatChannel",
	childs = {
		CHANNEL_INVALID = {
			type = "value",
			description = "value=0"
		},
		CHAT_CHANNEL_WORLD = {
			type = "value",
			description = "value=1"
		},
		CHAT_CHANNEL_FACTION = {
			type = "value",
			description = "value=2"
		},
		CHAT_CHANNEL_PRIVATE = {
			type = "value",
			description = "value=3"
		},
		CHAT_CHANNEL_SYSTEM = {
			type = "value",
			description = "value=4"
		},
		CHAT_CHANNEL_GM = {
			type = "value",
			description = "value=5"
		},
		CHAT_CHANNEL_NUMBER = {
			type = "value",
			description = "value=6"
		},
	}
},
EDir = {
	type = "lib",
	description = "EDir",
	childs = {
		DIR_INVALID = {
			type = "value",
			description = "value=0"
		},
		DIR_0 = {
			type = "value",
			description = "value=0"
		},
		DIR_1 = {
			type = "value",
			description = "value=1"
		},
		DIR_2 = {
			type = "value",
			description = "value=2"
		},
		DIR_3 = {
			type = "value",
			description = "value=3"
		},
		DIR_4 = {
			type = "value",
			description = "value=4"
		},
		DIR_5 = {
			type = "value",
			description = "value=5"
		},
		DIR_6 = {
			type = "value",
			description = "value=6"
		},
		DIR_7 = {
			type = "value",
			description = "value=7"
		},
	}
},
EDir2 = {
	type = "lib",
	description = "EDir2",
	childs = {
		DIR2_INVALID = {
			type = "value",
			description = "value=0"
		},
		DIR2_LEFT = {
			type = "value",
			description = "value=1"
		},
		DIR2_RIGHT = {
			type = "value",
			description = "value=2"
		},
	}
},
EObjType = {
	type = "lib",
	description = "EObjType",
	childs = {
		INVALID_OBJ_TYPE = {
			type = "value",
			description = "value=0"
		},
		OBJ_TYPE_ROLE = {
			type = "value",
			description = "value=1"
		},
		OBJ_TYPE_NPC = {
			type = "value",
			description = "value=2"
		},
		OBJ_TYPE_MONSTER = {
			type = "value",
			description = "value=3"
		},
		OBJ_TYPE_PET = {
			type = "value",
			description = "value=22"
		},
		OBJ_TYPE_ITEM = {
			type = "value",
			description = "value=23"
		},
		OBJ_TYPE_HORSE = {
			type = "value",
			description = "value=24"
		},
	}
},
EAttributes = {
	type = "lib",
	description = "EAttributes",
	childs = {
		ATTR_FIGHT_INVALID = {
			type = "value",
			description = "value=0"
		},
		ATTR_MAX_HP = {
			type = "value",
			description = "value=1"
		},
		ATTR_CUR_HP = {
			type = "value",
			description = "value=2"
		},
		ATTR_MAX_ENERGY = {
			type = "value",
			description = "value=3"
		},
		ATTR_CUR_ENERGY = {
			type = "value",
			description = "value=4"
		},
		ATTR_POWER = {
			type = "value",
			description = "value=5"
		},
		ATTR_AGILITY = {
			type = "value",
			description = "value=6"
		},
		ATTR_WISDOM = {
			type = "value",
			description = "value=7"
		},
		ATTR_STRENGTH = {
			type = "value",
			description = "value=9"
		},
		ATTR_ATTACK = {
			type = "value",
			description = "value=10"
		},
		ATTR_SKILL_ATTACK = {
			type = "value",
			description = "value=11"
		},
		ATTR_DAMAGE = {
			type = "value",
			description = "value=12"
		},
		ATTR_DEFENSE = {
			type = "value",
			description = "value=13"
		},
		ATTR_DAMAGE_REDUCE = {
			type = "value",
			description = "value=14"
		},
		ATTR_MOVE_SPEED = {
			type = "value",
			description = "value=15"
		},
		ATTR_CRIT = {
			type = "value",
			description = "value=16"
		},
		ATTR_DODGE = {
			type = "value",
			description = "value=17"
		},
		ATTR_ATTACK_RANGE = {
			type = "value",
			description = "value=20"
		},
		ATTR_ATTACK_SPEED = {
			type = "value",
			description = "value=21"
		},
		ATTR_EXP = {
			type = "value",
			description = "value=22"
		},
		ATTR_MONEY = {
			type = "value",
			description = "value=23"
		},
		ATTR_RMB = {
			type = "value",
			description = "value=24"
		},
		ATTR_CHAR_CURR_MAX = {
			type = "value",
			description = "value=49"
		},
		ATTR_LEVEL = {
			type = "value",
			description = "value=50"
		},
		ATTR_VIP_LEVEL = {
			type = "value",
			description = "value=56"
		},
		ATTR_VIP_EXP = {
			type = "value",
			description = "value=57"
		},
		ATTR_MAX_EXP = {
			type = "value",
			description = "value=62"
		},
	}
},
EActionBan = {
	type = "lib",
	description = "EActionBan",
	childs = {
		ACTION_BAN_LIVE = {
			type = "value",
			description = "value=0"
		},
		ACTION_BAN_MOVE = {
			type = "value",
			description = "value=1"
		},
		ACTION_BAN_UNBE_ATTACK = {
			type = "value",
			description = "value=2"
		},
		ACTION_BAN_ATTACK = {
			type = "value",
			description = "value=3"
		},
		ACTION_BAN_USE_ITEM = {
			type = "value",
			description = "value=4"
		},
		ACTION_BAN_MAX = {
			type = "value",
			description = "value=5"
		},
	}
},
ENumericalType = {
	type = "lib",
	description = "ENumericalType",
	childs = {
		NUMERICAL_TYPE_INVALID = {
			type = "value",
			description = "value=0"
		},
		NUMERICAL_TYPE_VALUE = {
			type = "value",
			description = "value=1"
		},
		NUMERICAL_TYPE_ODDS = {
			type = "value",
			description = "value=2"
		},
	}
},
ESkillType = {
	type = "lib",
	description = "ESkillType",
	childs = {
		SKILL_TYPE_INVALID = {
			type = "value",
			description = "value=0"
		},
		SKILL_TYPE_ACTIVE = {
			type = "value",
			description = "value=1"
		},
		SKILL_TYPE_PASSIVE = {
			type = "value",
			description = "value=2"
		},
		SKILL_TYPE_ASSIST = {
			type = "value",
			description = "value=3"
		},
		SKILL_TYPE_MAX = {
			type = "value",
			description = "value=4"
		},
	}
},
ESkillAttackType = {
	type = "lib",
	description = "ESkillAttackType",
	childs = {
		SKILL_ATTACK_TYPE_INVALID = {
			type = "value",
			description = "value=0"
		},
		SKILL_ATTACK_TYPE_SINGLE = {
			type = "value",
			description = "value=1"
		},
		SKILL_ATTACK_TYPE_GROUP = {
			type = "value",
			description = "value=2"
		},
		SKILL_ATTACK_TYPE_MAX = {
			type = "value",
			description = "value=3"
		},
	}
},
ESkillTargetType = {
	type = "lib",
	description = "ESkillTargetType",
	childs = {
		SKILL_TARGET_TYPE_INVALID = {
			type = "value",
			description = "value=0"
		},
		SKILL_TARGET_TYPE_ENEMY = {
			type = "value",
			description = "value=1"
		},
		SKILL_TARGET_TYPE_OWN = {
			type = "value",
			description = "value=2"
		},
		SKILL_TARGET_TYPE_TEAM = {
			type = "value",
			description = "value=3"
		},
		SKILL_TARGET_TYPE_MAX = {
			type = "value",
			description = "value=4"
		},
	}
},
EBuffEventFlag = {
	type = "lib",
	description = "EBuffEventFlag",
	childs = {
		BUFF_EVENT_FLAG_DIE = {
			type = "value",
			description = "value=1"
		},
		BUFF_EVENT_FLAG_HURT = {
			type = "value",
			description = "value=2"
		},
		BUFF_EVENT_FLAG_MP_DES = {
			type = "value",
			description = "value=3"
		},
		BUFF_EVENT_FLAG_FORCE_HATE = {
			type = "value",
			description = "value=4"
		},
		BUFF_EVENT_FLAG_REFLECT = {
			type = "value",
			description = "value=5"
		},
		BUFF_EVENT_FLAG_SLEEP = {
			type = "value",
			description = "value=6"
		},
		BUFF_EVENT_FLAG_STOP = {
			type = "value",
			description = "value=7"
		},
		BUFF_EVENT_FLAG_DIZZ = {
			type = "value",
			description = "value=8"
		},
		BUFF_EVENT_FLAG_NUM = {
			type = "value",
			description = "value=9"
		},
	}
},
EBuffEffectType = {
	type = "lib",
	description = "EBuffEffectType",
	childs = {
		BUFF_EFFECT_TYPE_INVALID = {
			type = "value",
			description = "value=0"
		},
		BUFF_EFFECT_TYPE_ADD_HPMP = {
			type = "value",
			description = "value=1"
		},
		BUFF_EFFECT_TYPE_ADD_EXTRA_ATTR = {
			type = "value",
			description = "value=2"
		},
		BUFF_EFFECT_TYPE_ADD_EXP = {
			type = "value",
			description = "value=3"
		},
		MAX_BUFF_EFFECT_TYPE_NUM = {
			type = "value",
			description = "value=4"
		},
	}
},
EBuffType = {
	type = "lib",
	description = "EBuffType",
	childs = {
		INVALID_BUFF_TYPE = {
			type = "value",
			description = "value=0"
		},
		BUFF_TYPE_SKILL = {
			type = "value",
			description = "value=1"
		},
		BUFF_TYPE_ITEM = {
			type = "value",
			description = "value=2"
		},
		BUFF_TYPE_PASSIVE_SKILL = {
			type = "value",
			description = "value=3"
		},
	}
},
EBuffExistType = {
	type = "lib",
	description = "EBuffExistType",
	childs = {
		BUFF_EXIST_TYPE_INVALID = {
			type = "value",
			description = "value=0"
		},
		BUFF_EXIST_TYPE_EXIST = {
			type = "value",
			description = "value=1"
		},
		BUFF_EXIST_TYPE_REPLACE = {
			type = "value",
			description = "value=2"
		},
		BUFF_EXIST_TYPE_OVERLIING = {
			type = "value",
			description = "value=1"
		},
		BUFF_EXIST_TYPE_IGNORE = {
			type = "value",
			description = "value=3"
		},
	}
},
EBuffLastType = {
	type = "lib",
	description = "EBuffLastType",
	childs = {
		BUFF_LAST_TYPE_INVALID = {
			type = "value",
			description = "value=0"
		},
		BUFF_LAST_TYPE_ABSOLUTE = {
			type = "value",
			description = "value=1"
		},
		BUFF_LAST_TYPE_OPPOSITE = {
			type = "value",
			description = "value=2"
		},
		BUFF_LAST_TYPE_PERMANENT = {
			type = "value",
			description = "value=3"
		},
		BUFF_LAST_TYPE_COUNT = {
			type = "value",
			description = "value=4"
		},
	}
},
EAttackImpactType = {
	type = "lib",
	description = "EAttackImpactType",
	childs = {
		INVALID_ATTACK_IMPACT_TYPE = {
			type = "value",
			description = "value=0"
		},
		ATTACK_IMPACT_TYPE_NORMAL = {
			type = "value",
			description = "value=1"
		},
		ATTACK_IMPACT_TYPE_CRIT = {
			type = "value",
			description = "value=2"
		},
		ATTACK_IMPACT_TYPE_DODGE = {
			type = "value",
			description = "value=3"
		},
		ATTACK_IMPACT_TYPE_HIT_DOUBLE = {
			type = "value",
			description = "value=4"
		},
		ATTACK_IMPACT_TYPE_CONFUSION = {
			type = "value",
			description = "value=5"
		},
		ATTACK_IMPACT_TYPE_RAND_ATTACK_ROLE = {
			type = "value",
			description = "value=6"
		},
	}
},
EMissionEvent = {
	type = "lib",
	description = "EMissionEvent",
	childs = {
		MISSION_EVENT_INVALID = {
			type = "value",
			description = "value=0"
		},
		MISSION_EVENT_DIALOG = {
			type = "value",
			description = "value=1"
		},
		MISSION_EVENT_GUANQIA = {
			type = "value",
			description = "value=2"
		},
		MISSION_EVENT_KILL_MONSTER = {
			type = "value",
			description = "value=3"
		},
		MISSION_EVENT_COLLECT_ITEM = {
			type = "value",
			description = "value=4"
		},
	}
},
EMissionStatus = {
	type = "lib",
	description = "EMissionStatus",
	childs = {
		MISSION_STATUS_INVALID = {
			type = "value",
			description = "value=0"
		},
		MISSION_STATUS_ACCEPTING = {
			type = "value",
			description = "value=1"
		},
		MISSION_STATUS_ACCEPTED = {
			type = "value",
			description = "value=2"
		},
		MISSION_STATUS_EXECUTED = {
			type = "value",
			description = "value=3"
		},
		MISSION_STATUS_FINISHED = {
			type = "value",
			description = "value=4"
		},
	}
},
EMissionOperation = {
	type = "lib",
	description = "EMissionOperation",
	childs = {
		MISSION_OPERATION_INVALID = {
			type = "value",
			description = "value=0"
		},
		MISSION_OPERATION_ACCEPT = {
			type = "value",
			description = "value=1"
		},
		MISSION_OPERATION_SUBMIT = {
			type = "value",
			description = "value=2"
		},
	}
},
EMissionType = {
	type = "lib",
	description = "EMissionType",
	childs = {
		MISSION_TYPE_INVALID = {
			type = "value",
			description = "value=0"
		},
		MISSION_TYPE_MAJOR = {
			type = "value",
			description = "value=1"
		},
		MISSION_TYPE_CURR_MAX = {
			type = "value",
			description = "value=2"
		},
	}
},
EFindEmptyPosType = {
	type = "lib",
	description = "EFindEmptyPosType",
	childs = {
		FIND_EMPTY_POS_TYPE_LEFT = {
			type = "value",
			description = "value=0"
		},
		FIND_EMPTY_POS_TYPE_MID = {
			type = "value",
			description = "value=1"
		},
		FIND_EMPTY_POS_TYPE_MID_LEFT = {
			type = "value",
			description = "value=2"
		},
		FIND_EMPTY_POS_TYPE_MID_RIGHT = {
			type = "value",
			description = "value=3"
		},
		FIND_EMPTY_POS_TYPE_RIGHT = {
			type = "value",
			description = "value=4"
		},
	}
},
ERoleLimitType = {
	type = "lib",
	description = "ERoleLimitType",
	childs = {
		ROLE_LIMIT_INVALID = {
			type = "value",
			description = "value=0"
		},
		ROLE_LIMIT_LOGIN = {
			type = "value",
			description = "value=1"
		},
		ROLE_LIMIT_CHAT = {
			type = "value",
			description = "value=2"
		},
		ROLE_LIMIT_DEL_LOGIN = {
			type = "value",
			description = "value=3"
		},
		ROLE_LIMIT_DEL_CHAT = {
			type = "value",
			description = "value=4"
		},
	}
},
ERoleOptLimitType = {
	type = "lib",
	description = "ERoleOptLimitType",
	childs = {
		ROLE_LIMIT_OPT_INVALID = {
			type = "value",
			description = "value=0"
		},
		ROLE_LIMIT_OPT_UPDATE_LOGIN = {
			type = "value",
			description = "value=1"
		},
		ROLE_LIMIT_OPT_UPDATE_CHAT = {
			type = "value",
			description = "value=2"
		},
		ROLE_LIMIT_OPT_DEL = {
			type = "value",
			description = "value=3"
		},
	}
},
ECombatStateType = {
	type = "lib",
	description = "ECombatStateType",
	childs = {
		COMBAT_STATE_TYPE_START = {
			type = "value",
			description = "value=1"
		},
		COMBAT_STATE_TYPE_END = {
			type = "value",
			description = "value=2"
		},
	}
},
EResetPosType = {
	type = "lib",
	description = "EResetPosType",
	childs = {
		RESET_POS_TYPE_INVALID = {
			type = "value",
			description = "value=0"
		},
		RESET_POS_TYPE_WINK = {
			type = "value",
			description = "value=1"
		},
		RESET_POS_TYPE_PULL_BACK = {
			type = "value",
			description = "value=2"
		},
		RESET_POS_TYPE_HIT_BACK = {
			type = "value",
			description = "value=3"
		},
		RESET_POS_TYPE_SKILL_WINK = {
			type = "value",
			description = "value=4"
		},
		RESET_POS_TYPE_DIRECT = {
			type = "value",
			description = "value=5"
		},
	}
},
EObjState = {
	type = "lib",
	description = "EObjState",
	childs = {
		OBJ_STATE_TEAM = {
			type = "value",
			description = "value=0"
		},
		OBJ_STATE_LEADER = {
			type = "value",
			description = "value=1"
		},
	}
},
ECharacterLogic = {
	type = "lib",
	description = "ECharacterLogic",
	childs = {
		CHARACTER_LOGIC_INVALID = {
			type = "value",
			description = "value=0"
		},
		CHARACTER_LOGIC_IDLE = {
			type = "value",
			description = "value=1"
		},
		CHARACTER_LOGIC_MOVE = {
			type = "value",
			description = "value=2"
		},
		CHARACTER_LOGIC_DEAD = {
			type = "value",
			description = "value=3"
		},
		CHARACTER_LOGIC_NUMBERS = {
			type = "value",
			description = "value=4"
		},
	}
},
EMoveMode = {
	type = "lib",
	description = "EMoveMode",
	childs = {
		MOVE_MODE_INVALID = {
			type = "value",
			description = "value=0"
		},
		MOVE_MODE_HOBBLE = {
			type = "value",
			description = "value=1"
		},
		MOVE_MODE_WALK = {
			type = "value",
			description = "value=2"
		},
		MOVE_MODE_RUN = {
			type = "value",
			description = "value=3"
		},
		MOVE_MODE_SPRINT = {
			type = "value",
			description = "value=4"
		},
	}
},
EMoveType = {
	type = "lib",
	description = "EMoveType",
	childs = {
		MOVE_TYPE_CHECK = {
			type = "value",
			description = "value=0"
		},
		MOVE_TYPE_NOCHECK = {
			type = "value",
			description = "value=1"
		},
	}
},
ERoleMoveType = {
	type = "lib",
	description = "ERoleMoveType",
	childs = {
		ROLE_MOVE_TYPE_MOVE = {
			type = "value",
			description = "value=0"
		},
		ROLE_MOVE_TYPE_STOP = {
			type = "value",
			description = "value=1"
		},
	}
},
EAddApproachObjectType = {
	type = "lib",
	description = "EAddApproachObjectType",
	childs = {
		ADD_APPROACH_MON_TYPE_DAMAGE = {
			type = "value",
			description = "value=0"
		},
		ADD_APPROACH_MON_TYPE_SCAN = {
			type = "value",
			description = "value=1"
		},
	}
},
EDelApproachObjectType = {
	type = "lib",
	description = "EDelApproachObjectType",
	childs = {
		DEL_APPROACH_MON_TYPE_DIE = {
			type = "value",
			description = "value=0"
		},
		DEL_APPROACH_MON_TYPE_MY_DIE = {
			type = "value",
			description = "value=1"
		},
		DEL_APPROACH_MON_TYPE_DROP = {
			type = "value",
			description = "value=2"
		},
	}
},
EReliveType = {
	type = "lib",
	description = "EReliveType",
	childs = {
		RELIVE_TYPE_LOCAL = {
			type = "value",
			description = "value=1"
		},
		RELIVE_TYPE_BACKTURN = {
			type = "value",
			description = "value=2"
		},
	}
},
EZoneServerState = {
	type = "lib",
	description = "EZoneServerState",
	childs = {
		ZONE_SERVER_STATE_INVALID = {
			type = "value",
			description = "value=0"
		},
		ZONE_SERVER_STATE_NORMAL = {
			type = "value",
			description = "value=1"
		},
		ZONE_SERVER_STATE_BUSY = {
			type = "value",
			description = "value=2"
		},
		ZONE_SERVER_STATE_CLOSE = {
			type = "value",
			description = "value=3"
		},
	}
},
EZoneServerFlag = {
	type = "lib",
	description = "EZoneServerFlag",
	childs = {
		ZONE_SERVER_FLAG_INVALID = {
			type = "value",
			description = "value=0"
		},
		ZONE_SERVER_FLAG_RECOMMEND = {
			type = "value",
			description = "value=1"
		},
		ZONE_SERVER_FLAG_NEW = {
			type = "value",
			description = "value=2"
		},
	}
},
EAnnouncement = {
	type = "lib",
	description = "EAnnouncement",
	childs = {
		ANNOUNCEMENT_INVALID = {
			type = "value",
			description = "value=0"
		},
		ANNOUNCEMENT_ROLE = {
			type = "value",
			description = "value=1"
		},
		ANNOUNCEMENT_ITEM = {
			type = "value",
			description = "value=2"
		},
		ANNOUNCEMENT_NUMBER = {
			type = "value",
			description = "value=3"
		},
	}
},
EAnnouncementSystem = {
	type = "lib",
	description = "EAnnouncementSystem",
	childs = {
		ANNOUNCEMENT_SYS_INVALID = {
			type = "value",
			description = "value=0"
		},
		ANNOUNCEMENT_SYS_MALL = {
			type = "value",
			description = "value=1"
		},
	}
},
EAnnouncementEvent = {
	type = "lib",
	description = "EAnnouncementEvent",
	childs = {
		AET_SYS_INVALID = {
			type = "value",
			description = "value=0"
		},
		AET_SYS_STOP = {
			type = "value",
			description = "value=1"
		},
		AET_GAME_NOTIY = {
			type = "value",
			description = "value=2"
		},
		AET_ROLE_LEVEL_UP = {
			type = "value",
			description = "value=3"
		},
		AET_ROLE_VIP_UP = {
			type = "value",
			description = "value=4"
		},
		AET_ROLE_GET_ITEM = {
			type = "value",
			description = "value=5"
		},
	}
},
EOddAndWeightType = {
	type = "lib",
	description = "EOddAndWeightType",
	childs = {
		ODDANDWEIGHTTYPE_INVALID = {
			type = "value",
			description = "value=0"
		},
		DROPODD_TYPE = {
			type = "value",
			description = "value=1"
		},
		DROPWEIGHT_TYPE = {
			type = "value",
			description = "value=2"
		},
	}
},
EFightType = {
	type = "lib",
	description = "EFightType",
	childs = {
		FIGHT_TYPE_INVALID = {
			type = "value",
			description = "value=0"
		},
		FIGHT_TYPE_CHAPTER = {
			type = "value",
			description = "value=1"
		},
		FIGHT_TYPE_CHALLENGE_OTHER = {
			type = "value",
			description = "value=2"
		},
	}
},
EGameRetCode = {
	type = "lib",
	description = "EGameRetCode",
	childs = {
		RC_SUCCESS = {
			type = "value",
			description = "value=0"
		},
		RC_FAILED = {
			type = "value",
			description = "value=1"
		},
		RC_ENTER_GAME_FAILED = {
			type = "value",
			description = "value=200"
		},
		RC_LOGIN_FAILED = {
			type = "value",
			description = "value=201"
		},
		RC_LOGIN_MAX_ROLE_NUM = {
			type = "value",
			description = "value=202"
		},
		RC_LOGIN_NOENOUGH_OBJ_UID = {
			type = "value",
			description = "value=203"
		},
		RC_LOGIN_NO_MAP_SERVER = {
			type = "value",
			description = "value=204"
		},
		RC_LOGIN_NO_ROLE = {
			type = "value",
			description = "value=205"
		},
		RC_LOGIN_MIN_ROLE_NUM = {
			type = "value",
			description = "value=206"
		},
		RC_LOGIN_ROLE_NAME_INVALID = {
			type = "value",
			description = "value=207"
		},
		RC_LOGIN_NO_MAP = {
			type = "value",
			description = "value=208"
		},
		RC_LOGIN_HAS_SELECT_ROLE = {
			type = "value",
			description = "value=209"
		},
		RC_LOGIN_NAME_REPEAT = {
			type = "value",
			description = "value=210"
		},
		RC_LOGIN_CREATE_ROLE_FAILED = {
			type = "value",
			description = "value=211"
		},
		RC_LOGIN_DELETE_ROLE_FAILED = {
			type = "value",
			description = "value=212"
		},
		RC_LOGIN_REQUEST_WAIT = {
			type = "value",
			description = "value=213"
		},
		RC_LOGIN_REQUEST_FAILED = {
			type = "value",
			description = "value=214"
		},
		RC_LOGIN_OLD_ROLE_EXIST = {
			type = "value",
			description = "value=215"
		},
		RC_LOGIN_LIMIT = {
			type = "value",
			description = "value=216"
		},
		RC_LOGIN_SERVER_CLOSE = {
			type = "value",
			description = "value=217"
		},
		RC_LOGIN_NO_ACCOUNT = {
			type = "value",
			description = "value=218"
		},
		RC_LOGIN_RENAME_FAILED = {
			type = "value",
			description = "value=219"
		},
		RC_LOGIN_RENAME_REPEAT = {
			type = "value",
			description = "value=220"
		},
		RC_ROLE_DIE = {
			type = "value",
			description = "value=300"
		},
		RC_ROLE_OFFLINE = {
			type = "value",
			description = "value=301"
		},
		RC_ROLE_NOT_EXIST = {
			type = "value",
			description = "value=302"
		},
		RC_LIMIT_MOVE = {
			type = "value",
			description = "value=303"
		},
		RC_DIE = {
			type = "value",
			description = "value=304"
		},
		RC_LACKGOLD = {
			type = "value",
			description = "value=305"
		},
		RC_LACKRMB = {
			type = "value",
			description = "value=306"
		},
		RC_PACK_FAILD = {
			type = "value",
			description = "value=400"
		},
		RC_PACK_DESTOPERATOR_HASITEM = {
			type = "value",
			description = "value=401"
		},
		RC_PACK_SOUROPERATOR_LOCK = {
			type = "value",
			description = "value=402"
		},
		RC_PACK_DESTOPERATOR_LOCK = {
			type = "value",
			description = "value=403"
		},
		RC_PACK_DESTOPERATOR_FULL = {
			type = "value",
			description = "value=404"
		},
		RC_PACK_SOUROPERATOR_EMPTY = {
			type = "value",
			description = "value=405"
		},
		RC_PACK_SPLIT_NUM_ERR = {
			type = "value",
			description = "value=407"
		},
		RC_PACK_EQUIP_TYPE_INVALID = {
			type = "value",
			description = "value=410"
		},
		RC_PACK_ITEM_SEX_LIMIT = {
			type = "value",
			description = "value=411"
		},
		RC_PACK_ITEM_LEVEL_LIMIT = {
			type = "value",
			description = "value=412"
		},
		RC_PACK_ITEM_JOB_LIMIT = {
			type = "value",
			description = "value=413"
		},
		RC_PACK_ITEM_MAP_LIMIT = {
			type = "value",
			description = "value=414"
		},
		RC_PACK_ITEM_TIME_OUT = {
			type = "value",
			description = "value=415"
		},
		RC_PACK_NO_ENOUGH_EMPTY_POS = {
			type = "value",
			description = "value=416"
		},
		RC_PACK_MAX_SIZE = {
			type = "value",
			description = "value=417"
		},
		RC_PACK_ITEM_DIE_LIMIT = {
			type = "value",
			description = "value=418"
		},
		RC_PACK_ITEM_COMBAT_LIMIT = {
			type = "value",
			description = "value=419"
		},
		RC_PACK_ITEM_STATUS_LIMIT = {
			type = "value",
			description = "value=420"
		},
		RC_PACK_CONT_COOL_DOWN = {
			type = "value",
			description = "value=421"
		},
		RC_BAG_IS_FULL = {
			type = "value",
			description = "value=500"
		},
		RC_BAG_HAVENOT_BAGTYPE = {
			type = "value",
			description = "value=501"
		},
		RC_BAG_HAVENOT_TARGETITEM = {
			type = "value",
			description = "value=502"
		},
		RC_BAG_USEITEM_FAILED = {
			type = "value",
			description = "value=503"
		},
		RC_BAG_DELETEITEM_FAILED = {
			type = "value",
			description = "value=504"
		},
		RC_BAG_DEDUCTITEM_FAILED = {
			type = "value",
			description = "value=505"
		},
		RC_BAG_SELLTITEM_FAILED = {
			type = "value",
			description = "value=506"
		},
		RC_BAG_HAVENOT_BUYGGRID = {
			type = "value",
			description = "value=507"
		},
		RC_BAG_ITEM_CDTIME = {
			type = "value",
			description = "value=508"
		},
		RC_BAG_ADDITEM_FAILED = {
			type = "value",
			description = "value=509"
		},
		RC_BAG_BUYGRID_FAILED = {
			type = "value",
			description = "value=510"
		},
		RC_BAG_CANNOTADDTOKEN = {
			type = "value",
			description = "value=511"
		},
		RC_BAG_HAVENOT_ENM_OPENGIRD = {
			type = "value",
			description = "value=512"
		},
		RC_BAG_CANNOT_ADDITEM_BYNULL = {
			type = "value",
			description = "value=512"
		},
		RC_NO_ENOUGH_LEVEL = {
			type = "value",
			description = "value=600"
		},
		RC_NO_ENOUGH_ITEM = {
			type = "value",
			description = "value=601"
		},
		RC_GM_FAILD = {
			type = "value",
			description = "value=900"
		},
		RC_GM_CMD_FORMAT_ERROR = {
			type = "value",
			description = "value=901"
		},
		RC_GM_CMD_NO_GM_KEY_NAME = {
			type = "value",
			description = "value=902"
		},
		RC_GM_CMD_NOT_FIND_GM_NAME = {
			type = "value",
			description = "value=903"
		},
		RC_GM_CMD_PARAM_ERROR = {
			type = "value",
			description = "value=904"
		},
		RC_GM_CMD_NO_ENOUGH_POWER = {
			type = "value",
			description = "value=905"
		},
		RC_BUFFER_FAILED = {
			type = "value",
			description = "value=1000"
		},
		RC_BUFFER_EXIST_SAME = {
			type = "value",
			description = "value=1001"
		},
		RC_BUFFER_NO_EXIST = {
			type = "value",
			description = "value=1002"
		},
		RC_BUFFER_EXIST_HIGHER = {
			type = "value",
			description = "value=1003"
		},
		RC_FIGHT_HAS_START = {
			type = "value",
			description = "value=1100"
		},
		RC_SKILL_NO_USE = {
			type = "value",
			description = "value=1200"
		},
		RC_SKILL_NO_USE_SKILL = {
			type = "value",
			description = "value=1201"
		},
		RC_SKILL_NO_JOB = {
			type = "value",
			description = "value=1202"
		},
		RC_SKILL_NO_DISTANCE = {
			type = "value",
			description = "value=1203"
		},
		RC_SKILL_NO_ENOUGH_MP = {
			type = "value",
			description = "value=1204"
		},
		RC_SKILL_NO_ATTACK_AND_TARGET_TYPE = {
			type = "value",
			description = "value=1205"
		},
		RC_SKILL_DEST_OBJ_IS_DIE = {
			type = "value",
			description = "value=1206"
		},
		RC_SKILL_NO_DEST_OBJ = {
			type = "value",
			description = "value=1207"
		},
		RC_SKILL_NO_SKILL_TYPE = {
			type = "value",
			description = "value=1208"
		},
		RC_SKILL_OWN_ISDIE = {
			type = "value",
			description = "value=1209"
		},
		RC_SKILL_NO_BE_ATTACK = {
			type = "value",
			description = "value=1215"
		},
		RC_SKILL_CAN_NOT_ATTACK_IN_FACTION = {
			type = "value",
			description = "value=1216"
		},
		RC_SKILL_NO_EMPTY_POS = {
			type = "value",
			description = "value=1217"
		},
		RC_SKILL_NO_CD = {
			type = "value",
			description = "value=1220"
		},
		RC_SKILL_NO_USE_ON_OBJ = {
			type = "value",
			description = "value=1221"
		},
		RC_SKILL_IN_SAFE_ZONE = {
			type = "value",
			description = "value=1222"
		},
		RC_SKILL_CAN_NOT_LOW_LEVEL_ROLE = {
			type = "value",
			description = "value=1223"
		},
		RC_SKILL_CAN_NOT_DIFF_LEVEL_ROLE = {
			type = "value",
			description = "value=1224"
		},
		RC_SKILL_CAN_NOT_ATTACK_IN_PEACE = {
			type = "value",
			description = "value=1225"
		},
		RC_SKILL_CAN_NOT_ATTACK_IN_GUILD = {
			type = "value",
			description = "value=1226"
		},
		RC_SKILL_MAX_LEVEL = {
			type = "value",
			description = "value=1210"
		},
		RC_SKILL_NO_ENOUGH_GOLD = {
			type = "value",
			description = "value=1211"
		},
		RC_SKILL_NO_EXP = {
			type = "value",
			description = "value=1212"
		},
		RC_SKILL_NO_LEVEL = {
			type = "value",
			description = "value=1213"
		},
		RC_SKILL_MAX_NUM = {
			type = "value",
			description = "value=1214"
		},
		RC_SKILL_NO_ENOUGH_SKILL_BOOK = {
			type = "value",
			description = "value=1218"
		},
		RC_SKILL_NO_PRE_GRADE = {
			type = "value",
			description = "value=1219"
		},
		RC_CHAT_SMALL_LEVEL_ERR = {
			type = "value",
			description = "value=1300"
		},
		RC_CHAT_GAP_TIME_TOO_SHORT_ERR = {
			type = "value",
			description = "value=1301"
		},
		RC_CHAT_CONTENT_IS_EMPTY_ERR = {
			type = "value",
			description = "value=1302"
		},
		RC_CHAT_CONTENT_ALL_EMPTY_ERR = {
			type = "value",
			description = "value=1303"
		},
		RC_CHAT_OTHER_FORBID_CONTENT_ERR = {
			type = "value",
			description = "value=1304"
		},
		RC_CHAT_INVALID_GM_ERR = {
			type = "value",
			description = "value=1305"
		},
		RC_CHAT_CONTENT_TOO_LONG_ERR = {
			type = "value",
			description = "value=1306"
		},
		RC_CHAT_FORBBID_ERR = {
			type = "value",
			description = "value=1307"
		},
		RC_MISSION_FAILD = {
			type = "value",
			description = "value=1400"
		},
		RC_MISSION_NO_EXIST = {
			type = "value",
			description = "value=1401"
		},
		RC_MISSION_NO_LEVEL = {
			type = "value",
			description = "value=1402"
		},
		RC_MISSION_NO_PRI_ID = {
			type = "value",
			description = "value=1403"
		},
		RC_MISSION_BAG_NO_EMPTY = {
			type = "value",
			description = "value=1404"
		},
		RC_MISSION_HAS_ACCEPT = {
			type = "value",
			description = "value=1405"
		},
		RC_MISSION_HAS_FINISH = {
			type = "value",
			description = "value=1406"
		},
		RC_MISSION_NO_COLLECT_ITEM = {
			type = "value",
			description = "value=1407"
		},
		RC_MISSION_NO_FINISHED = {
			type = "value",
			description = "value=1408"
		},
		RC_MAP_FAILD = {
			type = "value",
			description = "value=1700"
		},
		RC_MAP_NO_TRANSMIT_ID = {
			type = "value",
			description = "value=1701"
		},
		RC_MAP_NO_IN_TRANSMIT = {
			type = "value",
			description = "value=1702"
		},
		RC_MAP_LEVEL_IS_LESS = {
			type = "value",
			description = "value=1703"
		},
		RC_MAP_NO_FIND_DEST_MAP = {
			type = "value",
			description = "value=1704"
		},
		RC_MAP_CHANGE_LINE_WAIT = {
			type = "value",
			description = "value=1705"
		},
		RC_MAP_CHANGE_LINE_FAILED = {
			type = "value",
			description = "value=1706"
		},
		RC_MAP_OPENING_DYNAMAP = {
			type = "value",
			description = "value=1707"
		},
		RC_MAP_CHANGING_LINE = {
			type = "value",
			description = "value=1708"
		},
		RC_MAP_NO_TELPORT = {
			type = "value",
			description = "value=1709"
		},
		RC_MAP_NOT_EQUAL = {
			type = "value",
			description = "value=1710"
		},
		RC_MAP_DEST_POS_NOT_WALK = {
			type = "value",
			description = "value=1711"
		},
		RC_MAP_NOT_FIND = {
			type = "value",
			description = "value=1712"
		},
		RC_CANT_ENTER_RISK_MAP = {
			type = "value",
			description = "value=1713"
		},
		RC_ITEM_FAILD = {
			type = "value",
			description = "value=1800"
		},
		RC_ITEM_IS_BINDED = {
			type = "value",
			description = "value=1801"
		},
		RC_ITEM_IS_LOCKED = {
			type = "value",
			description = "value=1802"
		},
		RC_ITEM_IS_OUTDAY = {
			type = "value",
			description = "value=1803"
		},
		RC_ITEM_IS_TASK = {
			type = "value",
			description = "value=1804"
		},
		RC_ITEM_NO_EXIST = {
			type = "value",
			description = "value=1805"
		},
		RC_CREATE_ITEM_FAILED = {
			type = "value",
			description = "value=1807"
		},
		RC_ITEM_NOT_FIND_IN_CONFIG = {
			type = "value",
			description = "value=1808"
		},
		RC_ITEM_USE_NO_OBJECT = {
			type = "value",
			description = "value=1809"
		},
		RC_ITEM_IS_NO_DESTORY = {
			type = "value",
			description = "value=1810"
		},
		RC_ITEM_NO_CD = {
			type = "value",
			description = "value=1811"
		},
		RC_TEXT_INVALID = {
			type = "value",
			description = "value=20000"
		},
		RC_REGISTE_MAP_REPEAT = {
			type = "value",
			description = "value=40000"
		},
		RC_REGISTE_MAP_NOT_ADD = {
			type = "value",
			description = "value=40001"
		},
		RC_CHANGE_LINE_ROLE_FULL = {
			type = "value",
			description = "value=40002"
		},
		RC_REGISTE_SERVER_REPEAT = {
			type = "value",
			description = "value=40003"
		},
		RC_RECHARGE_WORLD_SERVER_ERR = {
			type = "value",
			description = "value=52000"
		},
		RC_RECHARGE_WORLD_SERVER_DB_ERR = {
			type = "value",
			description = "value=52001"
		},
		RC_RECHARGE_MAP_SERVER_UN_EXIST = {
			type = "value",
			description = "value=52002"
		},
		RC_RECHARGE_TIME_OUT = {
			type = "value",
			description = "value=52003"
		},
		RC_RECHARGE_ROLE_UNEXIST = {
			type = "value",
			description = "value=52004"
		},
		RC_RECHARGE_HAS_CHANGE_LINE = {
			type = "value",
			description = "value=52005"
		},
		RC_RECHARGE_HAS_REQUEST_STATUS = {
			type = "value",
			description = "value=52006"
		},
		RC_RECHARGE_HAS_RECHARGE = {
			type = "value",
			description = "value=52007"
		},
		RC_RECHARGE_USER_UN_EXIST = {
			type = "value",
			description = "value=52008"
		},
		RC_RECHARGE_ROLE_NOT_ENTER = {
			type = "value",
			description = "value=52009"
		},
	}
},
EPacketIDDef = {
	type = "lib",
	description = "EPacketIDDef",
	childs = {
		PACKET_WC_TEST = {
			type = "value",
			description = "value=1"
		},
		PACKET_CW_TEST_REQ = {
			type = "value",
			description = "value=2"
		},
		PACKET_CM_VARIED_TEST = {
			type = "value",
			description = "value=100"
		},
		PACKET_MC_VARIED_TEST_RET = {
			type = "value",
			description = "value=101"
		},
		PACKET_CM_GM_COMMAND = {
			type = "value",
			description = "value=102"
		},
		PACKET_CL_VERIFY_ACCOUNT = {
			type = "value",
			description = "value=1001"
		},
		PACKET_LC_VERIFY_ACCOUNT_RET = {
			type = "value",
			description = "value=1002"
		},
		PACKET_CW_LOGIN_GAME = {
			type = "value",
			description = "value=1003"
		},
		PACKET_WC_LOGIN_GAME_RET = {
			type = "value",
			description = "value=1004"
		},
		PACKET_CW_LOGIN_QUIT = {
			type = "value",
			description = "value=1005"
		},
		PACKET_WC_LOGIN_QUIT_RET = {
			type = "value",
			description = "value=1006"
		},
		PACKET_CW_CREATE_ROLE = {
			type = "value",
			description = "value=1008"
		},
		PACKET_WC_CREATE_ROLE_RET = {
			type = "value",
			description = "value=1009"
		},
		PACKET_CL_ZONE_LIST_REQ = {
			type = "value",
			description = "value=1010"
		},
		PACKET_LC_ZONE_LIST_RET = {
			type = "value",
			description = "value=1011"
		},
		PACKET_CW_VERIFY_CONNECT = {
			type = "value",
			description = "value=1012"
		},
		PACKET_WC_VERIFY_CONNECT_RET = {
			type = "value",
			description = "value=1013"
		},
		PACKET_CW_RAND_ROLE_NAME = {
			type = "value",
			description = "value=1014"
		},
		PACKET_WC_RAND_ROLE_NAME_RET = {
			type = "value",
			description = "value=1015"
		},
		PACKET_CL_HAS_ROLE_ZONE_LIST = {
			type = "value",
			description = "value=1016"
		},
		PACKET_LC_HAS_ROLE_ZONE_LIST_RET = {
			type = "value",
			description = "value=1017"
		},
		PACKET_CM_LOCAL_LOGIN = {
			type = "value",
			description = "value=1101"
		},
		PACKET_MC_LOCAL_LOGIN_RET = {
			type = "value",
			description = "value=1102"
		},
		PACKET_CM_ENTER_GAME = {
			type = "value",
			description = "value=1103"
		},
		PACKET_MC_ENTER_GAME_RET = {
			type = "value",
			description = "value=1104"
		},
		PACKET_MC_ENTER_VIEW = {
			type = "value",
			description = "value=1200"
		},
		PACKET_MC_LEAVE_VIEW = {
			type = "value",
			description = "value=1201"
		},
		PACKET_MC_SCENE_DATA = {
			type = "value",
			description = "value=1202"
		},
		PACKET_CM_MOVE = {
			type = "value",
			description = "value=1203"
		},
		PACKET_MC_MOVE_RET = {
			type = "value",
			description = "value=1204"
		},
		PACKET_MC_MOVE_BROAD = {
			type = "value",
			description = "value=1205"
		},
		PACKET_CM_ENTER_SCENE = {
			type = "value",
			description = "value=1206"
		},
		PACKET_CM_CHAT = {
			type = "value",
			description = "value=1207"
		},
		PACKET_MC_CHAT_BROAD = {
			type = "value",
			description = "value=1208"
		},
		PACKET_CM_TRANSMITE = {
			type = "value",
			description = "value=1209"
		},
		PACKET_MC_TRANSMITE_RET = {
			type = "value",
			description = "value=1210"
		},
		PACKET_MC_SYNC_ROLE_DATA = {
			type = "value",
			description = "value=1211"
		},
		PACKET_MC_ENTER_SCENE_RET = {
			type = "value",
			description = "value=1212"
		},
		PACKET_CM_RENAME_ROLE_NAME = {
			type = "value",
			description = "value=1213"
		},
		PACKET_MC_RENAME_ROLE_NAME_RET = {
			type = "value",
			description = "value=1214"
		},
		PACKET_CM_RAND_ROLE_NAME = {
			type = "value",
			description = "value=1215"
		},
		PACKET_MC_RAND_ROLE_NAME_RET = {
			type = "value",
			description = "value=1216"
		},
		PACKET_CM_KICK_ROLE = {
			type = "value",
			description = "value=1217"
		},
		PACKET_MC_KICK_ROLE_RET = {
			type = "value",
			description = "value=1218"
		},
		PACKET_MC_ANNOUNCEMENT = {
			type = "value",
			description = "value=1219"
		},
		PACKET_CM_JUMP = {
			type = "value",
			description = "value=1220"
		},
		PACKET_MC_JUMP_RET = {
			type = "value",
			description = "value=1221"
		},
		PACKET_CM_DROP = {
			type = "value",
			description = "value=1222"
		},
		PACKET_MC_DROP_RET = {
			type = "value",
			description = "value=1223"
		},
		PACKET_CM_LAND = {
			type = "value",
			description = "value=1224"
		},
		PACKET_MC_LAND_RET = {
			type = "value",
			description = "value=1225"
		},
		PACKET_MC_RESET_POS = {
			type = "value",
			description = "value=1226"
		},
		PACKET_MC_PLAYER_HEART = {
			type = "value",
			description = "value=1227"
		},
		PACKET_CM_PLAYER_HEART_RET = {
			type = "value",
			description = "value=1228"
		},
		PACKET_MC_ENTER_SCENE = {
			type = "value",
			description = "value=1229"
		},
		PACKET_CM_OPEN_DYNAMIC_MAP = {
			type = "value",
			description = "value=1230"
		},
		PACKET_MC_OPEN_DYNAMIC_MAP_RET = {
			type = "value",
			description = "value=1231"
		},
		PACKET_CM_CHANGE_MAP = {
			type = "value",
			description = "value=1232"
		},
		PACKET_MC_CHANGE_MAP_RET = {
			type = "value",
			description = "value=1233"
		},
		PACKET_CM_DYNAMIC_MAP_LIST = {
			type = "value",
			description = "value=1234"
		},
		PACKET_MC_DYNAMIC_MAP_LIST_RET = {
			type = "value",
			description = "value=1235"
		},
		PACKET_MC_ATTACK_BROAD = {
			type = "value",
			description = "value=1300"
		},
		PACKET_MC_ATTACK_IMPACT = {
			type = "value",
			description = "value=1301"
		},
		PACKET_CM_BUFF_ARRAY = {
			type = "value",
			description = "value=1302"
		},
		PACKET_MC_BUFF_ARRAY_RET = {
			type = "value",
			description = "value=1303"
		},
		PACKET_CM_VIEW_BUFF = {
			type = "value",
			description = "value=1304"
		},
		PACKET_MC_VIEW_BUFF_RET = {
			type = "value",
			description = "value=1305"
		},
		PACKET_MC_ADD_BUFFER = {
			type = "value",
			description = "value=1306"
		},
		PACKET_MC_DEL_BUFFER = {
			type = "value",
			description = "value=1307"
		},
		PACKET_MC_OBJ_ACTION_BAN = {
			type = "value",
			description = "value=1308"
		},
		PACKET_CM_FIGHT_FINISH = {
			type = "value",
			description = "value=1309"
		},
		PACKET_MC_FIGHT_FINISH_RET = {
			type = "value",
			description = "value=1310"
		},
		PACKET_CM_FIGHT_OPEN_CHAPTER = {
			type = "value",
			description = "value=1311"
		},
		PACKET_MC_FIGHT_OPEN_CHAPTER_RET = {
			type = "value",
			description = "value=1312"
		},
		PACKET_MC_ITEM_LIST = {
			type = "value",
			description = "value=1400"
		},
		PACKET_MC_ADD_ITEM = {
			type = "value",
			description = "value=1401"
		},
		PACKET_MC_DELETE_ITEM = {
			type = "value",
			description = "value=1402"
		},
		PACKET_MC_UPDATE_ITEM = {
			type = "value",
			description = "value=1403"
		},
		PACKET_MC_MOVE_ITEM = {
			type = "value",
			description = "value=1404"
		},
		PACKET_MC_EXCHANGE_ITEM = {
			type = "value",
			description = "value=1405"
		},
		PACKET_CM_BAG_BUY_GRID = {
			type = "value",
			description = "value=1406"
		},
		PACKET_MC_BAG_BUY_GRID_RET = {
			type = "value",
			description = "value=1407"
		},
		PACKET_MC_BAG_ADD_GRID = {
			type = "value",
			description = "value=1408"
		},
		PACKET_CM_BAG_OPERATOR = {
			type = "value",
			description = "value=1409"
		},
		PACKET_MC_BAG_OPERATOR_RET = {
			type = "value",
			description = "value=1410"
		},
		PACKET_MC_MISSION_UPDATE = {
			type = "value",
			description = "value=2900"
		},
		PACKET_MC_MISSION_UPDATE_PARAMS = {
			type = "value",
			description = "value=2901"
		},
		PACKET_MC_MISSIONRE_DEL = {
			type = "value",
			description = "value=2902"
		},
		PACKET_CM_MISSION_OPERATION = {
			type = "value",
			description = "value=2903"
		},
		PACKET_MC_MISSION_OPERATION_RET = {
			type = "value",
			description = "value=2904"
		},
		PACKET_CM_CHAT_REQ = {
			type = "value",
			description = "value=3000"
		},
		PACKET_MC_CHAT_RET = {
			type = "value",
			description = "value=3001"
		},
		PACKET_MC_CALLLBACKRETCODE = {
			type = "value",
			description = "value=3999"
		},
		PACKET_MC_BUFFER_TBL_DATA = {
			type = "value",
			description = "value=4000"
		},
		PACKET_MC_CONSTANT_TBL_DATA = {
			type = "value",
			description = "value=4001"
		},
		PACKET_CM_EXCHANGE_GIFT_REQ = {
			type = "value",
			description = "value=4600"
		},
		PACKET_MC_EXCHANGE_GIFT_RET = {
			type = "value",
			description = "value=4601"
		},
		PACKET_MC_TILI_INFO = {
			type = "value",
			description = "value=4602"
		},
		PACKET_MC_ACTIVE_ADD = {
			type = "value",
			description = "value=4603"
		},
		PACKET_MW_REGISTE = {
			type = "value",
			description = "value=31001"
		},
		PACKET_WM_REGISTE_RET = {
			type = "value",
			description = "value=31002"
		},
		PACKET_WM_CLOSE_SERVER = {
			type = "value",
			description = "value=31003"
		},
		PACKET_WM_UPDATE_SERVER = {
			type = "value",
			description = "value=31004"
		},
		PACKET_MW_UPDATE_SERVER = {
			type = "value",
			description = "value=31005"
		},
		PACKET_MW_OPEN_SCENE = {
			type = "value",
			description = "value=31006"
		},
		PACKET_MW_CLOSE_SCENE = {
			type = "value",
			description = "value=31007"
		},
		PACKET_MW_BROAD = {
			type = "value",
			description = "value=31101"
		},
		PACKET_MW_TRANS = {
			type = "value",
			description = "value=31102"
		},
		PACKET_WM_TRANS_ERROR = {
			type = "value",
			description = "value=31103"
		},
		PACKET_MW_TRANS_TO_WORLD = {
			type = "value",
			description = "value=31104"
		},
		PACKET_WM_BROAD = {
			type = "value",
			description = "value=31105"
		},
		PACKET_WM_LOAD_ROLE_DATA = {
			type = "value",
			description = "value=31201"
		},
		PACKET_MW_LOAD_ROLE_DATA_RET = {
			type = "value",
			description = "value=31202"
		},
		PACKET_WM_UNLOAD_ROLE_DATA = {
			type = "value",
			description = "value=31203"
		},
		PACKET_MW_UNLOAD_ROLE_DATA_RET = {
			type = "value",
			description = "value=31204"
		},
		PACKET_MW_ROLE_QUIT = {
			type = "value",
			description = "value=31205"
		},
		PACKET_MW_ROLE_KICK = {
			type = "value",
			description = "value=31206"
		},
		PACKET_MW_ROLE_HEART = {
			type = "value",
			description = "value=31207"
		},
		PACKET_WM_ROLE_HEART_RET = {
			type = "value",
			description = "value=31208"
		},
		PACKET_WM_USER_UPDATE = {
			type = "value",
			description = "value=31209"
		},
		PACKET_MW_ROLE_UPDATE = {
			type = "value",
			description = "value=31210"
		},
		PACKET_MW_USER_LOGIN = {
			type = "value",
			description = "value=31211"
		},
		PACKET_MW_CHANGE_LINE = {
			type = "value",
			description = "value=31212"
		},
		PACKET_WM_CHANGE_LINE_RET = {
			type = "value",
			description = "value=31213"
		},
		PACKET_WM_CHANGE_LINE = {
			type = "value",
			description = "value=31214"
		},
		PACKET_MW_RAND_ROLE_NAME = {
			type = "value",
			description = "value=31215"
		},
		PACKET_WM_RAND_ROLE_NAME_RET = {
			type = "value",
			description = "value=31216"
		},
		PACKET_MW_RENAME_ROLE_NAME = {
			type = "value",
			description = "value=31217"
		},
		PACKET_WM_RENAME_ROLE_NAME_RET = {
			type = "value",
			description = "value=31218"
		},
		PACKET_MW_GET_RAND_NAME_LIST = {
			type = "value",
			description = "value=31219"
		},
		PACKET_WM_GET_RAND_NAME_LIST_RET = {
			type = "value",
			description = "value=31220"
		},
		PACKET_MW_EXCHANGE_GIFT_REQ = {
			type = "value",
			description = "value=31238"
		},
		PACKET_WM_EXCHANGE_GIFT_RET = {
			type = "value",
			description = "value=31239"
		},
		PACKET_WM_LIMIT_ACCOUNT_INFO = {
			type = "value",
			description = "value=31241"
		},
		PACKET_WM_LIMIT_CHAT_INFO = {
			type = "value",
			description = "value=31242"
		},
		PACKET_MW_LIMIT_INFO_REQ = {
			type = "value",
			description = "value=31243"
		},
		PACKET_WM_SERVER_INFO = {
			type = "value",
			description = "value=31244"
		},
		PACKET_WM_AWARD_BIND_RMB = {
			type = "value",
			description = "value=31245"
		},
		PACKET_MW_ANNOUNCEMENT = {
			type = "value",
			description = "value=31246"
		},
		PACKET_MM_CHANGE_SCENE = {
			type = "value",
			description = "value=31252"
		},
		PACKET_MR_RECORDE = {
			type = "value",
			description = "value=31400"
		},
		PACKET_WR_RECORDE = {
			type = "value",
			description = "value=31401"
		},
		PACKET_RR_RECORDE = {
			type = "value",
			description = "value=31404"
		},
		PACKET_PS_REQUEST = {
			type = "value",
			description = "value=31402"
		},
		PACKET_SP_RESPONSE = {
			type = "value",
			description = "value=31403"
		},
		PACKET_RW_SERVER_INFO = {
			type = "value",
			description = "value=31405"
		},
		PACKET_WR_SERVER_INFO_RET = {
			type = "value",
			description = "value=31406"
		},
		PACKET_GP_REQUEST = {
			type = "value",
			description = "value=31407"
		},
		PACKET_PG_RESPONSE = {
			type = "value",
			description = "value=31408"
		},
		PACKET_BR_RECORDE = {
			type = "value",
			description = "value=31409"
		},
		PACKET_WL_REGIST = {
			type = "value",
			description = "value=31500"
		},
		PACKET_LW_REGIST_RET = {
			type = "value",
			description = "value=31501"
		},
		PACKET_WL_ROLE_LOGIN = {
			type = "value",
			description = "value=31502"
		},
		PACKET_LW_ROLE_LOGIN_RET = {
			type = "value",
			description = "value=31503"
		},
		PACKET_WL_ROLE_CREATE = {
			type = "value",
			description = "value=31504"
		},
		PACKET_LW_ROLE_CREATR_RET = {
			type = "value",
			description = "value=31505"
		},
		PACKET_WL_DATA_UPDATE = {
			type = "value",
			description = "value=31506"
		},
		PACKET_LW_LIMIT_INFO_UPDATE = {
			type = "value",
			description = "value=31507"
		},
		PACKET_LW_LIMIT_ACCOUNT_INFO = {
			type = "value",
			description = "value=31508"
		},
		PACKET_LW_LIMIT_CHAT_INFO = {
			type = "value",
			description = "value=31509"
		},
		PACKET_WL_LIMIT_INFO_REQ = {
			type = "value",
			description = "value=31510"
		},
		PACKET_XM_REGISTE = {
			type = "value",
			description = "value=32000"
		},
		PACKET_MX_REGISTE_RET = {
			type = "value",
			description = "value=32001"
		},
		PACKET_WB_REGISTE = {
			type = "value",
			description = "value=32100"
		},
		PACKET_BW_REGISTE_RET = {
			type = "value",
			description = "value=32101"
		},
		PACKET_BW_RECHARGE = {
			type = "value",
			description = "value=32102"
		},
		PACKET_WB_RECHARGE_RET = {
			type = "value",
			description = "value=32103"
		},
		PACKET_WM_RECHARGE = {
			type = "value",
			description = "value=32104"
		},
		PACKET_MW_RECHARGE_RET = {
			type = "value",
			description = "value=32105"
		},
	}
},
EGmPowerLevel = {
	type = "lib",
	description = "EGmPowerLevel",
	childs = {
		GM_POWER_INVALID = {
			type = "value",
			description = "value=0"
		},
		GM_POWER_LEVEL_1 = {
			type = "value",
			description = "value=1"
		},
		GM_POWER_LEVEL_2 = {
			type = "value",
			description = "value=2"
		},
		GM_POWER_LEVEL_3 = {
			type = "value",
			description = "value=3"
		},
		GM_POWER_LEVEL_4 = {
			type = "value",
			description = "value=4"
		},
		GM_POWER_LEVEL_5 = {
			type = "value",
			description = "value=5"
		},
		GM_POWER_DEBUG = {
			type = "value",
			description = "value=6"
		},
	}
},
EMoneyRecordTouchType = {
	type = "lib",
	description = "EMoneyRecordTouchType",
	childs = {
		MONEYRECORDDEFINE = {
			type = "value",
			description = "value=0"
		},
		MALL_BUYITEM = {
			type = "value",
			description = "value=1"
		},
		OPEN_BAGGUID = {
			type = "value",
			description = "value=2"
		},
		LEVELRAWARD = {
			type = "value",
			description = "value=3"
		},
		RECORD_SELL_ITEM = {
			type = "value",
			description = "value=4"
		},
		RECORD_NEW_ROLE_AWARD = {
			type = "value",
			description = "value=5"
		},
		RECORD_COMPENSATE_RMB = {
			type = "value",
			description = "value=6"
		},
		RECORD_NEW_ROLE_RMB = {
			type = "value",
			description = "value=7"
		},
		RECORD_MISSION_AWARD = {
			type = "value",
			description = "value=22"
		},
		MONEY_GM = {
			type = "value",
			description = "value=250"
		},
	}
},
EItemRecordType = {
	type = "lib",
	description = "EItemRecordType",
	childs = {
		ITEM_RECORD_DEFAULT = {
			type = "value",
			description = "value=0"
		},
		ITEM_RECORD_MALL_BUY = {
			type = "value",
			description = "value=1"
		},
		ITEM_RECORD_USE_ITEM = {
			type = "value",
			description = "value=2"
		},
		ITEM_RECORD_NEW_ROLE = {
			type = "value",
			description = "value=3"
		},
		ITEM_RECORD_EXCHANGE_GIFT = {
			type = "value",
			description = "value=4"
		},
		ITEM_RECORD_DROP = {
			type = "value",
			description = "value=5"
		},
		ITEM_RECORD_ITEM_GM = {
			type = "value",
			description = "value=250"
		},
	}
},
EManagerQueType = {
	type = "lib",
	description = "EManagerQueType",
	childs = {
		MGR_QUE_TYPE_INVALID = {
			type = "value",
			description = "value=0"
		},
		MGR_QUE_TYPE_READY = {
			type = "value",
			description = "value=1"
		},
		MGR_QUE_TYPE_ENTER = {
			type = "value",
			description = "value=2"
		},
		MGR_QUE_TYPE_LOGOUT = {
			type = "value",
			description = "value=3"
		},
	}
},
EUserFlag = {
	type = "lib",
	description = "EUserFlag",
	childs = {
		USER_FLAG_START_NUM = {
			type = "value",
			description = "value=0"
		},
		USER_FLAG_MAX_NUMBER = {
			type = "value",
			description = "value=255"
		},
	}
},
EScanReturn = {
	type = "lib",
	description = "EScanReturn",
	childs = {
		SCAN_RETURN_CONTINUE = {
			type = "value",
			description = "value=0"
		},
		SCAN_RETURN_BREAK = {
			type = "value",
			description = "value=1"
		},
		SCAN_RETURN_RETURN = {
			type = "value",
			description = "value=2"
		},
		SCAN_RETURN_NUMBER = {
			type = "value",
			description = "value=3"
		},
	}
},
EImpactType = {
	type = "lib",
	description = "EImpactType",
	childs = {
		IMPACT_TYPE_ME = {
			type = "value",
			description = "value=1"
		},
		IMPACT_TYPE_OTHER = {
			type = "value",
			description = "value=2"
		},
	}
},
ETransCode = {
	type = "lib",
	description = "ETransCode",
	childs = {
		TRANS_CODE_CONTINUE = {
			type = "value",
			description = "value=0"
		},
		TRANS_CODE_STOP = {
			type = "value",
			description = "value=1"
		},
	}
},
EMapDataBlockFlag = {
	type = "lib",
	description = "EMapDataBlockFlag",
	childs = {
		BLOCK_FLAG_WALK = {
			type = "value",
			description = "value=1"
		},
		BLOCK_FLAG_TRANSPARENT = {
			type = "value",
			description = "value=2"
		},
		BLOCK_FLAG_SKILL = {
			type = "value",
			description = "value=4"
		},
		BLOCK_FLAG_BATTLE = {
			type = "value",
			description = "value=8"
		},
		BLOCK_FLAG_SAFE_ZONE = {
			type = "value",
			description = "value=16"
		},
	}
},
EDbgOption = {
	type = "lib",
	description = "EDbgOption",
	childs = {
		DBG_OPTION_ENTER_VIEW = {
			type = "value",
			description = "value=0"
		},
	}
},
EMapServerInitFlag = {
	type = "lib",
	description = "EMapServerInitFlag",
	childs = {
		MAP_SVR_INIT_FLAG_DB_INIT = {
			type = "value",
			description = "value=0"
		},
		MAP_SVR_INIT_FLAG_WORLD_REGISTE = {
			type = "value",
			description = "value=1"
		},
		MAP_SVR_INIT_FLAG_SERVICE_START = {
			type = "value",
			description = "value=2"
		},
	}
},

}
end