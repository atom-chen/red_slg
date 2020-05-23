Test = class("test")

Test.Person = class("Test.Person")

function Test.Person:ctor(tt, aa, bb)
  self.test = 0;
  self.ttt = 111;
end

function Test.Person:bbf(tt, aa, bb)
end

function Test.Person:def()

end

function test(aa,bb,cc)
end
-------------------------------------------------------
-- @class function
-- @name Test:ctor
-- @description
-- @return
-- @usage
function Test:ctor()
	--! Test
	self.mt = tt;
end

function Test:_ctor()
  --! number 测试
	self.xx = 123
	self.bb = 123
end
-------------------------------------------------------
-- @class function
-- @name Test:test
-- @description test
-- @return nil:
-- @usage
function Test:test()
	self:test3();
	self:test4();
  self.xx = 1234;
end

function Test:test1()
	self:test();
	self:test1();
	if self:test1() then

  end
end

--test();

-------------------------------------------------------
-- @description: 分割字符串
-- @param: 待分割的字符串,分割字符
-- @return: 子串表.(含有空串)
--function stringSplit(str, splitStr, addSpliteFlag)
--  local subStrTab = {};
--  local spliteStrLen = 1;
--  while (true) do
--    local pos = string.find(str, splitStr);
--    if (not pos) then
--      table.insert(subStrTab, str);
--      break;
--    end
--    local subStr = string.sub(str, 1, pos-1);
--    if addSpliteFlag then
--      subStr = subStr .. splitStr;
--    end
--    table.insert(subStrTab, subStr);
--    str = string.sub(str, pos + spliteStrLen, #str);
--  end

--  return subStrTab;
--end

--local function getClassAPI(allClasses, classname, filePath, classDef)
--  local names = stringSplit(classname, "%.", false);
--  local classes = allClasses;

--  if #names == 0 then
--    return nil;
--  end

--  if #names > 0 then
--    local v= names[1];
--    if allClasses[v] == nil then
--      classes = {}
--      classes.childs = {}
--      allClasses[v] = classes;
--    else
--      classes = allClasses[v];
--    end
--    classes.type = "class";
--    classes.inherits = classDef.baseName;
--    classes.lineno =classDef.lineno;
--    classes.fileName=filePath;
--  end

--  if #names > 1 then
--    for k=2,#names,1 do
--      local v = names[k]
--      if classes.childs[v] == nil then
--        classAPI = {}
--        classAPI.childs = {}
--        classes.childs[v] = classAPI;
--        classes = classAPI;
--      else
--        classes = classes.childs[v];
--      end
--      classes.type = "class";
--      classes.inherits = classDef.baseName;
--      classes.lineno = classDef.lineno;
--      classes.fileName=filePath;
--    end
--  end

--  return classes;
--end

--local classes = {}
--getClassAPI(classes, "Test.Person.Address.Phone", "test.lua", {baseName="test", lineno = 1234});
--printObject(classes);