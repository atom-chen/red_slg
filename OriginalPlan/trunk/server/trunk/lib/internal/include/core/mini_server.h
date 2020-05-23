#ifndef _MINI_SERVER_H_
#define _MINI_SERVER_H_

#include "service.h"

namespace GXMISC
{
	// @TODO 需要重新设计并完成
	class CMiniServer : public GxService
	{
	public:
		CMiniServer(const std::string serverName = "");
	public:
		typedef GxService TBaseType;

	public:
		virtual bool onAfterInit();
		virtual bool onAfterLoad();
		virtual bool onSystemEnvironment();

	public:
		static uint32 Test()
		{
			_test = 0;
			_test += 5;

			return _test;
		}
		static uint32 Test(sint16)
		{
			_test = 0;
			_test += 5;

			return _test;
		}
		static void TT()
		{
			std::cout <<"main tt test!!!"<<std::endl;
		}
		sint64 test(std::string name)
		{
			return 1234;
		}
		virtual void test()
		{
			std::cout <<"main void test!!!!"<<std::endl;
		}

		virtual void test(uint32 t)
		{
			std::cout << "main int test!!!!" << std::endl;
		}

	protected:
		CGxServiceConfig _serverConfig;

	protected:
		static uint32 _test;
	};
}

#endif // _MINI_SERVER_H_