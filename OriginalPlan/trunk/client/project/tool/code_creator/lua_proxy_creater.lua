local MsgType = {}

MsgType.GUILD_TRAIN_INFO = 7120
MsgType.GUILD_TRAIN_FIGHT = 7121
MsgType.GUILD_TRAIN_FIGHT_END = 7122
MsgType.GUILD_TRAIN_REWARD = 7123
MsgType.GUILD_TRAIN_PASS_REWARD = 7124
MsgType.GUILD_TRAIN_REWARD_INFO = 7125
MsgType.GUILD_TRAIN_DUNGEON_LOG = 7126
MsgType.GUILD_TRAIN_DUNGEON_RANK = 7127
MsgType.GUILD_TRAIN_TIMES_BUY = 7128
MsgType.GUILD_TRAIN_RESET = 7129

local protocol = {
	[7120] = {	-- ѵ������Ϣ
		c = {},
		s = {
			{"result", "int16"},
			{"train_count", "int16"},		-- ����ս����
			{"buy_count", "int16"},		-- �ѹ������
			{"train_list", "array", "train_info"},
			{"can_reset","int8"}			-- �ɷ����þ���
		}
	},
	
	[7121] = {	-- ��ս�ؿ�
		c = {
			{"dungeonId", "uint16"}
		},
		s = {
			{"result", "int16"},
			{"dungeonId", "uint16"},
			{"dieList", "array", "train_hero"} -- ���𻵵Ĺ���
		}
	},
	
	[7122] = {	-- ��ս�������
		c = {
			{"dungeonID", "uint16"},
			{"hurt", "uint32"},						-- ��ɵ��˺�
			{"isWin", "int8"},					-- �Ƿ�ͨ�� 1ͨ�� 0δͨ��
			{"dieList", "array", "train_hero"}
		},
		s = {
			{"result", "int16"},
			{"dungeonId", "int16"},	
			{"member_exp", "int16"},		-- ���Ź���
			{"union_coin", "int16"},		-- ���ű�
		}
	},
	
	[7123] = {	-- ��ͨ�ر���
		c = {
			{"dungeonID", "uint16"},
			{"is_double", "uint8"},		-- 0���� 1˫�� 
		},
		s = {
			{"result", "int16"},
			{"reward_list","array","type_item"}		-- ͨ�ر���
		}
	},
	
	[7124] = {	-- ��ȡȫͨ����
		c = {
			{"train_id", "int16"}
		},
		s = {
			{"result", "int16"},
			{"gold", "int16"}
		}
	},
	
	[7125] = {	-- �������¼
		c = {
			{"dungeonID","uint16"}
		},
		s = {
			{"result", "int16"},
			{"reward_record_list", "array", "train_reward_record"}
		}
	},
	
	[7126] = {	-- ����ͨ���鱨
		c = {},
		s = {
			{"result", "int16"},
			{"train_pass_list", "array", "train_pass_record"}
		}
	},
	
	[7127] = {	-- �����˺�����
		c = {},
		s = {
			{"result", "int16"},
			{"train_hurt_list", "array","train_hurt_record"}
		}
	},
	
	[7128] = {	-- ������ս����
		c = {},
		s = {
			{"result", "int16"},
			{"buy_count", "uint8"},	-- �ѹ������
			{"train_count", "int16"} -- ����ս����
		}
	},
	
	[7129] = {	-- ���ų����ø���
		c = {},
		s = {
			{"result", "int16"}
		}
	},
	

    -- -----------------------------------------------
    -- ������¼
    -- -----------------------------------------------
    [7130] = {
        c = {
            {"dungeonID", "int16"}
        },
        s = {
            {"dungeonID", "int16"},
            {"min_power_role_name", "string"},
            {"min_power", "uint32"},
            {"min_power_message", "string"},
            {"min_time_role_name", "string"},
            {"min_time", "uint8"},
            {"min_time_message", "string"}
        }
    },

    [7131] = {
        c = {
            {"dungeonID", "int16"},
            {"flag", "int8"},           -- 1-ս�� 2-ʱ��
            {"message", "string"}
        },
        s = {
            {"result", "int16"}
        }
    },
}

--[[
usage:copy the protocol and MsgType here, and change the proxyName(and u can change the fileName, the result will save to the file), then run.
--]]

local proxyName = 'GuildProxy'
local fileName = proxyName .. "_.txt"

function capitalize(str)
	str = str:lower()
	if str:len() > 1 then
		return str:sub(1,1):upper() .. str:sub(2)
	else
		return str:upper()
	end
end

function convertReqFuncName(msgString)
	local ret = "req"
	for str in msgString:gmatch("%w+[a-zA-Z0-9]-") do
		ret = ret .. capitalize(str:lower())
	end
	return ret
end

function convertResponseFuncName(msgString)
	local ret = nil
	for str in msgString:gmatch("%w+[a-zA-Z0-9]-") do
		if not ret then
			ret = "_on" .. capitalize(str:lower())
		else
			ret = ret .. capitalize(str:lower())
		end
	end
	return ret
end

function createReqFunction(proxyName, name)
	local msgValue = MsgType[name]
	local msg = protocol[msgValue]
	local func = "function ".. proxyName .. ":" .. convertReqFuncName(name) .. "("
	local params = ""
	for i,val in ipairs(msg.c) do
		if params == "" then
			params = val[1]
		else
			params = params .. ', ' .. val[1]
		end
	end
	
	func = func .. params .. ")\n"
	local sendParams = ""
	if params ~= '' then
		sendParams = " ," .. params
	end
	func = func .. "\t" .. string.format('NetCenter:send(MsgType.%s%s)\n', name, sendParams)
	func = func .. "end\n"
	return func
end
--[[
function HeroProxy:_onHeroMaxNum(pack)
	ProxyBase._onPack(self,Notify.HERO_MAX_NUM, pack, function (self, event)

	end)
end
--]]

function createResFunction(proxyName, name)
	local msgValue = MsgType[name]
	local msg = protocol[msgValue]
	if not msg.s then return end
	local func = "function ".. proxyName .. ":" .. convertResponseFuncName(name) .. "(pack)\n"
	func = func .. "\t" .. string.format('ProxyBase._onPack(self,Notify.%s, pack, function (self, event)\n', name, sendParams)
	func = func .. '\n'
	func = func .. "\tend)\n"
	func = func .. "end\n"
	return func
end
 
local f,e = io.open(fileName, "w")
if not f then
	print(e)
	os.exit()
end
function output(str)
	print(str)
	--io.open("proxy_output.lua", str)
	f:write(str)
	f:write("\n")
end



local events = ""
for name in pairs(MsgType) do
	output(createReqFunction(proxyName, name))--"GUILD_TRAIN_INFO"
	output(createResFunction(proxyName, name))
	events = events .. string.format("\t\t[MsgType.%s] = self.%s,\n", name, convertResponseFuncName(name))
end

output(events)

f:close()
f = nil