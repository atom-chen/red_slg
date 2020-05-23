#ifndef _BIT_SET_H_
#define _BIT_SET_H_

#include "types_def.h"
#include "debug.h"

namespace	GXMISC
{
    // Size in bit of base word.

#pragma pack(push, 1)

    /**
    * 变长位集合
    */
    class	CBitSet
    {
        enum
        {
            BIT_LEN = (4*8),
            BIT_LEN_SHIFT = 5,
        };
    public:
        /// \name Object.
        //@{
        CBitSet();
        CBitSet(uint32 numBits);
        CBitSet(const CBitSet &bs);
        ~CBitSet();
        CBitSet	&operator=(const CBitSet &bs);
        //@}

        /// \name Basics.
        //@{
        /// Resize the bit array. All Bits are reseted.
        void	resize (uint32 numBits);

        /// Resize the bit array. Bits are not reseted. New bits are set with value.
        void	resizeNoReset (uint32 numBits, bool value=false);

        /// Clear the bitarray so size() return 0.
        void	clear();

        /// Return size of the bit array.
        uint32	size() const
        {
            return _numBits;
        }

        uint32 sizeInBytes()
        {
            return (uint32)(_array.size()*sizeof(sint32));
        }

        /// Set a bit to 0 or 1.
        void	set(sint32 bitNumber, bool value)
        {
            gxAssert(bitNumber>=0 && bitNumber<_numBits);

            uint32	mask= bitNumber&(BIT_LEN-1);
            mask= 1<<mask;
            if(value)
                _array[bitNumber >> BIT_LEN_SHIFT]|= mask ;
            else
                _array[bitNumber >> BIT_LEN_SHIFT]&= ~mask;
        }
        /// Get the value of a bit.
        bool	get(sint32 bitNumber) const
        {
            gxAssert(bitNumber>=0 && bitNumber<_numBits);

            uint32	mask= bitNumber&(BIT_LEN-1);
            mask= 1<<mask;
            return (_array[bitNumber >> BIT_LEN_SHIFT] & mask) != 0;
        }
        /// Get the value of a bit.
        bool	operator[](sint32 bitNumber) const
        {
            return get(bitNumber);
        }
        /// Set a bit to 1.
        void	set(sint32 bitNumber) {set(bitNumber, true);}
        /// Set a bit to 0.
        void	clear(sint32 bitNumber) {set(bitNumber, false);}
        /// Set all bits to 1.
        void	setAll();
        /// Set all bits to 0.
        void	clearAll();
        //@}


        /// \name Bit operations.
        //@{
        /// Return The bitarray NOTed.
        CBitSet	operator~() const;
        /**
        * Return this ANDed with bs.
        * The result BitSet is of size of \c *this. Any missing bits into bs will be considered as 0.
        */
        CBitSet	operator&(const CBitSet &bs) const;
        /**
        * Return this ORed with bs.
        * The result BitSet is of size of \c *this. Any missing bits into bs will be considered as 0.
        */
        CBitSet	operator|(const CBitSet &bs) const;
        /**
        * Return this XORed with bs.
        * The result BitSet is of size of \c *this. Any missing bits into bs will be considered as 0.
        */
        CBitSet	operator^(const CBitSet &bs) const;

        /// NOT the BitArray.
        void	flip();
        /**
        * AND the bitArray with bs.
        * The bitset size is not changed. Any missing bits into bs will be considered as 0.
        */
        CBitSet	&operator&=(const CBitSet &bs);
        /**
        * OR the bitArray with bs.
        * The bitset size is not changed. Any missing bits into bs will be considered as 0.
        */
        CBitSet	&operator|=(const CBitSet &bs);
        /**
        * XOR the bitArray with bs.
        * The bitset size is not changed. Any missing bits into bs will be considered as 0.
        */
        CBitSet	&operator^=(const CBitSet &bs);
        //@}

        /// \name Bit comparisons.
        //@{
        /**
        * Compare two BitSet not necessarely of same size. The comparison is done on N bits, where N=min(this->size(), bs.size())
        * \return true if the N common bits of this and bs are the same. false otherwise.
        */
        bool	compareRestrict(const CBitSet &bs) const;
        /// Compare two BitSet. If not of same size, return false.
        bool	operator==(const CBitSet &bs) const;
        /// operator!=.
        bool	operator!=(const CBitSet &bs) const;
        /// Return true if all bits are set. false if size()==0.
        bool	isAllSet();
        /// Return true if all bits are cleared. false if size()==0.
        bool	isAllCleared();
        //@}

        /// Return the raw vector
        const std::vector<uint32>& getVector() const { return _array; }
        const char* data() 
        {
            if(_array.size() > 0)
            {
                return (char*)&_array[0]; 
            }

            return NULL;
        }
        /// Write an uint32 into the bit set (use with caution, no check)
        void	setUint( uint32 srcValue, uint32 i ) { _array[i] = srcValue; }

        /// Return a string representing the bitfield with 1 and 0 (from left to right)
        std::string	toString() const;

