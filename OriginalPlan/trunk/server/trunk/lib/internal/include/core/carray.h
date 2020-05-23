#ifndef _ARRAY_H_
#define _ARRAY_H_

#include "types_def.h"
#include "stdcore.h"
#include "stream_traits.h"
#include "stream.h"

namespace GXMISC
{
#pragma pack(push, 1)
	template<bool>
	class _AryTypeClean
	{
	public:
		static void Clean(void* buf, sint32 len)
		{
			memset(buf, 0, len);
		}
	};

	template<>
	class _AryTypeClean<false>
	{
	public:
		static void Clean(void* buff, sint32 len)
		{
			UNREFERENCED_PARAMETER(buff);
			UNREFERENCED_PARAMETER(len);
		}
	};

#define DArrayKey(MemberName)	\
	sint32* pOffset = (sint32*)&(TSelfType::ArreyKeyOffset);	\
	*pOffset = offsetof(TSelfType, MemberName);

#define DArrayKeyImpl(Type, MemberName)	\
public:	\
	Type(){	\
	sint32* pOffset = (sint32*)&(TSelfType::ArreyKeyOffset);	\
	*pOffset = offsetof(TSelfType, MemberName);	\
	}

	template<typename T>
	class IArrayEnable : GXMISC::IStreamableAll
	{
	public:
		typedef T TSelfType;
		typedef sint8 TArrayKeyType;

	public:
		static sint32 ArreyKeyOffset;
	};

	template<typename T>
	class IArrayEnableSimple
	{
	public:
		typedef T TSelfType;
		typedef sint8 TArrayKeyType;

	public:
		static sint32 ArreyKeyOffset;
	};
	template<typename T>
	sint32 GXMISC::IArrayEnableSimple<T>::ArreyKeyOffset = 0;

	template<typename T>
	sint32 GXMISC::IArrayEnable<T>::ArreyKeyOffset = 0;

	template<typename T>
	class CArrayFinder
	{
		typedef typename T::TArrayKeyType __TArrayKeyType;

	public:
		template<typename TArray, typename TKey>
		static sint32 Find(const TArray& ary, const TKey& key)
		{
			for(typename TArray::size_type i = 0; i < ary.size(); ++i)
			{
				const char* pKeyOffset = ((const char*)(&(ary[i])))+T::ArreyKeyOffset;
				if(memcmp(pKeyOffset, &key, sizeof(key)) == 0)
				{
					return i;
				}
			}

			return -1;
		}
	};

	template<class TArrayT, sint32 N, typename LenType = typename std::conditional<N<=255, uint8, 
		typename std::conditional<N<=65535,uint16,uint32>::type>::type>
	class CArray : public IStreamableAll{
	public:
		CArray()
		{
			_AryTypeClean<std::is_trivial<TArrayT>::value>::Clean(_elems, sizeof(_elems));
			_length = 0;
		}

	protected:
		LenType _length;
		TArrayT _elems[N];
		
    public:
        typedef TArrayT				value_type;
        typedef TArrayT*			iterator;
		typedef TArrayT*			pointer_type;
        typedef const TArrayT*		const_iterator;
        typedef TArrayT&			reference;
        typedef const TArrayT&		const_reference;
        typedef LenType				size_type;
        typedef std::ptrdiff_t		difference_type;
		typedef sint8				TArrayContType;
		typedef std::reverse_iterator<iterator> reverse_iterator;
		typedef std::reverse_iterator<const_iterator> const_reverse_iterator;
	public:
        iterator begin()			
		{ 
			return _elems;
		}
        const_iterator begin() const	
		{
			return _elems;
		}
        const_iterator cbegin() const	
		{ 
			return _elems; 
		}

        iterator end()
		{ 
			return _elems+_length;
		}
        const_iterator end() const
		{
			return _elems+_length;
		}
        const_iterator	cend() const
		{ 
			return _elems+_length;
		}

        reverse_iterator rbegin() 
		{ 
			return reverse_iterator(end());
		}
        const_reverse_iterator rbegin() const 
        {
            return const_reverse_iterator(end());
        }
        const_reverse_iterator crbegin() const
        {
            return const_reverse_iterator(end());
        }
        reverse_iterator rend() 
		{
			return reverse_iterator(begin());
		}
        const_reverse_iterator rend() const 
        {
            return const_reverse_iterator(begin());
        }
        const_reverse_iterator crend() const
        {
            return const_reverse_iterator(begin());
        }

