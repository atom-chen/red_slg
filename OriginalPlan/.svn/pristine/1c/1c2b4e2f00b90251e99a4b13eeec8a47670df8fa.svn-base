local id = ID("sample.samplemenu")

local P = {
  name = "Sample plugin",
  description = "Sample plugin to demonstrate various event types.",
  author = "Paul Kulchenko",
}

-- Events that are marked with "return false" can return `false` to
-- abort further processing.
-- For `onEditorPreSave` event it means that file saving will be aborted.
-- For `onEditorPreClose` event it means that closing an editor tab will be aborted.
-- For `onEditorKeyDown` event it means that the key will be "eaten".
-- For `onEditorAction` event it means that the action will not be executed.
-- For `onFiletreeActivate` event it means that no further processing is done.
-- For `onEditorCharAdded` event it means that no further processing is done
-- (but the character is still added to the editor).
-- line numbers are 1-based in callbacks

local events = {
  onRegister =         function(self) end,
  onUnRegister =       function(self) end,
  onEditorLoad =       function(self, editor) end,
  onEditorPreClose =   function(self, editor) end, -- return false
  onEditorClose =      function(self, editor) end,
  onEditorNew =        function(self, editor) end,
  onEditorPreSave =    function(self, editor, filepath) end, -- return false
  onEditorSave =       function(self, editor) end,
  onEditorFocusLost =  function(self, editor) end,
  onEditorFocusSet =   function(self, editor) end,
  onEditorAction =     function(self, editor, event) end, -- return false
  onEditorKeyDown =    function(self, editor, event) end, -- return false
  onEditorCharAdded =  function(self, editor, event) end, -- return false
  onEditorUserlistSelection = function(self, editor, event) end, -- return false
  onEditorMarkerUpdate = function(self, editor, marker, line, value) end, -- return false
  onEditorUpdateUI =   function(self, editor, event) end,
  onEditorPainted =    function(self, editor, event) end,
  onEditorCallTip =    function(self, editor, tip, value, eval) return true; end, -- return false
  onEditorModified =   function(self, editor) end, --return false
  onEditorDClicked =   function(self, editor, onlyClick) end, --return false
  onEditorSelected =   function(self, editor) end, -- return false
  onFiletreeActivate = function(self, tree, event, item) end, -- return false
  onFiletreeLDown =    function(self, tree, event, item) end,
  onFiletreeRDown =    function(self, tree, event, item) end,
  onMenuEditor =       function(self, menu, editor, event) end,
  onMenuEditorTab =    function(self, menu, notebook, event, index) end,
  onMenuOutput =       function(self, menu, editor, event) end,
  onMenuOutputTab =    function(self, menu, notebook, event, index) end,
  onMenuConsole =      function(self, menu, editor, event) end,
  onMenuFiletree =     function(self, menu, tree, event) end,
  onMenuOutline =      function(self, menu, tree, event) end,
  onMenuWatch =        function(self, menu, tree, event) end,
  onProjectPreLoad =   function(self, project) end, -- before project is changed
  onProjectLoad =      function(self, project) end, -- after project is changed
  onProjectClose =     function(self, project) end,
  onInterpreterLoad =  function(self, interpreter) end,
  onInterpreterClose = function(self, interpreter) end,
  onDebuggerPreLoad =  function(self, debugger, options) end, -- return false
  onDebuggerLoad =     function(self, debugger, options) end,
  onDebuggerPreClose = function(self, debugger) end, -- return false
  onDebuggerClose =    function(self, debugger) end,
  onDebuggerPreActivate = function(self, debugger, file, line) end, -- return false
  onDebuggerActivate = function(self, debugger, file, line, editor) end,
  onDebuggerStatusUpdate = function(self, debugger, status) end, -- return false
  onDebuggerCommand =  function(self, debugger, command, server, options) end,
  onIdle =             function(self, event) end,
  onIdleOnce =         function(self, event) end,
  onAppFocusLost =     function(self, app) end,
  onAppFocusSet =      function(self, app) end,
  onAppLoad =          function(self, ide) end,
  onAppClose =         function(self, app) end,
  onAppShutdown =      function(self, app) end, -- the last event right before exiting
  onPojectDebug =      function(self, ide) end,
}

--[[ Uncomment this to see event names printed in the Output window
  for k in pairs(events) do
    if k:find("^on") then
      P[k] = k:find("^onEditor")
        and function(self, ed)
          -- document can be empty for newly added documents
          local doc = ide:GetDocument(ed)
          DisplayOutputLn(self:GetFileName(), k, doc and doc:GetFilePath() or "new document") end
        or function(self, ...)
          DisplayOutputLn(self:GetFileName(), k, ...) end
    end
  end

  P.onMenuEditor = function(self, menu, editor, event)
    local point = editor:ScreenToClient(event:GetPosition())
    pos = editor:PositionFromPointClose(point.x, point.y)
    menu:Append(id, ">> Sample item; pos "..pos)
    menu:Enable(id, true)

    editor:Connect(id, wx.wxEVT_COMMAND_MENU_SELECTED,
      function() DisplayOutputLn("Selected "..pos) end)

    DisplayOutputLn(self:GetFileName(), "onMenuEditor")
  end

  P.onMenuEditorTab = function(self, menu, notebook, event, index)
    menu:Append(id, ">> Sample item; tab "..index)
    menu:Enable(id, true)

    notebook:Connect(id, wx.wxEVT_COMMAND_MENU_SELECTED,
      function() DisplayOutputLn("Selected "..index) end)

    DisplayOutputLn(self:GetFileName(), "onMenuEditorTab")
  end

  P.onMenuFiletree = function(self, menu, tree, event)
    local item_id = event:GetItem()
    local name = tree:GetItemFullName(item_id)
    menu:Append(id, ">> Sample item; name "..name)
    menu:Enable(id, true)

    tree:Connect(id, wx.wxEVT_COMMAND_MENU_SELECTED,
      function() DisplayOutputLn("Selected "..name) end)

    DisplayOutputLn(self:GetFileName(), "onMenuFiletree")
  end

  P.onInterpreterLoad = function(self, interpreter)
    DisplayOutputLn(self:GetFileName(), "onInterpreterLoad", interpreter:GetFileName())
  end

  P.onInterpreterClose = function(self, interpreter)
    DisplayOutputLn(self:GetFileName(), "onInterpreterClose", interpreter:GetFileName())
  end

  P.onEditorPreSave = function(self, editor, filepath)
    if filepath:find("%.txt$") then
      DisplayOutputLn(self:GetFileName(), "onEditorPreSave", "Aborted saving a .txt file")
      return false
    else
      DisplayOutputLn(self:GetFileName(), "onEditorPreSave", filepath)
    end
  end

  P.onEditorCharAdded = function(self, editor, event)
    DisplayOutputLn(self:GetFileName(), "onEditorCharAdded", event:GetKey())
  end

  P.onEditorKeyDown = function(self, editor, event)
    DisplayOutputLn(self:GetFileName(), "onEditorKeyDown", event:GetKeyCode())
  end

--]]

 P.onEditorLoad = function(self, editor)
	--editor:SetViewEOL(1)
	editor:ConvertEOLs(editor:GetEOLMode())
end

P.onEditorSave = function(self, editor)
	editor:ConvertEOLs(editor:GetEOLMode())
end

-------------------------------------------------------
-- @usage: 用法
-- @class: 类型
-- @name: 名字
-- @description: 描述
-- @filed: 成员
-- @param: 参数
-- @see: 参考
-- @author: 作者
-- @return: 返回值
local KeyCodeFragment = {
	-- selLen 选择
	{ key="for", cf1=" k=1,10 do", cf2="end", offsetSel=1, selLen=1 },
	{ key="if", cf1="  then", cf2="end", offsetSel=1, selLen=0 },
	{ key="elseif", cf1="  then", cf2="", offsetSel=1, selLen=0 },
	{ key="function", cf1=" ()", cf2="end", offsetSel=1, selLen=0 },
	{ key="---", cf1=[[
-------------------------------------------------------
-- @class
-- @name
-- @description
-- @return nil:
-- @usage
]],
	cf2="", offsetSel=63, selLen=0 },
  { key="__comment", cf1=[[
-------------------------------------------------------
-- @class
-- @name
-- @description
-- @return nil:
-- @usage]],
	cf2="", offsetSel=66, selLen=0 },
	--{ key="{", cfg="  ", cf2="}", offsetSel=1, selLen=0 },
	--{ key="(", cfg="  ", cf2=")", offsetSel=1, selLen=0 },
	--{ key="\"", cfg=" \"", cf2="", offsetSel=1, selLen=0 },
}

-- 是否为自动完成的代码
local IsKeyCode=function(key)
	for _,v in pairs(KeyCodeFragment) do
		if v.key == key then
			return true;
		end
	end

	return false;
end

-- 获取自动完成的代码
function GetKeyCode(key)
	for _,v in pairs(KeyCodeFragment) do
		if v.key == key then
			return v;
		end
	end

	return nil;
end

-- 代码片断自动完成
function P:InsertCodeFragment(editor, pos, lastWord, indentation)
	if IsKeyCode(lastWord) then
		editor:SetCurrentPos(pos);
		-- 可以自动完成
		local keyCode = GetKeyCode(lastWord);
		if keyCode == nil then return true; end
		if keyCode.cf2 == "" then
			indentation=0;
		end

		if indentation == 1 then
			-- 插入动完成的字符
			local line = editor:LineFromPosition(pos);
			editor:AddTextRaw(keyCode.cf1);
			local indent = editor:GetLineIndentation(line);
			-- insert line
			editor:NewLine();
			editor:AddTextRaw(keyCode.cf2);
			editor:SetLineIndentation(line+1, indent);
		else
			-- 插入动完成的字符
			editor:AddTextRaw(keyCode.cf1.." "..keyCode.cf2);
		end

		editor:SetSelection(pos+keyCode.offsetSel, pos+keyCode.offsetSel+keyCode.selLen);

		return true;
	end

	return false;
end

