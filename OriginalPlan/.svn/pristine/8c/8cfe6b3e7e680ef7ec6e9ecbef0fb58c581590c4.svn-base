local PARSE = require 'lua_parser_loose'
local LEX = require 'lua_lexer_loose'
local lx = LEX.lexc([=[
		--function tt()
		--end
		--local zt = {};
		a = b;
		local z = zz;
		--[[
		local i,j,k = b,c,d;
		function f(x,y,z)
			a = x;
			b = j;
			c = tt();
			d = z[1];
			x=y;
			local zz = z;
		end
		--]]
	]=], nil, 1)

--[[
	function tt()
	end
	local zt = {};
	local i,j,k = b, c, d;
	function f(x,y,z)
		a = x;
		b = j;
		c = tt();
		d = z[1];
		ott(d, "CRect");

	end
--]]
--[[
local varnext = {}
local vars;
local varTypes = {};
PARSE.parse_scope_resolve(lx,
	function(op, name, lineinfo, vars)
		if op == 'Id' or op == 'VarNext' then
			local cnext = lx:peek()
      if cnext.tag == 'Keyword' and cnext[1] == '=' then
				-- hope match a=b
				lx:next();
				cnext = lx:peek();
				if cnext.tag == 'Id' then
					-- math a=b
					print(name, cnext[1]);
					table.insert(varTypes,{key=name, ref=cnext[1], pos=lineinfo});
				end
			end
		end

		-- level needs to be adjusted for VarInside as it comes into scope
		-- only after next block statement
		local at = vars[0] and (vars[0] + (op == 'VarInside' and 1 or 0))
		if op == 'Statement' then
			for _, token in pairs(varnext) do print("==test=="); end
			varnext = {}
		elseif op == 'VarNext' or op == 'VarInside' then
			table.insert(varnext, {'Var', name, lineinfo, vars, at})
		end
	end,
vars)
print("DONE");

function FindRefrence()
	for _,v in pairs(varTypes) do
		local pos = v.pos;
		local instances = v.ref and IndicateFindInstances(editor, ref, pos-1)
		local word = editor:GetTextRange(instances[0]-1, instances[0]-1+#v.ref)
		OutLn(instances[0], word);
	end
end
--]]

local c = string.byte();

local a = b;
local vars={};
local varnext = {}
PARSE.parse_scope_resolve(lx, function(op, name, lineinfo, vars)
	if not(op == 'Id' or op == 'Statement' or op == 'Var'
		or op == 'VarNext' or op == 'VarInside' or op == 'VarSelf'
		or op == 'FunctionCall' or op == 'Scope' or op == 'EndScope') then
		return
	end -- "normal" return; not interested in other events

	-- level needs to be adjusted for VarInside as it comes into scope
	-- only after next block statement
	local at = vars[0] and (vars[0] + (op == 'VarInside' and 1 or 0))
	if op == 'Statement' then
		for _, token in pairs(varnext) do
			print(unpack(token));
			--coroutine.yield(unpack(token))
		end
		varnext = {}
	elseif op == 'VarNext' or op == 'VarInside' then
		-- match a=b
		local text = "local z = zz;";
		if (text:match("^%s*local%s+[%w_]+%s*=%s*[%w_]+[%s;]*$")) then
			for _, token in pairs(varnext) do
				print(unpack(token));
				--coroutine.yield(unpack(token))
			end
			varnext = {}

			-- a=b
			lx:next();
			local cnext = lx:peek();
			if cnext.tag == 'Id' then
				-- match a=b
				print(op, name, lineinfo, vars, at, cnext[1]);
				--coroutine.yield(op, name, lineinfo, vars, at, cne[1])
			end
		end

		table.insert(varnext, {'Var', name, lineinfo, vars, at})
	end
	if op == 'Id' then
		-- match assign a=b, forbid a,b,c = x,y,z
		local text = "a = b;";
		if (text:match("^%s*[%w_]+%s*=%s*[%w_]+[%s;]*$")) then
			-- a=b
			lx:next();
			local cnext = lx:peek();
			if cnext.tag == 'Id' then
				-- match a=b
				print(op, name, lineinfo, vars, at, cnext[1]);
				--coroutine.yield(op, name, lineinfo, vars, at, cne[1])
			end
		end
	end

	print(op, name, lineinfo, vars, at);
	--coroutine.yield(op, name, lineinfo, vars, at)
end, vars)
