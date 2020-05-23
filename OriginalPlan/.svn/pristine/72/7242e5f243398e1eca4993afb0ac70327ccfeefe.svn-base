--wdx
-------------------加密  保存成另外值到内存
local __pairs = pairs

local test = XUtil:encryptNumber(67)
local isNumber = false
if type(test) == "number" then
    isNumber = true
end

local indexFuc,encrypNext

if isNumber then
    indexFuc = function(table, key)
        local data = rawget(table,"__encryptData")
        local value = rawget(data,key)
        if type(value) == "number" then
            -- local src = rawget(table,"__testData")[key]
            value = XUtil:decryptionNumber(value)
            -- if src ~= value then
            --     print("error。。。。。。值不一样了！！！！"..src.."  "..value,key)
            -- end

            -- assert(src == value ,"error。。。。。。值不一样了！！！！"..src.."  "..value,key)
            return value
        else
            return data[key]
        end
    end

    encrypNext = function(tb,params)
        local key,value = next(tb,params)
        if type(value) == "number" then
            value = XUtil:decryptionNumber(value)
        end
        return key,value
    end

else
    indexFuc = function(table, key)
        local data = rawget(table,"__encryptData")
        local value = rawget(data,key)
        if type(value) == "userdata" and tolua.type(value) == "encrypt_number" then
            -- local src = rawget(table,"__testData")[key]
            value = XUtil:decryptionNumber(value.p1,value.p2)

            return value
        else
            return data[key]
        end
    end

    encrypNext = function(tb,params)
        local key,value = next(tb,params)
        if type(value) == "userdata" and tolua.type(value) == "encrypt_number" then
            value = XUtil:decryptionNumber(value.p1,value.p2)
        end
        return key,value
    end
end


local function newindexFuc(table,key,value)
    -- local testData = rawget(table,"__testData")
    -- rawset(testData,key,value)
    local data = rawget(table,"__encryptData")
    if type(value) == "number" then  --数字才进行加密
        local eInfo = XUtil:encryptNumber(value)
        rawset(data,key,eInfo)
    else -- 其他直接赋值
        data[key] = value
    end
end

--加密元表
local encryptMT = {
    __index = indexFuc,
    __newindex = newindexFuc
}
encryptMT.__metatable = encryptMT

--是否是加密的
local function isEncrypt(tb)
    if getmetatable(tb) == encryptMT then
        return true
    else
        return false
    end
end

--重写pairs
function pairs(tb)
    if isEncrypt(tb) then  --有加密的tb遍历
        return encrypNext,rawget(tb,"__encryptData"),nil
    else
        return __pairs(tb)
    end
end

function table.encrypt(tb)
    local encryptData = {}
    -- local testData = {}--测试使用

    -- encryptData.__encryptData = encryptData
    -- encryptData.__testData = testData
    -- rawset(tb,"__testData",testData)
    rawset(tb,"__encryptData",encryptData)

    local old_mt = getmetatable(tb)
    if old_mt then
        setmetatable(encryptData, old_mt)
        -- setmetatable(testData, old_mt)
    end
    setmetatable(tb, encryptMT)
end

--加密数据的克隆  出来的tb 也是加密的
function table.encryptClone(tb)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        local isEn = isEncrypt(object)
        if isEn then  --加密的table
            table.encrypt(new_table)
        end
        lookup_table[object] = new_table
        for key, value in pairs(object) do
            new_table[_copy(key)] = _copy(value)
        end
        if not isEn then  --不是加密的
            setmetatable(new_table, getmetatable(object))
        end
        return new_table
    end
    return _copy(tb)
end