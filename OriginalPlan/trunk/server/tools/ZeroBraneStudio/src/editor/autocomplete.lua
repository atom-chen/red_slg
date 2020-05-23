-- Copyright 2011-15 Paul Kulchenko, ZeroBrane LLC
-- authors: Luxinia Dev (Eike Decker & Christoph Kubisch)
---------------------------------------------------------

local ide = ide
local q = EscapeMagic

-- api loading depends on Lua interpreter
-- and loaded specs

------------
-- API

local function newAPI(api)
  api = api or {}
  for i in pairs(api) do
    api[i] = nil
  end
  -- tool tip info and reserved names
  api.tip = {
    staticnames = {},
    keys = {},
    finfo = {},
    finfoclass = {},
    shortfinfo = {},
    shortfinfoclass = {},
		lineinfo = {},
  }
  -- autocomplete hierarchy
  api.ac = {
    childs = {},
  }

  return api
end

local apis = {
  none = newAPI(),
  lua = newAPI(),
}

function GetApi(apitype) return apis[apitype] or apis.none end

----------
-- API loading
-- gen complete class name
local function gennames(tab, prefix, parenttab)
  for i,v in pairs(tab) do
    v.classname = (prefix and (prefix..".") or "")..i
		v.parent = parenttab;
    if (v.childs) then
      gennames(v.childs,v.classname, v)
    end
  end
end

