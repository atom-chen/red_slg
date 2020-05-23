Object1 = class("Object1")
function Object1:tt1(ff)
end

Object = class("Object", Object1) -- 类定义

function test()
end

function Object:ctor()
	self.mt = 1234;
end

function Object:test1(dd,ee)
end

-------------------------------------------------------
-- @class function
-- @name Object:Test1
-- @description 
-- @param nil:dd 
-- @param nil:ee 
-- @return Object
-- @usage 
function Object:Test1(dd,ee)
end

function Object:tt1(dd,ee)
end

Sample = class("Sample", Object) -- 类定义

function Sample:ctor(obj)
	--! Object
	self.obj = obj;
end

function Sample:test(aa,bb,cc)
	print(self.mt);
	local a = print(self.obj:Test1(fff)
	test();
	
end

function Sample:test1()
	self:tt1();
	local p = self.obj;
end

function testtt()
end