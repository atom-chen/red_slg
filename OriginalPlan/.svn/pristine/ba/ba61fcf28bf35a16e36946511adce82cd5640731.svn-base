#ifndef _MSG_QUEUE_H_
#define _MSG_QUEUE_H_

#include "types_def.h"
#include "stdcore.h"
#include "mutex.h"
#include "base_util.h"

namespace GXMISC
{
	// 同步队列
    template<typename T, typename LockType=CMutex>
    class CMsgQueue
    {
    private:
        LockType                _lock;
        std::deque<T>           _queue;
		sint32					_queSize;
    public:

		CMsgQueue()
        {
			_queSize = 0;
        }

        virtual ~CMsgQueue()
        {
        }

        void push(std::list<T>& tempList, sint32 num = MAX_SINT32_NUM)
        {
            if(num == 0 || tempList.empty())
            {
                return;
            }
            
            do 
            {
                typename std::list<T>::iterator iter = tempList.begin();
                sint32 count = 0;
				CAutoMutex<LockType> lock(this->_lock);
                for(; iter != tempList.end() && count < num; count++, iter++)
                {
                    _queue.push_back(*iter);
                }
				_queSize = (sint32)_queue.size();
            } while (false);
        }

        void pop(std::list<T>& lst, sint32 num = MAX_SINT32_NUM)
        {
            if(empty())
            {
                return;
            }

            sint32 nCount = 0;
			CAutoMutex<LockType> lock(this->_lock);
            while(!empty() && nCount < num)
            {
                nCount++;
                lst.push_back(_queue.front());
                _queue.pop_front();
				_queSize = (sint32)_queue.size();
            }
        }

        void push(const T& msg)
        {
            CAutoMutex<LockType> lock(this->_lock);
            _queue.push_back(msg);
			_queSize = (uint32)_queue.size();
        }

		void pushFront(const T& msg)
		{
			CAutoMutex<LockType> lock(this->_lock);
			_queue.push_front(msg);
			_queSize = (sint32)_queue.size();
		}

        bool pop(T& msg)
        {
            if(empty())
            {
                return false;
            }
            
            CAutoMutex<LockType> lock(this->_lock);
            if(!empty())
            {
                msg = _queue.front();
                _queue.pop_front();
				_queSize = _queue.size();
                return true;
            }

            return false;
        }

        inline uint32 size()
        {
            return _queSize;
        }

        bool empty()
        {
            return _queue.empty();
        }
    };
}

#endif