local function clone(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for key, value in pairs(object) do
            new_table[_copy(key)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

local function addAPI(ftype, fname, clearflag, logflag) -- relative to API directory
  local env = apis[ftype] or newAPI()
  local api = ide.apis[ftype][fname];

	local res
  if type(api) == 'table' then
    res = api
  else
    local fn, err = loadfile(api)
    if err then
      DisplayOutputLn(TR("Error while loading API file: %s"):format(err))
      return
    end
    local suc
    suc, res = pcall(function() return fn(env.ac.childs) end)
    if (not suc) then
      DisplayOutputLn(TR("Error while processing API file: %s"):format(res))
      return
    end
    -- cache the result
    ide.apis[ftype][fname] = res
  end
  apis[ftype] = env
  gennames(res, nil, nil)
	local allapis = {childs = {}}

  for i,v in pairs(res) do
		local ccs = v.childs;
		if env.ac.childs[i] == nil and not clearflag then
			env.ac.childs[i] = {};
			for kc,vc in pairs(v) do
			  if type(vc) ~= "table" then
			    env.ac.childs[i][kc] = vc;
			  end
			end
			env.ac.childs[i].childs = {}
		end

		if ccs and env.ac.childs[i] then
			local cc = env.ac.childs[i].childs;
			if cc then
				for kc,vc in pairs(ccs) do
					if clearflag then
						cc[kc] = nil;
					else
						cc[kc] = vc;
					end
				end
			end
		else
			if clearflag then
				if not v.childs and (env.ac.childs[i] and not env.ac.childs[i].childs) then
					env.ac.childs[i] = nil;
				end
			else
				env.ac.childs[i] = v;
			end
		end
		allapis.childs[i] = v;
	end

	return allapis;
end

local function loadallAPIs(only, subapis, known)
  for ftype, v in pairs(only and {[only] = ide.apis[only]} or ide.apis) do
    if apis[ftype] ~= nil then
			apis[ftype].ac.childs = {}
    end
    if (not known or known[ftype]) then
      for fname in pairs(v) do
        if (not subapis or subapis[fname]) then addAPI(ftype, fname) end
      end
    end
  end
end

local function scanAPIs()
  for _, file in ipairs(FileSysGetRecursive("api", true, "*.lua")) do
    if not IsDirectory(file) then
      local ftype, fname = file:match("api[/\\]([^/\\]+)[/\\](.*)%.")
      if not ftype or not fname then
        DisplayOutputLn(TR("The API file must be located in a subdirectory of the API directory."))
        return
      end
      ide.apis[ftype] = ide.apis[ftype] or {}
      ide.apis[ftype][fname] = file
    end
  end
end

---------
-- ToolTip and reserved words list
-- also fixes function descriptions

local function fillTips(ac, tip, apibasename, clearflag)
  --local apiac = api.ac
  --local tclass = api.tip
  local apiac = ac
  local tclass = tip
--  tclass.staticnames = {}
--  tclass.keys = {}
--  tclass.finfo = {}
--  tclass.finfoclass = {}
--  tclass.shortfinfo = {}
--  tclass.shortfinfoclass = {}
--	tclass.lineinfo = {}

  local staticnames = tclass.staticnames
  local keys = tclass.keys
  local finfo = tclass.finfo
  local finfoclass = tclass.finfoclass
  local shortfinfo = tclass.shortfinfo
  local shortfinfoclass = tclass.shortfinfoclass
	local lineinfo = tclass.lineinfo

  local function traverse (tab, libname, format)
    if not tab.childs then return end
    format = tab.format or format
    for key,info in pairs(tab.childs) do
      local fullkey = (libname ~= "" and libname.."." or "")..key
      traverse(info, fullkey, format)

      if info.type == "function" or info.type == "method" or info.type == "value" then
				local frontname = nil
				local description = nil
				local inf = nil
				local sentence = nil
				local infshort = nil
				local infshortbatch = nil
				if clearflag == nil then
					frontname = (info.returns or "(?)").." "..fullkey.." "..(info.args or "(?)")
					frontname = frontname:gsub("\n"," "):gsub("\t","")
					description = info.description or ""

					-- build info
					--inf = ((info.type == "value" and "" or frontname.."\n")..description)
					--sentence = description:match("^(.-)%. ?\n")
          inf = (frontname.."\n"..description)
					sentence = description:match("^(.-)%. ?\n")
					--infshort = ((info.type == "value" and "" or frontname.."\n")
					--	..(sentence and sentence.."..." or description))
          infshort = (frontname.."\n"..(sentence and sentence.."..." or description))
					infshortbatch = (info.returns and info.args) and frontname or infshort
				end

        -- add to infoclass
        if not finfoclass[libname] then finfoclass[libname] = {} end
        if not shortfinfoclass[libname] then shortfinfoclass[libname] = {} end
				if clearflag == nil then
					finfoclass[libname][key] = inf
					shortfinfoclass[libname][key] = infshort
				else
					finfoclass[libname][key] = nil
					shortfinfoclass[libname][key] = nil
				end

        -- add to info
				if clearflag == nil then
					if not finfo[key] or #finfo[key]<200 then
						if finfo[key] then finfo[key] = finfo[key] .. "\n\n"
						else finfo[key] = "" end
						finfo[key] = finfo[key] .. inf
					elseif not finfo[key]:match("\n %(%.%.%.%)$") then
						finfo[key] = finfo[key].."\n (...)"
					end
				else
					finfo[key] = nil
				end

        -- add to shortinfo
				if clearflag == nil then
					if not shortfinfo[key] or #shortfinfo[key]<200 then
						if shortfinfo[key] then shortfinfo[key] = shortfinfo[key] .. "\n"
						else shortfinfo[key] = "" end
						shortfinfo[key] = shortfinfo[key] .. infshortbatch
					elseif not shortfinfo[key]:match("\n %(%.%.%.%)$") then
						shortfinfo[key] = shortfinfo[key].."\n (...)"
					end
				else
					shortfinfo[key] = nil
				end

				-- add to lineinfo
				local prelibname = libname == "" and "__" or libname
				if not lineinfo[prelibname] then lineinfo[prelibname] = {} end
				if info.fileName and info.lineno then
					if clearflag == nil then
						lineinfo[prelibname][key] = {fileName = info.fileName,lineno = info.lineno}
					else
						lineinfo[prelibname][key] = nil
					end
				end
			elseif info.type == "class" and info.lineno then
				--[[
				local frontname = (info.returns or "(?)").." "..fullkey.." "..(info.args or "(?)")
        frontname = frontname:gsub("\n"," "):gsub("\t","")
        local description = info.description or ""

        -- build info
        local inf = ((info.type == "value" and "" or frontname.."\n")
          ..description)
        local sentence = description:match("^(.-)%. ?\n")
        local infshort = ((info.type == "value" and "" or frontname.."\n")
          ..(sentence and sentence.."..." or description))
        if type(format) == 'function' then -- apply custom formatting if requested
          inf = format(fullkey, info, inf)
          infshort = format(fullkey, info, infshort)
        end
        local infshortbatch = (info.returns and info.args) and frontname or infshort

				-- add to info
        if not finfo[key] or #finfo[key]<200 then
          if finfo[key] then finfo[key] = finfo[key] .. "\n\n"
          else finfo[key] = "" end
          finfo[key] = finfo[key] .. inf
        elseif not finfo[key]:match("\n %(%.%.%.%)$") then
          finfo[key] = finfo[key].."\n (...)"
        end

        -- add to shortinfo
        if not shortfinfo[key] or #shortfinfo[key]<200 then
          if shortfinfo[key] then shortfinfo[key] = shortfinfo[key] .. "\n"
          else shortfinfo[key] = "" end
          shortfinfo[key] = shortfinfo[key] .. infshortbatch
        elseif not shortfinfo[key]:match("\n %(%.%.%.%)$") then
          shortfinfo[key] = shortfinfo[key].."\n (...)"
        end
				]]
				-- add to lineinfo
			if not lineinfo["__"] then lineinfo["__"] = {} end
			lineinfo["__"][key] = {fileName = info.fileName,lineno = info.lineno}
		end
      if info.type == "keyword" then
        keys[key] = true
      end
      staticnames[key] = true
    end
  end
  traverse(apiac,apibasename)
end

-- reload modify file apis
function ReloadDyncAPI(ftype, fileName, tempApis)
	local ac = nil
	-- clear all exist apis
	if ide.apis[ftype][fileName] ~= nil then
	  ac = addAPI(ftype, fileName, true, true);
	  fillTips(ac, apis[ftype].tip, "", true);
	end

	-- fill new apis
	ide:AddAPI(ftype, fileName, tempApis);
	local existflag = false
	for k,v in pairs(ide.interpreter.api) do
		if v == fileName then
			existflag = true;
			break;
		end
	end
	if not existflag then
		table.insert(ide.interpreter.api, fileName)
	end
	ac = addAPI(ftype, fileName, false)
	fillTips(ac, apis[ftype].tip, "");
end

local function generateAPIInfo(only)
  for i,api in pairs(apis) do
    if ((not only) or i == only) then
      fillTips(api.ac,api.tip,"")
    end
  end
end

function UpdateAssignCache(editor, logflag)
  if (editor.spec.typeassigns and not editor.assignscache) then
    --local assigns = editor.spec.typeassigns(editor)
    local assigns = PkgTypeAssigns(editor, logflag)
    editor.assignscache = {
      assigns = assigns,
      line = editor:GetCurrentLine(),
    }
  end
end

local function matchlast(expr)
  local matchwds = {}
	for k in expr:gmatch("([%w_]+)[:%.]*") do
		table.insert(matchwds, k);
	end

	return matchwds;
end

  -- assumes a tidied up string (no spaces, braces..)
local function resolveAssign(editor,tx,lastrest,logflag)
	local ac = editor.api.ac
	local sep = editor.spec.sep
	local anysep = "["..q(sep).."]"
	local assigns = editor.assignscache and editor.assignscache.assigns
	
	local maxDepth = 10
	local function getclassall(tab, wds, idx, maxidx, logflag, depth)
		if depth > maxDepth then
			return
		end

		if idx > maxidx then
			if tab.valuetype and not tab.valuetype:find("^%s*$") and ac.childs[tab.valuetype] then
				return ac.childs[tab.valuetype], tab;
			end
			return tab, tab;
		end
		local rtab = nil
		local mtab = nil
		-- tab.a
		if tab.childs and tab.childs[wds[idx]] then
			rtab, mtab = getclassall(tab.childs[wds[idx]], wds, idx+1, maxidx, logflag, depth+1);
		end

		-- process valuetype, but only if it doesn't reference the current tab
		local acv = ac.childs[tab.valuetype];
		if not rtab and tab.valuetype and not tab.valuetype:find("^%s*$") and tab ~= acv and acv then
			rtab, mtab = getclassall(acv, wds, idx, maxidx, logflag, depth+1)
		end

		if not rtab then
			-- traverse inherits class
			if tab.inherits and not tab.inherits:find("^%s*$") then
				local bases = stringSplit(tab.inherits, " ");
				for k,v in pairs(bases) do
					if not v:find("^%s*$") then
						local acv = ac.childs[v];
						if acv then
							rtab, mtab = getclassall(acv, wds, idx, maxidx, logflag, depth+1)
							if rtab then
								break;
							end
						end
					end
				end
			end
		end

		return rtab, mtab
	end
	_getclassall = getclassall;

	local function getclass(tab,a)
	local key,rest = a:match("([%w_]+)"..anysep.."?(.*)")
	key = tonumber(key) or key -- make this work for childs[0]
		if (key and rest and tab.childs and tab.childs[key]) then
			return getclass(tab.childs[key], rest);
		end
		-- process valuetype, but only if it doesn't reference the current tab
		if tab.valuetype and not tab.valuetype:find("^%s*$") and tab ~= ac.childs[tab.valuetype] then
			return getclass(ac, tab.valuetype..sep:sub(1,1)..a)
		end

		if tab.inherits and not tab.inherits:find("^%s*$") then
			local bases = stringSplit(tab.inherits, " ", false);
			for k,v in pairs(bases) do
				if not v:find("^%s*$") then
					local mtab, ma = getclass(ac.childs[v], a)
					if mtab ~= ac.childs[v] and ma ~= a then
						return mtab, ma
					end
				end
			end
		end

		return tab,a
  end

  local c
  if (assigns) then
    -- find assign
    local change, n, refs, stopat = true, 0, {}, os.clock() + 0.2
    while (change) do
      -- abort the check if the auto-complete is taking too long
      if n > 50 and os.clock() > stopat then
        if ide.config.acandtip.warning then
          DisplayOutputLn("Warning: Auto-complete was aborted after taking too long to complete."
            .. " Please report this warning along with the text you were typing to support@zerobrane.com.")
        end
        break
      else
        n = n + 1
      end

      local classname = nil
      c = ""
      change = false
      for w,s in tx:gmatch("([%w_]+)("..anysep.."?)") do
        local old = classname
        -- check if what we have so far can be matched with a class name
        -- this can happen if it's a reference to a value with a known type
        classname = classname or assigns[c..w]
        --if (s ~= "" and old ~= classname) then
	if (old ~= classname and classname ~= nil ) then
          -- continue checking unless this can lead to recursive substitution
          change = not classname:find("^"..w..anysep) and not classname:find("^"..c..w..anysep)
          c = classname..s
        else
          c = c..w..s
        end
      end
      
      -- check for loops in type assignment
      if refs[tx] then break end
      refs[tx] = c
      tx = c
      -- if there is any class duplication, abort the loop
      if classname and select(2, c:gsub(classname, classname)) > 1 then
        break 
      end
    end
  else
    c = tx
  end
	local wds = matchlast(c);
	local maxidx = #wds
	if maxidx > 0 and c:find("^[%s%w_:%.]+$") then
		-- then work from api
		local tab,mtab = getclassall(ac, wds, 1, lastrest and maxidx-1 or maxidx, logflag, 0)
		return tab,mtab,lastrest and wds[maxidx] or "",c
	end

	return nil, nil, nil, nil
end

function GetTipInfo(editor, content, short, fullmatch, pos, logflag)
  if not content then return end
  content = content:gsub("%s*(["..editor.spec.sep.."])%s*", "%1")
  -- strip closed brace scopes
  content = content:gsub("%b()","")
  content = content:gsub("%b{}","")
  content = content:gsub("%b[]","")
  -- remove everything that can't be auto-completed
  content = content:match("[%w_"..q(editor.spec.sep).."]*$")
  content = PkgToSelfCall(editor, content, pos);
  UpdateAssignCache(editor)

  -- try to resolve the class
  -- not lastrest for full match like a.b.c(, because multiple inheritance make same match like a.b
  local tab,mtab = resolveAssign(editor, content, false, logflag)
  if fullmatch then
    tab = mtab;
  end
  
  local sep = editor.spec.sep
  local anysep = "["..q(sep).."]"
  local caller = content:match("([%w_]+)%s*%(?%s*$")
	-- get parent api
  local class = (tab and tab.parent and tab.parent.classname
    or caller and content:match("([%w_]+)"..anysep..caller.."%s*%(?%s*$") or "")
  local tip = editor.api.tip
  local classtab = short and tip.shortfinfoclass or tip.finfoclass
  local funcstab = short and tip.shortfinfo or tip.finfo
  local linestab = tip.lineinfo

  if (editor.assignscache and not (class and classtab[class])) then
    local assigns = editor.assignscache.assigns
    class = assigns and assigns[class] or class
  end
  local res = nil
	if (caller and class and classtab[class]) then
		res = classtab[class][caller]
	elseif caller then
		res = funcstab[caller]
	end
	local lineinfo = nil
	if (caller and class and linestab[class] and not (class==caller)) then
		lineinfo = linestab[class][caller]
	elseif caller and linestab["__"] then
		lineinfo = linestab["__"][caller]
	end
	if not lineinfo and class and  caller and cppapi then
		local templineinfo = cppapi[class.."::"..caller];
		if templineinfo then
			lineinfo = {}
			lineinfo.lineno = templineinfo.lineno;
			lineinfo.fileName = cppapi.rootpath..templineinfo.filename;
		end
	end

  -- some values may not have descriptions (for example, true/false);
  -- don't return empty strings as they are displayed as empty tooltips.
  return res and #res > 0 and res,lineinfo or nil,nil
end

local function reloadAPI(only,subapis)
  newAPI(apis[only])
  loadallAPIs(only,subapis)
  generateAPIInfo(only)
end

function ReloadLuaAPI()
  local interp = ide.interpreter
  local cfgapi = ide.config.api
  local fname = interp and interp.fname
  local intapi = cfgapi and fname and cfgapi[fname]
  local apinames = {}
  -- general APIs as configured
  for _, v in ipairs(type(cfgapi) == 'table' and cfgapi or {}) do apinames[v] = true end
  -- interpreter-specific APIs as configured
  for _, v in ipairs(type(intapi) == 'table' and intapi or {}) do apinames[v] = true end
  -- interpreter APIs
  for _, v in ipairs(interp and interp.api or {}) do apinames[v] = true end
  reloadAPI("lua",apinames)
end

do
  local known = {}
  for _, spec in pairs(ide.specs) do
    if (spec.apitype) then
      known[spec.apitype] = true
    end
  end
  -- by defaul load every known api except lua
  known.lua = false

  scanAPIs()
  loadallAPIs(nil,nil,known)
  generateAPIInfo()
end

-------------
-- Dynamic Words

local dywordentries = {}
local dynamicwords = {}

local function addDynamicWord (api,word)
  if api.tip.keys[word] or api.tip.staticnames[word] then return end
  local cnt = dywordentries[word]
  if cnt then
    dywordentries[word] = cnt + 1
    return
  end
  dywordentries[word] = 1
  local wlow = word:lower()
  for i=0,#word do
    local k = wlow:sub(1,i)
    dynamicwords[k] = dynamicwords[k] or {}
    table.insert(dynamicwords[k], word)
  end
end
local function removeDynamicWord (api,word)
  if api.tip.keys[word] or api.tip.staticnames[word] then return end
  local cnt = dywordentries[word]
  if not cnt then return end

  if (cnt == 1) then
    dywordentries[word] = nil
    for i=0,#word do
      local wlow = word:lower()
      local k = wlow : sub (1,i)
      local page = dynamicwords[k]
      if page then
        local cnt  = #page
        for n=1,cnt do
          if page[n] == word then
            if cnt == 1 then
              dynamicwords[k] = nil
            else
              table.remove(page,n)
            end
            break
          end
        end
      end
    end
  else
    dywordentries[word] = cnt - 1
  end
end
function DynamicWordsReset ()
  dywordentries = {}
  dynamicwords = {}
end

local function getEditorLines(editor,line,numlines)
  return editor:GetTextRangeDyn(
    editor:PositionFromLine(line),editor:PositionFromLine(line+numlines+1))
end

function DynamicWordsAdd(editor,content,line,numlines)
  if ide.config.acandtip.nodynwords then return end
  local api = editor.api
  local anysep = "["..q(editor.spec.sep).."]"
  content = content or getEditorLines(editor,line,numlines)
  for word in content:gmatch(anysep.."?%s*([a-zA-Z_]+[a-zA-Z_0-9]+)") do
    addDynamicWord(api,word)
  end
end

function DynamicWordsRem(editor,content,line,numlines)
  if ide.config.acandtip.nodynwords then return end
  local api = editor.api
  local anysep = "["..q(editor.spec.sep).."]"
  content = content or getEditorLines(editor,line,numlines)
  for word in content:gmatch(anysep.."?%s*([a-zA-Z_]+[a-zA-Z_0-9]+)") do
    removeDynamicWord(api,word)
  end
end

function DynamicWordsRemoveAll(editor)
  if ide.config.acandtip.nodynwords then return end
  DynamicWordsRem(editor,editor:GetTextDyn())
end

------------
-- Final Autocomplete

local cachemain = {}
local cachemethod = {}
local laststrategy
local function getAutoCompApiList(childs,fragment,method)
  fragment = fragment:lower()
  local strategy = ide.config.acandtip.strategy
  if (laststrategy ~= strategy) then
    cachemain = {}
    cachemethod = {}
    laststrategy = strategy
  end

  local cache = method and cachemethod or cachemain

  if (strategy == 2) then
    local wlist = cache[childs]
    if not wlist then
      wlist = " "
      for i,v in pairs(childs) do
        -- in some cases (tip.finfo), v may be a string; check for that first.
        -- if a:b typed, then value (type == "value") not allowed
        -- if a.b typed, then method (type == "method") not allowed
        if type(v) ~= 'table' or (v.type and
          ((method and v.type ~= "value")
            or (not method and v.type ~= "method"))) then
          wlist = wlist..i.." "
        end
      end
      cache[childs] = wlist
    end
    local ret = {}
    local g = string.gmatch
    local pat = fragment ~= "" and ("%s("..fragment:gsub(".",
        function(c)
          local l = c:lower()..c:upper()
          return "["..l.."][%w_]*"
        end)..")") or "([%w_]+)"
    pat = pat:gsub("%s","")
    for c in g(wlist,pat) do
      table.insert(ret,c)
    end

    return ret
  end

  if cache[childs] and cache[childs][fragment] then
    return cache[childs][fragment]
  end

  local t = {}
  cache[childs] = t

  local sub = strategy == 1
  for key,v in pairs(childs) do
    -- in some cases (tip.finfo), v may be a string; check for that first.
    -- if a:b typed, then value (type == "value") not allowed
    -- if a.b typed, then method (type == "method") not allowed
    if type(v) ~= 'table' or (v.type and
      ((method and v.type ~= "value")
        or (not method and v.type ~= "method"))) then
      local used = {}
      local kl = key:lower()
      for i=0,#key do
        local k = kl:sub(1,i)
        t[k] = t[k] or {}
        used[k] = true
        table.insert(t[k],key)
      end
      if (sub) then
        -- find camel case / _ separated subwords
        -- glfwGetGammaRamp -> g, gg, ggr
        -- GL_POINT_SPRIT -> g, gp, gps
        local last = ""
        for ks in string.gmatch(key,"([A-Z%d]*[a-z%d]*_?)") do
          local k = last..(ks:sub(1,1):lower())
          last = k

          t[k] = t[k] or {}
          if (not used[k]) then
            used[k] = true
            table.insert(t[k],key)
          end
        end
      end
    end
  end

  return t
end

ResolveAssign = resolveAssign
function CreateAutoCompList(editor,key,pos,logflag)
  local api = editor.api
  local tip = api.tip
  local ac = api.ac
  local sep = editor.spec.sep
  editor.assignscache = false;
  if key == nil then
    return nil;
  end
  local method = key:match(":[^"..q(sep).."]*$") ~= nil
  -- ignore keywords
  if tip.keys[key] then return end
  UpdateAssignCache(editor, true)
  local tab,mtab,rest = resolveAssign(editor, key, not key:find("[:.]$"), logflag)
  local progress = tab and tab.childs
  ide:SetStatusFor(progress and tab.classname and ("Auto-completing '%s'..."):format(tab.classname) or "")
  if not progress then return end
  if (tab == ac) and rest then
    local _, krest = rest:match("([%w_]+)["..q(sep).."]([%w_]*)%s*$")
    if (krest) then
      tab = #krest >= (ide.config.acandtip.startat or 2) and tip.finfo or {}
      rest = krest:gsub("[^%w_]","")
    else
      rest = rest:gsub("[^%w_]","")
    end
  else
    --  rest = rest:gsub("[^%w_]","")
  end
  local last = key:match("([%w_]+)%s*$")
  
  -- build dynamic word list
  -- only if api search couldnt descend
  -- ie we couldnt find matching sub items
  local dw = ""
  local dwList = {}
  if (last and #last >= (ide.config.acandtip.startat or 2)) then
    last = last:lower()
    if dynamicwords[last] then
      local list = dynamicwords[last]
      table.sort(list,function(a,b)
          local ma,mb = a:sub(1,#last)==last, b:sub(1,#last)==last
          if (ma and mb) or (not ma and not mb) then return a<b end
          return ma
        end)
      -- ignore if word == last and sole user
      for i,v in ipairs(list) do
        if (v:lower() == last and dywordentries[v] == 1) then
          table.remove(list,i)
          break
        end
      end

      dwList = list
    end
  end

  -- list from api
  laststrategy = nil
  local apilist = getAutoCompApiList(tab.childs or tab, rest, method)
  local function addInheritance(tab, apilist, seen)
    if not tab.inherits then return end
    for base in tab.inherits:gmatch("[%w_"..q(sep).."]+") do
      local tab = ac
      -- map "a.b.c" to class hierarchy (a.b.c)
      for class in base:gmatch("[%w_]+") do tab = tab.childs[class] end

      if tab and not seen[tab] then
        seen[tab] = true
        for _,v in pairs(getAutoCompApiList(tab.childs,rest,method)) do
          table.insert(apilist, v)
        end
        addInheritance(tab, apilist, seen)
      end
    end
  end

  -- handle (multiple) inheritance; add matches from the parent class/lib
  addInheritance(tab, apilist, {[tab] = true})

  -- include local/global variables
  if ide.config.acandtip.symbols and not key:find(q(sep)) then
    local vars, context = {}
    local tokens = editor:GetTokenList()
    for _, token in ipairs(tokens) do
      if token.fpos and pos and token.fpos > pos then break end
      if token[1] == 'Id' or token[1] == 'Var' then
        local var = token.name
        if var:find(key, 1, true) == 1
        -- skip the variable formed by what's being typed
        and (not token.fpos or not pos or token.fpos < pos-#key) then
          -- if it's a global variable, store in the auto-complete list,
          -- but if it's local, store separately as it needs to be checked
          table.insert(token.context[var] and vars or apilist, var)
        end
        context = token.context
      end
    end
    for _, var in pairs(context and vars or {}) do
      if context[var] then table.insert(apilist, var) end
    end
  end

  local compstr = ""
  -- include dynamic words
  local last = key:match("([%w_]+)%s*$")
  if (last and #last >= (ide.config.acandtip.startat or 2)) then
    last = last:lower()
    for i,v in ipairs(dynamicwords[last] or {}) do
      -- ignore if word == last and sole user
      if (v:lower() == last and dywordentries[v] == 1) then break end
      table.insert(apilist, v)
    end
  end

  local li

  if apilist then
    if (#rest > 0) then
      local strategy = ide.config.acandtip.strategy

      if (strategy == 2 and #apilist < 500) then
        -- when matching "ret": "ret." < "re.t" < "r.et"
        local patany = rest:gsub(".", function(c) return "["..c:lower()..c:upper().."](.-)" end)
        local patcase = rest:gsub(".", function(c) return c.."(.-)" end)
        local weights = {}
        local penalty = 0.1
        local function weight(str)
          if not weights[str] then
            local w = 0
            str:gsub(patany,function(...)
                local l = {...}
                -- penalize gaps between matches, more so at the beginning
                for n, v in ipairs(l) do w = w + #v * (1 + (#l-n)*penalty) end
              end)
            weights[str] = w + (str:find(patcase) and 0 or penalty)
          end
          return weights[str]
        end
        table.sort(apilist,function(a,b)
            local ma, mb = weight(a), weight(b)
            if (ma == mb) then return a:lower()<b:lower() end
            return ma<mb
          end)
      else
        table.sort(apilist,function(a,b)
            local ma,mb = a:sub(1,#rest)==rest, b:sub(1,#rest)==rest
            if (ma and mb) or (not ma and not mb) then return a<b end
            return ma
          end)
      end
    else
      table.sort(apilist)
    end

    local prev = apilist[#apilist]
    for i = #apilist-1,1,-1 do
      if prev == apilist[i] then
        table.remove(apilist, i+1)
      elseif tip.keys[apilist[i]] then
        table.remove(apilist, i)
      elseif apilist[i] == "__selfMemAssign" then
        table.remove(apilist, i)
      else prev = apilist[i] end
    end

    local templist = {}
    for k,v in ipairs(apilist) do
    	templist[v] = true;
    end
    for k=#dwList,1,-1 do
    	if templist[dwList[k]] == true  or tip.keys[dwList[k]] then
    		table.remove(dwList, k);
    	end
    end
    dw = table.concat(dwList," ")
    
    local tempKeys = {}
    local keyToken = GetWordByPosition(editor, editor:GetCurrentPos(), false);
    if keyToken then
    	for k,v in pairs(tip.keys) do
    		if k:find("^"..keyToken) then
    			table.insert(tempKeys, k);
    		end
    	end
    end
    
    if #tempKeys > 0 then
    	compstr = table.concat(tempKeys," ")
    end
    if #apilist > 0 then
    	if #compstr > 0 then
    		compstr = compstr .. " "
    	end
    
    	compstr = compstr..table.concat(apilist," ")
    end
  end

  -- concat final, list complete first
  local li = compstr .. (#compstr > 0 and #dw > 0 and " " or "") .. dw

  return li ~= "" and (#li > 10240 and li:sub(1,10240).."..." or li) or nil
end
