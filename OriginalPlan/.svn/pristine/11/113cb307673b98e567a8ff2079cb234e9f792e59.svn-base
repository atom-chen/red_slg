local _class={};
 
function Class(super)
	local class_type={};
	class_type.ctor=false;
	class_type.super=super;
	
	-- 创建操作，调用基类构造函数
	class_type.new=function(...) 
		local obj={};
		do
			local create;
			create = function(c,...)
					if c.super then
						create(c.super,...);
					end
					if c.ctor then
						c.ctor(obj,...);
					end
				end
 
			create(class_type,...);
		end

		setmetatable(obj,{ __index=_class[class_type] });	-- 访问虚表
		return obj;
	end
	
	-- 虚表
	local vtbl={};
	_class[class_type]=vtbl;
 
	-- 将当前类的赋值操作重定位到虚表中
	setmetatable(class_type,{__newindex=
		function(t,k,v)
			vtbl[k]=v;
		end
	})
	
	-- 如果有基类，则读取操作重定义到基类中
	if super then
		setmetatable(vtbl,{__index=
			function(t,k)
				local ret=_class[super][k];
				vtbl[k]=ret;
				return ret;
			end
		})
	end
 
	return class_type;
end