-- 代码自动完成
function P:AutoCodeFragment(editor, event)
	local ch = event:GetKeyCode()
	if ch ~= wx.WXK_TAB then
		return true;
	end

	local q = EscapeMagic

	local line = editor:GetCurrentLine();
	local lineStart = editor:PositionFromLine(line);
  local text = editor:GetTextRange(lineStart,editor:GetCurrentPos());

	local anysep = "["..q(editor.spec.sep).."]"
	local lastWord = nil;
	local indentation = 0; -- 对齐
	for word in text:gmatch(anysep.."?%s*([a-zA-Z_]+[a-zA-Z_0-9]+)") do
    lastWord = word;
		indentation = indentation+1;
  end
	for word in text:gmatch(anysep.."?%s*(%-%-%-)") do
	  lastWord = word;
	  indentation = indentation+1;
  end
	if lastWord then
		text = editor:GetTextRange(editor:GetCurrentPos()-#lastWord,editor:GetCurrentPos());
		if text ~= lastWord then return true; end

		if self:InsertCodeFragment(editor, editor:GetCurrentPos(), lastWord, indentation) then
			return false;
		end
	end

	return true;
end

-- 双击事件
doubleClickFlag = false;
function P:onEditorDClicked(editor, onlyClick)
	--local styles = ide.config.styles
	--local fg = styles.sel and styles.sel.bg and wx.wxColour(unpack(styles.sel.bg))
	--editor:SetAdditionalCaretForeground(fg);
	doubleClickFlag = onlyClick;
end

-- 获取动态编译的源码
function GetDyncCompilerSrc ( editor )
	local pos = editor:GetCurrentPos();
	local line = editor:GetCurrentLine();
	local text = "";
	if line > 0 then
		-- Get top text
		local lineEndPos = editor:GetLineEndPosition(line-1);
		text = editor:GetTextRange(0,lineEndPos);
		text = text.."\r\n";
	end

	local fpos = editor:PositionFromLine(line);
	text = text .. editor:GetTextRange(fpos,pos-1);
	text = text .. "=1;\r\n"

	local totalLine = editor:GetLineCount();
	if totalLine > line then
		-- Get buttom text
		local lineStartPos = editor:PositionFromLine(line+1);
		local lineEndPos = editor:GetLineEndPosition(totalLine-1);
		text = text..editor:GetTextRange(lineStartPos,lineEndPos);
	end

	return text,pos-1;
end

-- 遍历语法树
local function WalkAst(ast, maxDepth, fdown, fup)
	if maxDepth == nil then
		maxDepth = 1000;
	end

	local function walk(ast, depth, fdown, fup)
		if depth >= maxDepth then
			return;
		end
		assert(type(ast) == 'table')
		if fdown then
      if fdown(ast,depth) then
        return
      end
    end
		for k,bast in ipairs(ast) do
			if type(bast) == 'table' then
				walk(bast, depth+1, fdown, fup)
			end
		end
		if fup then fup(ast,depth) end
	end

	walk(ast, 0, fdown, fup);
end

-- 是否为类函数
local function IsClassFunction(ast)
	if ast.tag=="Set" then -- set operate
		local firstAst = ast[1][1];
		local secondAst = ast[2][1];
		if firstAst.tag == "Index" and secondAst.tag == "Function" then
			return true;
		end
	end
end

-- 判断是否为全局调用
function PkgIsGlobalCall(editor, fpos)
	local var, funccall = GetValAtPosition(editor, fpos)
	-- if this is a value type rather than a function/method call, then use
	-- full match to avoid calltip about coroutine.status for "status" vars
	local _,lineinfo = GetTipInfo(editor, funccall or var, false, true, fpos)
	if lineinfo and lineinfo.fileName then
		return true;
	end

	return false;
end

local ClassFunctions = {};  -- 类函数表
-- 通过指定位置获取类名
local function GetClassNameByLine(pos)
  local count = #ClassFunctions
	for k=count,1,-1 do
		if ClassFunctions[k].lineno <= pos then
			return true, ClassFunctions[k].cname, ClassFunctions[k].lineno;
		end
	end
	return false;
end

-------------------------------------------------------
-- @description 删除两端空格
-- @param 源字符串
-- @return 删除后字符串
function stringDelTowEndSpace(str)
  assert(type(str)=="string")
  return str:match("^[%c%s]*(.+)[%c%s]*$")
end


-- 是否为空字符行(匹配^%s*$)
local function isEmptyCharLine(str)
	return str:find("^%s*$");
end

-- 获取注释定义
local function getCommentTypeDef(str)
	return str:match("^%s*%-%-+%s*!%s*([%w_]+)%s+(.*)")
end

-- 获取函数返回值
-- 获取注释定义
local function getCommentFuncRetDef(str)
	return str:match("^%s*%-%-+%s*@%s*return%s+([%w_]+)")
end

-- 是否为注释
local function isCommentDefineLine(str)
	return str:match("^%s*%-%-")
end

-- 是否为函数定义(%s*local%s+function|%sfunction%s+)
local function isFunctionDefine(templine)
	return templine:find("^%s*function") or templine:find("^%s*local%s+function")
end

-- 是否为注释定义 @class xxx[class,enum,function]
local function isCommentTypeDefine(templine)
	return templine:find("^%s*%-%-+%s*@class%s+")
end

-- 是盃为类定义
local function isClassDefine(tempLine)
	return getClassDefine(tempLine) ~= nil;
end

-- 是否为end
local function isEndString(tempLine)
	return tempLine:find("^end%s*$");
end

-- 获取赋值定义
local function getAssignDef(str)
	return str:match("%s*([%w_%.]+)%s*=%s*");
end

-- 获取函数名定义
-- 返回类名, 函数名, 参数字符串
local function getFunctionDefine(str)
	local funcName = nil;
	local className = nil
	local paramstr = nil
	local localFlag = true

	for k1,v in str:gmatch("function%s+([%w_%.]+%s*)[:%.](%s*[%w_]+)") do
		className = k1;
		funcName = v;
		localFlag = false
		break;
	end

	if funcName == nil then
		for k1,v in str:gmatch("function%s+([%w_%.]+)") do
			funcName = k1;
			localFlag = false
			break;
		end
	end

	if funcName == nil then
		for k1,v in str:gmatch("local%s+function%s+([%w_%.]+)") do
			funcName = k1;
			break;
		end
	end

	if funcName ~= nil then
		for kl in str:gmatch("%(([^%)]*)%)") do
			paramstr = kl;
			break;
		end

		if paramstr == nil or isEmptyCharLine(paramstr) then
			paramstr = ""
		end
	end

	if className ~= nil then
		className = stringDelTowEndSpace(className);
		assert(className ~= nil);
	end

	if funcName ~= nil then
		funcName = stringDelTowEndSpace(funcName);
		assert(funcName ~= nil);
	end

	if paramstr ~= nil and paramstr ~= "" then
		paramstr = stringDelTowEndSpace(paramstr);
		assert(paramstr ~= nil);
	end

	return className, funcName, paramstr, localFlag;
end

-------------------------------------------------------
-- @class: 类型
-- @name: 名字
-- @description: 描述
-- @filed: 成员 **
-- @param: 参数
-- @see: 参考 **
-- @author: 作者 **
-- @return: 返回值
-- @usage: 用法
local function getCommentTypeDefine(filelines, lineno)
	local commentDefs = {}
	commentDefs.param = {}
	local countline = 0;
	for k=lineno,#filelines,1 do
		local linetx = filelines[k];
		if isCommentDefineLine(linetx) then
			local _mtype = nil
			local _mstr = nil
			local _doc = nil
			_mstr = linetx:match("^%s*%-%-+%s*@usage%s+(.+)");
			if _mstr then
				commentDefs.usage = _mstr;
			end
			_mstr = linetx:match("^%s*%-%-+%s*@class%s+([%w_]+)");
			if _mstr then
				commentDefs.class = _mstr;
			end
			_mstr = linetx:match("^%s*%-%-+%s*@name%s+([%w_]+)");
			if _mstr then
				commentDefs.name = _mstr;
			end
			_mstr = linetx:match("^%s*%-%-+%s*@description%s+(.+)");
			if _mstr then
				commentDefs.desc = _mstr;
			end
			_mtype,_doc = linetx:match("^%s*%-%-+%s*@return%s+([%w_]+)%s*:%s*(.+)");
			if _mtype then
				commentDefs.returns = {_mtype,_doc};
			end
			_mtype,_mstr,_doc = linetx:match("^%s*%-%-+%s*@param%s+([%w_]+)%s*:%s*([%w_]+)%s*(.+)");
			if _mstr then
			    commentDefs.param[_mstr] = {_mtype,_mstr,_doc};
			end
		elseif isEmptyCharLine(linetx) then
		else
			break;
		end

		countline = countline+1;
	end

	return countline, commentDefs;
end

-- 是否为函数定义(%s*([%w_%d%.]+)%s*=%s*[Cc]lass)
-- 返回类名, 函数名, 参数字符串
local function getClassDefine(str)
	--return str:match("^%s*([%w%d_%.]+)%s*=%s*[Cc]lass%s*%(");
	local cname = str:match("%s*([%w%d_%.]+)%s*=%s*[Cc]lass%s*%(")
	if cname ~= nil then
		return cname, nil
	end

	cname, aname = str:match("^%s*([%w%d_]+)%s*=%s*([%w%d_]+)%.new%s*%(");

	return cname, aname
end

-- 获取到类继承的基类
local function getBaseClass(str)
	return str:match("[Cc]lass%s*%(%s*[\"\'][%w%d_%.]+[\"\']%s*,%s*([%w%d_%.]+)%s*%)");
end

-- 获取到某个以上的注释类型
-- '--! xxx'
local function getUpCommentTagType(editor, curLine, upEndLine)
	local commType = nil
	for k=curLine,upEndLine,-1 do
		local lineText = editor:GetLine(k);
		if lineText and not isEmptyCharLine(lineText) then
			if isCommentDefineLine(lineText) then
				commType = getCommentTypeDef(lineText);
				if commType ~= nil and commType:find("^%s*$") then
					commType = nil;
				end
			end

			break;
		end
	end

	return commType;
end

-- 获取到注释里的函数返回类型
-- '-- @return xxx'
local function getUpCommentFuncRetType(curLine, upEndLine, srcLineList)
	local commType = nil
	for k=curLine,upEndLine,-1 do
		local lineText = srcLineList[k];
		if lineText and not isEmptyCharLine(lineText) then
			if isCommentDefineLine(lineText) then
				commType = getCommentFuncRetDef(lineText);
				if commType ~= nil then
					break;
				end
			else
				break;
			end
		end
	end

	return commType == nil and "" or commType;
end

-- 替换标准的更新类型赋值缓存函数
function PkgTypeAssigns(editor, logflag)
  local q = EscapeMagic
  local line = GetFunctionLineByLine(editor:GetCurrentLine());
  local endline = editor:GetCurrentLine()
  if line == nil or line >= endline then
  	return {}
  end
  local ret, classname = GetClassNameByLine(editor:GetCurrentLine());
  if not ret  then
  	return {};
  end
  local iscomment = editor.spec.iscomment
  local assigns = {}
  local paramTypes = {}
  -- 向上找注释
  for k=line-1,1,-1 do
  	local tempLine = editor:GetLine(k)
  	if isEmptyCharLine(tempLine) then
  	elseif isCommentDefineLine(tempLine) then
  		-- @param nil:pos
  		local paramType = editor:GetLine(k):match("[^@]*@%s*param%s*([%w_]+%s*:%s*[%w_]+)")
  		if paramType then
  			local pType = paramType:match("([^:]+)")
  			local pKey = paramType:match(":([%w_]+)")
  			if pType ~= "nil" and paramTypes ~= nil and pKey ~= nil then
  				paramTypes[pKey] = pType;
  			end
  		end
  	else
  		break;
  	end
  end

  for k,v in pairs(paramTypes) do
  	assigns[k] = v
  end
  
  local filePath = GetEditorPath(editor)
  local classAPI = editor.api.ac.childs[classname]
  if classAPI and classAPI.childs and classAPI.childs["__selfMemAssign"] and classAPI.childs["__selfMemAssign"].files then
    local fileSelfMembers = classAPI.childs["__selfMemAssign"].files[filePath]
    if nil ~= fileSelfMembers then
      local sep = editor.spec.sep
      local varname = "([%w_][%w_"..q(sep:sub(1,1)).."]*)"
      local identifier = "([%w_][%w_"..q(sep).."%s]*)"
      for k,v in pairs(fileSelfMembers) do
        local lt,funcall = GetValAllAtLine(v, #v, editor.spec.sep)
	if nil ~= lt then
          local keytx = lt
	  if funcall then
	    keytx = keytx..":"
	  end
	  keytx = PkgToSelfCallC(keytx,classname,true)
          local tab,mtab,rest = ResolveAssign(editor, keytx, not keytx:find("[:.]$"), false)
          if tab then
            -- if this is a value type rather than a function/method call, then use
            -- full match to avoid calltip about coroutine.status for "status" vars
	    if classAPI.childs[k].valuetype == nil or classAPI.childs[k].valuetype == "" then
	      classAPI.childs[k].valuetype = tab.classname
	    end
          end
	end
      end
   end
  end

  while (line <= endline) do
    local ls = editor:PositionFromLine(line)
    local s = bit.band(editor:GetStyleAt(ls),31)
    if (not iscomment[s]) then
      local tx = editor:GetLine(line) --= string

      -- check for assignments
      local sep = editor.spec.sep
      local varname = "([%w_][%w_"..q(sep:sub(1,1)).."]*)"
      local identifier = "([%w_][%w_"..q(sep).."%s]*)"

      -- special hint
      local typ,var = tx:match("%s*%-%-=%s*"..varname.."%s+"..identifier)
      if (var and typ) then
        typ = typ:gsub("%s","")
        assigns[var] = typ
      else
        -- real assignments
        local var,typ = tx:match("%s*"..identifier.."%s*=%s*([^;]+)")
				local tempType = getUpCommentTagType(editor, line-1, line-10)
				if nil ~= tempType then
					typ = tempType
				end
        var = var and var:gsub("local","")
        var = var and var:gsub("%s","")
        typ = typ and typ
          :gsub("%b()","")
          :gsub("%b{}","")
          :gsub("%b[]","")
          -- remove comments; they may be in strings, but that's okay here
          :gsub("%-%-.*","")
        if (typ and (typ:match(",") or typ:match("%sor%s") or typ:match("%sand%s"))) then
          typ = nil
        end
        typ = typ and typ:gsub("%s","")
        typ = typ and typ:gsub(".+", function(s)
          return (s:find("^'[^']*'$")
              or s:find('^"[^"]*"$')
              or s:find('^%[=*%[.*%]=*%]$')) and 'string' or s
        end)

        -- filter out everything that is not needed
        if typ and typ ~= 'string' -- special value for all strings
          and (not typ:match('^'..identifier..'$') -- not an identifier
            or typ:match('^%d') -- or a number
            or editor.api.tip.keys[typ] -- or a keyword
            ) then
          typ = nil
        end
        if typ and IsSelfCall(typ) and type(classname) == "string" then
          -- self.xxx or self:xxxx
          typ = typ:gsub("^%s*self",classname)
        end
        if (var and typ) and var ~= typ then
          class,func = typ:match(varname.."["..q(sep).."]"..varname)
          if (assigns[typ]) then
            assigns[var] = assigns[typ]
          elseif (func) then
            -- FIXME remove this, in favor of proper api definitions
            local added = false
            --local funcnames = {"new","create"}
            --for i,v in ipairs(funcnames) do
            --  if (func == v) then
            --    assigns[var] = class
            --    added = true
            --    break
            --  end
            --end
            if (not added) then
              -- let's hope autocomplete info can resolve this
              assigns[var] = typ
            end
          else
            assigns[var] = typ
          end
        end
      end
    end
    line = line+1
  end

  return assigns
end

-- 通过指定行号获取函数定义行号
function GetFunctionLineByLine(lineno)
	local last;
  local count = #ClassFunctions
	for k=count,1,-1 do
		if ClassFunctions[k].lineno <= lineno then
			return ClassFunctions[k].lineno;
		end
	end
	return nil;
end

-- 通过类名获取类函数
local function GetClassFunctionList(cname, callstr)
	local funcList = {};
	for _,v in pairs(ClassFunctions) do
		if v.cname == cname then
			if callstr then
				if v.fname:find("^"..callstr) ~= nil then
					table.insert(funcList, v.fname.."()");
				end
			else
				table.insert(funcList, v.fname.."()");
			end
		end
	end
	return funcList;
end

-- 获取源码的所有函数列表
local function GetSourceFunctionList(ast)
	ClassFunctions = {};
	WalkAst(ast, 3, function(ast)
			if ast.tag=="Set" then -- set operate
				local firstAst = ast[1][1];
				local secondAst = ast[2][1];
				if firstAst.tag == "Index" and secondAst.tag == "Function" then
					local cffast = firstAst[1][1];
					local cfsast = firstAst[2][1];
					local fpos, lpos = tostring(secondAst.lineinfo.first):match('|K(%d+)'), tostring(secondAst.lineinfo.last):match('|K(%d+)');
					table.insert(ClassFunctions, {cname=cffast,fname=cfsast,fpos=tonumber(fpos), lpos=tonumber(lpos)});
				end
			end
		end
	);
end

-- 获取自动完成列表
function GetAutoList(inEditor, dyncFlag)
	local editor = inEditor;
	local text = nil;
  if dyncFlag then
    text = GetDyncCompilerSrc(editor);
  else
    text = editor:GetText();
  end

	local ide = ide;
	local frame = ide.frame;
	local ast, tokenlist, ret = DynamicAst(GetEditorPath(editor), text);
	if not ret then
		frame:GetStatusBar():SetStatusText("Compiler Error!!!!", 6);
	else
		frame:GetStatusBar():SetStatusText("Compiler Success!!!!", 6);
	end

	--AutocompleteVariable(editor, editor:GetCurrentPos());
	--return GetVariableType(editor,pos);

  return ast;
end

-- 通过位置获取整个单词
function GetWordByPosition(editor, pos, fullmatch)
	local fPos = editor:WordStartPosition(pos, false);
	local lPos = editor:WordEndPosition(pos,false);
	local word = editor:GetTextRange(fPos, lPos);
	if fullmatch then
		return word:match("^([%w_]+)$")
	end

	return word:match("%s*([%w_]+)");
end

-- 在工具栏显示函数列表
function ShowFileFunctionList(editor)
  ide.frame.toolBar.functionlist:Clear();
  for _,v in pairs(ClassFunctions) do
		if v.cname ~= nil then
			ide.frame.toolBar.functionlist:Append(v.cname..":"..v.fname..v.param);
    else
      ide.frame.toolBar.functionlist:Append(v.fname..v.param);
		end
	end
end

-- 选择函数列表函数跳转到函数的定义
function GotoFunctionDefineByName(editor, str)
  local lineno = nil;
  for _,v in pairs(ClassFunctions) do
    local sstr = nil
		if v.cname ~= nil then
      sstr = v.cname..":"..v.fname
    else
      sstr = v.fname
		end

    if str:find("^"..sstr) then
        lineno = v.lineno;
        break;
      end
	end

  if lineno ~= nil then
    -- 找到指定的函数文件行并确保光标在屏幕中央
    editor:GotoPosEnforcePolicy(editor:PositionFromLine(lineno))
    if not ide:GetEditorWithFocus(editor) then ide:GetDocument(editor):SetActive() end
  end
end

-- 获取编辑页面的路径
function GetEditorPath(editor)
	if editor == nil then
		return nil;
	end

  local id = editor:GetId()
	if ide.openDocuments[id] == nil then
		return nil;
	end
  if not ide.openDocuments[id].filePath then return nil end

	return ide.openDocuments[id].filePath;
end

-- 通过位置获取类名
function GetClassNameByPos(editor, pos, allmatch)
	local line = editor:GetCurrentLine();
	local ret, cname, cpos = GetClassNameByLine(line);
	if ret then
		return cname, cpos;
	end

	return nil, nil;
end

-- 是否是self call
function IsSelfCall(str, allmatch)
	if not str then
		return false;
	end
	if allmatch then
	    if str:find("^%s*self[%.:][%w_]+$") ~= nil or str:find("^%s*self[%.:]$") ~= nil then
		    return true;
	    end
	else
	    if str:find("^%s*self[%.:][%w_]+") ~= nil or str:find("^%s*self[%.:]") ~= nil then
		    return true;
	    end
	end
	return false;
end

-- 通过位置获取self:xxx格式
function GetSelfCallByPos(editor, pos, allmatch)
	local wd = GetValAtPosition(editor, pos, true);
	if wd == nil then
		return nil
	end

	if allmatch then
		if not (wd:find("^self[%.:][%w_]+$") ~= nil or wd:find("^self[%.:]$") ~= nil) then
			return nil;
		end
	else
		if not (wd:find("^self[%.:][%w_]+") ~= nil or wd:find("^self[%.:]") ~= nil) then
			return nil;
		end
	end

	return wd;
end

-------------------------------------------------------
-- @description: 分割字符串
-- @param: 待分割的字符串,分割字符
-- @return: 子串表.(含有空串)
function stringSplit(str, splitStr, addSpliteFlag)
  local subStrTab = {};
  local spliteStrLen = 1;
  while (true) do
    local pos = string.find(str, splitStr);
    if (not pos) then
      table.insert(subStrTab, str);
      break;
    end
    local subStr = string.sub(str, 1, pos-1);
    if addSpliteFlag then
      subStr = subStr .. splitStr;
    end
    table.insert(subStrTab, subStr);
    str = string.sub(str, pos + spliteStrLen, #str);
  end

  return subStrTab;
end

-- 全局跳转列表
AllJumpStack = {}

function GotoFilePos(filePath, fpos)
	LoadFile(filePath,nil,true);
	-- 找到指定的函数文件行并确保光标在屏幕中央
	ide:GetEditor():GotoPosEnforcePolicy(fpos)
	if not ide:GetEditorWithFocus(ide:GetEditor()) then
		ide:GetDocument(ide:GetEditor()):SetActive()
	end
end

function GotoFileLine(filePath, lineno, pos)
	LoadFile(filePath,nil,true);
	-- 找到指定的函数文件行并确保光标在屏幕中央
	--ide:GetEditor():GotoPosEnforcePolicy(ide:GetEditor():PositionFromLine(lineno)+pos)
	if not ide:GetEditorWithFocus(ide:GetEditor()) then
		ide:GetDocument(ide:GetEditor()):SetActive()
	end
	ide:GetEditor():GotoPosEnforcePolicy(ide:GetEditor():PositionFromLine(lineno))
end

function PkgNavigateBack()
  if #AllJumpStack == 0 then return false end
  local lineinfo = table.remove(AllJumpStack)
	GotoFilePos(lineinfo.fileName, lineinfo.lineno);
  return true
end

-- 成员函数中的self.xxx=aaa定义
local function getFunctionVarSet(ast)
	local selfMems = {}
	WalkAst(ast, 10, function(ast, depth)
			if ast.tag=="Set" then -- set operate
				local firstAst = ast[1][1];
				local secondAst = ast[2][1];
				if firstAst.tag == 'Index'
					and firstAst[1].tag == 'Id' and firstAst[1][1] == 'self'
					and firstAst[2].tag == 'String' then
						-- self.xxx 定义
						table.insert(selfMems,
							{
								l=tostring(firstAst.lineinfo.first):match('|L(%d+)'),
								name=firstAst[2][1]
							});
				end
			end
		end
	);

	return selfMems;
end

local function getClassAPI(allClasses, classname, aliasName, filePath, classDef, isClass)
  local names = stringSplit(classname, "%.", false);
  local classes = allClasses;

  if #names == 0 then
    return nil;
  end

  if #names > 0 then
    local v= names[1];
    if allClasses[v] == nil then
      classes = {}
      classes.childs = {}
      allClasses[v] = classes;
    else
      classes = allClasses[v];
    end
    classes.type = "class";
    if classes.inherits == nil or classes.inherits == "" then
      classes.inherits = classDef.baseName;
    end

    if aliasName ~= nil then
	classes.inherits = aliasName
    end
    classes.fileName=filePath;
	if isClass then
		classes.lineno = classDef.lineno;
	else
		if classes.lineno == nil or tonumber(classes.lineno) > tonumber(classDef.lineno) then
			classes.lineno = classDef.lineno;
		end
    end
  end

  if #names > 1 then
    for k=2,#names,1 do
      local v = names[k]
      if classes.childs[v] == nil then
        classAPI = {}
        classAPI.childs = {}
        classes.childs[v] = classAPI;
        classes = classAPI;
      else
        classes = classes.childs[v];
      end
	classes.type = "class";

	if classes.inherits == nil or classes.inherits == "" then
	  classes.inherits = classDef.baseName;
	end

	classes.fileName=filePath;
	if isClass then
		classes.lineno = classDef.lineno;
	else
		if classes.lineno == nil or tonumber(classes.lineno) > tonumber(classDef.lineno) then
			classes.lineno = classDef.lineno;
		end
	end
    end
  end

  return classes;
end

local function addDynamicAPI(filePath, tempFunctions, ctorSelfMemDef, classDefines, logflag)
	local classes = {}
	local globalFuncs = {}
	local apis = {}

	for _,v in pairs(classDefines) do
		if v.cname ~= nil then
			local classAPI = nil
			classAPI = getClassAPI(classes, v.cname, v.aname, filePath, v, true);
			classAPI.childs["new"] = {
				type = "function",
				fileName=filePath,
				lineno = v.lineno,
				returns = v.cname,
				valuetype = v.cname
			}
			classAPI.childs["create"] = {
				type = "function",
				fileName=filePath,
				lineno = v.lineno,
				returns = v.cname,
				valuetype = v.cname
			}
		end
	end

	for _,v in pairs(tempFunctions) do
		if v.cname ~= nil then
			local classAPI = nil
			classAPI = getClassAPI(classes, v.cname, v.aname, filePath, v, false);
			classAPI.childs[v.fname] = {
				type = "method",
				fileName=filePath,
				args = v.param,
				lineno = v.lineno,
				returns = v.retType,
				valuetype = v.retType
			}
		else
			if not v.localFlag then
				globalFuncs[v.fname] = {
					type = "function",
					fileName=filePath,
					args = v.param,
					lineno = v.lineno,
					returns = v.retType,
					valuetype = v.retType
				}
			end
		end
	end

	local memclass = {}
	--cname=className,mname=v.name,lineno=v.l+beginLine,mtype=selfMemType
	for _,v in pairs(ctorSelfMemDef) do
		if v.cname ~= nil then
			local classAPI = nil
			classAPI = getClassAPI(classes, v.cname, v.aname, filePath, v, false);
			if classAPI.childs[v.mname] == nil then
				classAPI.childs[v.mname] = {
					type = "value",
					fileName=filePath,
					lineno = v.lineno,
					valuetype = v.mtype,
					args = "self.member",
					returns = v.mtype,
					description = v.mdesc
				}
			end
			if memclass[v.cname] == nil then
				if classAPI.childs["__selfMemAssign"] == nil then
					classAPI.childs["__selfMemAssign"] = {
						type = "value",
						fileName=filePath,
						lineno = 0,
						valuetype = "",
						args = "self.member",
						returns = "",
						description = "self member assign cache",
						files = {}
					}
				end
				classAPI.childs["__selfMemAssign"].files[filePath] = {}
				memclass[v.cname] = true
			end
			classAPI.childs["__selfMemAssign"].files[filePath][v.mname] = v.lineText
		end
	end

	for k,v in pairs(classes) do
		apis[k] = v;
	end
	for k,v in pairs(globalFuncs) do
		apis[k] = v;
	end

	ReloadDyncAPI("lua", filePath, apis);
end

-- 编译函数并获取self.xxx=xxx及参数的定义
local function compileFuncCode(filePath, src, className, srcLineList, beginLine)
	local selfMemSets = {}
	local ast = DynamicAst(filePath, src);
	if ast then
		selfMemSets = getFunctionVarSet(ast);
	end
	
	local selfMems = {}
	for _,v in pairs(selfMemSets) do
		v.l = tonumber(v.l)
		
		for k=v.l-1,1,-1 do
			local lineText = srcLineList[k];
			if not isEmptyCharLine(lineText) then
				-- 非空行
				local selfMemType,selfMemDesc = getCommentTypeDef(lineText);
				if not selfMemType then
					selfMemType = ""
				end
				table.insert(selfMems,{cname=className,mname=v.name,lineno=v.l+beginLine-1,mtype=selfMemType,mdesc=selfMemDesc,lineText=srcLineList[v.l]})
				break;
			end
		end
	end

	return selfMems;
end

-------------------------------------------------------
-- @class function
-- @name GetProtocolID
-- @description
-- @return nil:
-- @usage ClientController.funs[81] = ClientController.onUserSaveRechargeOrder
local function GetProtocolID(templine)
  return templine:match("^%s*ClientController.funs%[(%d+)%]%s*=%s*ClientController.on([a-zA-Z0-9]+)");
end

function ConvertProtocolFile(editor)
  local lineNum = 0
  local fileSrcLines = {}

  --editor = nil;
  if nil ~= editor then
		-- 读编辑页面数据
		lineNum = editor:GetLineCount();
		for _lineno=1,lineNum,1 do
			table.insert(fileSrcLines, editor:GetLine(_lineno-1));
		end
  else
    table.insert(fileSrcLines, "function ClientController.GuessBet(sBetStr, ss, cc, bb)\r\n");
    table.insert(fileSrcLines, "  local pid = cpp_buff_create(aa)\r\n");
    table.insert(fileSrcLines, "  cpp_buff_writeShort(pid,60)\r\n");
    table.insert(fileSrcLines, "  if sBetStr == nil then\r\n");
    table.insert(fileSrcLines, "    cpp_buff_writeBoolean(pid,false)\r\n");
    table.insert(fileSrcLines, "    cpp_buff_writeString(pid,\"\")\r\n");
    table.insert(fileSrcLines, "  else\r\n");
    table.insert(fileSrcLines, "    cpp_buff_writeBoolean(pid,true)\r\n");
    table.insert(fileSrcLines, "    cpp_buff_writeString(pid,sBetStr)\r\n");
    table.insert(fileSrcLines, "  end\r\n");
    table.insert(fileSrcLines, "  cpp_buff_writeString(pid,sBetStr)\r\n");
    table.insert(fileSrcLines, "  cpp_buff_encode(pid)\r\n");
    table.insert(fileSrcLines, "  return pid\r\n");
    table.insert(fileSrcLines, "end\r\n");
  end

  lineNum = #fileSrcLines
	_lineno = 1
  local funcLines = {}
  local funcStart = false;
  local _ = nil;
  local funcName = nil;
  local ctorSrc = "";
  local writeStruct = {}
  local readStruct = {}
  local readBeanStruct = {}
  local readProtocolIDs = {}
  local writeProtocolIDs = {}
	while _lineno <= lineNum do
    local templine = fileSrcLines[_lineno];
    if isFunctionDefine(templine) then
      funcStart = true;
      ctorSrc = ctorSrc..templine;
      _,tempStr = getFunctionDefine(templine);
      funcName = tempStr:match("^on([%d%w]+)$");
      if funcName == nil then
        funcName = tempStr;
      end
    elseif isEndString(templine) then
      ctorSrc = ctorSrc..templine;
      --OutLn(ctorSrc);
      if funcStart then
        local ast = DynamicAst("ttt.lua", ctorSrc);
        if ast then
          local selfMemSets, typeFlag	= getStructSet(ast);
--          if #selfMemSets <= 0 then
--            OutLn(funcName);
--          end
          if typeFlag == 2 then
            table.insert(writeStruct, {members = selfMemSets, className = funcName});
          elseif typeFlag == 1 then
            table.insert(readStruct, {members = selfMemSets, className = funcName});
          elseif typeFlag == 3 then
            table.insert(readBeanStruct, {members = selfMemSets, className = funcName});
          else
            assert(false);
          end
        end
      end
      ctorSrc = "";
      funcStart = false;
    elseif funcStart then
      ctorSrc = ctorSrc..templine;
    else
      local proID, proName = GetProtocolID(templine);
      if proID ~= nil and proName ~= nil then
        readProtocolIDs[proName] = proID;
      end
    end
    _lineno = _lineno+1;
  end

  for k,mem in pairs(writeStruct) do
    local funcName = mem.className;
    OutLn("class CM"..funcName.." : public CRequestPacket");
    OutLn("{");
    OutLn("public:");
    local memCount = 1;
    for _,v in pairs(mem.members) do
      if memCount < 2 then
        writeProtocolIDs[funcName] = v[2];
        OutLn("\tDReqPacketImpl(CM"..funcName..", PACKET_CM_"..funcName:upper()..");");
      else
        OutLn("\t"..v[1].." "..v[2]..";");
      end
      memCount = memCount+1;
    end
    OutLn("};");
  end
  for k,mem in pairs(readStruct) do
    local funcName = mem.className;
    OutLn("class MC"..funcName.."Ret : public CResponsePacket");
    OutLn("{");
    OutLn("public:");
    --OutLn("\t"..funcName:upper());
    OutLn("\tDResPacketImpl(MC"..funcName.."Ret, PACKET_MC_"..funcName:upper().."_RET);");
    for _,v in pairs(mem.members) do
      OutLn("\t"..v[1].." "..v[2]..";");
    end
    OutLn("};");
  end
  for k,mem in pairs(readBeanStruct) do
    local funcName = mem.className;
    OutLn("class "..funcName);
    OutLn("{");
    OutLn("public:");
    for _,v in pairs(mem.members) do
      OutLn("\t"..v[1].." "..v[2]..";");
    end
    OutLn("};");
  end
  for k,v in pairs(writeProtocolIDs) do
    OutLn("\tPACKET_CM_"..k:upper().." = "..v..",");
  end
  for k,v in pairs(readProtocolIDs) do
    OutLn("\tPACKET_MC_"..k:upper().."_RET = "..v..",");
  end

--   protocol[CMPacket.PackID] = CMapPlayerHandler:handleXXX;
--  for k,mem in pairs(writeStruct) do
--    local funcName = mem.className;
--    OutLn("MapPlayerHandler.Protocls[CM"..funcName..".PackID] = MapPlayerHandler.handle"..funcName..";");
--  end
--  local defaultValues = {
--    uint8 = 1,
--    sint16 = 10,
--    sint32 = 10,
--    TCharArray2 = "\"\""
--  }
--  for k,mem in pairs(readStruct) do
--    local funcName = mem.className;
--    OutLn("function CMapPlayerHandler:handle"..funcName.."(pack)");
--    OutLn("\tlogDebug(\"Handle packet: CM"..funcName.."\");");
--    OutLn("");
--    OutLn("\tlocal retPack = MC"..funcName.."Ret.new();");
--    OutLn("\tretPack.retCode = 1;");
--    for _,v in pairs(mem.members) do
--      local defVal = defaultValues[v[1]];
--      if defVal == nil then
--        if (v[1]):match("CArray2<") then
--          defVal = "{}";
--        else
--          defVal = "self:new"..v[1].."()";
--        end
--      end
--      OutLn("\tretPack."..v[2].." = "..defVal..";");
--    end
--    OutLn("\tself:sendPacket(retPack);");
--    OutLn("\treturn true;");
--    OutLn("end");
--  end
--  for k,mem in pairs(readBeanStruct) do
--    local funcName = mem.className;
--    OutLn("function CMapPlayerHandler:new"..funcName.."()");
--    OutLn("\tlocal obj = "..funcName..".new();");
--    for _,v in pairs(mem.members) do
--      local defVal = defaultValues[v[1]];
--      if defVal == nil then
--        if (v[1]):match("CArray2<") then
--          defVal = "{}";
--        else
--          defVal = "self:new"..v[1].."()";
--        end
--      end
--      OutLn("\tobj."..v[2].." = "..defVal..";");
--    end
--    OutLn("\treturn obj;");
--    OutLn("end");
--  end
end

waitCompileFileList = {}
lastCompilerFileName = nil
-- 源文件词法分析
local function compileFile(filePath, logflag)
	if ide:GetProject() == nil then
		return
	end

	local fileCount = 0;
	for _,_ in pairs(waitCompileFileList) do
		fileCount = fileCount+1;
	end
	local compileFileName = filePath:match(ide:GetProject().."(.+)");
	if not compileFileName then compileFileName = filePath; end
	ide.frame:GetStatusBar():SetStatusText("CompileFile: "..compileFileName..", RestFileNum: "..fileCount, 0);
	local tempFunctions = {}
	local isCtor = false
	local ctorSrc = ""
	local ctorLines = {}
	local ctorBeginLine = 0
	local ctorSelfMemDef = {}
	local fileSrcLines = {}
	local classDefines = {}
	local _lineno = 0
	local lineNum = 0

	local _doc = ide:FindDocument(filePath);
	local editor = nil
	if nil ~= _doc then
		editor = GetEditor(_doc.index);
	end

	if nil ~= editor then
		-- 读编辑页面数据
		lineNum = editor:GetLineCount();
		for _lineno=1,lineNum,1 do
			table.insert(fileSrcLines, editor:GetLine(_lineno-1));
		end
	else
		-- 读文件
		local file = io.open(filePath);
		if nil ~= file then
			for templine in file:lines() do
				table.insert(fileSrcLines, templine);
			end
			file:close();
			file = nil;
		end
	end

	lineNum = #fileSrcLines
	_lineno = 1
	while _lineno <= lineNum do
		local funcName = nil;
		local className = nil
		local params = nil
		local line = nil;
		local _localFlag = true
		local commentDefs = nil
		local templine = fileSrcLines[_lineno];
		if isCommentTypeDefine(templine) then
			local linenum = nil
			linenum, commentDefs = getCommentTypeDefine(fileSrcLines, _lineno);
			_lineno = _lineno+linenum
			if commentDefs.class == "enum" then
				local linetx = fileSrcLines[_lineno];
				local enumName = getAssignDef(linetx);
				if enumName then
					table.insert(classDefines, {cname=enumName,lineno=_lineno-1,baseName=""});
					_lineno = _lineno+1;
				end
			end
		elseif isEndString(templine) then
			if isCtor then
				isCtor = false;
				if ctorSrc ~= "" then
					table.insert(ctorLines, templine)
					ctorSrc = ctorSrc..templine;
					-- ctor 源码
					className = getFunctionDefine(ctorLines[1]);
					local memDefs = compileFuncCode(filePath,ctorSrc,className,ctorLines,ctorBeginLine-1);
					for _,v in ipairs(memDefs) do
						table.insert(ctorSelfMemDef, v);
					end
				end
			end
			_lineno = _lineno+1;
		elseif isFunctionDefine(templine) then
			line = templine;
			className,funcName,params,_localFlag = getFunctionDefine(line);
			if funcName ~= nil then
				local _retType = getUpCommentFuncRetType(_lineno-1, 1, fileSrcLines);
				table.insert(tempFunctions,
					{cname=className,fname=funcName,lineno=_lineno-1,param="("..params..")",localFlag=_localFlag,retType = _retType})
				if isCtor then
					isCtor = false;
					if ctorSrc ~= "" then
						-- ctor 源码
						local memDefs = compileFuncCode(filePath,ctorSrc,className,ctorLines,ctorBeginLine-1);
						for _,v in ipairs(memDefs) do
							table.insert(ctorSelfMemDef, v);
						end
					end
				end
				--if funcName == "ctor" or funcName == "_ctor" then
					isCtor = true
					ctorSrc = templine
					ctorLines = {}
					table.insert(ctorLines, templine);
					ctorBeginLine = _lineno;
				--end
			end

			_lineno = _lineno+1;
			commentDefs = nil;
		elseif getClassDefine(templine) ~= nil then
			if isCtor then
				isCtor = false;
				if ctorSrc ~= "" then
					-- ctor 源码
					local memDefs = compileFuncCode(filePath,ctorSrc,className,ctorLines,ctorBeginLine-1);
					for _,v in ipairs(memDefs) do
						table.insert(ctorSelfMemDef, v);
					end
				end
			end

			local className,aliasName = getClassDefine(templine);
			local baseName = getBaseClass(templine);
			if baseName == nil then
				baseName = ""
			end
			table.insert(classDefines, {cname=className,lineno=_lineno-1,baseName=baseName,aname=aliasName});

			_lineno = _lineno+1;
			commentDefs = nil
		else
			if isCtor then
				local s1 = templine:sub(templine:len(),-1):byte();
				if s1 ~= 10 then
					templine = templine.."\r\n";
				end
				ctorSrc = ctorSrc..templine;
				table.insert(ctorLines, templine);
			end

			_lineno = _lineno+1;
			commentDefs = nil;
		end
	end

	addDynamicAPI(filePath, tempFunctions, ctorSelfMemDef, classDefines, logflag);

	if editor == GetEditor() then
		ClassFunctions = tempFunctions
		ShowFileFunctionList(editor);
	end
end

LastKeyMatchLine = nil

-- 编辑页面鼠标按下事件
function PkgSelectKey(editor, pos, jumpFlag)
	local luaKeyMatch = {}
	luaKeyMatch["for"] = {
		endKeys={{"do",0},{"end",1}}
	}
	luaKeyMatch["if"] = {
		endKeys = {{"elseif",1},{"then",1},{"else",1},{"end",1}}
	}
	luaKeyMatch["then"] = {
		endKeys = {{"elseif",1},{"else",1},{"end",1}}
	}
	luaKeyMatch["else"] = {
		endKeys = {{"end",0}}
	}
	luaKeyMatch["elseif"] = {
		endKeys = {{"elseif",0},{"else",0},{"end",0}}
	}
	luaKeyMatch["function"] = {
		endKeys = {{"end",1}}
	}
	luaKeyMatch["while"] = {
		endKeys = {{"end",1}}
	}
	luaKeyMatch["do"] = {
		endKeys = {{"end",1}}
	}

	local function getEndKeys(wdKey, lineText)
		if wdKey == "then" and lineText:find("^%s*elseif%s+") then
			-- if xxx then
			local keys = luaKeyMatch[wdKey].endKeys;
			local tempKeys = {}
			for k,v in pairs(keys) do
				table.insert(tempKeys, {v[1], v[2]-1});
			end

			return tempKeys;
		end

		return luaKeyMatch[wdKey].endKeys;
	end

	local insts = {}
	local wd = GetWordByPosition(editor, pos, true);
	if nil ~= wd and luaKeyMatch[wd] then
		local line = editor:LineFromPosition(pos)
		local lineCount = editor:GetLineCount()
		local foldLv = editor:GetFoldLevel(line)%4096

		-- 终结关键字
		local endKeys = getEndKeys(wd, editor:GetLine(line));

		local matchLines = {}
		for k=line+1,lineCount-1,1 do
			local tempLv = editor:GetFoldLevel(k)%4096
			local matchKeyIndex = nil
			local lineText = editor:GetLine(k);
			for kk,v in pairs(endKeys) do
				if foldLv+v[2] == tempLv and lineText:find("^%s*"..v[1].."%s+") then
					table.insert(matchLines, {k,v[1]});
					matchKeyIndex = kk;
					break;
				end
			end

			if matchKeyIndex ~= nil and  matchKeyIndex == #endKeys then
				break;
			end
		end

		if #matchLines > 0 then
			local fPos = editor:WordStartPosition(pos, false);
			editor:ClearSelections()
			editor:SetSelection(fPos, fPos+#wd)
			editor:SetMainSelection(0);
		end

		for _,v in pairs(matchLines) do
			local lineText = editor:GetLine(v[1]);
			local posb = lineText:find(v[2]);
			if posb then
				local lposb = editor:PositionFromLine(v[1])+posb-1;
				editor:AddSelection(lposb+#v[2], lposb)
			end
		end

		if #matchLines > 0 and jumpFlag then
			editor:SetMainSelection(1);
		elseif #matchLines > 0 then
			editor:SetMainSelection(0);
		end
	end
end

function GetValAllAtLine(linetx, localpos, sep)
	local lt = linetx:sub(1,localpos)

	lt = lt:gsub("%s*(["..sep.."])%s*", "%1")
	-- strip closed brace scopes
	lt = lt:gsub("%b()","")
	lt = lt:gsub("%b{}","")
	lt = lt:gsub("%b[]","")

	local templt = lt:reverse();
	local q = EscapeMagic
	local exprstr = templt:match("^([%s%w_"..q(sep).."]+)");
	if exprstr == nil or exprstr:find("^%s*$") then
		return nil,nil
	end
	exprstr = stringDelTowEndSpace(exprstr);
	exprstr = exprstr:gsub("%s+:", ":");
	exprstr = exprstr:gsub(":%s+", ":");
	exprstr = exprstr:gsub("%s+%.", ".");
	exprstr = exprstr:gsub("%.%s+", ".");
	exprstr = exprstr:gsub("%(%s+", "(");
	exprstr = exprstr:gsub("%s+%(", "(");
	exprstr = exprstr:match("^[%w_%.:%(]+");
	exprstr = exprstr:reverse();
	local right, funccall = linetx:sub(localpos+1,#linetx):match("^([a-zA-Z_0-9]*)%s*([%(]?)")
	if right then
		exprstr = exprstr..right;
	end

	return exprstr, funccall;
end

function GetValAllAtPosition(editor, pos, logflag)
	if editor:GetCharAt(pos-1) == ("("):byte() then
		pos = pos-1;
	end

	local line = editor:GetCurrentLine()
	local linetx = editor:GetLine(line)
	local linestart = editor:PositionFromLine(line)
	local localpos = pos-linestart

	return GetValAllAtLine(linetx, localpos, editor.spec.sep)
end

-------------------------------------------------------
-- @class function
-- @name getIfReadMember
-- @description 获取if分支的读取成员
-- @param nil:ast
-- @return nil:
-- @usage
local function getIfReadMember(ast)
	local readMember = {};
	WalkAst(ast, 10, function(ast, depth)
		if ast.tag == "Set" then
			local firstAst = ast[1][1];
			local secondAst = ast[2][1];
			if firstAst.tag == 'Index' and secondAst.tag == "Call" then
        assert(readMember.memberName == nil and readMember.functionName == nil and readMember.arrayFlag == nil);
				--OutLn("Set call", firstAst[1][1], firstAst[2][1], secondAst[1][1], secondAst[2][1]);
				--readMember.memberName = firstAst[2][1];
				readMember.functionName = secondAst[1][1];
        if firstAst[2][1] ~= "i" then
          readMember.memberName = firstAst[2][1];
          readMember.arrayFlag = false;
        else
          readMember.memberName = firstAst[1][1];
          readMember.arrayFlag = true;
        end
        return true;
			end
		elseif ast.tag == "Call" and ast[1].tag == "Index" then
      assert(readMember.memberName == nil and readMember.functionName == nil and readMember.arrayFlag == nil);
			--OutLn("Call", ast[1][1], ast[1][2], ast[1].tag);
			readMember.functionName = ast[1][2][1];
			for k=2, 10 do
			  if ast[k] and ast[k].tag == "Index" then
          --OutLn("Call params: ", readMember.functionName, ast[k], ast[k][1][1], ast[k][2][1]);
          if ast[k][2][1] ~= "i" then
            readMember.memberName = ast[k][2][1];
            readMember.arrayFlag = false;
          else
            readMember.memberName = ast[k][1][1];
            readMember.arrayFlag = true;
          end
          return true;
			  end
			end
		end
  end);

	return readMember;
end

-------------------------------------------------------
-- @class function
-- @name isWriteStruct
-- @description 是否为写协议，有cpp_buff_create函数调用
-- @param nil:ast
-- @return nil:
-- @usage
local function isWriteStruct(ast)
	local isWriteFlag = false;
	WalkAst(ast, 10, function(ast, depth)
		if isWriteFlag then
			return true;
		end
		if ast.tag == "Call" then
			if "cpp_buff_create" == ast[1][1] then
				isWriteFlag = true;
				return true;
			end
		end
    end);

	return isWriteFlag;
end

-------------------------------------------------------
-- @class function
-- @name isReadStruct
-- @description 是否为读取协议，有这一行代码 res._ok = cpp_buff_readShort(pid);
-- @param nil:ast
-- @return nil:
-- @usage
local function isReadStruct(ast)
	local isReadFlag = false;
	WalkAst(ast, 10, function(ast, depth)
		if isReadFlag then
			return true;
		end
		if ast.tag == "Set" then
			local firstAst = ast[1][1];
			local secondAst = ast[2][1];
			if firstAst.tag == 'Index' and secondAst.tag == "Call" then
				if firstAst[1].tag == 'Id' and ((firstAst[1][1] == "res" and firstAst[2][1] == "_ok")
					or (firstAst[1][1] == "event" and firstAst[2][1] == "_ok"))then
					isReadFlag = true;
					return true;
				end
			end
		end
  end);

  return isReadFlag;
end

-------------------------------------------------------
-- @class function
-- @name isReadBeanStruct
-- @description 是否为写协议，函数名是否为XXXReader
-- @param nil:ast
-- @return nil:
-- @usage
local function isReadBeanStruct(ast)
	local isReadBeanFlag = false;
	WalkAst(ast, 10, function(ast, depth)
		if isReadBeanFlag then
			return true;
		end
    if ast.tag == "Set" then
      local firstAst = ast[1][1];
			local secondAst = ast[2][1];
      if firstAst.tag == "Index" and secondAst.tag == "Function" then
        if string.find(firstAst[2][1], "[%w%d]+Reader") ~= nil then
          isReadBeanFlag = true;
          return true;
        end
      end
    end
  end);

	return isReadBeanFlag;
end

-------------------------------------------------------
-- @class function
-- @name getWriteStructSet
-- @description 获取写入成员
-- @param nil:ast
-- @return nil:
-- @usage
local function getWriteStructSet(ast)
	local writeFunctions = {}
	writeFunctions["cpp_buff_create"] = {"", false};
	writeFunctions["cpp_buff_encode"] = {"", false};

	writeFunctions["cpp_buff_writeBoolean"] = {"uint8", true};
	writeFunctions["cpp_buff_writeShort"] = {"sint16", true};
	writeFunctions["cpp_buff_writeInt"] = {"sint32", true};
	writeFunctions["cpp_buff_writeLong"] = {"sint32", true};
	writeFunctions["cpp_buff_writeString"] = {"TCharArray2", true};

	local members = {};
	local addMember = false;
	WalkAst(ast, 10, function(ast, depth)
		if ast.tag == "Call" then
			local funName = ast[1][1];
			if addMember then
				if writeFunctions[funName][2] then
					assert(ast[3].tag == "Id" or ast[3].tag == "Number" or ast[3].tag == "String");
					table.insert(members, {writeFunctions[funName][1], ast[3][1]});
					--OutLn("Member: ", writeFunctions[funName][1], ast[3][1]);
				end
			elseif "cpp_buff_create" == funName then
				assert(addMember == false);
				addMember = true;
			else
				assert(false);
			end
		elseif ast.tag == "If" then
			local ifname = ast[1][2][1];
			assert(addMember == true);
			if addMember then
				table.insert(members, {"uint8", ifname.."Flag"});
				table.insert(members, {"TCharArray2", ifname});
				--OutLn("Member: ", TCharArray2, ifname);
			end
			return true;
		end
	end);

	return members;
end

-------------------------------------------------------
-- @class function
-- @name getReadStructSet
-- @description 获取读取成员
-- @param nil:ast
-- @return nil:
-- @usage
-- 		res._ok = cpp_buff_readShort(pid);
--		if cpp_buff_readBoolean(pid) then
--			res._errorMsg = cpp_buff_readString(pid)
--		end
--		if cpp_buff_readBoolean(pid) then ===== 结构体的读写
local function getReadStructSet(ast)
	local readFunctions = {}
	readFunctions["cpp_buff_readBoolean"] = {"uint8", true};
	readFunctions["cpp_buff_readShort"] = {"sint16", true};
	readFunctions["cpp_buff_readInt"] = {"sint32", true};
	readFunctions["cpp_buff_readLong"] = {"sint32", true};
	readFunctions["cpp_buff_readString"] = {"TCharArray2", true};

	local members = {};
	local addMember = false;

	WalkAst(ast, 10, function(ast, depth)
		if ast.tag == "Set" then
			local firstAst = ast[1][1];
			local secondAst = ast[2][1];
			if firstAst.tag == 'Index' and secondAst.tag == "Call" then
				if addMember then
					if firstAst[1].tag == 'Id' then
						local funcName = secondAst[1][1];
						table.insert(members, {readFunctions[funcName][1],  firstAst[2][1]});
						--OutLn(firstAst[1][1], firstAst[2][1], secondAst[1][1], secondAst[2][1]);
					end
				elseif firstAst[1].tag == 'Id' and ((firstAst[1][1] == "res" and firstAst[2][1] == "_ok")
					or (firstAst[1][1] == "event" and firstAst[2][1] == "_ok")) then
					addMember = true;
				else
					assert(false);
				end
			end
		elseif ast.tag == "If" then
			assert(addMember == true);
			local member = getIfReadMember(ast[2]);
			local types = nil;
			if readFunctions[member.functionName] ~= nil then
				types = readFunctions[member.functionName][1];
			else
				types = member.functionName;
			end
			table.insert(members, {"uint8", member.memberName.."Flag"});
			if member.arrayFlag then
			  table.insert(members, {"CArray2<"..types..">", member.memberName});
			else
			  table.insert(members, {types, member.memberName});
			end
			--OutLn("Member:"..member.memberName, "Function:"..member.functionName);
			return true;
		end
	end);

	return members;
end

-------------------------------------------------------
-- @class function
-- @name getReadBeanStructSet
-- @description 获取读取成员
-- @param nil:ast
-- @return nil:
-- @usage
local function getReadBeanStructSet(ast)
  local readFunctions = {}
	readFunctions["cpp_buff_readBoolean"] = {"uint8", true};
	readFunctions["cpp_buff_readShort"] = {"sint16", true};
	readFunctions["cpp_buff_readInt"] = {"sint32", true};
	readFunctions["cpp_buff_readLong"] = {"sint32", true};
	readFunctions["cpp_buff_readString"] = {"TCharArray2", true};

	local members = {};
	local addMember = true;

	WalkAst(ast, 10, function(ast, depth)
		if ast.tag == "Set" then
			local firstAst = ast[1][1];
			local secondAst = ast[2][1];
			if firstAst.tag == 'Index' and secondAst.tag == "Call" then
				if addMember then
					if firstAst[1].tag == 'Id' then
						local funcName = secondAst[1][1];
						table.insert(members, {readFunctions[funcName][1],  firstAst[2][1]});
						--OutLn(firstAst[1][1], firstAst[2][1], secondAst[1][1], secondAst[2][1]);
					end
--				elseif firstAst[1].tag == 'Id' and ((firstAst[1][1] == "res" and firstAst[2][1] == "_ok")
--					or (firstAst[1][1] == "event" and firstAst[2][1] == "_ok")) then
--					addMember = true;
--				else
--					assert(false);
				end
			end
		elseif ast.tag == "If" then
			assert(addMember == true);
			local member = getIfReadMember(ast[2]);
			local types = nil;
			if readFunctions[member.functionName] ~= nil then
				types = readFunctions[member.functionName][1];
			else
				types = member.functionName;
			end
			table.insert(members, {"uint8", member.memberName.."Flag"});
			if member.arrayFlag then
				table.insert(members, {"CArray2<"..types..">", member.memberName});
			else
				table.insert(members, {types, member.memberName});
			end
			--OutLn("Member:"..member.memberName, "Function:"..member.functionName);
			return true;
		end
	end);

	return members;
end

function getStructSet(ast)

	if isReadStruct(ast) then
		return getReadStructSet(ast), 1;
	end

	if isWriteStruct(ast) then
		return getWriteStructSet(ast), 2;
	end

  if isReadBeanStruct(ast) then
    return getReadBeanStructSet(ast), 3;
  end

	return {}, 0;
end

function PkgToType2(editor, pos)
	local line = editor:GetCurrentLine()
	local linetx = editor:GetLine(line)
	local linestart = editor:PositionFromLine(line)
	local localpos = pos-linestart
	local linetxtopos = linetx:sub(1,localpos)

	local var, funccall = GetValAllAtPosition(editor, pos, true)
	local exprtx = var
	if exprtx then
		editor.assignscache = false;

		UpdateAssignCache(editor, true)
		local keytx = exprtx..":"
		local tab,mtab,rest = ResolveAssign(editor, keytx, not keytx:find("[:.]$"), false)

		if tab then
			-- if this is a value type rather than a function/method call, then use
			-- full match to avoid calltip about coroutine.status for "status" vars
			_,lineinfo = GetTipInfo(editor, tab.classname, false, true, pos, true)
			if lineinfo and lineinfo.fileName then
				table.insert(AllJumpStack, {fileName=GetEditorPath(editor),lineno=pos});
				GotoFileLine(lineinfo.fileName, lineinfo.lineno, localpos);
				return false
			end
		end
	end
end

function PkgToType(editor, pos)
	local line = editor:GetCurrentLine()
	local linetx = editor:GetLine(line)
	local linestart = editor:PositionFromLine(line)
	local localpos = pos-linestart
	local linetxtopos = linetx:sub(1,localpos)

	local var, funccall = GetValAllAtPosition(editor, pos, true)
	local exprtx = var
	if exprtx then
		editor.assignscache = false;
		-- if this is a value type rather than a function/method call, then use
		-- full match to avoid calltip about coroutine.status for "status" vars
		_,lineinfo = GetTipInfo(editor, exprtx, false, true, pos, true)
		if lineinfo and lineinfo.fileName then
			table.insert(AllJumpStack, {fileName=GetEditorPath(editor),lineno=pos});
			GotoFileLine(lineinfo.fileName, lineinfo.lineno, localpos);
			return false
		end
	end

	return true
end

function PkgToDefine(editor, pos)
	local value = pos ~= wxstc.wxSTC_INVALID_POSITION and GetValAtPosition(editor, pos, false) or nil
	local instances = value and IndicateFindInstances(editor, value, pos+1)
	if instances and instances[0] and value then
		NavigateToPosition(editor, pos, instances[0]-1, #value)
		return false
	else
		return PkgToType(editor, pos)
	end

	return true
end

-- 编辑器按下事件
function P:onEditorKeyDown(editor, event)
	local keycode = event:GetKeyCode()
	local mod = event:GetModifiers()

	if mod == wx.wxMOD_ALT and keycode == string.byte("G") then
		if not PkgToDefine(editor, editor:GetCurrentPos()) then
			return false
		end
	end

	if mod == wx.wxMOD_ALT and keycode == string.byte("A") then
		if not PkgToType2(editor, editor:GetCurrentPos()) then
			return false
		end
	end

	if mod == wx.wxMOD_ALT and keycode == string.byte("T") then
		--compileFile("E:/work/project/code/trunk/shenglqs/server/tools/ZeroBraneStudio/tt.lua");
		--local res, lineinfo = GetTipInfo(editor, "CreateAutoCompList(", false, true, editor:GetCurrentPos(), true)
		--OutLn(lineinfo,res);
		--OutLn(editor.api.tip.lineinfo.Sample.Test1);
		--[[
		OutLn("Test:", _getclassall(editor.api.ac, {"Sample", "obj", "test1"}, 1, 3));
		OutLn("Test:", editor.api.ac, _getclassall(editor.api.ac, {"Sampl",}, 1, 0));
		--for k,v in pairs(editor.api.ac.childs["Test"].childs) do
		--	OutLn(k,v);
		--end
		OutLn("Test3:", editor.api.ac, _getclassall(editor.api.ac, {"MapPlayerHandler","spRole",}, 1, 2, true));
		OutLn("Test4:", editor.api.ac.childs.MapPlayerHandler.childs.spRole);
		local assigns = PkgTypeAssigns(editor);
		for k,v in pairs(assigns) do
			OutLn(k, v);
		end
		]]
		--for k,v in pairs(editor.api.ac.childs.Role.childs) do
		--	OutLn(k,v);
		--end

		--compileFile(GetEditorPath(editor), true);
		--OutLn(editor.api.ac.childs.CRole.childs.setHummanDBBuffer);
		--OutLn(editor.api.ac.childs.CRole.childs.toRoleString);
--		for k,v in pairs(editor.api.tip.keys) do
--			OutLn(k,v);
--		end
--		OutLn(editor.api.tip.keys["do"]);
		--GetValAllAtPosition(editor, editor:GetCurrentPos(), true);
		--PkgTypeAssigns(editor, true);
		--OutLn(editor.api.ac.childs.CMServerHelper.childs.LuaGetRole);
		--OutLn(.childs["ctor"]);
		--for k,v in pairs(editor.api.ac.childs["Test.Person"].childs) do
		--	OutLn(k,v);
		--end
		--OutLn("Test:", editor.api.ac, _getclassall(editor.api.ac, {"Test", "Person"}, 1, 0, true));
		local pos = editor:GetCurrentPos()
		local lt = GetValAllAtPosition(editor, pos);
		if lt ~= nil then
			OutLn(lt)
			lt = PkgToSelfCall(editor, lt, pos);

		end
		return false;
	end
	if mod == wx.wxMOD_ALT and keycode == string.byte("D") then
		--editor:InsertText(insertPos, "\r\n-- @param nil:"..stringDelTowEndSpace(kp).." ");
		local pos = editor:PositionFromLine(editor:GetCurrentLine());
		local indent = editor:GetLineIndentation(editor:GetCurrentLine());
		editor:InsertText(pos, "--! \r\n");
		local stopPos = editor:PositionFromLine(editor:GetCurrentLine()-1)+4;
		editor:GotoPosEnforcePolicy(stopPos)
		if not ide:GetEditorWithFocus(editor) then ide:GetDocument(editor):SetActive() end
		editor:SetLineIndentation(editor:GetCurrentLine(), indent);
	end

	if event:ShiftDown() and event:ControlDown() and keycode == string.byte("C") then
		-- 插入注释
		local line = editor:GetCurrentLine();
		local lineCount = editor:GetLineCount();
		local commentType = 'none' -- 注释类型(function|class)
		local targetLine = line;
		-- 自动识别下一非空行的代码格式
		local cname = nil
		local fname = nil
		local paramlist = {}
		for kl=line,line+10,1 do
			if kl > lineCount then
				break;
			end
			local lineText = editor:GetLine(kl);
			if not isEmptyCharLine(lineText) then
				cname = getClassDefine(lineText)
				if cname == nil then
					local paramstr = nil
					cname, fname, paramstr = getFunctionDefine(lineText);
					if fname ~= nil then
						commentType = 'function';
						if paramstr ~= "" then
							paramlist = stringSplit(paramstr, ',');
						end
					end
				else
					commentType = 'class'
				end
				targetLine = kl-1;
				break;
			end
		end

		self:InsertCodeFragment(editor, editor:PositionFromLine(targetLine), "__comment", false);
		local lineText = editor:GetLine(targetLine);
		if lineText:find("^%-%-+\r\n$") then
			local stopAtLastLine = targetLine+1;
			-- @class
			lineText = editor:GetLine(targetLine+1);
			if lineText:find("^%-%-%s*@%s*class%s*") == nil then
				return false;
			end
			if commentType ~= nil then
				editor:SetSelection(editor:PositionFromLine(targetLine+1),editor:GetLineEndPosition(targetLine+1))
				editor:TargetFromSelection()
				editor:ReplaceTarget("-- @class "..commentType);
				stopAtLastLine = targetLine+2;
			end

			-- @name
			lineText = editor:GetLine(targetLine+2);
			if lineText:find("^%-%-%s*@%s*name%s*") == nil then
				return false;
			end
			if commentType ~= nil then
				editor:SetSelection(editor:PositionFromLine(targetLine+2),editor:GetLineEndPosition(targetLine+2))
				editor:TargetFromSelection()
				if commentType == 'function' then
					if cname ~= nil then
						editor:ReplaceTarget("-- @name "..cname..":"..fname);
					else
						editor:ReplaceTarget("-- @name "..fname);
					end
				elseif commentType == 'class' then
					editor:ReplaceTarget("-- @name "..cname);
				else
					editor:ReplaceTarget("-- @name __undefine");
				end
				stopAtLastLine = targetLine+3;
			end

			-- @param
			local insertPos = nil;
			local insertLine = targetLine+3;
			ide:GetDocument(editor):SetActive()
			for _, kp in ipairs(paramlist) do
				insertPos = editor:GetLineEndPosition(insertLine);
				editor:InsertText(insertPos, "\r\n-- @param nil:"..stringDelTowEndSpace(kp).." ");
				insertLine = insertLine+1;
			end

			editor:GotoPosEnforcePolicy(editor:GetLineEndPosition(stopAtLastLine))
			if not ide:GetEditorWithFocus(editor) then ide:GetDocument(editor):SetActive() end
		end

		return false;
	end

	if editor:GetSelections() > 1 and doubleClickFlag then
		-- 双击选择模式, 如果无ctrl按下的双击则取消其他的多选择
		local caret = editor:GetSelectionNCaret(editor:GetMainSelection());
		local anchor = editor:GetSelectionNAnchor(editor:GetMainSelection());
		editor:ClearSelections();
		editor:SetSelection(anchor, caret);
		doubleClickFlag = false;
	end

	if self:AutoCodeFragment(editor,event) == false then
		-- table键自动补全代码
		return false;
	end

	return true;
end

function PkgToSelfCallC(lt, className, needCheck)
	if needCheck then
		if not IsSelfCall(lt) then
			return lt
		end
	end

	return lt:gsub("^%s*self",className)
end

-- 将self.xxx转换成类调用的形式
function PkgToSelfCall(editor, lt, pos)
	if IsSelfCall(lt) then
		if not pos then
			pos = editor:GetCurrentPos();
		end
		local className = GetClassNameByPos(editor, pos, false);
		if nil ~= className then
			return PkgToSelfCallC(lt, className)
		end
	end

	return lt;
end

-- 编辑器自动完成事件
function P:onEditorAutoComplete(editor)
	local pos = editor:GetCurrentPos();

	local style = pos >= 2 and bit.band(editor:GetStyleAt(pos-2),31) or 0;
	if editor.spec.iscomment[style] then
		-- 注释里的自动完成
		local lineText = editor:GetLine(editor:GetCurrentLine());
		if lineText:find("%-%-%s*@") then
			local commenttags = {"usage", "class", "name", "description",
				"filed", "param", "see", "author", "return"};
			local userList = {};
			if editor:GetCharAt(pos-1) == string.byte('@') then
				userList = commenttags;
			else
				local wd = GetWordByPosition(editor,pos);
				if wd then
					for _,vc in ipairs(commenttags) do
						if vc:find("^"..wd) then
							table.insert(userList, vc);
						end
					end
				end
			end
			if #userList > 0 then
				editor:UserListShow(1, table.concat(userList, " "));
			else
				if editor:AutoCompActive() then
					editor:AutoCompCancel()
				end
			end
			return false;
		end
	end

	return true;
end

-- 编辑器字符添加事件
P.onEditorCharAdded = function(self, editor, event)
	return true;
end

-- 编辑页面被选中
function P:onEditorSelected(editor)
	local editorPath = GetEditorPath(editor);
	if editorPath ~= nil then
		if lastCompilerFileName == editorPath then
			return true;
		end

		compileFile(editorPath);
		lastCompilerFileName = editorPath
		waitCompileFileList[editorPath] = nil;
	end

  return true
end

-- 编辑页面失去焦点
--[[
function P:onEditorFocusLost(editor)
	local editorPath = GetEditorPath(editor);
	if editorPath ~= nil then
		waitCompileFileList[editorPath] = true;
	end
end
]]

-- 编辑页面修改事件
function P:onEditorModified(editor)
	local editorPath = GetEditorPath(editor);
	if editorPath ~= nil then
		waitCompileFileList[editorPath] = true;
	end
end

-- 编辑器加载事件
function P:onAppLoad(ide)
  compileTimer = wx.wxTimer(ide.frame);
  ide.frame:Connect(wx.wxEVT_TIMER,
  function (event)
		local nilVals = {}
		local waitCompileFile = {}
		local fileCount = 0
		for k,v in pairs(waitCompileFileList) do
			if v == true then
				if #waitCompileFile < 5 then
					table.insert(waitCompileFile,k);
				end
				fileCount = fileCount+1
			end
		end

		if #waitCompileFile > 0 then
			for _,v in pairs(waitCompileFile) do
				compileFile(v);
				waitCompileFileList[v] = nil;
				lastCompilerFileName = v;
			end
		end

		if fileCount > 2 then
			-- 高速解析源码
			if compileTimer:GetInterval() > 100 then
				compileTimer:Stop();
				compileTimer:Start(100);
			end
		else
			-- 低速解析源码
			if compileTimer:GetInterval() < 5000 then
				compileTimer:Stop();
				compileTimer:Start(5000);
			end
		end
  end)

  compileTimer:Start(2000, true);
end

-- 工具调试事件
function P:onPojectDebug(ide)
  if GetEditor() == nil then
	  OutLn("Please open least one file to debug!!!");
	  return false
  end

  if ide.interpreter ~= nil and ide.interpreter.getEntryPoint ~=nil then
		local wkd = ide.interpreter:fworkdir(GetNameToRun(true));
		local entryFile = ide.interpreter:getEntryPoint(wkd);
	  if entryFile ~= nil then
        LoadFile(entryFile,nil,true);
    end
  end

	return true;
end

-- 工程加载前事件
function P:onProjectPreLoad(project)
end

-- 工程加载后事件
function P:onProjectLoad(project)
	local files = FileSysGetRecursive(project, true, "*.lua");
	for k,v in pairs(files) do
		waitCompileFileList[v] = true;
		--compileFile(v);
	end

--	OutLn("Project:", ide:GetProject());
--compileFile("E:/work/project/code/trunk/shenglqs/server/tools/ZeroBraneStudio/src/editor/editor.lua");
--compileFile("E:/work/project/code/trunk/shenglqs/server/tools/ZeroBraneStudio/src/editor/autocomplete.lua");
	AllJumpStack = {}
end

-- 工程关闭事件
function P:onProjectClose(project)
end

return P
