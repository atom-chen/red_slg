-- 登陆服务器与游戏服务器之间的通信
-- c 表示游戏服请求
-- s 表示登陆服返回
-- 特殊的通信, 要c和s一致

local packCfg = {
    [1000]={ -- 验证码
        c = {
            {"verify_code", "string"}
        },
        s = {
            {"verify_code", "string"}
        }
    }
    ,[1001]={ -- 发送服务器信息到登陆服务器
        c = {
			{"server_id","int32"} --服务器ID
            ,{"name", "string"}
            ,{"ip", "string"}
            ,{"port", "int32"}
            ,{"hot", "int8"}     --热度,1-热 0-否
		},
        s = {
			{"server_id","int32"} --服务器ID
            ,{"name", "string"}
            ,{"ip", "string"}
            ,{"port", "int32"}
            ,{"hot", "int8"}     --热度,1-热 0-否
		}
	}
    ,[1002] = { -- 1001 登陆服务器返回
        c = {},
        s = {}
    }
    ,[1003]={  -- 通知登陆服务器可以接受用户登陆
        c = {},
		s = {}
    }
    ,[1004] ={
        c = {
            {"platform_id", "int32"}
            ,{"account_id", "string"}
            ,{"md5", "string"}
        },
        s = {
            {"platform_id", "int32"}
            ,{"account_id", "string"}
            ,{"md5", "string"}
        }
    }
    ,[1005] = { -- 通知登录服, 当前在线人数
        c = {
            {"roleNum", "int32"},
            {"canLogin", "int8"}        -- 0-否 1-是
        },
        s = {
            {"roleNum", "int32"},
            {"canLogin", "int8"}        -- 0-否 1-是
        }
    }
    ,[1006] = { -- 通知游戏服角色注册
        c = {
            {"platform_id", "int32"}
            ,{"account_id", "string"}
        },
        s = {
            {"platform_id", "int32"}
            ,{"account_id", "string"}
        }
    }
    ,[1007] = { -- 帐号绑定
        c = {
            {"plat_id", "int32"}
            ,{"old_acc_id", "string"}
            ,{"new_acc_id", "string"}
        },
        s = {
            {"plat_id", "int32"}
            ,{"old_acc_id", "string"}
            ,{"new_acc_id", "string"}
        }
    }
}

return packCfg