        bool find(const value_type& v)
        {
            for(sint32 i = 0; i < (sint32)size(); ++i)
            {
                if(_elems[i] == v)
                {
                    return true;
                }
            }

            return false;
        }

		template<typename KeyT>
		iterator findByKey(const KeyT& key)
		{
			sint32 index = CArrayFinder<value_type>::Find(*this, key);
			if(index != -1)
			{
				return &(_elems[index]);
			}

			return end();
		}

		template<typename KeyT>
		value_type* findDataByKey(const KeyT& key)
		{
			sint32 index = CArrayFinder<value_type>::Find(*this, key);
			if(index != -1)
			{
				return &(_elems[index]);
			}

			return NULL;
		}

		template<typename KeyT>
		bool isExistByKey(const KeyT& key)
		{
			return findByKey(key) != end();
		}

        void erase(LenType i)
        {
            rangeCheck(i);
            if(_length > i)
            {
                LenType count = _length-i-1;
                if(count > 0)
                {
                    memcpy(_elems+i, _elems+i+1, sizeof(value_type)*count);
                }
                _length--;
            }
        }

        reference operator[](LenType i) 
        { 
            rangeCheck(i);
            return _elems[i];
        }
        const_reference operator[](LenType i) const 
        {     
            rangeCheck(i);
            return _elems[i]; 
        }
        reference at(LenType i) 
        { 
            rangeCheck(i);
            return _elems[i];
        }
        const_reference at(LenType i) const 
        {     
            rangeCheck(i);
            return _elems[i]; 
        }
        reference front() 
        { 
            return _elems[0]; 
        }
        const_reference front() const 
        {
            return _elems[0];
        }
        reference back() 
        { 
            rangeCheck(_length-1);
            return _elems[_length-1]; 
        }
        const_reference back() const 
        { 
            rangeCheck(_length-1);
            return _elems[_length-1]; 
        }
        bool pushBack(const value_type& value)
        {
            assert(_length < maxSize());
            if(_length < maxSize())
            {
                _elems[_length] = value;
                _length++;
                return true;
            }

            return false;
        }
        bool pushBack(const char* values, LenType sizes)
        {   
            assert(sizes%sizeof(value_type) == 0);
            assert(sizes >= 0);
			LenType cc = (LenType)sizes / sizeof(value_type);
            if((_length+cc) > maxSize())
            {
                return false;
            }
            memcpy(curData(), values, sizes);
            _length += cc;

            return true;
        }
		bool push_back(const value_type& value)
		{
			return pushBack(value);
		}
		template<typename Cont>
		void pushCont(const Cont& cont)
		{
			for(typename Cont::const_iterator iter = cont.begin(); iter != cont.end(); ++iter)
			{
				pushBack(*iter);
			}
		}

        void popBack()
        {
            if(_length > 0)
            {
                _length = _length-1;
            }
        }

        template<typename Cont>
        void getCont(Cont& cont)
        {
            for(LenType i = 0; i < _length; ++i)
            {
                cont.push_back(_elems[i]);
            }
        }

		template<typename Cont>
		void getCont(Cont& cont) const
		{
			for(LenType i = 0; i < _length; ++i)
			{
				cont.push_back(_elems[i]);
			}
		}

        void clear()
        {
            _length = 0;
			_AryTypeClean<std::is_pod<TArrayT>::value>::Clean(_elems, sizeof(_elems));
        }

        void resize(LenType len)
        {
			_length = std::min<sint32>(len, N);
        }

		reference addSize(LenType len = 1)
		{
			if(len < 1)
			{
				len = 1;
			}
			_length = std::min<sint32>(_length+len, N);
			return back();
		}

