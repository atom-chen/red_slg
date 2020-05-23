-- 登陆服验证

local packCfg = {
    [2001]={ -- 登陆验证
        c = {
            {"platformId", "int32"}
			,{"keyId","string"}
            ,{"accountPass", "string"}  -- 暂时没有
            ,{"isGuest", "int8"}        -- 1-是游客 0-不是
            ,{"OS", "int8"}             -- 手机系统 1-android 2-ios 0-未知
		},
        s = {
            {"result", "int16"}
		}
	}
    ,[2002] = { -- 服务器列表
		c = "",
        s = {
            {"platformList", "array", "platformInfo"}
        }
    }
    ,[2003]={ -- 选服
        c = { {"serverId", "int32"} },
		s = { 
            {"result", "int16"} 
            ,{"accountId", "string"}
            ,{"md5", "string"}
            ,{"ip", "string"}
            ,{"port", "int32"}
            ,{'platformId', "int32"}
        }
    }
    ,[2004] = { -- 角色注册
        c = {
            {"plat_id", "int32"}
            ,{"acc_id", "string"}
            ,{"passwd", "string"}
            ,{"OS", "int8"}         -- 手机系统 1-android 2-ios 0-未知
        },
        s = {
            {"result", "int16"}
        }
    }

    ,[2005] = { -- 帐号绑定
        c = {
            {"plat_id", "int32"}
            ,{"old_acc_id", "string"}
            ,{"new_acc_id", "string"}
			,{"new_acc_pwd","string"}
        },
        s = {
            {"result", "int16"}
        }
    }
    ,[2006] = { -- 君海平台要求的返回值
        s = {
            {"lgnjson", "string"}
        }
    }

    ,[2010] = {     -- 获取该账号登陆过的服务器
        c = {
        },
        s = {
            {"loginLogList", "array", "loginLog"}
        }
    }
}


return packCfg
