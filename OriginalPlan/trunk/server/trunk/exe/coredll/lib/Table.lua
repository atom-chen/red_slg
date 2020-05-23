-------------------------------------------------------
-- 作用: 得到表的大小
-- 参数: 表
-- 返回: 表的大小
function tableGetSize(tab)
	if type(tab) ~= "table"
	then
		return 0;
	end
	
	local size = 0;
	for i,v in pairs(tab) do
		size = size+1;
	end

	return size;
end

-------------------------------------------------------
-- 作用: 连接两个表, 将表2连接到表1上
-- 参数: 表1, 表2
-- 返回: 连接后的新表
function tableConnect(tab1, tab2)
	local tab = {};
	if type(tab1) ~= "table" 
	then
		return tab;
	end

	tab = tab1;
	if type(tab2) ~= "table" 
	then
		return tab;
	end
	
	for i,v in pairs(tab2) do
		tab[i] = v;
	end
	
	return tab;
end

-------------------------------------------------------
-- 作用: 连接两个表, 将表2连接到表1上
-- 参数: 表1, 表2
-- 返回: 连接后的新表
function tableConnect2(tab1, tab2)
	local tab = tab1;

	for i,v in pairs(tab2) do
		table.insert(tab, v);
	end
	
	return tab;
end

-------------------------------------------------------
-- 作用: 是否在表中
-- 参数: 表,待查找的元素
-- 返回: true或false
function tableIsExist(tab, elem)
	for i,v in pairs(tab) do
		if elem == v then
			return v;
		end
	end

	return nil;
end

-------------------------------------------------------
-- 作用: 将非顺序列表转换成顺序表
-- 参数: 转换前的表
-- 返回: 转换后的表
function tableChange(tab)
	local tab1 = {};
	for i,v in pairs(tab) do
		table.insert(tab1, v);
	end

	return tab1;
end