		bool empty() const 
		{ 
			return _length == 0;
		}
		bool isMax() const
		{ 
			return size() >= maxSize();
		}
		LenType size() const 
		{
			return std::min<LenType>(_length, N);
		}
		inline LenType maxSize() const
		{ 
			return (LenType)N; 
		}
		LenType capacity() const 
		{ 
			return maxSize()-size(); 
		}
		uint32 sizeInBytes() const 
		{ 
			return (uint32)(sizeof(_length)+sizeof(value_type)*_length);
		}
		uint32 sizeInBytesNoLen() const 
		{ 
			return sizeof(value_type)*_length;
		}
		inline uint32 maxSizeInBytes() const
		{
			return sizeof(_length)+sizeof(value_type)*N;
		}
		uint32 capacityInBytes() const 
		{
			return maxSizeInBytes()-sizeInBytes();
		}

        void swap (CArray<value_type,N>& y)
        {
            for (LenType i = 0; i < N; ++i)
            {
                std::swap((*this), y);
            }
        }

        const value_type* data() const 
		{
			return _elems;
		}
        value_type* data() 
		{ 
			return _elems; 
		}
        value_type* curData()
		{
			return _elems+_length; 
		}

        template <typename T2>
        CArray<value_type,N>& operator= (const CArray<T2,N>& rhs)
        {
			if(!rhs.empty())
			{
				std::copy(rhs.begin(), rhs.end(), begin());
			}
            _length = rhs.size();
            return *this;
        }
        CArray<value_type,N>& operator= (const CArray<value_type,N>& rhs)
        {
			if(!rhs.empty())
			{
				std::copy(rhs.begin(), rhs.end(), begin());
			}
            _length = rhs.size();
            return *this;
        }

        void assign (const value_type& value, LenType n = N)
        {
            std::fill_n(begin(), n, value);
            _length = n;
        }
		void assign(iterator startIter, iterator endIter)
		{
			std::copy(startIter, endIter, begin());
		}
		void assign(iterator startIter, LenType n)
		{
			assign(startIter, startIter+n);
		}

        void rangeCheck (LenType i) const
        {
#ifdef LIB_DEBUG
            if (i >= size())
            {
				assert(false);
            }
#endif
        }

        void refix()
        {
            _length = _length > maxSize() ? maxSize() : _length;
        }

		void serial(GXMISC::IStream& f)
		{
			f.serial(this->_length);
			for(sint32 i = 0; i < (sint32)this->_length; ++i)
			{
				f.serial(this->_elems[i]);
			}
		}

		uint32 serialLen() const
		{
			uint32 len = sizeof(this->_length);
			for(sint32 i = 0; i < (sint32)this->_length; ++i)
			{
				len += GXMISC::IStream::SerialLen(this->_elems[i]);
			}

			return len;
		}

		void unSerial(GXMISC::IUnStream& f)
		{
			f.serial(this->_length);
			for(sint32 i = 0; i < (sint32)this->_length; ++i)
			{
				f.serial(this->_elems[i]);
			}
		}

		uint32 unSerialLen()
		{
			uint32 len = sizeof(this->_length);
			for(sint32 i = 0; i < (sint32)this->_length; ++i)
			{
				len += GXMISC::IUnStream::SerialLen(this->_elems[i]);
			}

			return len;
		}
    };

	typedef struct _TraitTypeObject
	{
	}TTraitTypeObj;
	typedef struct _TraitTypeAry : public TTraitTypeObj
	{
	}TTraitTypeAry;
	typedef struct _TraitTypeTinyAry : public TTraitTypeAry
	{
	}TTraitTypeTinyAry;
	typedef struct _TraitTypeSmallAry : public TTraitTypeAry
	{
	}TTraitTypeSmallAry;
	typedef struct _TraitTypeBigAry : public TTraitTypeAry
	{
	}TTraitTypeBigAry;

	template<uint32 N, typename LenType=uint32>
	class CCharArray : public CArray<char, N+1, LenType>
    {
	public:
		typedef char HashKeyType;
		const static HashKeyType InvalidKey = '0';

	public:
		template<typename T, typename VoidT=void>
		class CAryInnerTypeTraits
		{
		};

