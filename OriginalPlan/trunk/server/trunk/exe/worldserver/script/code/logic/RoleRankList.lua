-------------------------------------------------------
-- 作用: 通过列表获取指定英雄
-- 参数: 位置表,返回英雄列表
-- 返回: 无
function rankListTabGetHero(indexs, heros)

	local sortFunc=function(a,b)
		return a > b;
	end

	local tempIndexs = indexs;
	-- table.sort(tempIndexs, sortFunc);
 	for k,v in pairs(tempIndexs) do
 		luaGetHero(heros, v);
 	end
end

-------------------------------------------------------
-- 作用: 修正大小
-- 参数: 当前值, 最小值, 最大值
-- 返回: 修正后的值
function refixValue(val, minVal, maxVal)
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

-------------------------------------------------------
-- 作用: 顺序获取英雄列表
-- 参数: 起始索引,终止索引,返回英雄列表
-- 返回: 无
function rankListSeqGetHero(startIndex, endIndex, heros)
 	local totalNum = luaGetRankNum();
	if totalNum <= 0 then
		return;
	end

	startIndex = refixValue(startIndex, 0, totalNum-1);
	endIndex = refixValue(endIndex, 0, totalNum-1);
	local indexs = {};
 	for i = startIndex,endIndex,1 do
		table.insert(indexs, i);
 	end
	rankListTabGetHero(indexs, heros);
end

-------------------------------------------------------
-- 作用: 上下限区间获取英雄列表
-- 参数: 起始索引, 下限增量, 上限增量, 英雄数目, 返回的英雄列表
-- 返回: 无
function rankListRegMinMaxGetHero(startIndex, minAdd, maxAdd, getNum, heros)
	local indexs = {};
 	local totalNum = luaGetRankNum();
	
	-- 首尾固定+中间随机
	local begNum = startIndex+minAdd;
	local endNum = startIndex+maxAdd;
	begNum = refixValue(begNum, 0, totalNum-1);
	endNum = refixValue(endNum, 0, totalNum-1);

	table.insert(indexs, begNum);
	if not tableIsExist(indexs, endNum) then
		table.insert(indexs, endNum);
	end
	
	for i = 1, 50, 1 do
		local rNum = luaRandNum(begNum+1, endNum-1);
		rNum = refixValue(rNum, 0, totalNum-1);
		if not tableIsExist(indexs, rNum) then
			table.insert(indexs, rNum);
		end
		if #indexs >= getNum then
			break;
		end
	end

	rankListTabGetHero(indexs, heros);
end

-------------------------------------------------------
-- 作用: 间隔获取英雄列表
-- 参数: 起始索引,间隔, 个数, 返回英雄列表
-- 返回: 无
function rankListRegGetHero(startIndex, interval, getNum, heros)
	local indexs = {};
 	local totalNum = luaGetRankNum();
	
	-- 首尾固定+中间随机
	local begNum = startIndex-getNum*interval;
	local endNum = startIndex-1*interval;
	begNum = refixValue(begNum, 0, totalNum-1);
	endNum = refixValue(endNum, 0, totalNum-1);

	table.insert(indexs, begNum);
	if not tableIsExist(indexs, endNum) then
		table.insert(indexs, endNum);
	end

	for i = 1, 50, 1 do
		local rNum = luaRandNum(begNum+1, endNum-1);
		rNum = refixValue(rNum, 0, totalNum-1);
		if not tableIsExist(indexs, rNum) then
			table.insert(indexs, rNum);
		end
		if #indexs >= getNum then
			break;
		end
	end
	rankListTabGetHero(indexs, heros);
end


