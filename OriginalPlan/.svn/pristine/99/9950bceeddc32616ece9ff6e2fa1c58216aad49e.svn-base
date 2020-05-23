#ifndef _GAME_RAND_H_
#define _GAME_RAND_H_

#include "core/singleton.h"
#include "core/debug.h"

class CRandGen : public GXMISC::CManualSingleton<CRandGen>
{
public:
	typedef uint32 TSeedType;
	DSingletonImpl();

private:
	TSeedType _seed[3];
	static const TSeedType Max32BitLong = 0xFFFFFFFFLU;

public:
	static const TSeedType RandomMax = Max32BitLong;

	CRandGen(const TSeedType seed = 0)
	{
		reset(seed);
	}

	//ReSeed the random number generator
	//种子处理
	void reset(const TSeedType seed = 0)
	{		
		_seed[0] = (seed ^ 0xFEA09B9DLU) & 0xFFFFFFFELU;
		_seed[0] ^= (((_seed[0] << 7) & Max32BitLong) ^ _seed[0]) >> 31;

		_seed[1] = (seed ^ 0x9C129511LU) & 0xFFFFFFF8LU;
		_seed[1] ^= (((_seed[1] << 2) & Max32BitLong) ^ _seed[1]) >> 29;

		_seed[2] = (seed ^ 0x2512CFB8LU) & 0xFFFFFFF0LU;
		_seed[2] ^= (((_seed[2] << 9) & Max32BitLong) ^ _seed[2]) >> 28;

		randUInt();
	}

	//Returns an unsigned integer from 0..RandomMax
	//0~RandMax uint 随机数
	uint32 randUInt(void)
	{
		_seed[0] = (((_seed[0] & 0xFFFFFFFELU) << 24) & Max32BitLong)
			^ ((_seed[0] ^ ((_seed[0] << 7) & Max32BitLong)) >> 7);

		_seed[1] = (((_seed[1] & 0xFFFFFFF8LU) << 7) & Max32BitLong)
			^ ((_seed[1] ^ ((_seed[1] << 2) & Max32BitLong)) >> 22);

		_seed[2] = (((_seed[2] & 0xFFFFFFF0LU) << 11) & Max32BitLong)
			^ ((_seed[2] ^ ((_seed[2] << 9) & Max32BitLong)) >> 17);

		return (_seed[0] ^ _seed[1] ^ _seed[2]);
	}

	//Returns a double in [0.0, 1.0]
	//返回0.0~1.0之间的双精度浮点
	double randDouble()
	{
		return static_cast<double>(randUInt())
			/ (static_cast<double>(RandomMax) );
	}

	template<typename T>
	T getRand(T nStart, T nEnd)
	{
		if(nStart > nEnd)
		{
			std::swap(nStart, nEnd);
		}

		return randUInt()%(nEnd-nStart+1) + nStart;
	}

	bool randBool()
	{
		return randUInt() > (GXMISC::MAX_UINT32_NUM)/2;
	}

	bool randOdds(uint32 baseNum, uint32 rateNum)
	{
		return (randUInt()%(baseNum+1)) <= rateNum;
	}

	bool randNumList(std::vector<sint32>* outList, sint32 minSize, sint32 maxSize, sint32 minNum, sint32 maxNum, bool repeat = false)
	{
		if(maxNum > 1000)
		{
			gxError("Rand max num is too big!Num={0}", maxNum);
		}

		if(minSize > maxSize)
		{
			return false;
		}

		if(minNum > maxNum)
		{
			return false;
		}

		uint32 num = getRand(minNum, maxNum);

		if(repeat)
		{
			// 可重复
			for(uint32 i = 0; i < num; ++i)
			{
				sint32 size = getRand(minSize, maxSize);
				outList->push_back(size);
			}
		}
		else
		{
			if((maxSize-minSize+1) < minNum)
			{
				return false;
			}

			std::vector<sint32> unRepeatNum;
			for(sint32 i = minSize; i <= maxSize; ++i)
			{
				unRepeatNum.push_back(i);
			}

			for(uint32 i = 0; i < unRepeatNum.size(); ++i)
			{
				uint32 tempNum = randUInt()%unRepeatNum.size();
				std::swap(unRepeatNum[i], unRepeatNum[tempNum]);
			}

			num = num > (uint32)unRepeatNum.size() ? (uint32)unRepeatNum.size() : num;
			outList->assign(unRepeatNum.begin(), unRepeatNum.begin()+num);
		}

		return true;
	}
}; 

#define DRandGen CRandGen::GetInstance()
#define DRand(a,b) DRandGen.getRand(a,b)


#endif