		template<typename VoidT>
		class CAryInnerTypeTraits<uint8, VoidT>
		{
		public:
			typedef TTraitTypeTinyAry TTraitType;
		};
		template<typename VoidT>
		class CAryInnerTypeTraits<sint8, VoidT>
		{
		public:
			typedef TTraitTypeTinyAry TTraitType;
		};
		template<typename VoidT>
		class CAryInnerTypeTraits<uint16, VoidT>
		{
		public:
			typedef TTraitTypeSmallAry TTraitType;
		};
		template<typename VoidT>
		class CAryInnerTypeTraits<sint16, VoidT>
		{
		public:
			typedef TTraitTypeSmallAry TTraitType;
		};
		template<typename VoidT>
		class CAryInnerTypeTraits<uint32, VoidT>
		{
		public:
			typedef TTraitTypeBigAry TTraitType;
		};
		template<typename VoidT>
		class CAryInnerTypeTraits<sint32, VoidT>
		{
		public:
			typedef TTraitTypeBigAry TTraitType;
		};

	public:
		typedef CArray<char, N+1, LenType> TBaseType;
		typedef typename CArray<char, N+1, LenType>::size_type size_type;
		typedef typename CAryInnerTypeTraits<LenType>::TTraitType TTraitType;

    public:
        CCharArray() : TBaseType()
        {
            this->_length = 0;
            memset(this->_elems, 0, sizeof(this->_elems));
        }
        CCharArray(const char* msg) : TBaseType()
        {
			this->clear();
            this->pushBack(msg, (LenType)strlen(msg));
        }
        const std::string toString() const
        {
            assert(!this->isMax());
            std::string str(this->_elems, this->_length);
            return str;
        }
        CCharArray<N, LenType>& operator=(const char* msg)
        {
			this->clear();
            this->pushBack(msg, (LenType)strlen(msg));
            return *this;
        }
        CCharArray<N,LenType>& operator=(const CCharArray<N,LenType>& rhs)
        {
			this->clear();
            memcpy(this->_elems, rhs.data(),rhs.size());
            this->_length = rhs.size();
            return *this;
        }
		bool operator == (const CCharArray<N,LenType>& rhs)
		{
			if(rhs.size() != this->size()){
				return false;
			}

			return strcmp(this->data(), rhs.data());
		}
		bool operator != (const CCharArray<N,LenType>& rhs)
		{
			return !(*this == rhs);
		}
		bool operator == (char ch)
		{
			if(this->size() > 1){
				return false;
			}
			if(ch == 0){
				if(!this->empty()){
					return false;
				}

				return true;
			}else{
				if(this->empty()){
					return false;
				}

				return this->at(0) == ch;
			}

			return false;
		}
		bool operator != (char ch)
		{
			return !(*this == ch);
		}
		operator char(){
			return '\0';
		}
    };

#pragma pack(pop)
}

