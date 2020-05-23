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
	// @TODO ��д���Կ�
	typedef CHashMap<TUniqueIndex_t, uint32> TDebugHandlerHash;
	class CDebugControl : public CManualSingleton<CDebugControl>
	{
	public:
		CDebugControl();
		~CDebugControl();

	public:
		bool isHandler(TUniqueIndex_t index);							// �ж��Ƿ����˵��Զ���
		void addHandler(TUniqueIndex_t index);							// ��Ӵ������
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
		bool _taskVar;												// �ײ�������־
		bool _socketProfileVar;										// Socketͳ��
		bool _databaseProfileVar;									// ���ݿ�ͳ��
		bool _taskProfileVar;										// ����ͳ��
		bool _socketLoopProfileVar;									// ����ѭ��ͳ��
		bool _taskBlockAllocVar;									// ����鴦��
		bool _socketBufferVar;										// SocketBuffer
		CHashMap<TUniqueIndex_t, uint32> _handlerAry;				// SocketHandler����Ϣ
		bool _handlerFlag;											// �Ƿ���Ҫ�����Զ���
		bool _mainLoopProfileVar;									// ��ѭ��ͳ��
        bool _serviceStop;
	};

	#define DCoreDebugControl CDebugControl::GetInstance()

	// ���Կ���־
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