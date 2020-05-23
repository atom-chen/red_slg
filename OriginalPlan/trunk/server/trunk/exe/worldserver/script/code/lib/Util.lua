-------------------------------------------------------
-- 作用: 打印对像
-- 参数: 对象
-- 返回: 空
function printObject(tab)
    if type(tab) ~= "table"
    then
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
-- 作用: 判断指针是否为NULL或nil
-- 参数: 指针
-- 返回: true或false
function IsNULL(val)
	return val == 0 or val == nil;
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
