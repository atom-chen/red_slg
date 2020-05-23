local f = require("fileHandler");
ParticleMgr = require("view.ParticleMgr")
local SourceCopy = class("SourceCopy")
local pngDesPath = "E:\\client\\project\\game\\res\\eft\\texture\\"
local mashDesPath = "E:\\client\\project\\game\\res\\eft\\mesh\\"
local mxlDesPath = "E:\\client\\project\\game\\res\\eft\\work_script\\"
local logPath = "E:\\"
local srcpath = "E:\\hongjing\\edit\\"

local logFullPath = logPath.."hongjinglog.txt"
logfile = io.open(logFullPath,"w") 
function write_log( str )
	if logfile then
		logfile:write( str )
	end
end

	
function SourceCopy:source_copy()
	print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" )
	write_log("kaishi......2222222222222222")
	write_log("校验"..pngDesPath.."目录\r\n")
	--write_log(os.execute("dir "..pngDesPath))
	--write_log("\r\n校验"..mashDesPath.."目录\r\n")
	--write_log(os.execute("dir "..mashDesPath))	
	--write_log("\r\n校验"..mxlDesPath.."目录\r\n")
	--write_log(os.execute("dir "..mxlDesPath))
	--write_log("\r\n校验"..srcpath.."目录\r\n")
	--write_log(os.execute("dir "..srcpath))	
	--write_log("\r\n目录校验完毕\r\n")

 	local _particleCfg = ConfigMgr:requestConfig("eft",nil,true)
	local pngFiles = { }
	local meshFiles = { }
	local xmlFiles = {}

	for i, v in pairs( _particleCfg ) do

		local particle = ParticleMgr:CreateParticleSystem(i);
		if particle then
			print("正在创建粒子特效ID =",i)
			local xmlArryObj =  tolua.cast( particle:GetXmlNames(), "CCArray");
			if xmlArryObj then
				local child = tolua.cast( xmlArryObj,"CCString")
				local mxlName = child:getCString()
				mxlName = mxlName..".xml"
				print("当前的粒子特效的xml文件为：",mxlName)
				if "cocos2dx_empty_ps.xml" == mxlName then
					write_log("正在创建粒子特效ID ="..i.."不存在,xml 为:"..v.path.."\n\r")
				end
				
			end
			---copy pen source 
			local pngArryObj =  tolua.cast( particle:GetTextureNames(), "CCArray");
			if pngArryObj then
				local count = pngArryObj:count()
				for k=1,count do
					local child = tolua.cast( pngArryObj:objectAtIndex(k-1),"CCString")
					local pngName = child:getCString()
					if string.find(pngName, ".png") then
						table.insert(pngFiles, pngName)
					end
				end
			end

			---copy mesh source 
			local meshArryObj =  tolua.cast( particle:GetMeshNames(), "CCArray");
			if meshArryObj then
				local count = meshArryObj:count()
				for k=1,count do
					local child = tolua.cast( meshArryObj:objectAtIndex(k-1),"CCString")
					local meshName = child:getCString()
					if string.find(meshName, ".mesh") or string.find(meshName, ".MESH")then
						table.insert(meshFiles, meshName)
					end
				end
			end

			---copy xml source
			local xmlArryObj =  tolua.cast( particle:GetXmlNames(), "CCArray");
			if xmlArryObj then
				local child = tolua.cast( xmlArryObj,"CCString")
				local mxlName = child:getCString()
				mxlName = mxlName..".xml"
				table.insert(xmlFiles, mxlName)
				
			end
		else
			write_log(" the particle create errors id = "..i.." \r\n")
		end
	end
	print("kaishi......33333333333333333333")
	---清空文件夹
	write_log(" clean the path files"..pngDesPath.."\r\n")
	self:scandirwin( pngDesPath )
	write_log(" clean the path files"..mashDesPath.."\r\n")
	self:scandirwin( mashDesPath )
	write_log(" clean the path files"..mxlDesPath.."\r\n")
	self:scandirwin( mxlDesPath )
	--return
	write_log(" copying png source....".."\r\n")
	if not self:trim_resource( pngFiles, srcpath,pngDesPath, "png") then
		print("kaishi......4444444444444444444444")
		logfile:close()
		return 
	end
	write_log(" copy png source completed\r\n")
	write_log(" copying mesh source....\r\n")
	if not  self:trim_resource( meshFiles, srcpath,mashDesPath, "mesh") then
		print("kaishi......555555555555555555555555")
		logfile:close()
		return 
	end
	write_log(" copy mesh source completed\r\n")
	write_log(" copying xml source....\r\n")
	if not self:trim_resource( xmlFiles, srcpath,mxlDesPath, "xml") then
		print("kaishi......6666666666666666666666666666")
		logfile:close()
		return
	end
	write_log(" copy xml source completed\r\n")
	write_log(" copy source sucess!\r\n")
	logfile:close()
end

function SourceCopy:scandirwin( directory )
   for filename in io.popen('dir "'..directory..'" /b'):lines() do --Windows ， 自己修改dir命令的参数，此为列举目录
	  os.remove( directory..filename)
   end
   return true
end


function SourceCopy:trim_resource( tageFiles, srcDir, desDir, printString )
	if type(tageFiles) ~= "table" then
		write_log("TestPanel:trim_resource  param is not table !!! \r\n")
		logfile:close()
		return false
	end

	for k, v in pairs(tageFiles) do
		local files = {}
		local i =1
		findindir( srcDir, v, files, true )

		for i, f in pairs(files ) do
			if not self:copyfile( f, desDir, printString ) then
				write_log("copy_error"..f.." in different path!"..desDir.."\r\n")
				logfile:close()
				return false
			end
		end

		local fun = function( table_s )
				local count = 0;
				for i, v in pairs(table_s ) do
					count = count + 1
				end
				return count
		end

		local pathcount = fun( files )
		if pathcount >1 then
			--write_log("--------more same "..printString.." in different path!".. v.."\r\n")
			--return false
		elseif pathcount == 0 then
			write_log("--------no exist then  "..printString.."  in  path!"..v.."\r\n")
			--return false
		end
	end

	return true
end

function SourceCopy:copyfile(source,destination, printString )
	sourcefile = io.open(source,"rb") 
	if not sourcefile then
		write_log("--------the "..printString.."  is not exist...".. sourcefile.."\r\n")
		--return false
	end
	local comd = " copy "..source.." ".. destination
	os.execute( comd  )
	return true

end 

return SourceCopy.new()
