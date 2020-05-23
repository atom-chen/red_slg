
// call function
	public:
		template<typename R>
		R call(const char* funcname, R defVal){
			return _inc->callFunc(funcname, defVal);
		}

		template<typename R, typename P1>
		R call(const char* funcname, R defVal, P1 p1)
		{
			return _inc->callFunc(funcname, defVal, p1);
		}

		template<typename R, typename P1, typename P2>
		R call(const char* funcname, R defVal, P1 p1, P2 p2)
		{
			return _inc->callFunc(funcname, defVal, p1, p2);
		}

		template<typename R, typename P1, typename P2, typename P3>
		R call(const char* funcname, R defVal, P1 p1, P2 p2, P3 p3)
		{
			return _inc->callFunc(funcname, defVal, p1, p2, p3);
		}

		template<typename R, typename P1, typename P2, typename P3, typename P4>
		R call(const char* funcname, R defVal, P1 p1, P2 p2, P3 p3, P4 p4)
		{
			return _inc->callFunc(funcname, defVal, p1, p2, p3, p4);
		}

		template<typename R, typename P1, typename P2, typename P3, typename P4, typename P5>
		R call(const char* funcname, R defVal, P1 p1, P2 p2, P3 p3, P4 p4, P5 p5)
		{
			return _inc->callFunc(funcname, defVal, p1, p2, p3, p4, p5);
		}

		template<typename R, typename P1, typename P2, typename P3, typename P4, typename P5, typename P6>
		R call(const char* funcname, R defVal, P1 p1, P2 p2, P3 p3, P4 p4, P5 p5, P6 p6)
		{
			return _inc->callFunc(funcname, defVal, p1, p2, p3, p4, p5, p6);
		}

		template<typename R, typename P1, typename P2, typename P3, typename P4, typename P5, typename P6, typename P7>
		R call(const char* funcname, R defVal, P1 p1, P2 p2, P3 p3, P4 p4, P5 p5, P6 p6, P7 p7)
		{
			return _inc->callFunc(funcname, defVal, p1, p2, p3, p4, p5, p6, p7);
		}

		template<typename R, typename P1, typename P2, typename P3, typename P4, typename P5, typename P6, typename P7, typename P8>
		R call(const char* funcname, R defVal, P1 p1, P2 p2, P3 p3, P4 p4, P5 p5, P6 p6, P7 p7, P8 p8)
		{
			return _inc->callFunc(funcname, defVal, p1, p2, p3, p4, p5, p6, p7, p8);
		}

		template<typename R, typename P1, typename P2, typename P3, typename P4, typename P5, typename P6, typename P7, typename P8, typename P9>
		R call(const char* funcname, R defVal, P1 p1, P2 p2, P3 p3, P4 p4, P5 p5, P6 p6, P7 p7, P8 p8, P9 p9)
		{
			return _inc->callFunc(funcname, defVal, p1, p2, p3, p4, p5, p6, p7, p8, p9);
		}
		template<typename R, typename P1, typename P2, typename P3, typename P4, typename P5, typename P6, typename P7, typename P8, typename P9, typename P10>
		R call(const char* funcname, R defVal, P1 p1, P2 p2, P3 p3, P4 p4, P5 p5, P6 p6, P7 p7, P8 p8, P9 p9, P10 p10)
		{
			return _inc->callFunc(funcname, defVal, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10);
		}

		bool bCall(const char* funcname)
		{
			return _inc->bCallFunc(funcname);
		}
		template<typename P1>
		bool bCall(const char* funcname, P1 p1)
		{
			return _inc->bCallFunc(funcname, p1);
		}
		template< typename P1, typename P2>
		bool bCall(const char* funcname, P1 p1, P2 p2)
		{
			return _inc->bCallFunc(funcname, p1, p2);
		}
		template< typename P1, typename P2, typename P3>
		bool bCall(const char* funcname, P1 p1, P2 p2, P3 p3)
		{
			return _inc->bCallFunc(funcname, p1, p2, p3);
		}
		template< typename P1, typename P2, typename P3, typename P4>
		bool bCall(const char* funcname, P1 p1, P2 p2, P3 p3, P4 p4)
		{
			return _inc->bCallFunc(funcname, p1, p2, p3, p4);
		}
		template< typename P1, typename P2, typename P3, typename P4, typename P5>
		bool bCall(const char* funcname, P1 p1, P2 p2, P3 p3, P4 p4, P5 p5)
		{
			return _inc->bCallFunc(funcname, p1, p2, p3, p4, p5);
		}
		template< typename P1, typename P2, typename P3, typename P4, typename P5, typename P6>
		bool bCall(const char* funcname, P1 p1, P2 p2, P3 p3, P4 p4, P5 p5, P6 p6)
		{
			return _inc->bCallFunc(funcname, p1, p2, p3, p4, p5, p6);
		}
		template< typename P1, typename P2, typename P3, typename P4, typename P5, typename P6, typename P7>
		bool bCall(const char* funcname, P1 p1, P2 p2, P3 p3, P4 p4, P5 p5, P6 p6, P7 p7)
		{
			return _inc->bCallFunc(funcname, p1, p2, p3, p4, p5, p6, p7);
		}
		template< typename P1, typename P2, typename P3, typename P4, typename P5, typename P6, typename P7, typename P8>
		bool bCall(const char* funcname, P1 p1, P2 p2, P3 p3, P4 p4, P5 p5, P6 p6, P7 p7, P8 p8)
		{
			return _inc->bCallFunc(funcname, p1, p2, p3, p4, p5, p6, p7, p8);
		}
		template< typename P1, typename P2, typename P3, typename P4, typename P5, typename P6, typename P7, typename P8, typename P9>
		bool bCall(const char* funcname, P1 p1, P2 p2, P3 p3, P4 p4, P5 p5, P6 p6, P7 p7, P8 p8, P9 p9)
		{
			return _inc->bCallFunc(funcname, p1, p2, p3, p4, p5, p6, p7, p8, p9);
		}
		template< typename P1, typename P2, typename P3, typename P4, typename P5, typename P6, typename P7, typename P8, typename P9, typename P10>
		bool bCall(const char* funcname, P1 p1, P2 p2, P3 p3, P4 p4, P5 p5, P6 p6, P7 p7, P8 p8, P9 p9, P10 p10)
		{
			return _inc->bCallFunc(funcname, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10);
		}

		//==========================================================
		void vCall(const char* funcname)
		{
			_inc->vCallFunc(funcname);
		}
		template<typename P1>
		void vCall(const char* funcname, P1 p1)
		{
			return _inc->vCallFunc(funcname, p1);
		}
		template< typename P1, typename P2>
		void vCall(const char* funcname, P1 p1, P2 p2)
		{
			return _inc->vCallFunc(funcname, p1, p2);
		}
		template< typename P1, typename P2, typename P3>
		void vCall(const char* funcname, P1 p1, P2 p2, P3 p3)
		{
			return _inc->vCallFunc(funcname, p1, p2, p3);
		}
		template< typename P1, typename P2, typename P3, typename P4>
		void vCall(const char* funcname, P1 p1, P2 p2, P3 p3, P4 p4)
		{
			return _inc->vCallFunc(funcname, p1, p2, p3, p4);
		}
		template< typename P1, typename P2, typename P3, typename P4, typename P5>
		void vCall(const char* funcname, P1 p1, P2 p2, P3 p3, P4 p4, P5 p5)
		{
			return _inc->vCallFunc(funcname, p1, p2, p3, p4, p5);
		}
		template< typename P1, typename P2, typename P3, typename P4, typename P5, typename P6>
		void vCall(const char* funcname, P1 p1, P2 p2, P3 p3, P4 p4, P5 p5, P6 p6)
		{
			return _inc->vCallFunc(funcname, p1, p2, p3, p4, p5, p6);
		}
		template< typename P1, typename P2, typename P3, typename P4, typename P5, typename P6, typename P7>
		void vCall(const char* funcname, P1 p1, P2 p2, P3 p3, P4 p4, P5 p5, P6 p6, P7 p7)
		{
			return _inc->vCallFunc(funcname, p1, p2, p3, p4, p5, p6, p7);
		}
		template< typename P1, typename P2, typename P3, typename P4, typename P5, typename P6, typename P7, typename P8>
		void vCall(const char* funcname, P1 p1, P2 p2, P3 p3, P4 p4, P5 p5, P6 p6, P7 p7, P8 p8)
		{
			return _inc->vCallFunc(funcname, p1, p2, p3, p4, p5, p6, p7, p8);
		}
		template< typename P1, typename P2, typename P3, typename P4, typename P5, typename P6, typename P7, typename P8, typename P9>
		void vCall(const char* funcname, P1 p1, P2 p2, P3 p3, P4 p4, P5 p5, P6 p6, P7 p7, P8 p8, P9 p9)
		{
			return _inc->vCallFunc(funcname, p1, p2, p3, p4, p5, p6, p7, p8, p9);
		}
		template< typename P1, typename P2, typename P3, typename P4, typename P5, typename P6, typename P7, typename P8, typename P9, typename P10>
		void vCall(const char* funcname, P1 p1, P2 p2, P3 p3, P4 p4, P5 p5, P6 p6, P7 p7, P8 p8, P9 p9, P10 p10)
		{
			return _inc->vCallFunc(funcname, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10);
		}