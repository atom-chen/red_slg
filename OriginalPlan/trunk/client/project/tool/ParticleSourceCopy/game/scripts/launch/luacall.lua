--
-- Author: LiangHongJie
-- Date: 2014-01-08 11:08:50
--
--[[--

	lua调用本地接口类

	这里列出不同类型对应的 Java 签名字符串：
	类型名	 			类型
	I	 				整数，或者 Lua function
	F	 				浮点数
	Z	 				布尔值
	Ljava/lang/String;	字符串
	V	 				Void 空，仅用于指定一个 Java 方法不返回任何值
	
	调用java时候的签名
	签名	 					解释
	()V	 						参数：无，返回值：无
	(I)V	 					参数：int，返回值：无
	(Ljava/lang/String;)Z	 	参数：字符串，返回值：布尔值
	(IF)Ljava/lang/String;	 	参数：整数、浮点数，返回值：字符串

	错误代码定义如下：
	错误代码	 描述
	-1	 		不支持的参数类型或返回值类型
	-2	 		无效的签名
	-3	 		没有找到指定的方法
	-4	 		Java 方法执行时抛出了异常
	-5	 		Java 虚拟机出错
	-6	 		Java 虚拟机出错


]]
local luacall = {}
luacall.className = "cm.sgfs.game.call.CallInterface"

--获取游戏登陆参数
function luacall.getUrlParams()
	if device.platform ~= "android" then
		return ;
	end
	local mothed = "getUrlParams"
	local args={}
	local sig = "()Ljava/lang/String;"
	local ok, ret = luaj.callStaticMethod(luacall.className, mothed, args, sig)
	if not ok then
    	print("luaj error:", ret)
	else
   		print("ret:", ret) -- 输出 ret: 5
   		local param = json.decode(ret,true)
   		if param then 
   			PLATFORM_ID=param["pf"] or PLATFORM_ID
   			SVRID_ID = param["svrid"] or SVRID_ID
   			ACCOUNT_ID = param["aid"] or ACCOUNT_ID
   			SES_KEY =param["ses"] or SES_KEY
   			SERVER_URL = param["svr"] or SERVER_URL
   			STIME = param["stime"] or STIME
   		end
	end
end
--玩家升级通知
function luacall.roleLevel()
	if device.platform ~= "android" then	return 	end
	local mothed = "roleLevel"
	local level = RoleModel.myInfo.level
	local name = RoleModel.myInfo.name
	local args={level,name}
	local sig = "(ILjava/lang/String;)V"
	luaj.callStaticMethod(luacall.className, mothed, args, sig)
end
--充值
function luacall.goCharge(amount)
	if device.platform ~= "android" then	return 	end
	amount = tonumber(amount)
	if amount <1 then return end
	local mothed = "goCharge"
	local roleId = RoleModel.myInfo.roleId
	local name = RoleModel.myInfo.name
	local args={roleId,name,amount}
	local sig = "(ILjava/lang/String;F)V"
	luaj.callStaticMethod(luacall.className, mothed, args, sig)
end
--打开心网页
function luacall.navigateTo(url)
	if device.platform ~= "android" or not not url then	return 	end

	local mothed = "navigateTo"
	local args={url}
	local sig = "(Ljava/lang/String;)V"
	luaj.callStaticMethod(luacall.className, mothed, args, sig)
end
--返回登陆
function luacall.backLogin()
	if device.platform ~= "android" then	return 	end
	local mothed = "backLogin"
	local args={}
	local sig = "()V"
	luaj.callStaticMethod(luacall.className, mothed, args, sig)
end

--读取文件
function luacall.readFile(path)
	if device.platform ~= "android" then	return 	end
	if not path then return nil end
	local mothed = "readFile"
	local args={path}
	local sig = "(Ljava/lang/String;)Ljava/lang/String;"
	local ok, ret = luaj.callStaticMethod(luacall.className, mothed, args, sig)
	if not ok then 	return nil end
	return ret
end
function luacall.performKeypadEvent( mainScene )
	if device.platform ~= "android" then return end
	local layer = display.newLayer()
	layer:setKeypadEnabled(true)
    layer:addKeypadEventListener(function(event)
        if event == "back" then 
            local mothed = "showAlertDialog"
			local args={"神魔乱舞","大侠是否需要退出游戏？",function ()
				CCDirector:sharedDirector():endToLua()
			end}
			local sig = "(Ljava/lang/String;Ljava/lang/String;I)V"
			luaj.callStaticMethod(luacall.className, mothed, args, sig)
            end
        end)
    mainScene:addChild(layer)
end
--[[
	读取缓存文件
]]
function luacall.cacheRead( fileName )
	if device.platform ~= "android" then return end
	if not fileName then return nil end
	local mothed = "cacheRead"
	local args={fileName}
	local sig = "(Ljava/lang/String;)Ljava/lang/String;"
	local ok, ret = luaj.callStaticMethod(luacall.className, mothed, args, sig)
	if not ok then 	return nil end
	return ret
end
--[[
	写入缓存文件
]]
function luacall.cacheWrite( fileName ,str)
	if device.platform ~= "android" then return end
	if not fileName or not str then return nil end
	local mothed = "cacheWrite"
	local args={fileName,str}
	local sig = "(Ljava/lang/String;Ljava/lang/String;)V"
	local ok, ret = luaj.callStaticMethod(luacall.className, mothed, args, sig)
end
return luacall