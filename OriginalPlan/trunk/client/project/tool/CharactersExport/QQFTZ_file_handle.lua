print("开始转换")
require("fileHandler")
local file = "../../game"
local outTxtFile = "jianti2fanti.txt"
local files = { file.."/res/uilayer/zh_cn",file.."/res/config",file.."/scripts",file.."/update"}
--local files = {"F:\\config"}
function update_dir(path)
    for file in lfs.dir(path)  do
        if file ~= "." and file ~= ".." then
            local f = path.."/"..file
            local attr = lfs.attributes(f)
            assert(type(attr)=="table")
            if attr.mode == "directory" then
                update_dir(f)
            else
				local index = string.find(f, ".lua")
				print("正在处理的文件：",f)
				if index and index > 1 then
					os.execute("QQFTZ.exe "..f.." "..outTxtFile)
				end
            end
        end
    end
end

function main()
	for k,v in pairs(files) do
		update_dir(v)
	end
	
end

main()