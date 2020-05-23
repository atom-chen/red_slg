--
-- Author: changao
-- Date: 2014-06-19
--

local AttrCfg = {}

function AttrCfg:init()
	self._heroAttrColumn 	= ConfigMgr:requestConfig("hero_attr_column", nil, true)
	self:_initAttrCfg()

	self:_initSpeed()
	self:initArmAttrName()
end

function AttrCfg:_initSpeed()
--[[
0	600	极快
601	800	快
801	1000	普通
1001	1200	慢
1201	9999999999	极慢
--]]
	self._speed = "speed"
	self._speedArr = {-1,600,800,1000,1200}
	self._speedName = {'无法移动', '极快', '快', '普通', '慢', '极慢'}
end

function AttrCfg:toReadableSpeed(speed)
	local name = self._speedName[#self._speedName]
	for i,s in ipairs(self._speedArr) do
		if speed <= s then
			name = self._speedName[i]
			break
		end
	end
	return name
end

function AttrCfg:getAttrIndex()
	return self._attrIndex
end

function AttrCfg:cloneAttr(attr)
	local a = AttrCfg:newAttr()
	for k,v in pairs(attr) do a[k] = v end
	return a
end

function AttrCfg:getAttrName(idx)
	--print("function AttrCfg:getAttrName(idx)", idx, self._attrIndex)
	return self._attrIndex[idx].name
end

function AttrCfg:getAttrReadable(idx)
	return self._attrIndex[idx].desc
end


function AttrCfg:getAttrColumns()
	return self._heroAttrColumn
end

function AttrCfg:getAttrShowName(name)
	return self._attrMap[name].desc
end

function AttrCfg:getColumnByName(name)
	--print("function AttrCfg:getColumnByName(name)", name, self._attrMap[name])
	return self._attrMap[name]
end

function AttrCfg:getColumnByType(typ)
	--print("function AttrCfg:getColumnByName(name)", name, self._attrMap[name])
	return self._attrIndex[typ]
end

function AttrCfg:getColumnByIndex(idx)
	--print("function AttrCfg:getColumnByName(name)", name, self._attrMap[name])
	return self._attrIndex[idx]
end


function AttrCfg:getShowAttrColumns()
	return self._heroShowAttrColumn
end

function AttrCfg:isPercent(name)
	local typ = self._attrMap[name].type
	return typ == 2 or typ == 3
end

function AttrCfg:_percent(value)
	local val = math.floor(value)
	local a,b = val%100,math.floor(val/100)
	local str = tostring(b)
	if a > 0 then
		if a%10 == 0 then
			str = str .. "." .. math.floor(a/10)
		else
			str = str .. "." .. a
		end
	end
	return str .. "%"
end

function AttrCfg:getType(nameOrIdx)
	local column
	if type(nameOrIdx) == 'string' then
		column = self._attrMap[nameOrIdx]
	else
		column = self._attrIndex[nameOrIdx]
	end
	return column.type
end

function AttrCfg:getAttrReadableValue(name, val)
	local typ = self:getType(name)
	if typ == 2 or typ == 3 then
		return self:_percent(val)
	else
		return tostring(math.floor(val))
	end
end

function AttrCfg:_initAttrCfg()
	if not self._heroShowAttrColumn then
		self._heroShowAttrColumn = {}
		self._attrIndex = {}
		self._attrMap = {}
		for i,column in ipairs(self._heroAttrColumn) do
			local showColumn = {}
			for k,v in pairs(column) do
				if v == "speed" then
					showColumn[k] = "speed_string"
				else
					showColumn[k] = v
				end
			end
			local id = showColumn.id
			if id then
				self._attrIndex[id] = showColumn
			end
			self._attrMap[showColumn.name] = showColumn
			table.insert(self._heroShowAttrColumn, showColumn)
		end
		self._attrMap["speed"] = self._attrMap["speed_string"]
	end
end

function AttrCfg:newAttr()
	local attrs = {}
	setmetatable(attrs, {__index = function() return 0 end})
	return attrs
end

function AttrCfg:zeroAttr(attr)
	for k,v in pairs(attr) do
		attr[k] = 0
	end
end

function AttrCfg:addAttrs(attr, attrList1, ...)
	local attrList = {attrList1, ...}
	for i,attrs in ipairs(attrList) do
		self:_addAttrs(attr, attrs)
	end
	return attr
end

function AttrCfg:_addAttrs(attr, addAttrs)
	if addAttrs then
		for i,attrItem in ipairs(addAttrs) do
			local t = attrItem[1]
			local val = attrItem[2]
			local name = self:getAttrName(t)
			attr[name] = attr[name] + val
		end
	end
	return attr
end

function AttrCfg:setFactor(attrs, newfactor)
	for name,value in pairs(attrs) do
		if self:getColumnByName(name).type ~= 4 then
			attrs[name] = value*newfactor
		end
	end
end

function AttrCfg:getReadableAttrItem(typ, val)
	local column
	if type(typ) == 'number' then
		column = self:getColumnByIndex(typ)
	else
		column = self:getColumnByName(typ)
	end
	if column.name == self._speed and val ~= 0 then
		return {name=column.name, desc=column.desc, value=self:toReadableSpeed(val), type=column.id, number=val}
	else
		local value = val
		if column.type == 2 or column.type == 3 then
			value = self:_percent(val)
		else
			value = math.floor(val)
		end
		return {name=column.name, desc=column.desc, value=value,type=column.id,number=val}
	end
end


function AttrCfg:getReadableAttr(attrs, finalAttr)
	local readable = {}
	if finalAttr then
		for i,column in ipairs(self:getAttrColumns()) do
			local val = attrs[column.name]
			local row = nil
			if column.name == self._speed and val ~= 0 then
				row ={name=column.name, desc=column.desc, value=self:toReadableSpeed(val), number=val, type=column.id}
			elseif val > 0 then
				if column.type == 2 then
					row ={name=column.name, desc=column.desc, value=self:_percent(val), number=val, type=column.id}
				elseif column.type ~= 3 then
					row ={name=column.name, desc=column.desc, value=val,number=val, type=column.id}
				end
			end
			if column.show ~= 1 and row then
				table.insert(readable, row)
			end
		end
	else
		for i,column in ipairs(self:getAttrColumns()) do
		--	dump(column)
			local val = attrs[column.name]
			local row = nil
			if column.name == self._speed and val ~= 0 then
				row = {name=column.name, desc=column.desc, value=self:toReadableSpeed(val), number=val, type=column.id}
			elseif val > 0 then
				if column.type == 2 or column.type == 3 then
					val = self:_percent(val)
				end
				row = {name=column.name, desc=column.desc, value=val, number=attrs[column.name], type=column.id}
			end
			if column.show ~= 1 and row then
				table.insert(readable, row)
			end
		end
	end
	return readable
end

function AttrCfg:namedAttrAdd(attr, attr1,...)
	local attrlist = {attr1, ... }
	for i,iattr in ipairs(attrlist) do
		for i,column in ipairs(self._heroAttrColumn) do
			local name = column.name
			attr[name] = attr[name] + iattr[name]
		end
	end
	return attr
end

function AttrCfg:getAttrByAttrId( id )
	return self._heroAttrColumn[id]
end

function AttrCfg:finalAttr(attr, vfinal)
	local final = vfinal or self:newAttr()
	local factors = self:newAttr()
	for name,value in pairs(attr) do
		local column = self:getColumnByName(name)
		if column.type == 3 then
			if column.master then
				for i,idx in ipairs(column.master) do
					local parent = self:getAttrName(idx)
				--	final[parent] = math.floor(attr[parent] * (1+value/10000)) --assume that all index in column.master are not repeat
					factors[parent] = factors[parent] + value
				end
			end
			--[[
			local factorName = name .. "_percent"
			local factorC = self:getColumnByName(factorName)
			if factorC and factorC.type == 3 then
				local factor = attr[factorName]
				final[name] = math.floor(value * (1+factor/10000))
			end
			--]]
		else
			final[name] = math.floor(value)
		end
	end

	for name, value in pairs(factors) do
		final[name] = math.floor(final[name] * (1+value/10000))
	end

	return final
end

function AttrCfg:attrRaise(attr, raiseAttr)
	local final = attr
	local factors = self:newAttr()
	for name,value in pairs(raiseAttr) do
		local column = self:getColumnByName(name)
		if column.type == 3 then
			if column.master then
				for i,idx in ipairs(column.master) do
					local parent = self:getAttrName(idx)
					factors[parent] = factors[parent] + value
				end
			end
		end
	end

	for name, value in pairs(factors) do
		final[name] = math.floor(final[name] * (1+value/10000))
	end

	return final
end

function AttrCfg:attrRaisePercentPart(attr, percent)
	local final = attr

	for name,value in pairs(final) do
		local column = self:getColumnByName(name)
		if column.type == 1 then
			final[name] = math.floor(percent/100*final[name])
		end
	end
	return final
end


--value:hero_attr_column.type-(hero.cfg.atkRate and hero.cfg.atkRate_1)'s index
function AttrCfg:getAtkRateTypeMagicNumber()
	return 7
end

function AttrCfg:initArmAttrName()
	local data = {	[HeroInfo.ARM_TANK] = {27,28,29},
					[HeroInfo.ARM_PLAIN] = {30,31,32},
					[HeroInfo.ARM_SOLDIER] = {33,34,35},
					[HeroInfo.ARM_CHARIOT] = {36,37,38},
				}
	self._armArrays = {}
	local attrVals = {{"main_atk", "minor_atk"}, {"def"}, {"hp"}}
	for arm, attrs in pairs(data) do
		local armArray = {}
		for i,attrIndex in ipairs(attrs) do
			local name = AttrCfg:getAttrName(attrIndex)
			local info = {attrs=attrVals[i]}

			armArray[name] = info
		end
		self._armArrays[arm] = armArray
	end
end

function AttrCfg:addArmAttr(attr, armAttr, arm)
	local armArray = self._armArrays[arm]
	for name, info in pairs(armArray) do
		local val = armAttr[name]
		if val > 0 then
			local attrNames = info.attrs
			for i, attrName in ipairs(attrNames) do
				if attr[attrName] > 0 then
					attr[attrName] = attr[attrName] + val
				end
			end
		end
	end
	--[[
	for name,val in pairs(armAttr) do
		local info = self._armAttrNames[name]
		if info then
			if info.arm == arm then
				attr[info.name] = attr[info.name] + val
			end
		else
			attr[name] = attr[name] + val
		end
	end
	--]]
end

return AttrCfg