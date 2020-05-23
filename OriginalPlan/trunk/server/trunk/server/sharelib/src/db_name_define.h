#ifndef _DB_NAME_DEFINE_H_
#define _DB_NAME_DEFINE_H_

// 数据库ID 
enum EGameDbId
{
	DB_LOGIN = 1,				///< 登陆数据库
	DB_GAME = 2,                ///< 游戏数据库
	DB_RECODE_GAME = 3,			///< 日志数据库
	DB_SERVER = 4,				///< 服务器列表
};

#endif	// _DB_NAME_DEFINE_H_