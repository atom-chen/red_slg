namespace luabind
{
	// CArray2×ª»»
	template <typename T>
	struct default_converter< CArray2<T> >
		: native_converter_base< CArray2<T> >
	{
		static int compute_score(lua_State* L, int index)
		{
			return (lua_type(L, index) == LUA_TTABLE )? 0 : -1;
		}

		CArray2<T> from(lua_State* L, int index)
		{
			CArray2<T> container; 
			luabind::object tbl(from_stack(L, index)); 

			for (luabind::iterator itr(tbl), end; itr != end; ++itr) 
			{ 
				boost::optional<T> v = object_cast_nothrow<T>(*itr); 
				if (v){ 
					container.push_back(*v); 
				} 
			}

			return container;
		}

		void to(lua_State* L, CArray2<T> const& container)
		{
			lua_createtable(L, container.size(), 0); 

			luabind::object tbl(from_stack(L, -1)); 
			int n = 0; 

			for (typename CArray2<T>::const_iterator itr = container.begin(); itr != container.end(); ++itr) 
			{ 
				tbl[++n] = *itr; 
			}
		}
	};

	template <typename T>
	struct default_converter< CArray1<T> >
		: native_converter_base< CArray1<T> >
	{
		static int compute_score(lua_State* L, int index)
		{
			return (lua_type(L, index) == LUA_TTABLE )? 0 : -1;
		}

		CArray1<T> from(lua_State* L, int index)
		{
			CArray1<T> container; 
			luabind::object tbl(from_stack(L, index)); 

			for (luabind::iterator itr(tbl), end; itr != end; ++itr) 
			{ 
				boost::optional<T> v = object_cast_nothrow<T>(*itr); 
				if (v){ 
					container.pushBack(*v); 
				} 
			}

			return container;
		}

		void to(lua_State* L, CArray1<T> const& container)
		{
			lua_createtable(L, container.size(), 0); 

			luabind::object tbl(from_stack(L, -1)); 
			int n = 0; 

			for (typename CArray1<T>::const_iterator itr = container.begin(); itr != container.end(); ++itr) 
			{ 
				tbl[++n] = *itr; 
			}
		}
	};
};
