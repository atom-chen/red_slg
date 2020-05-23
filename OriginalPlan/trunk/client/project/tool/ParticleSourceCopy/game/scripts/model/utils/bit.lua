--
-- Author: LiangHongJie
-- Date: 2013-12-26 18:41:40
-- 位运算符
--
--[[--
模块：bit 位运算
example：
	bit.print(bit.bitD2b(7))                          
	-->00000000000000000000000000000111
	bit.print(bit.bitD2b(bit.bitNot(7)))         
	-->11111111111111111111111111111000
	bit.print(bit.bitD2b(bit.bitRshift(7,2)))    
	-->00000000000000000000000000000001
	bit.print(bit.bitD2b(bit.bitLshift(7,2)))    
	-->00000000000000000000000000011100
	print(bit.bitB2d(bit.bitD2b(7)))          -->     7
	print(bit.bitXor(7,2))                    -->     5
	print(bit.bitAnd(7,4))                    -->     4
	print(bit.bitOr(5,2))                     -->     7
]]

local bit={data32={}}
for i=1,32 do
    bit.data32[i]=2^(32-i)
end
--[[--
	data转bit
]]
function bit.bitD2b(arg)
    local tr={}
    for i=1,32 do
        if arg >= bit.data32[i] then
        tr[i]=1
        arg=arg-bit.data32[i]
        else
        tr[i]=0
        end
    end
    return tr
end  
--[[
	bit 转 data
]]
function bit.bitB2d(arg)
    local nr=0
    for i=1,32 do
        if arg[i] ==1 then
        nr=nr+2^(32-i)
        end
    end
    return  nr
end   
--[[--
--按位异或运算
--当两对应的二进位相异时，结果为1
]]
function bit.bitXor(a,b)
    local op1=bit.bitD2b(a)
    local op2=bit.bitD2b(b)
    local r={}
    for i=1,32 do
        if op1[i]==op2[i] then
            r[i]=0
        else
            r[i]=1
        end
    end
    return  bit.bitB2d(r)
end 
--[[--
--按位与运算
--当两对应的二进位都为1时，结果为1
]]
function bit.bitAnd(a,b)
    local op1=bit.bitD2b(a)
    local op2=bit.bitD2b(b)
    local r={}
    
    for i=1,32 do
        if op1[i]==1 and op2[i]==1  then
            r[i]=1
        else
            r[i]=0
        end
    end
    return bit.bitB2d(r)
end 
--[[
--按位或运算
--只要对应的二个二进位有一个为1时，结果位就为1
]]
function bit.bitOr(a,b)
    local op1=bit.bitD2b(a)
    local op2=bit.bitD2b(b)
    local r={}
    
    for i=1,32 do
        if  op1[i]==1 or   op2[i]==1   then
            r[i]=1
        else
            r[i]=0
        end
    end
    return bit.bitB2d(r)
end 
--[[
--求反运算 
--0101 结果 1010
]]
function bit.bitNot(a)
    local op1=bit.bitD2b(a)
    local r={}

    for i=1,32 do
        if  op1[i]==1   then
            r[i]=0
        else
            r[i]=1
        end
    end
    return  bit.bitB2d(r)
end 
--[[
--右移运算
]]
function bit.bitRshift(a,n)
    local op1=bit.bitD2b(a)
    local r=bit.bitD2b(0)
    
    if n < 32 and n > 0 then
        for i=1,n do
            for i=31,1,-1 do
                op1[i+1]=op1[i]
            end
            op1[1]=0
        end
    r=op1
    end
    return bit.bitB2d(r)
end 
--[[
--左移运算
]]
function bit.bitLshift(a,n)
    local op1=bit.bitD2b(a)
    local r=bit.bitD2b(0)
    
    if n < 32 and n > 0 then
        for i=1,n do
            for i=1,31 do
                op1[i]=op1[i+1]
            end
            op1[32]=0
        end
    r=op1
    end
    return bit.bitB2d(r)
end
--[[--
	打印输出
]]
function bit.print(ta)
    local sr=""
    for i=1,32 do
        sr=sr..ta[i]
    end
    print(sr)
end
return bit