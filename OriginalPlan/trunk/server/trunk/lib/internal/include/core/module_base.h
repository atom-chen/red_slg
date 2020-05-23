#ifndef _MODULE_BASE_H_
#define _MODULE_BASE_H_

#include "module_manager.h"
#include "task.h"

namespace GXMISC
{
	class GxService;
	class IThread;
	class CModuleBase;
	class CModuleThreadLoopWrap;

	// ģ���߳����ж���
	class CModuleThreadLoop : public IRunnable
	{
	protected:
		CModuleThreadLoop();
	public:
		virtual ~CModuleThreadLoop();
	
	public:
		// ��ʼ��(�����̵߳�)
		virtual bool init();
		// ��������(�����߳�)
		virtual bool start();
		// ����(�ͷ��߳�)
		virtual void cleanUp();
		
	public:
		// �����߳̽�������
		void setCommunicationQ(CSyncActiveQueue* inputQ, CSyncActiveQueue* outputQ);
		// ����ģ������
		void setModuleConfig(IModuleConfig* config);
		// ����ѭ����װ����
		void setLoopWrap(CModuleThreadLoopWrap* loopWrap);
		// �����Ƿ���Ҫ�ͷ�
		void setFreeFlag(bool flag);
		// ��ȡ�Ƿ���Ҫ�ͷ�
		bool needFree();
		// ��ȡ�������
		const CSyncActiveQueueWrap* getTaskQueueWrap() const;
		// ��ȡ�̰߳�װ����
		CModuleThreadLoopWrap* getThreadLoopWrap() const;
	public:
		// ���к���
		virtual void run();
	protected:
		// ��run֮ǰ��ʼ��
		virtual void initBeforeRun(){}
		// ��������к���
		virtual bool onBreath(){ return true;  };
		// ���������¼�
		virtual void onHandleTask(CTask* task);

	public:
		// ��������
		template<typename T>
        T* newTask()
        {
            return _queueWrap.allocObj<T>();
        }
		// �ͷ�����
		void	freeTask(CTask* arg);
	protected:
		// ������������
		void handleInputTask();
		// �����������
		void handleOutputTask();

	private:
		// ��������
		void _clearSelf();

	protected:
		IThread* _thread;  // �߳�
		CModuleThreadLoopWrap* _loopWrap;   // ѭ����װ����
		IModuleConfig*			_moduleConfig;	// ģ������
		CSyncActiveQueueWrap _queueWrap;	// ���з�װ����
		bool _needFree; // �Ƿ���Ҫ�ͷ�

	protected:
		TTime_t					_startTime;					// ����ʱ��
		TTime_t					_curTime;					// ��ǰʱ��
		uint32					_runSeconds;				// ����ʱ��(��)
		uint64					_totalLoopCount;			// ѭ������
		uint32					_maxLoopCount;				// һ��֮������ѭ����
		uint32					_curLoopCount;				// ��ǰ���ڵ�ѭ����
		TTime_t                 _lastLoopProfileTime;       // �ϴ�ͳ��ʱ��
	};

	// ģ�����̶߳��߳����ж���ķ�װ
	class CModuleThreadLoopWrap
	{
	protected:
		CModuleThreadLoopWrap(CModuleBase* pModule);
	public:
		virtual ~CModuleThreadLoopWrap();

	public:
		// ��ʼ������(�����̶߳����)
		virtual bool init();
		// ����(�̶߳����)
		virtual bool start();
		// ֹͣ(�̶߳����)
		virtual void stop();
		// ����
		virtual void cleanUp();
		// ÿ֡ѭ��
		virtual void breath(GXMISC::TDiffTime_t diff);
	private:
		// �������
		void _clearSelf();
		
	protected:
		// ֡ѭ���¼�
		virtual void onBreath(GXMISC::TDiffTime_t diff){};
		// ֹͣ�¼�
		virtual void onStop(){};
		// ���������¼�
		virtual void onHandleTask(CTask* task);

	public:
		// ��������
		template<typename T>
		T* newTask()
		{
			return _queueWrap.allocObj<T>();
		}
		// �ͷ�����
		void	freeTask(CTask* arg);
	protected:
		// ������������
		void handleInputTask(TDiffTime_t diff);
		// �����������
		void handleOutputTask(TDiffTime_t diff);

	public:
		// �Ƿ���������
		bool isRunning();
		// �Ƿ��Ѿ��˳�����
		bool isExitRun();
	protected:
		// �����̶߳���
		virtual CModuleThreadLoop* createThreadLoop() = 0;
		// �ж�������¼�
		virtual void onCreateThreadLoop(CModuleThreadLoop* threadLoop);

