-------------------------------------------------------
-- 作用: 打印对像
-- 参数: 对象
-- 返回: 空
function printObject(tab)
    if type(tab) ~= "table" then
		print(tab);
		return;
    end

    for i,v in pairs(tab) do
        if type(v) == "table"
        then
            print("table",i,"{");
	    printObject(v);
            print("}");
        else
            print(i, v);
        end
    end
end

-------------------------------------------------------
-- 作用: 加载一个函数
-- 参数: 函数名及参数
-- 返回: 函数对象
function loadFuncByName(funcName, args)
	local funcString = funcName .. "(";
	local isFirst = true;
	for k, v in ipairs(args) do
		if k == nil or v == nil then
			return nil;
		end

		if isFirst then
			isFirst = false;
			funcString = funcString .. v;
		else 
			funcString = funcString .. "," .. v;
		end
	end
	funcString = funcString .. ")";
	log:debug(funcString .. "\r\n");
	return loadstring(funcString);
end

local _G = _G;
-------------------------------------------------------
-- 作用: 加载一个函数
-- 参数: 函数名及参数
-- 返回: 函数对象
function loadFuncByName1(funcName)
	return _G[funcName];
end

-------------------------------------------------------
-- 作用: 随机不重复列表
-- 参数: m,n范围, 个数
-- 返回: 数字列表
function randList(m,n,maxNum)
	math.randomseed( os.time() );

	local indexs = {};
	local num = 0;
	for k = 1, 10000, 1 do
		local tempNum = math.random(m, n)
		local numStr = tostring(tempNum);
		if indexs[numStr] == nil then
			indexs[numStr] = tempNum;
			num = num+1;
		end

		if num >= maxNum then
			break;
		end
	end

	return indexs;
end

-------------------------------------------------------
-- @class function
-- @name RandNumString
-- @description 随机一个指定长度的数字字符串
-- @param number:len 
-- @return string: 
-- @usage
_RandStringLen = {{0,9},{10,99},{100,999},{1000,9999},{10000,99999},{100000,999999},{1000000,9999999},
	{10000000,99999999},{100000000,999999999},{1000000000,9999999999},{10000000000,99999999999},
	{100000000000,999999999999},{1000000000000,9999999999999},{10000000000000,70368744177664}}
function RandNumString(len)
	assert(len > 0 and len < 15);
	return tostring(math.random(_RandStringLen[len][1], _RandStringLen[len][2]));
end

-------------------------------------------------------

-- @class function

-- @name IsNULL

-- @description 判断指针是否为NULL或nil，为空则返回true否则返回false

-- @param nil:val 

-- @return nil: 

-- @usage 
function IsNULL(val)
	return val == 0 or val == nil;
end



-------------------------------------------------------

-- @class function

-- @name IsAnyNULL

-- @description 判断所有的参数值是否有>=1个为空，有则返回true否则返回false

-- @param nil:... 

-- @return nil: 

-- @usage 

function IsAnyNULL(...)
	
	for _,v in ipairs({...}) do
	
	if v == 0 or v == nil then

			return true;

		end

	end


	return false;

end


-------------------------------------------------------

-- @class function

-- @name IsValidPtr

-- @description 判断指针是否为NULL或nil，不为空则返回true否则返回false

-- @param nil:val 

-- @return nil: 

-- @usage 

function IsValidPtr(val)

	return not (val == 0 or val == nil);

end



-------------------------------------------------------

-- @class function

-- @name IsAllValidPtr

-- @description 检测参数全部都是有效的指针，是则返回true否则返回false

-- @param nil:... 

-- @return boolean: 

-- @usage 

function IsAllValidPtr(...)
	
	for _,v in ipairs({...}) do

		if v == 0 or v == nil then

			return false;
		
		end
	
	end


	return true;

end

-------------------------------------------------------
-- 作用: 修正大小
-- 参数: 当前值, 最小值, 最大值
-- 返回: 修正后的值
function RefixValue(val, minVal, maxVal)
	assert(minVal <= maxVal);
	local tempVal = val;
	if tempVal < minVal then
		tempVal = minVal;
	end
	if tempVal > maxVal then
		tempVal = maxVal;
	end

	return tempVal;
end

function DateTimeToString(times)
	if times == nil then
		times = os.time()
	end

	return os.date("%Y_%m_%d_%H_%M_%S",times)
end

function TimeToString(times)
	if times == nil then
		times = os.time()
	end

	return os.date("%Y.%m.%d %H:%M:%S", times);
end

function SleepN(n)
   local t0 = os.clock()
   while os.clock() - t0 <= n do end
end
