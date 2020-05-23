#ifndef _SYN_DATA_WRAPER_H_
#define _SYN_DATA_WRAPER_H_

#include "types_def.h"
#include "bit_set.h"

namespace GXMISC
{
	struct FiledVar
	{
		FiledVar()
		{
			index = -1;
			var = NULL;
			lenght = 0;
		}

		bool isValid()
		{
			return index != -1 && var != NULL && lenght != 0;
		}

		sint32  index;
		void*   var;
		sint32  lenght;
	};

	template<typename T, uint32 N>
	class CSynDataWraper
	{
#define RegisteVar(index, var)    \
	count++;    \
	this->registeVar(index, &var, sizeof(var));
#define BeginRegiste()  \
	sint32 count = 0; 
#define EndRegiste()

	public:
		CSynDataWraper()
		{
			_dirtySet.clearAll();
			_isDirty = false;
		}

	public:
		void registeVar(uint32 index, void* data, sint32 length)
		{
			gxAssertEx(index < N, "out of range, index = {0}", index);
			gxAssertEx(data != NULL, "data is null, index = {0}", index);
			gxAssertEx(length > 0, "data len is less 0, index = {0}", index);
			gxAssertEx(!_vars[index].isValid(), "filed is valid! index = {0}", index);

			_vars[index].index = index;;
			_vars[index].lenght = length;
			_vars[index].var = data;
			_keys.push_back(index);
		}

		void setData(sint32 index, void* data, sint32 length)
		{
			gxAssertEx(index < N, "out of range, index = {0}", index);
			gxAssertEx(data != NULL, "data is null, index = {0}", index);
			gxAssertEx(length > 0, "data len is less 0, index = {0}", index);
			gxAssertEx(_vars[index].isValid(), "filed is valid! index = {0}", index);

			gxAssertEx(_vars[index].index == index, "index is invalid! src_index = {0}, dest_index = {1}", _vars[index].index, index);
			gxAssertEx(_vars[index].lenght == length, "data length is invalid! src_length = {0}, dest_length = {1}", _vars[index].lenght, length);

			_dirtySet.set(index);
			memcpy(_vars[index].var, data, length);
			setDirty();
		}

		void setInt32(uint32 index, sint32 data)
		{
			setData(index, &data, sizeof(data));
		}

		void setUInt32(uint32 index, uint32 data)
		{
			setData(index, &data, sizeof(data));
		}

		void getData(uint32 index, void* data, sint32 length)
		{
			gxAssertEx(index < N, "out of range, index = {0}", index);
			gxAssertEx(data != NULL, "data is null, index = {0}", index);
			gxAssertEx(length > 0, "data len is less 0, index = {0}", index);
			gxAssertEx(_vars[index].isValid(), "filed is valid! index = {0}", index);

			gxAssertEx(_vars[index].index == index, "index is invalid! src_index = {0}, dest_index = {1}", _vars[index].index, index);
			gxAssertEx(_vars[index].lenght == length, "data length is invalid! src_length = {0}, dest_length = {1}", _vars[index].lenght, length);

			memcpy(data, _vars[index].var, length);
		}

		template<typename DataType>
		DataType& toData(uint32 index)
		{
			gxAssertEx(index < N, "out of range, index = {0}", index);
			gxAssertEx(_vars[index].isValid(), "filed is valid! index = {0}", index);

			gxAssertEx(_vars[index].index == index, "index is invalid! src_index = {0}, dest_index = {1}", _vars[index].index, index);
			gxAssertEx(_vars[index].lenght == sizeof(DataType), "data length is invalid! src_length = {0}, dest_length = {1}", _vars[index].lenght, sizeof(DataType));

			return *((DataType*)_vars[index].var);
		}

		uint32 toUint(uint32 index)
		{
			return toData<uint32>(index);
		}
		sint32 toSint(uint32 index)
		{
			return toData<sint32>(index);
		}
		float toFloat(uint32 index)
		{
			return toData<float>(index);
		}

		void toBuffer(char* buffer, sint32 length, bool resetFlag = false)
		{
			gxAssert(isDirty());
			char *pBuffer = buffer;
			uint16 count = _dirtySet.size();
			memcpy(pBuffer, &count, sizeof(count));
			pBuffer += sizeof(count);
			memcpy(pBuffer, _dirtySet.data(), _dirtySet.sizeInBytes());
			pBuffer += _dirtySet.sizeInBytes();

			for(uint32 i = 0; i < _keys.size(); ++i)
			{
				uint32 index = _keys[i];
				gxAssertEx(index == _vars[index].index, "Index={0}:{1}", index, _vars[index].index);
				gxAssert(_vars[index].var != NULL);
				gxAssert(_vars[index].lenght > 0);
				memcpy(pBuffer, _vars[index].var, _vars[index].lenght);
				pBuffer += _vars[index].lenght;
			}

			if(resetFlag)
			{
				reset();
			}
		}

		bool isDirty()
		{
			return _isDirty;
		}

		void setDirty()
		{
			_isDirty = true;
		}

		void reset()
		{
			_dirtySet.clearAll();
			_isDirty = false;
		}

	private:
		CFixBitSet<N>		_dirtySet;
		std::vector<uint32> _keys;
		FiledVar            _vars[N];
		bool                _isDirty;
	};
}

#endif