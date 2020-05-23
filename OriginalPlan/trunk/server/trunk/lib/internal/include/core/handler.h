#ifndef _HANDLER_H_
#define _HANDLER_H_

#include "base_util.h"
#include "interface.h"
#include "script_object_base.h"

namespace GXMISC
{
    // 协议执行返回
    enum EHandleRet
    {
        HANDLE_RET_OK = 0,
        HANDLE_RET_FAILED,
    };

    /**
     * @brief 异步处理对象
     */
    class IHandler : public IScriptObject
    {
    protected:
        IHandler(const IAllocatable* allocable = NULL, TUniqueIndex_t index = INVALID_UNIQUE_INDEX);
	public:
        virtual ~IHandler();

    public:
        // 连接建立
        virtual bool start() = 0;
        // 消息处理
        virtual EHandleRet handle(char* msg, uint32 len) = 0;
        // 连接关闭
        virtual void close() = 0;
		// 重连接
		virtual void onReconnect(){}
        // 定时更新
        virtual void breath(TDiffTime_t diff) = 0;
        // 删除
		virtual void onDelete(){};
        // 是否有效
        virtual bool isValid() = 0;
        // 重置当前对象 @TODO 废弃掉
		virtual void reset(){};

	public:
		// 名称
		virtual const char* getName();
		// 是否启动过
        void setStarted();
		// 是否已经启动
        bool isStarted();
        // 初始化
        void setParam(const IAllocatable* allocable, TUniqueIndex_t index);
        // 获取唯一索引
        TUniqueIndex_t getUniqueIndex();

    protected:
        // 设置已经失效
        void setInvalid();
        // 判断是否已经失效
        bool isInvalid();
		// 获取类型名
		template<typename T>
        const char* getName(T* pObj)
		{
			return typeid(pObj).name();
		}

    protected:
		// 设置唯一标识
        void setUniqueIndex(TUniqueIndex_t index);

    protected:
        IAllocatable        *_allocable;        // 可分配内存对象
        TUniqueIndex_t      _index;             // 唯一标识
        bool                _invalid;           // 已经失效
        bool                _startFlag;         // 是否已经开启
    };
}

#endif