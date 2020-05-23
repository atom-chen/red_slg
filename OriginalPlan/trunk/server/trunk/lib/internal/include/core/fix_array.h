#ifndef _FIX_ARRAY_H_
#define _FIX_ARRAY_H_

//#include <boost/type_traits/is_pod.hpp>
#include "debug.h"

namespace GXMISC
{
#pragma pack(push, 1)

    template<bool>
    class _FixTypeClean
    {
    public:
        static void Clean(void* buf, sint32 len)
        {
            memset(buf, 0, len);
        }
    };

    template<>
    class _FixTypeClean<false>
    {
    public:
        static void Clean(void* buf, sint32 len)
        {
        }
    };

    template<class T, sint32 N>
    class CFixArray 
    {
    public:
        CFixArray()
        {
			_FixTypeClean<std::is_trivial<T>::value>::Clean(_elems, sizeof(_elems));
        }

    protected:
        T       _elems[N];

    public:
        // type definitions
        typedef T				value_type;
        typedef T*				iterator;
        typedef const T*		const_iterator;
        typedef T&				reference;
        typedef const T&		const_reference;
        typedef uint32			size_type;
        typedef std::ptrdiff_t	difference_type;

        // iterator support
        iterator        begin()			{ return _elems; }
        const_iterator  begin() const	{ return _elems; }
        const_iterator	cbegin() const	{ return _elems; }

        iterator        end()			{ return _elems+N; }
        const_iterator  end() const		{ return _elems+N; }
        const_iterator	cend() const	{ return _elems+N; }

        // reverse iterator support
        typedef std::reverse_iterator<iterator> reverse_iterator;
        typedef std::reverse_iterator<const_iterator> const_reverse_iterator;

        reverse_iterator rbegin() { return reverse_iterator(end()); }
        const_reverse_iterator rbegin() const 
        {
            return const_reverse_iterator(end());
        }
        const_reverse_iterator crbegin() const
        {
            return const_reverse_iterator(end());
        }

        reverse_iterator rend() { return reverse_iterator(begin()); }
        const_reverse_iterator rend() const 
        {
            return const_reverse_iterator(begin());
        }
        const_reverse_iterator crend() const
        {
            return const_reverse_iterator(begin());
        }

		template<typename T2>
		bool find(const T2& v)
		{
			for(sint32 i = 0; i < maxSize(); ++i)
            {
                if(_elems[i] == v)
                {
                    return true;
                }
            }

            return false;
        }

        void rangeCheck(sint32 i) const
        {
#ifdef LIB_DEBUG
            if(i >= N)
            {
                gxAssert(false);
            }
#endif
        }

        // operator[]
        reference operator[](size_type i)
        { 
            rangeCheck(i);
            return _elems[i];
        }
        const_reference operator[](size_type i) const 
        {     
            rangeCheck(i);
            return _elems[i]; 
        }

        reference at(size_type i)
        { 
            rangeCheck(i);
            return _elems[i];
        }
        const_reference at(size_type i) const 
        {     
            rangeCheck(i);
            return _elems[i]; 
        }

        // front() and back()
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
            return _elems[N-1]; 
        }
        const_reference back() const 
        { 
            return _elems[N-1]; 
        }

        template<typename Cont>
        void assignCont(const Cont& cont)
        {
            uint32 i = 0;
            for(typename Cont::const_iterator iter = cont.begin(); iter != cont.end(); ++iter, ++i)
            {
                _elems[i] = *iter;
            }
        }

        // size is constant
        size_type maxSize() { return N; }
        size_type maxSize() const { return N; }
        uint32 sizeInBytes() const { return sizeof(T)*maxSize(); }

        // swap (note: linear complexity)
        void swap (CFixArray<T,N>& y)
        {
            for (size_type i = 0; i < N; ++i)
            {
                std::swap((*this), y);
            }
        }

        // direct access to data (read-only)
        const T* data() const { return _elems; }
        T* data() { return _elems; }

        // assignment with type conversion
        template <typename T2>
        CFixArray<T,N>& operator= (const CFixArray<T2,N>& rhs)
        {
            std::copy(rhs.begin(),rhs.end(), begin());
            return *this;
        }
        CFixArray<T,N>& operator= (const CFixArray<T,N>& rhs)
        {
            std::copy(rhs.begin(), rhs.end(), begin());
            return *this;
        }

        // assign one value to all elements
        void assign (const T& value, sint32 n = N)
        {
            std::fill_n(begin(), n, value);
        }
    };

#pragma pack(pop)

}

#endif