local UIMap = class("UIMap")

function UIMap:ctor(indexCount)
	self._indexCount = indexCount or 1
	self._data = {}
	self._count = 0
end

function UIMap:add(...)
	local args = {...}
	local t = self._data

	for i=1, self._indexCount-1 do
		local key = args[1]
		local val = t[key]
		if not val then
			t[key] = {}
		end
		t = t[key]
	end

	local oval = t[args[self._indexCount]]
	local nval = args[self._indexCount+1]
	if oval == nil and nval ~= nil then
		self._count = self._count + 1
	elseif oval == nil and nval == nil then
	elseif oval ~=nil and nval ~= nil then
	else
		self._count = self._count - 1
	end
	t[args[self._indexCount]] = args[self._indexCount+1]

end

function UIMap:remove(...)
	local args = {...}
	local t = self._data

	for i=1, self._indexCount-1 do
		local key = args[1]
		local val = t[key]
		if val == nil then
			return false
		end
		t = val
	end

	if t[args[self._indexCount]] ~= nil then
		t[args[self._indexCount]] = nil
		self._count = self._count - 1
		return true
	end

	return false
end

function UIMap:exist(...)
	local args = {...}
	local t = self._data

	for i=1, self._indexCount-1 do
		local key = args[1]
		local val = t[key]
		if val == nil then
			return false
		end
		t = val
	end

	if t[args[self._indexCount]] ~= nil then
		return true
	end

	return false
end


function UIMap:count()
	return self._count
end

function UIMap:clear()
	self._data = {}
	self._count = 0
end

function UIMap:get(...)
	local args = {...}
	local t = self._data
	for i=1, self._indexCount-1 do
		local key = args[1]
		local val = t[key]
		if val == nil then
			return nil
		end
	end
	return t[args[self._indexCount]]
end

function UIMap:set(...)
	return self:add(...)
end

function UIMap:dispose()
	self:clear()
end

return UIMap