// ²Î¿¼afxtempl.h
/*
// CArray<TYPE, ARG_TYPE>

template<class TYPE, class ARG_TYPE = const TYPE&>
class CArray : public CObject
{
public:
// Construction
CArray();

// Attributes
INT_PTR GetSize() const;
INT_PTR GetCount() const;
BOOL IsEmpty() const;
INT_PTR GetUpperBound() const;
void SetSize(INT_PTR nNewSize, INT_PTR nGrowBy = -1);

// Operations
// Clean up
void FreeExtra();
void RemoveAll();

// Accessing elements
const TYPE& GetAt(INT_PTR nIndex) const;
TYPE& GetAt(INT_PTR nIndex);
void SetAt(INT_PTR nIndex, ARG_TYPE newElement);
const TYPE& ElementAt(INT_PTR nIndex) const;
TYPE& ElementAt(INT_PTR nIndex);

// Direct Access to the element data (may return NULL)
const TYPE* GetData() const;
TYPE* GetData();

// Potentially growing the array
void SetAtGrow(INT_PTR nIndex, ARG_TYPE newElement);
INT_PTR Add(ARG_TYPE newElement);
INT_PTR Append(const CArray& src);
void Copy(const CArray& src);

// overloaded operator helpers
const TYPE& operator[](INT_PTR nIndex) const;
TYPE& operator[](INT_PTR nIndex);

// Operations that move elements around
void InsertAt(INT_PTR nIndex, ARG_TYPE newElement, INT_PTR nCount = 1);
void RemoveAt(INT_PTR nIndex, INT_PTR nCount = 1);
void InsertAt(INT_PTR nStartIndex, CArray* pNewArray);

// Implementation
protected:
TYPE* m_pData;   // the actual array of data
INT_PTR m_nSize;     // # of elements (upperBound - 1)
INT_PTR m_nMaxSize;  // max allocated
INT_PTR m_nGrowBy;   // grow amount

public:
~CArray();
void Serialize(CArchive&);
#ifdef _DEBUG
void Dump(CDumpContext&) const;
void AssertValid() const;
#endif
};

/////////////////////////////////////////////////////////////////////////////
// CArray<TYPE, ARG_TYPE> inline functions

template<class TYPE, class ARG_TYPE>
AFX_INLINE INT_PTR CArray<TYPE, ARG_TYPE>::GetSize() const
{ return m_nSize; }
template<class TYPE, class ARG_TYPE>
AFX_INLINE INT_PTR CArray<TYPE, ARG_TYPE>::GetCount() const
{ return m_nSize; }
template<class TYPE, class ARG_TYPE>
AFX_INLINE BOOL CArray<TYPE, ARG_TYPE>::IsEmpty() const
{ return m_nSize == 0; }
template<class TYPE, class ARG_TYPE>
AFX_INLINE INT_PTR CArray<TYPE, ARG_TYPE>::GetUpperBound() const
{ return m_nSize-1; }
template<class TYPE, class ARG_TYPE>
AFX_INLINE void CArray<TYPE, ARG_TYPE>::RemoveAll()
{ SetSize(0, -1); }
template<class TYPE, class ARG_TYPE>
AFX_INLINE TYPE& CArray<TYPE, ARG_TYPE>::GetAt(INT_PTR nIndex)
{ 
ASSERT(nIndex >= 0 && nIndex < m_nSize);
if(nIndex >= 0 && nIndex < m_nSize)
return m_pData[nIndex]; 
AfxThrowInvalidArgException();		
}
template<class TYPE, class ARG_TYPE>
AFX_INLINE const TYPE& CArray<TYPE, ARG_TYPE>::GetAt(INT_PTR nIndex) const
{
ASSERT(nIndex >= 0 && nIndex < m_nSize);
if(nIndex >= 0 && nIndex < m_nSize)
return m_pData[nIndex]; 
AfxThrowInvalidArgException();		
}
template<class TYPE, class ARG_TYPE>
AFX_INLINE void CArray<TYPE, ARG_TYPE>::SetAt(INT_PTR nIndex, ARG_TYPE newElement)
{ 
ASSERT(nIndex >= 0 && nIndex < m_nSize);
if(nIndex >= 0 && nIndex < m_nSize)
m_pData[nIndex] = newElement; 
else
AfxThrowInvalidArgException();		
}
template<class TYPE, class ARG_TYPE>
AFX_INLINE const TYPE& CArray<TYPE, ARG_TYPE>::ElementAt(INT_PTR nIndex) const
{ 
ASSERT(nIndex >= 0 && nIndex < m_nSize);
if(nIndex >= 0 && nIndex < m_nSize)
return m_pData[nIndex]; 
AfxThrowInvalidArgException();		
}
template<class TYPE, class ARG_TYPE>
AFX_INLINE TYPE& CArray<TYPE, ARG_TYPE>::ElementAt(INT_PTR nIndex)
{ 
ASSERT(nIndex >= 0 && nIndex < m_nSize);
if(nIndex >= 0 && nIndex < m_nSize)
return m_pData[nIndex]; 
AfxThrowInvalidArgException();		
}
template<class TYPE, class ARG_TYPE>
AFX_INLINE const TYPE* CArray<TYPE, ARG_TYPE>::GetData() const
{ return (const TYPE*)m_pData; }
template<class TYPE, class ARG_TYPE>
AFX_INLINE TYPE* CArray<TYPE, ARG_TYPE>::GetData()
{ return (TYPE*)m_pData; }
template<class TYPE, class ARG_TYPE>
AFX_INLINE INT_PTR CArray<TYPE, ARG_TYPE>::Add(ARG_TYPE newElement)
{ INT_PTR nIndex = m_nSize;
SetAtGrow(nIndex, newElement);
return nIndex; }
template<class TYPE, class ARG_TYPE>
AFX_INLINE const TYPE& CArray<TYPE, ARG_TYPE>::operator[](INT_PTR nIndex) const
{ return GetAt(nIndex); }
template<class TYPE, class ARG_TYPE>
AFX_INLINE TYPE& CArray<TYPE, ARG_TYPE>::operator[](INT_PTR nIndex)
{ return ElementAt(nIndex); }

/////////////////////////////////////////////////////////////////////////////
// CArray<TYPE, ARG_TYPE> out-of-line functions

template<class TYPE, class ARG_TYPE>
CArray<TYPE, ARG_TYPE>::CArray()
{
m_pData = NULL;
m_nSize = m_nMaxSize = m_nGrowBy = 0;
}

template<class TYPE, class ARG_TYPE>
CArray<TYPE, ARG_TYPE>::~CArray()
{
ASSERT_VALID(this);

if (m_pData != NULL)
{
for( int i = 0; i < m_nSize; i++ )
(m_pData + i)->~TYPE();
delete[] (BYTE*)m_pData;
}
}

template<class TYPE, class ARG_TYPE>
void CArray<TYPE, ARG_TYPE>::SetSize(INT_PTR nNewSize, INT_PTR nGrowBy)
{
ASSERT_VALID(this);
ASSERT(nNewSize >= 0);

if(nNewSize < 0 )
AfxThrowInvalidArgException();

if (nGrowBy >= 0)
m_nGrowBy = nGrowBy;  // set new size

if (nNewSize == 0)
{
// shrink to nothing
if (m_pData != NULL)
{
for( int i = 0; i < m_nSize; i++ )
(m_pData + i)->~TYPE();
delete[] (BYTE*)m_pData;
m_pData = NULL;
}
m_nSize = m_nMaxSize = 0;
}
else if (m_pData == NULL)
{
// create buffer big enough to hold number of requested elements or
// m_nGrowBy elements, whichever is larger.
#ifdef SIZE_T_MAX
ASSERT(nNewSize <= SIZE_T_MAX/sizeof(TYPE));    // no overflow
#endif
size_t nAllocSize = __max(nNewSize, m_nGrowBy);
m_pData = (TYPE*) new BYTE[(size_t)nAllocSize * sizeof(TYPE)];
memset((void*)m_pData, 0, (size_t)nAllocSize * sizeof(TYPE));
for( int i = 0; i < nNewSize; i++ )
#pragma push_macro("new")
#undef new
::new( (void*)( m_pData + i ) ) TYPE;
#pragma pop_macro("new")
m_nSize = nNewSize;
m_nMaxSize = nAllocSize;
}
else if (nNewSize <= m_nMaxSize)
{
// it fits
if (nNewSize > m_nSize)
{
// initialize the new elements
memset((void*)(m_pData + m_nSize), 0, (size_t)(nNewSize-m_nSize) * sizeof(TYPE));
for( int i = 0; i < nNewSize-m_nSize; i++ )
#pragma push_macro("new")
#undef new
::new( (void*)( m_pData + m_nSize + i ) ) TYPE;
#pragma pop_macro("new")
}
else if (m_nSize > nNewSize)
{
// destroy the old elements
for( int i = 0; i < m_nSize-nNewSize; i++ )
(m_pData + nNewSize + i)->~TYPE();
}
m_nSize = nNewSize;
}
else
{
// otherwise, grow array
nGrowBy = m_nGrowBy;
if (nGrowBy == 0)
{
// heuristically determine growth when nGrowBy == 0
//  (this avoids heap fragmentation in many situations)
nGrowBy = m_nSize / 8;
nGrowBy = (nGrowBy < 4) ? 4 : ((nGrowBy > 1024) ? 1024 : nGrowBy);
}
INT_PTR nNewMax;
if (nNewSize < m_nMaxSize + nGrowBy)
nNewMax = m_nMaxSize + nGrowBy;  // granularity
else
nNewMax = nNewSize;  // no slush

ASSERT(nNewMax >= m_nMaxSize);  // no wrap around

if(nNewMax  < m_nMaxSize)
AfxThrowInvalidArgException();

#ifdef SIZE_T_MAX
ASSERT(nNewMax <= SIZE_T_MAX/sizeof(TYPE)); // no overflow
#endif
TYPE* pNewData = (TYPE*) new BYTE[(size_t)nNewMax * sizeof(TYPE)];

// copy new data from old
::ATL::Checked::memcpy_s(pNewData, (size_t)nNewMax * sizeof(TYPE),
m_pData, (size_t)m_nSize * sizeof(TYPE));

// construct remaining elements
ASSERT(nNewSize > m_nSize);
memset((void*)(pNewData + m_nSize), 0, (size_t)(nNewSize-m_nSize) * sizeof(TYPE));
for( int i = 0; i < nNewSize-m_nSize; i++ )
#pragma push_macro("new")
#undef new
::new( (void*)( pNewData + m_nSize + i ) ) TYPE;
#pragma pop_macro("new")

// get rid of old stuff (note: no destructors called)
delete[] (BYTE*)m_pData;
m_pData = pNewData;
m_nSize = nNewSize;
m_nMaxSize = nNewMax;
}
}

template<class TYPE, class ARG_TYPE>
INT_PTR CArray<TYPE, ARG_TYPE>::Append(const CArray& src)
{
ASSERT_VALID(this);
ASSERT(this != &src);   // cannot append to itself

if(this == &src)
AfxThrowInvalidArgException();

INT_PTR nOldSize = m_nSize;
SetSize(m_nSize + src.m_nSize);
CopyElements<TYPE>(m_pData + nOldSize, src.m_pData, src.m_nSize);
return nOldSize;
}

template<class TYPE, class ARG_TYPE>
void CArray<TYPE, ARG_TYPE>::Copy(const CArray& src)
{
ASSERT_VALID(this);
ASSERT(this != &src);   // cannot append to itself

if(this != &src)
{
SetSize(src.m_nSize);
CopyElements<TYPE>(m_pData, src.m_pData, src.m_nSize);
}
}

template<class TYPE, class ARG_TYPE>
void CArray<TYPE, ARG_TYPE>::FreeExtra()
{
ASSERT_VALID(this);

if (m_nSize != m_nMaxSize)
{
// shrink to desired size
#ifdef SIZE_T_MAX
ASSERT(m_nSize <= SIZE_T_MAX/sizeof(TYPE)); // no overflow
#endif
TYPE* pNewData = NULL;
if (m_nSize != 0)
{
pNewData = (TYPE*) new BYTE[m_nSize * sizeof(TYPE)];
// copy new data from old
::ATL::Checked::memcpy_s(pNewData, m_nSize * sizeof(TYPE),
m_pData, m_nSize * sizeof(TYPE));
}

// get rid of old stuff (note: no destructors called)
delete[] (BYTE*)m_pData;
m_pData = pNewData;
m_nMaxSize = m_nSize;
}
}

template<class TYPE, class ARG_TYPE>
void CArray<TYPE, ARG_TYPE>::SetAtGrow(INT_PTR nIndex, ARG_TYPE newElement)
{
ASSERT_VALID(this);
ASSERT(nIndex >= 0);

if(nIndex < 0)
AfxThrowInvalidArgException();

if (nIndex >= m_nSize)
SetSize(nIndex+1, -1);
m_pData[nIndex] = newElement;
}

template<class TYPE, class ARG_TYPE>
void CArray<TYPE, ARG_TYPE>::InsertAt(INT_PTR nIndex, ARG_TYPE newElement, INT_PTR nCount)
{
    ASSERT_VALID(this);
    ASSERT(nIndex >= 0);    // will expand to meet need
    ASSERT(nCount > 0);     // zero or negative size not allowed

    if(nIndex < 0 || nCount <= 0)
        AfxThrowInvalidArgException();

    if (nIndex >= m_nSize)
    {
        // adding after the end of the array
        SetSize(nIndex + nCount, -1);   // grow so nIndex is valid
    }
    else
    {
        // inserting in the middle of the array
        INT_PTR nOldSize = m_nSize;
        SetSize(m_nSize + nCount, -1);  // grow it to new size
        // destroy intial data before copying over it
        for( int i = 0; i < nCount; i++ )
            (m_pData + nOldSize + i)->~TYPE();
        // shift old data up to fill gap
        ::ATL::Checked::memmove_s(m_pData + nIndex + nCount, (nOldSize-nIndex) * sizeof(TYPE),
            m_pData + nIndex, (nOldSize-nIndex) * sizeof(TYPE));

        // re-init slots we copied from
        memset((void*)(m_pData + nIndex), 0, (size_t)nCount * sizeof(TYPE));
        for( int i = 0; i < nCount; i++ )
#pragma push_macro("new")
#undef new
            ::new( (void*)( m_pData + nIndex + i ) ) TYPE;
#pragma pop_macro("new")
    }

    // insert new value in the gap
    ASSERT(nIndex + nCount <= m_nSize);
    while (nCount--)
        m_pData[nIndex++] = newElement;
}

template<class TYPE, class ARG_TYPE>
void CArray<TYPE, ARG_TYPE>::RemoveAt(INT_PTR nIndex, INT_PTR nCount)
{
    ASSERT_VALID(this);
    ASSERT(nIndex >= 0);
    ASSERT(nCount >= 0);
    INT_PTR nUpperBound = nIndex + nCount;
    ASSERT(nUpperBound <= m_nSize && nUpperBound >= nIndex && nUpperBound >= nCount);

    if(nIndex < 0 || nCount < 0 || (nUpperBound > m_nSize) || (nUpperBound < nIndex) || (nUpperBound < nCount))
        AfxThrowInvalidArgException();

    // just remove a range
    INT_PTR nMoveCount = m_nSize - (nUpperBound);
    for( int i = 0; i < nCount; i++ )
        (m_pData + nIndex + i)->~TYPE();
    if (nMoveCount)
    {
        ::ATL::Checked::memmove_s(m_pData + nIndex, (size_t)nMoveCount * sizeof(TYPE),
            m_pData + nUpperBound, (size_t)nMoveCount * sizeof(TYPE));
    }
    m_nSize -= nCount;
}

template<class TYPE, class ARG_TYPE>
void CArray<TYPE, ARG_TYPE>::InsertAt(INT_PTR nStartIndex, CArray* pNewArray)
{
    ASSERT_VALID(this);
    ASSERT(pNewArray != NULL);
    ASSERT_VALID(pNewArray);
    ASSERT(nStartIndex >= 0);

    if(pNewArray == NULL || nStartIndex < 0)
        AfxThrowInvalidArgException();

    if (pNewArray->GetSize() > 0)
    {
        InsertAt(nStartIndex, pNewArray->GetAt(0), pNewArray->GetSize());
        for (INT_PTR i = 0; i < pNewArray->GetSize(); i++)
            SetAt(nStartIndex + i, pNewArray->GetAt(i));
    }
}

template<class TYPE, class ARG_TYPE>
void CArray<TYPE, ARG_TYPE>::Serialize(CArchive& ar)
{
    ASSERT_VALID(this);

    CObject::Serialize(ar);
    if (ar.IsStoring())
    {
        ar.WriteCount(m_nSize);
    }
    else
    {
        DWORD_PTR nOldSize = ar.ReadCount();
        SetSize(nOldSize, -1);
    }
    SerializeElements<TYPE>(ar, m_pData, m_nSize);
}

#ifdef _DEBUG
template<class TYPE, class ARG_TYPE>
void CArray<TYPE, ARG_TYPE>::Dump(CDumpContext& dc) const
{
    CObject::Dump(dc);

    dc << "with " << m_nSize << " elements";
    if (dc.GetDepth() > 0)
    {
        dc << "\n";
        DumpElements<TYPE>(dc, m_pData, m_nSize);
    }

    dc << "\n";
}

template<class TYPE, class ARG_TYPE>
void CArray<TYPE, ARG_TYPE>::AssertValid() const
{
    CObject::AssertValid();

    if (m_pData == NULL)
    {
        ASSERT(m_nSize == 0);
        ASSERT(m_nMaxSize == 0);
    }
    else
    {
        ASSERT(m_nSize >= 0);
        ASSERT(m_nMaxSize >= 0);
        ASSERT(m_nSize <= m_nMaxSize);
        ASSERT(AfxIsValidAddress(m_pData, m_nMaxSize * sizeof(TYPE)));
    }
}
#endif //_DEBUG
 */

#endif