    private:
        std::vector<uint32>	_array;
        sint32				_numBits;
        uint32				_maskLast;	// Mask for the last uint32.
    };

    // 可以定义长度的位标记集合
    template <uint32 nSize>
    class CFixBitSet
    {
    public:
        enum
        {
            BIT_SIZE = nSize,                                           //位标记的长度，单位是二进制位
            BYTE_SIZE = BIT_SIZE%8 == 0 ? BIT_SIZE/8 : 1+BIT_SIZE/8,    //信息区占用的字节数
        };

        CFixBitSet()
        {
            memset((void*)_bitFlags, '\0', sizeof(_bitFlags));
        };

        // 复制构造器
        CFixBitSet(CFixBitSet const& rhs)
        {
            memcpy((void*)_bitFlags, (void*)(rhs.data()), sizeof(_bitFlags));
        };
        virtual ~CFixBitSet() {};

        // 复制操作符
        CFixBitSet& operator=(CFixBitSet const& rhs)
        {
            memcpy((void*)_bitFlags, (void*)(rhs.data()), sizeof(_bitFlags));
            return *this;
        };
	
		bool operator == (CFixBitSet const & rhs)
		{
			return memcmp((void*)_bitFlags, (void*)(rhs.data()), sizeof(_bitFlags)) == 0;
		}

        CFixBitSet& operator &= (const CFixBitSet &bs)
        {
            for(uint32 i = 0; i < BYTE_SIZE; ++i)
            {
                _bitFlags[i] &= bs._bitFlags[i];
            }
            return *this;
        }
        CFixBitSet&	operator |= (const CFixBitSet &bs)
        {
            for(uint32 i = 0; i < BYTE_SIZE; ++i)
            {
                _bitFlags[i] |= bs._bitFlags[i];
            }
            return *this;
        }
        CFixBitSet& operator ^= (const CFixBitSet &bs)
        {
            for(uint32 i = 0; i < BYTE_SIZE; ++i)
            {
                _bitFlags[i] ^= bs._bitFlags[i];
            }

            return *this;
        }

        //设置所有标记位
        void setAll()
        {
            memset((void*)_bitFlags, 0xFF, sizeof(_bitFlags));
        }

        //清除所有标记位
        void clearAll()
        {
            memset((void*)_bitFlags, 0x00, sizeof(_bitFlags));
        }

        //取指定的标记位
        bool get(sint32 const nIdx) const
        {
            if(0>nIdx||BIT_SIZE<=nIdx)
            {
                gxAssertEx(false,"[BitFlagSet_T::GetFlagByIndex]: Index out of range!");
                return false;
            }
            return 0!=(_bitFlags[nIdx>>3]&(char)(1<<nIdx%8));
        }

		/// Get the value of a bit.
		bool	operator[](const sint32 nIdx) const
		{
			return get(nIdx);
		}

        // 清除指定的标记位
        void clear(const sint32 nIdx)
        {
            if(0>nIdx||BIT_SIZE<=nIdx)
            {
                gxAssertEx(false,"[BitFlagSet_T::ClearFlagByIndex]: Index out of range!");
                return;
            }
            _bitFlags[nIdx>>3] &= ~(0x01<<(nIdx%8));
        }

        //设定指定的标记位
        void set(sint32 const nIdx)
        {
            if(0>nIdx || BIT_SIZE<=nIdx)
            {
                gxAssertEx(false, "[BitFlagSet_T::MarkFlagByIndex]: Index out of range!");
                return;
            }

            _bitFlags[nIdx>>3] |=	0x01<<(nIdx%8);
        }

        //所占用的字节数
        uint32 sizeInBytes() const
		{
			return BYTE_SIZE;
		}

        //所支持的标记数
        uint32 size() const 
		{
			return BIT_SIZE;
		}

        // 取数据区的指针
        const char * const data() const 
		{
			return _bitFlags;
		}

        template<typename DataType>
        void toData(DataType& val) const
        {
            gxAssert(sizeof(DataType) >= BYTE_SIZE);
            memcpy(&val, _bitFlags, BYTE_SIZE);
        }

		// 转换成字符串
        operator std::string() const
        {
            std::string str;
            for(sint8 c = BYTE_SIZE-1; c >= 0; --c)
            {
                for ( sint8 i=7; i != -1; --i )
                {
                    str += ( (_bitFlags[c] >> i) & 1 ) ? '1' : '0';
                }
            }

            return str;
        }

        const std::string toString() const
        {
            return *this;
        }
        
	protected:
        char _bitFlags[BYTE_SIZE];  // 数据存储区
    };

	class CBit8 : public CFixBitSet<sizeof(uint8)*8>
	{
	public:
		typedef CFixBitSet<sizeof(uint8)*8> TBaseType;
        typedef uint8 TValueType;
        typedef CBit8 TSelfType;

	public:
		CBit8() : TBaseType() {}
		CBit8(uint8 flag){ memcpy((void*)_bitFlags, (void*)(&flag), sizeof(_bitFlags)); }

