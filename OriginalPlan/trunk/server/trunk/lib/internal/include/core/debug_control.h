#ifndef _DEBUG_DEFINE_H_
#define _DEBUG_DEFINE_H_

#include "stdcore.h"
#include "hash_util.h"
#include "base_util.h"
#include "singleton.h"
#include "mutex.h"
#include "debug.h"

namespace GXMISC
{
	// @TODO 重写调试库
	typedef CHashMap<TUniqueIndex_t, uint32> TDebugHandlerHash;
	class CDebugControl : public CManualSingleton<CDebugControl>
	{
	public:
		CDebugControl();
		~CDebugControl();

	public:
		bool isHandler(TUniqueIndex_t index);							// 判断是否开启了调试对象
		void addHandler(TUniqueIndex_t index);							// 添加处理对象
		void setTaskVar(bool val);
		bool getTaskVar();
		void setSocketProfileVar(bool val);
		bool getSocketProfileVar();
		void setDatabaseProfileVar(bool val);
		bool getDatabaseProfileVar();
		void setTaskProfileVar(bool val);
		bool getTaskProfileVar();
		void setSocketLoopProfileVar(bool val);
		bool getSocketLoopProfileVar();
		void setTaskBlockAllocVar(bool val);
		bool getTaskBlockAllocVar();
		void setSocketBufferVar(bool val);
		bool getSocketBufferVar();
		void setMainLoopProfileVar(bool val);
		bool getMainLoopProfileVar();
        void setServiceStopVar(bool val);
        bool getServiceStopVar();
		
	private:
		CMutex _lock;
		bool _taskVar;												// 底层任务日志
		bool _socketProfileVar;										// Socket统计
		bool _databaseProfileVar;									// 数据库统计
		bool _taskProfileVar;										// 任务统计
		bool _socketLoopProfileVar;									// 网络循环统计
		bool _taskBlockAllocVar;									// 任务块处理
		bool _socketBufferVar;										// SocketBuffer
		CHashMap<TUniqueIndex_t, uint32> _handlerAry;				// SocketHandler的信息
		bool _handlerFlag;											// 是否需要检测调试对象
		bool _mainLoopProfileVar;									// 主循环统计
        bool _serviceStop;
	};

	#define DCoreDebugControl CDebugControl::GetInstance()

	// 调试库日志
	#define DTaskLog(fmt, ...)					if(DCoreDebugControl.getTaskVar()) gxLogStat(DMainLog, __FILE__, __LINE__, __FUNCTION__, fmt,  ##__VA_ARGS__)
	#define DSocketProfileLog(fmt, ...)			if(DCoreDebugControl.getSocketProfileVar()) gxLogStat(DMainLog, __FILE__, __LINE__, __FUNCTION__, fmt,  ##__VA_ARGS__)
	#define DDatabaseProfileLog(fmt, ...)		if(DCoreDebugControl.getDatabaseProfileVar()) gxLogStat(DMainLog, __FILE__, __LINE__, __FUNCTION__, fmt,  ##__VA_ARGS__)
	#define DTaskProfileLog(fmt, ...)			if(DCoreDebugControl.getTaskProfileVar()) gxLogStat(DMainLog, __FILE__, __LINE__, __FUNCTION__, fmt,  ##__VA_ARGS__)
	#define DSocketLoopProfileLog(fmt, ...)		if(DCoreDebugControl.getSocketLoopProfileVar()) gxLogStat(DMainLog, __FILE__, __LINE__, __FUNCTION__, fmt,  ##__VA_ARGS__)
	#define DTaskBlockAllocProfileLog(fmt, ...)	if(DCoreDebugControl.getTaskBlockAllocVar()) gxLogStat(DMainLog, __FILE__, __LINE__, __FUNCTION__, fmt,  ##__VA_ARGS__)
	#define DSocketBuffLog(fmt, ...)			if(DCoreDebugControl.getSocketBufferVar()) gxLogStat(DMainLog, __FILE__, __LINE__, __FUNCTION__, fmt,  ##__VA_ARGS__)
	#define DSocketBuffCondLog(uid,fmt, ...)	if(DCoreDebugControl.isHandler(uid)) gxLogStat(DMainLog, __FILE__, __LINE__, __FUNCTION__, fmt,  ##__VA_ARGS__)
	#define DMainLoopProfileLog(fmt, ...)		if(DCoreDebugControl.getMainLoopProfileVar()) gxLogStat(DMainLog, __FILE__, __LINE__, __FUNCTION__, fmt,  ##__VA_ARGS__)
}

#endif