#ifndef _SOCKET_BROAD_CAST_H_
#define _SOCKET_BROAD_CAST_H_

#include "module_base.h"

namespace GXMISC
{
	class CNetLoopWrap;
	
	// ����㲥(����������˳��û��Ҫ��Ĺ㲥Э��)
	class CSocketBroadCast : public CModuleThreadLoop
	{
		typedef CModuleThreadLoop TBaseType;

	public:
		CSocketBroadCast();
		~CSocketBroadCast();

	public:
		// ��ʼ��(�����̵߳�)
		virtual bool init();
		// ����
		virtual void cleanUp();
	
	public:
		// ���������װ����
		void setNetLoopWraps(CNetLoopWrap** wraps, sint32 wrapNum);

	protected:
		// ��Run֮ǰ��ʼ��
		virtual void initBeforeRun();
		// ֡ѭ��
		virtual bool onBreath();
		// ֹͣ����
		virtual void onStop();
	public:
		// �㲥��Ϣ
		void broadMsg(const char* msg, sint32 len, const TSockIndexAry& socks);
	private:
		// �㲥��Ϣ
		void broadMsg(const char* msg, sint32 len, const TSockIndexAry& socks, CNetLoopWrap* wrap, uint32 index);

	private:
		std::vector<CNetLoopWrap*> _netWraps;						///< ���߼��߳�Socket��װ���б�
		std::vector<CSyncActiveQueueWrap>	_sockTaskQueueWrap;		///< �ײ���߳��������

	private:
		std::vector<CSyncActiveQueue>     _sockLoopInputQ;			///< �ײ���߳��������
		std::vector<CSyncActiveQueue>     _sockLoopOutputQ;			///< �ײ���߳��������
	};

	class CNetBroadcastModule;
	// �㲥�̷߳�װ����
	class CNetBroadcastWrap : public CSimpleThreadLoopWrap
	{
		typedef CSimpleThreadLoopWrap TBaseType;

	public:
		CNetBroadcastWrap(CNetBroadcastModule* moduleMgr);
		~CNetBroadcastWrap();

	public:
		// �㲥��Ϣ
		void broadMsg(const char* msg, sint32 len, const TSockIndexAry& socks);

	protected:
		// ����һ���̶߳���
		virtual CModuleThreadLoop* createThreadLoop();
	protected:
		// ���̶߳������
		virtual void onCreateThreadLoop(CModuleThreadLoop* threadLoop);

	private:
		CSocketBroadCast _broadcastThread;	///< �㲥�߳�
	};

	// �㲥ģ��
	class CNetBroadcastModule : public CModuleBase
	{
	public:
		CNetBroadcastModule(const std::string& moduleName = "SocketBroadCastModule");
		~CNetBroadcastModule();
	
	public:
		// �㲥��Ϣ
		void broadMsg(const char* msg, sint32 len, const TSockIndexAry& socks);

	private:
		// ����ѭ������
		virtual CModuleThreadLoopWrap* createLoopWrap();

	private:
		IModuleConfig _config;
	};
}

#endif // _SOCKET_BROAD_CAST_H_