	public:
		// ���ñ��ID
		void setTagId(uint8 tagId);
		// ��ȡ���ID
		uint8 getTagId();
		// ����Ψһ���
		TUniqueIndex_t genUniqueIndex();
		// Socket�Ƿ�Ϊ��ǰѭ����������
		bool isUserIndex(TUniqueIndex_t uid);
		// ��ȡ�̶߳���
		CModuleThreadLoop* getModuleThreadLoop() const;
	public:
		// ����������
		void setService(GxService* service);
		// ��ȡ������
		GxService* getService() const;
		// ��ȡ���������е�������
		sint32 getOutputQSize() const;

	public:
		// �õ��û�����
		virtual sint32 getUserNum() const;
		// �õ������û���Ŀ
		virtual sint32 getMaxUserNum() const;
		// �Ƿ��Ѿ��ﵽ�����û���
		virtual bool isMaxUserNum() const;

	public:
		// ��ȡ�������
		const CSyncActiveQueueWrap* getTaskQueueWrap() const;
	protected:
		// �����߳̽�������
		void setCommunicationQ(CSyncActiveQueue* inputQ, CSyncActiveQueue* outputQ);
		
	protected:
		CModuleThreadLoop* _threadLoop;		// ѭ���̶߳���
		CModuleBase *_moduleBase;           // ģ�����
 		CSyncActiveQueue* _inputQ;			// �������
 		CSyncActiveQueue* _outputQ;			// �������
		GxService* _mainService;			// ������
		CSyncActiveQueueWrap _queueWrap;	// ���з�װ����
		uint8 _tagId;						// ���ID
		uint32 _genId;						// ��ʼ��������ID
		IModuleConfig* _moduleConfig;		// ģ������
	};
	
	// ��ѭ����װ����
	class CSimpleThreadLoopWrap : public CModuleThreadLoopWrap
	{
	protected:
		CSimpleThreadLoopWrap(CModuleBase* module);
	public:
		virtual ~CSimpleThreadLoopWrap();

	protected:
		virtual void onCreateThreadLoop(CModuleThreadLoop* threadLoop);
		
	protected:
		CSyncActiveQueue _inputQue;		// �������
		CSyncActiveQueue _outputQue;	// �������
	};

	// ģ�����
	class CModuleBase : public IModuleManager
	{
	protected:
		CModuleBase(IModuleConfig* config);
	public:
		virtual ~CModuleBase();

	private:
		// �������
		void _clearSelf();

	public:
		// ��ʼ��
		virtual bool init();
		// ����
		virtual bool start();
		// ����
		virtual void cleanUp();

	public:
		// ֹͣ�¼�
		virtual void onStop();
	protected:
		// ѭ���¼�
		virtual bool doLoop(TDiffTime_t diff);

	protected:
		// ֡ѭ���¼�
		virtual bool onBreath(TDiffTime_t diff){ return true; };

	public:
		// �õ�����߳���
		sint32 getMaxConnNum() const;
		// ��ȡѭ���߳���
		sint32 getLoopNum() const;
		// ����������
		void setService(GxService* service);
		// ��ȡ������
		GxService* getService() const;

	public:
		// �õ�һ����С��ѭ������
		CModuleThreadLoopWrap* getLeastLoop() const;
		// ���е�ѭ�������Ƿ��Ѿ�ֹͣ
		bool checkAllLoopStop();

	protected:
		// ����ѭ����װ����
		virtual CModuleThreadLoopWrap* createLoopWrap() = 0;
		// �ж�������¼�
		// @param index ��0��ʼ����
		virtual void onCreateThreadLoopWrap(CModuleThreadLoopWrap* threadLoopWrap, sint32 index);
	protected:
		CModuleThreadLoopWrap** _loopThreadWraps;	// ���е�ѭ���߳�
		GxService* _mainService;					// ������
	};

	// ���߼��̷߳��͵������̵߳�����
	class CLoopToThreadTask : public CTask
	{
	protected:
		CLoopToThreadTask();
	public:
		virtual ~CLoopToThreadTask();

	public:
		// �����µ�����
		template<typename T>
		T* newTask()
		{
			return getLoopThread()->newTask<T>();
		}

	private:
		// ���߳�ԭ��, ��ֹʹ�ô˺���
		virtual CModuleThreadLoopWrap* getLoopThreadWrap() const{ gxAssert(FALSE_COND);  return NULL; };
	};

	// �����̷߳��͵����߼��̵߳�����
	class CThreadToLoopTask : public CTask
	{
	protected:
		CThreadToLoopTask();
	public:
		virtual ~CThreadToLoopTask();

	public:
		// �Ƿ���ɹ�
		bool isSuccess();
		// ���óɹ����
		void setSuccess(TErrorCode_t flag = 0);
		// ��ȡ�ɹ����
		TErrorCode_t getErrorCode();

	protected:
		TErrorCode_t errorCode;		///< ������

	private:
		// ���߳�ԭ��, ��ֹʹ�ô˺���
		virtual CModuleThreadLoop* getLoopThread() const { gxAssert(false);  return NULL; };
	};
}

#endif // _MODULE_BASE_H_