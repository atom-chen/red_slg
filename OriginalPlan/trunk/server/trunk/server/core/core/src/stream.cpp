#include "stream_impl.h"

namespace lua_tinker
{
	CScriptString read(lua_State *L, int index)
	{
		CScriptString str;
		if (lua_isstring(L, index))
		{
			size_t len = 0;
			str.buffer = lua_tolstring(L, index, &len);
			str.len = (sint32)len;
		}

		return str;
	}

	void push(lua_State* L, CScriptString str)
	{
		lua_pushlstring(L, str.buffer, str.len);
	}
};

namespace GXMISC{

	sint16 CMemOutputStream::writeString(const CScriptString& str)
	{
		if (getFreeSize() < (2 + str.len))
		{
			return 0;
		}

		serial<uint16>((uint16)str.len);
		serialBuffer(str.buffer, str.len);

		return (sint16)(2 + str.len);
	}

	sint16 CMemOutputStream::writeSString(const CScriptString& str)
	{
		if (getFreeSize() < (1 + str.len))
		{
			return 0;
		}

		serial<uint8>((uint8)str.len);
		serialBuffer(str.buffer, str.len);

		return (sint16)(1 + str.len);
	}

	const CScriptString CMemInputStream::readSString()
	{
		uint8 val = 0;
		serial(val);
		const char* tempBuffer = curData();
		_curPos += val;
		return CScriptString(tempBuffer, val);
	}

	const CScriptString CMemInputStream::readString()
	{
		uint16 val = 0;
		serial(val);
		const char* tempBuffer = curData();
		_curPos += val;
		return CScriptString(tempBuffer, val);
	}
}