-------------------------------------------------------
-- 作用: 随机英雄列表
-- 参数: 起始索引,终止索引, 个数, 返回英雄列表
-- 返回: 无
function rankListRandGetHero(startIndex, endIndex, getNum, heros)
 	local totalNum = luaGetRankNum();
	if totalNum <= 0 then
		return;
	end
	startIndex = refixValue(startIndex, 0, totalNum-1);
	endIndex = refixValue(endIndex, 0, totalNum-1);
	local randNums = randList(startIndex, endIndex, getNum);
	local indexs = tableChange(randNums);
	assert(#indexs > 0);
	
	rankListTabGetHero(indexs, heros);
end

-------------------------------------------------------
-- 作用: 随机获取英雄榜
-- 参数: 返回英雄列表
-- 返回: 无
function _rankListGetRandHero(myRankNum, heros)
	
	local perNum = luaGetConstInt(ETagConstantType.JJC_PERNUM)-2;

	if myRankNum == 0 then
		return 0;
	elseif myRankNum > luaGetConstInt(ETagConstantType.JJC_RANGE4) then
		local minRank = luaGetConstInt(ETagConstantType.JJC_RANGE5);
		local maxRank = luaGetConstInt(ETagConstantType.JJC_RANGE6);
		rankListRandGetHero(minRank-1, maxRank-1, perNum, heros);
	elseif myRankNum > luaGetConstInt(ETagConstantType.JJC_RANGE3) then
		local minAdd = luaGetConstInt(ETagConstantType.JJC_SPACE4);
		local maxAdd = luaGetConstInt(ETagConstantType.JJC_SPACE4_2);
		rankListRegMinMaxGetHero(myRankNum-1, minAdd, maxAdd, perNum, heros);
	elseif myRankNum > luaGetConstInt(ETagConstantType.JJC_RANGE2) then
		local minAdd = luaGetConstInt(ETagConstantType.JJC_SPACE3);
		local maxAdd = luaGetConstInt(ETagConstantType.JJC_SPACE3_2);
		rankListRegMinMaxGetHero(myRankNum-1, minAdd, maxAdd, perNum, heros);
	elseif myRankNum > luaGetConstInt(ETagConstantType.JJC_RANGE1) then
		local minAdd = luaGetConstInt(ETagConstantType.JJC_SPACE2);
		local maxAdd = luaGetConstInt(ETagConstantType.JJC_SPACE2_2);
		rankListRegMinMaxGetHero(myRankNum-1, minAdd, maxAdd, perNum, heros);
	-- elseif myRankNum > perNum then
	--	local interval = luaGetConstInt(ETagConstantType.JJC_SPACE1);
	--	rankListRegGetHero(myRankNum-1, interval, perNum, heros);
	else
		local minAdd = luaGetConstInt(ETagConstantType.JJC_SPACE1);
		local maxAdd = luaGetConstInt(ETagConstantType.JJC_SPACE1_2);
		rankListRegMinMaxGetHero(myRankNum-1, minAdd, maxAdd, perNum, heros);
	end

	return 0;
end

-------------------------------------------------------
-- 作用: 随机获取英雄榜, 刷新规则
-- 参数: 返回英雄列表
-- 返回: 无
function _rankListGetRandHero1(myRankNum, heros)
	
	local perNum = luaGetConstInt(ETagConstantType.JJC_PERNUM)-2;
	log:debug(""..myRankNum..","..perNum);
	if myRankNum == 0 then
		return 0;
	elseif myRankNum > luaGetConstInt(ETagConstantType.JJC_RANGE4) then
		local minRank = luaGetConstInt(ETagConstantType.JJC_RANGE5);
		local maxRank = luaGetConstInt(ETagConstantType.JJC_RANGE6);
		rankListRandGetHero(minRank-1, maxRank-1, perNum, heros);
	elseif myRankNum > luaGetConstInt(ETagConstantType.JJC_RANGE3) then
		local minRank = luaGetConstInt(ETagConstantType.JJC_SPACE4)+myRankNum-1;
		local maxRank = luaGetConstInt(ETagConstantType.JJC_SPACE4_2)+myRankNum-1;
		rankListRandGetHero(minRank-1, maxRank-1, perNum, heros);
	elseif myRankNum > luaGetConstInt(ETagConstantType.JJC_RANGE2) then
		local minRank = luaGetConstInt(ETagConstantType.JJC_SPACE3)+myRankNum-1;
		local maxRank = luaGetConstInt(ETagConstantType.JJC_SPACE3_2)+myRankNum-1;
		rankListRandGetHero(minRank-1, maxRank-1, perNum, heros);
	elseif myRankNum > luaGetConstInt(ETagConstantType.JJC_RANGE1) then
		local minRank = luaGetConstInt(ETagConstantType.JJC_SPACE2)+myRankNum-1;
		local maxRank = luaGetConstInt(ETagConstantType.JJC_SPACE2_2)+myRankNum-1;
		rankListRandGetHero(minRank-1, maxRank-1, perNum, heros);
	else
		local minRank = luaGetConstInt(ETagConstantType.JJC_SPACE1)+myRankNum-1;
		local maxRank = luaGetConstInt(ETagConstantType.JJC_SPACE1_2)+myRankNum-1;
		rankListRandGetHero(minRank-1, maxRank-1, perNum, heros);
	end

	return 0;
end

-------------------------------------------------------
-- 作用: 获取英雄榜指定的页面的英雄列表
-- 参数: 索引页, 返回英雄列表
-- 返回: 总的索引数
function _rankListGetAllHero(index, heros)
 	local totalNum = luaGetRankNum();
	local perNum = luaGetConstInt(ETagConstantType.JJC_PERNUM);
 	local totalIndexNum = math.modf(totalNum/perNum);
	if totalNum%perNum > 0 then
		totalIndexNum = totalIndexNum+1;
	end
 	if index < 0 then
 		index = 0;
 	end
 	if index > totalIndexNum-1 then
 		index = totalIndexNum-1;
 	end
 	local startIndex = index*perNum;
 	local endIndex = startIndex+perNum-1;

	rankListSeqGetHero(startIndex, endIndex, heros);

	return totalIndexNum;
end

-------------------------------------------------------
-- 作用: 获取英雄榜的英雄列表
-- 参数: 类型,索引页,返回英雄列表
-- 返回: 总的索引数
function rankListGetHeros(types, index, myRankNum, heros)
	
	local perNum = luaGetConstInt(ETagConstantType.JJC_PERNUM);

	local totalIndexs = 0;
	log:debug("Type="..types..",".."Index="..index);
	if types == ERankListType.RANK_LIST_TYPE_RAND then		-- 随机类型
		totalIndexs = _rankListGetRandHero(myRankNum, heros);
	elseif types == ERankListType.RANK_LIST_TYPE_ALL then
		totalIndexs = _rankListGetAllHero(index, heros);	-- 全部类型
	elseif types == ERankListType.RANK_LIST_TYPE_MY then
		local index = math.modf(myRankNum/perNum);
		totalIndexs = _rankListGetAllHero(index, heros);	-- 查看自己
	elseif types == ERankListType.RANK_LIST_TYPE_REFRESH then		
		_rankListGetRandHero1(myRankNum, heros);		-- 刷新可以挑战的英雄
	else
		log:error("RankType=" .. types);
		assert(false);
	end

	return totalIndexs;
end

-------------------------------------------------------
-- 作用: 获取英雄榜的英雄列表
-- 参数: 类型,索引页,返回英雄列表
-- 返回: 总的索引数
function rankListGetTotalIndex()
	local totalNum = luaGetRankNum();
	local perNum = luaGetConstInt(ETagConstantType.JJC_PERNUM);
 	local totalIndexNum = math.modf(totalNum/perNum);

	return totalIndexNum;
end
