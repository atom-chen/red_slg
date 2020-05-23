#include "stdcore.h"
#include "bit_set.h"

using namespace std;

namespace	GXMISC
{
	// must be defined elsewhere
#ifndef min
#define min(a,b)            (((a) < (b)) ? (a) : (b))
#endif

	CBitSet::CBitSet()
	{
		_numBits= 0;
		_maskLast= 0;
	}
	CBitSet::CBitSet(uint32 numBits)
	{
		_numBits= 0;
		_maskLast= 0;
		resize(numBits);
	}
	CBitSet::CBitSet(const CBitSet &bs)
	{
		_numBits= bs._numBits;
		_maskLast= bs._maskLast;
		_array= bs._array;
	}
	CBitSet::~CBitSet()
	{
	}
	CBitSet	&CBitSet::operator=(const CBitSet &bs)
	{
		_numBits= bs._numBits;
		_maskLast= bs._maskLast;
		_array= bs._array;

		return *this;
	}

	void	CBitSet::clear()
	{
		_array.clear();
		_numBits= 0;
		_maskLast=0;
	}
	void	CBitSet::resize(uint32 numBits)
	{
		if(numBits==0)
			clear();

		_numBits= numBits;
		_array.resize( (_numBits+BIT_LEN-1) / BIT_LEN );
		uint32	nLastBits= _numBits & (BIT_LEN-1) ;
		// Generate the mask for the last word.
		if(nLastBits==0)
			_maskLast= ~((uint32)0);
		else
			_maskLast= (1<< nLastBits) -1;

		// reset to 0.
		clearAll();
	}
	void	CBitSet::resizeNoReset(uint32 numBits, bool value)
	{
		if(numBits==0)
			clear();

		uint32 oldNum=_numBits;
		_numBits= numBits;
		_array.resize( (_numBits+BIT_LEN-1) / BIT_LEN );
		uint32	nLastBits= _numBits & (BIT_LEN-1) ;
		// Generate the mask for the last word.
		if(nLastBits==0)
			_maskLast= ~((uint32)0);
		else
			_maskLast= (1<< nLastBits) -1;

		// Set new bit to value
		for (uint32 i=oldNum; i<(uint32)_numBits; i++)
			set(i, value);
	}
	void	CBitSet::setAll()
	{
		const vector<uint32>::size_type s = _array.size();
		fill_n(_array.begin(), s, ~((uint32)0));

		if (s)
			_array[s-1]&= _maskLast;
	}
	void	CBitSet::clearAll()
	{
		fill_n(_array.begin(), _array.size(), 0);
	}

	CBitSet	CBitSet::operator~() const
	{
		CBitSet	ret;

		ret= *this;
		ret.flip();
		return ret;
	}
	CBitSet	CBitSet::operator&(const CBitSet &bs) const
	{
		CBitSet	ret;

		ret= *this;
		ret&=bs;
		return ret;
	}
	CBitSet	CBitSet::operator|(const CBitSet &bs) const
	{
		CBitSet	ret;

		ret= *this;
		ret|=bs;
		return ret;
	}
	CBitSet	CBitSet::operator^(const CBitSet &bs) const
	{
		CBitSet	ret;

		ret= *this;
		ret^=bs;
		return ret;
	}
	void	CBitSet::flip()
	{
		if(_numBits==0)
			return;

		for(sint32 i=0;i<(sint32)_array.size();i++)
			_array[i]= ~_array[i];

		_array[_array.size()-1]&= _maskLast;
	}
	CBitSet	&CBitSet::operator&=(const CBitSet &bs)
	{
		if(_numBits==0)
			return *this;

		vector<uint32>::size_type minSize = min(_array.size(), bs._array.size());
		vector<uint32>::size_type i;
		for(i=0;i<minSize;i++)
			_array[i]= _array[i] & bs._array[i];
		for(i=minSize;i<_array.size();i++)
			_array[i]=0;

		_array[_array.size()-1]&= _maskLast;

		return *this;
	}
	CBitSet	&CBitSet::operator|=(const CBitSet &bs)
	{
		if(_numBits==0)
			return *this;

		vector<uint32>::size_type minSize = min(_array.size(), bs._array.size());
		vector<uint32>::size_type i;
		for(i=0;i<minSize;i++)
			_array[i]= _array[i] | bs._array[i];
		// Do nothing for bits word from minSize to Array.size().

		_array[_array.size()-1]&= _maskLast;

		return *this;
	}
	CBitSet	&CBitSet::operator^=(const CBitSet &bs)
	{
		if(_numBits==0)
			return *this;

		vector<uint32>::size_type minSize= min(_array.size(), bs._array.size());
		vector<uint32>::size_type i;
		for(i=0;i<minSize;i++)
			_array[i]= _array[i] ^ bs._array[i];
		// Do nothing for bits word from minSize to Array.size().

		_array[_array.size()-1]&= _maskLast;

		return *this;
	}

	bool	CBitSet::operator==(const CBitSet &bs) const
	{
		if(_numBits!=bs._numBits)
			return false;

		for(sint32 i=0;i<(sint32)_array.size();i++)
		{
			if(_array[i]!=bs._array[i])
				return false;
		}
		return true;
	}
	bool	CBitSet::operator!=(const CBitSet &bs) const
	{
		return (!operator==(bs));
	}
	bool	CBitSet::compareRestrict(const CBitSet &bs) const
	{
		sint32	n=min(_numBits, bs._numBits);
		if(n==0) return true;

		sint32	nA= (n+BIT_LEN-1) / BIT_LEN;
		uint32	mask;

		uint32	nLastBits= n & (BIT_LEN-1) ;
		// Generate the mask for the last common word.
		if(nLastBits==0)
			mask= ~((uint32)0);
		else
			mask= (1<< nLastBits) -1;


		for(sint32 i=0;i<nA-1;i++)
		{
			if(_array[i]!=bs._array[i])
				return false;
		}
		if( (_array[nA-1]&mask) != (bs._array[nA-1]&mask) )
			return false;


		return true;
	}
	bool	CBitSet::isAllSet()
	{
		if(_numBits==0)
			return false;
		for(sint32 i=0;i<(sint32)_array.size()-1;i++)
		{
			if( _array[i]!= (~((uint32)0)) )
				return false;
		}
		if( _array[_array.size()-1]!= _maskLast )
			return false;
		return true;
	}
	bool	CBitSet::isAllCleared()
	{
		if(_numBits==0)
			return false;
		for(sint32 i=0;i<(sint32)_array.size();i++)
		{
			if( _array[i]!= 0 )
				return false;
		}
		return true;
	}

	/*
	* Return a string representing the bitfield with 1 and 0 (from left to right)
	*/
	std::string	CBitSet::toString() const
	{
		string s;
		for ( sint32 i=0; i!=(sint32)size(); ++i )
		{
			s += (get(i) ? '1' : '0');
		}
		return s;
	}
}