		//复制构造器
		CBit8(CBit8 const& rhs)
		{
			memcpy((void*)_bitFlags, (void*)(rhs.data()), sizeof(_bitFlags));
		}
		
		operator uint8()
		{
			return *((uint8*)((void*)_bitFlags));
		}

        TSelfType& operator=(const TValueType& val)
        {
            memcpy(_bitFlags, &val, sizeof(TValueType));
            return *this;
        }

		operator uint8() const
		{
			return *((uint8*)((void*)_bitFlags));
		}
		
		~CBit8() {};

	public:
		uint8 toUInt8()
		{
			return *this;
		}
	};

	class CBit16 : public CFixBitSet<sizeof(uint16)*8>
	{
	public:
		typedef CFixBitSet<sizeof(uint16)*8> TBaseType;
        typedef uint16 TValueType;
        typedef CBit16 TSelfType;

	public:
		CBit16() : TBaseType() {}
		CBit16(uint16 flag){ memcpy((void*)_bitFlags, (void*)(&flag), sizeof(_bitFlags)); }

		//复制构造器
		CBit16(CBit16 const& rhs)
		{
			memcpy((void*)_bitFlags, (void*)(rhs.data()), sizeof(_bitFlags));
		}
        
        TSelfType& operator=(const TValueType& val)
        {
            memcpy(_bitFlags, &val, sizeof(TValueType));
            return *this;
        }

		operator uint16()
		{
			return *((uint16*)((void*)_bitFlags));
		}

        operator uint16() const
        {
            return *((uint16*)((void*)_bitFlags));
        }

		~CBit16() {};

	public:
		uint16 toUInt16()
		{
			return *this;
		}
	};

	class CBit32 : public CFixBitSet<sizeof(uint32)*8>
	{
	public:
		typedef CFixBitSet<sizeof(uint32)*8> TBaseType;
        typedef uint32 TValueType;
        typedef CBit32 TSelfType;

	public:
		CBit32() : TBaseType() {}
		CBit32(uint32 flag){ memcpy((void*)_bitFlags, (void*)(&flag), sizeof(_bitFlags)); }

		//复制构造器
		CBit32(CBit32 const& rhs)
		{
			memcpy((void*)_bitFlags, (void*)(rhs.data()), sizeof(_bitFlags));
		}

        TSelfType& operator=(const TValueType& val)
        {
            memcpy(_bitFlags, &val, sizeof(TValueType));
            return *this;
        }

		operator uint32()
		{
			return *((uint32*)((void*)_bitFlags));
		}
    
        operator uint32() const
        {
            return *((uint32*)((void*)_bitFlags));
        }

		~CBit32() 
		{

		};

	public:
		uint32 toUInt32()
		{
			return *this;
		}
	};

	class CBit64 : public CFixBitSet<sizeof(uint64)*8>
	{
	public:
		typedef CFixBitSet<sizeof(uint64)*8> TBaseType;
        typedef uint64 TValueType;
        typedef CBit64 TSelfType;

	public:
		CBit64() : TBaseType() {}
		CBit64(uint64 flag){ memcpy((void*)_bitFlags, (void*)(&flag), sizeof(_bitFlags)); }

		//复制构造器
		CBit64(CBit64 const& rhs)
		{
			memcpy((void*)_bitFlags, (void*)(rhs.data()), sizeof(_bitFlags));
		}
        
        TSelfType& operator=(const TValueType& val)
        {
            memcpy(_bitFlags, &val, sizeof(TValueType));
            return *this;
        }

		operator uint64()
		{
			return *((uint64*)((void*)_bitFlags));
		}

        operator uint64() const
        {
            return *((uint64*)((void*)_bitFlags));
        }

		~CBit64()
		{

		};

	public:
		uint64 toUInt64()
		{
			return *this;
		}
	};

    typedef CBit8 TBit8_t;
    typedef CBit16 TBit16_t;
    typedef CBit32 TBit32_t;
    typedef CBit64 TBit64_t;

    //判断某位是否被置
    //15.14....3.2.1.0 
    #define DISSET0(x) ((x)&0x1)
    #define DISSET1(x) ((x)&0x2)
    #define DISSET2(x) ((x)&0x4)
    #define DISSET3(x) ((x)&0x8)
    #define DISSET4(x) ((x)&0x10)
    #define DISSET5(x) ((x)&0x20)
    #define DISSET6(x) ((x)&0x40)
    #define DISSET7(x) ((x)&0x80)
    #define DISSET8(x) ((x)&0x100)
    #define DISSET9(x) ((x)&0x200)
    #define DISSET10(x) ((x)&0x400)
    #define DISSET11(x) ((x)&0x800)
    #define DISSET12(x) ((x)&0x1000)
    #define DISSET13(x) ((x)&0x2000)
    #define DISSET14(x) ((x)&0x4000)
    #define DISSET15(x) ((x)&0x8000)

#pragma pack(pop)

}

#endif