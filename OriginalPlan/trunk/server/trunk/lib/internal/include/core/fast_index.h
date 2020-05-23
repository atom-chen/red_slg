#ifndef _FAST_INDEX_H_
#define _FAST_INDEX_H_

namespace GXMISC
{
	// @TODO 暂时不用, 未完成
    // 无效的索引
    const uint32 INVALID_FAST_INDEX = std::numeric_limits<uint32>::max();
    typedef uint32 FastIndex_t;
    /**
    * @brief 快速索引池
    *        主要用于快速访问, 添加和删除均需要O(n), 访问仅需要O(1)
    *        内部存储指针对象
    */
    template<typename T, bool isFree = false>
    class CFastIndex
    {
    public:
        typedef std::list<T*>   ListType;
        typedef std::vector<T*> VectorType;

    public:
        CFastIndex(uint32 count)
        {
			gxAssertEx(count > 0 && count < INVALID_FAST_INDEX, "count = {0}", count);
            _storeVector.resize(count);
            std::fill(_storeVector.begin(), _storeVector.end(), NULL);
        }

        ~CFastIndex()
        {
            for(typename ListType::iterator iter = _usedList.begin(); iter != _usedList.end(); ++iter)
            {
                if(isFree)
                {
                    delete *iter;
                }
            }

            _usedList.clear();
            _storeVector.clear();
        }

    public:
        uint32 getFreeIndex()
        {
			gxAssertEx(_usedList.size() <= _storeVector.size(), "lsize = {0}, vsize = {1}", _usedList.size(), _storeVector.size());
            for(uint32 i = 0; i < _storeVector.size(); ++i)
            {
                if(_storeVector[i] == NULL)
                {
                    return i;
                }
            }

            return INVALID_FAST_INDEX;
        }

        bool   addObj(T* obj, CFastIndex index)
        {
            if(index == INVALID_FAST_INDEX)
            {
				gxAssertEx(_usedList.size() == _storeVector.size(), "lsize = {0}, vsize = {1}", _usedList.size(), _storeVector.size());
				gxAssertEx(false, "lsize = {0}, vsize = {1}", _usedList.size(), _storeVector.size());
                return false;
            }

            gxAssert(_storeVector[index] == NULL);
            _storeVector[index] = obj;
        }

        void   delObj(FastIndex_t index)
        {
			gxAssertEx(_storeVector[index] != NULL, "index = {0}", index);
            if(isFree)
            {
                delete _storeVector[index];
            }

            _storeVector[index] = NULL;
        }

        uint32 size()
        {
			gxAssertEx(_usedList.size() <= _storeVector.size(), "lsize = {0}, vsize = {1}", _usedList.size(), _storeVector.size());
            return _usedList.size();
        }

        T* operator[](FastIndex_t index)
        {
			gxAssertEx(_usedList.size() <= _storeVector.size(), "lsize = {0}, vsize = {1}", _usedList.size(), _storeVector.size());
            return _storeVector[index];
        }

    private:
        std::list<T*>       _usedList;
        std::vector<T*>     _storeVector;
    };
}

#endif