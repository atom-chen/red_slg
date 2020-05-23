#ifndef _STREAM_IMPL_H_
#define _STREAM_IMPL_H_

#include "stream.h"
#include "script/lua_base_conversions.h"

namespace GXMISC{
	class CMemInStream : public IUnStream
	{
	protected:
		CMemInStream(){}
		CMemInStream(uint32 maxSize){ init(maxSize); }
	public:
		virtual ~CMemInStream()
		{
			if (_needFree)
			{
				DSafeDeleteArray(_buffer);
			}
		}

	public:
		void cleanUp()
		{
			_buffer = NULL;
			_curPos = 0;
			_maxBufferLen = 0;
			_needFree = false;
		}
	public:
		void init(uint32 maxSize, const char* buf = NULL)
		{
			if (buf == NULL)
			{
				_buffer = new char[maxSize];
				_needFree = true;
			}
			else
			{
				_buffer = buf;
				_needFree = false;
			}

			_curPos = 0;
			_maxBufferLen = maxSize;
		}

	public:
		const char* data()
		{
			return _buffer;
		}

		const char* curData()
		{
			return _buffer + _curPos;
		}

		uint32 size()
		{
			return _curPos;
		}

		void reset()
		{
			_curPos = 0;
		}

		uint32 maxSize()
		{
			return _maxBufferLen;
		}

		sint32 getFreeSize()
		{
			return _maxBufferLen - _curPos;
		}

	protected:
		const char* _buffer;
		uint32 _curPos;
		uint32 _maxBufferLen;
		bool _needFree;
	};

	class CMemOutStream : public IStream
	{
	protected:
		CMemOutStream(){
			cleanUp();
		}
		CMemOutStream(uint32 maxSize){ init(maxSize); }
	public:
		virtual ~CMemOutStream()
		{
			if (_needFree)
			{
				DSafeDeleteArray(_buffer);
			}

			cleanUp();
		}

	public:
		void cleanUp()
		{
			_buffer = NULL;
			_curPos = NULL;
			_maxBufferLen = NULL;
			_needFree = false;
		}

	public:
		void init(uint32 maxSize, char* buf = NULL)
		{
			if (buf == NULL)
			{
				_buffer = new char[maxSize];
				_needFree = true;
			}
			else
			{
				_buffer = buf;
				_needFree = false;
			}

			_curPos = 0;
			_maxBufferLen = maxSize;
		}

	public:
		char* data()
		{
			return _buffer;
		}

		char* curData()
		{
			return _buffer + _curPos;
		}

		uint32 size()
		{
			return _curPos;
		}

		void reset()
		{
			_curPos = 0;
		}

		uint32 maxSize()
		{
			return _maxBufferLen;
		}

		sint32 getFreeSize()
		{
			return _maxBufferLen - _curPos;
		}

	protected:
		char* _buffer;
		uint32 _curPos;
		uint32 _maxBufferLen;
		bool _needFree;
	};

	template<uint32 MaxSize>
	class CMemTempInStream : public IUnStream
	{
	public:
		CMemTempInStream(){ this->_curPos = 0; this->_maxBufferLen = MaxSize; memset(this->_buffer, 0, sizeof(this->_buffer)); }
		virtual ~CMemTempInStream(){}

	public:
		char* data()
		{
			return _buffer;
		}

		char* curData()
		{
			return _buffer + _curPos;
		}

		uint32 size()
		{
			return _curPos;
		}

		void reset()
		{
			_curPos = 0;
		}

		uint32 maxSize()
		{
			return _maxBufferLen;
		}

	protected:
		char _buffer[MaxSize];
		uint32 _curPos;
		uint32 _maxBufferLen;
	};

	template<uint32 MaxSize>
	class CMemTempOutStream : public IStream
	{
	public:
		CMemTempOutStream(){ _curPos = 0; _maxBufferLen = MaxSize; memset(_buffer, 0, sizeof(_buffer)); }
		virtual ~CMemTempOutStream(){}

	public:
		char* data()
		{
			return _buffer;
		}

		char* curData()
		{
			return _buffer + _curPos;
		}

		uint32 size()
		{
			return _curPos;
		}

		void reset()
		{
			_curPos = 0;
		}

		uint32 maxSize()
		{
			return _maxBufferLen;
		}

	protected:
		char _buffer[MaxSize];
		uint32 _curPos;
		uint32 _maxBufferLen;
	};

	template<uint32 MaxSize>
	class CMemTempOutputStream : public CMemTempOutStream<MaxSize>
	{
	public:
		CMemTempOutputStream(){}
		virtual ~CMemTempOutputStream(){}

	public:
		virtual bool serialBuffer(const char *buf, uint32 len)
		{
			if ((len + this->_curPos) <= this->_maxBufferLen)
			{
				memcpy(this->_buffer + this->_curPos, buf, len);
				this->_curPos += len;
				return true;
			}

			return false;
		}
	};

	template<uint32 MaxSize>
	class CMemTempInputStream : public CMemTempInStream<MaxSize>
	{
	public:
		CMemTempInputStream(){}
		virtual ~CMemTempInputStream(){}

	public:
		virtual bool serialBuffer(char *buf, uint32 len)
		{
			if ((len + this->_curPos) <= this->_maxBufferLen)
			{
				memcpy(buf, this->_buffer + this->_curPos, len);
				this->_curPos += len;
				return true;
			}

			return false;
		}
	};

	class CMemOutputStream : public CMemOutStream
	{
	public:
		CMemOutputStream(){}
		CMemOutputStream(uint32 maxSize){ init(maxSize); }
		virtual ~CMemOutputStream(){}

	public:
		virtual bool serialBuffer(const char *buf, uint32 len)
		{
			if ((len + this->_curPos) <= this->_maxBufferLen)
			{
				memcpy(this->_buffer + this->_curPos, buf, len);
				this->_curPos += len;
				return true;
			}
			assert(false);
			return false;
		}

	public:
		bool writeBufferByPos(const char *buf, uint32 len, uint32 pos)
		{
			if ((len + pos) <= this->_maxBufferLen)
			{
				memcpy(this->_buffer + pos, buf, len);
				return true;
			}
			assert(false);
			return false;
		}

		sint32 getCurrentPos()
		{
			return _curPos;
		}
	public:
		sint8 writeInt8(const sint8& val)
		{
			if (getFreeSize() < 1)
			{
				return 0;
			}

			serial(val);

			return 1;
		}

		sint8 writeUInt8(const uint8& val)
		{
			if (getFreeSize() < 1)
			{
				return 0;
			}

			serial(val);

			return 1;
		}

		sint8 writeInt16(const sint16& val)
		{
			if (getFreeSize() < 2)
			{
				return 0;
			}

			serial(val);

			return 2;
		}

		sint8 writeUInt16(const uint16& val)
		{
			if (getFreeSize() < 2)
			{
				return 0;
			}

			serial(val);

			return 2;
		}

		sint8 writeInt32(const sint32& val)
		{
			if (getFreeSize() < 4)
			{
				return 0;
			}

			serial(val);

			return 4;
		}

		sint8 writeUInt32(const uint32& val)
		{
			if (getFreeSize() < 4)
			{
				return 0;
			}

			serial(val);

			return 4;
		}

		sint8 writeInt64(const sint64& val)
		{
			if (getFreeSize() < 8)
			{
				return 0;
			}

			serial(val);

			return 8;
		}

		sint8 writeUInt64(const uint64& val)
		{
			if (getFreeSize() < 8)
			{
				return 0;
			}

			serial(val);

			return 8;
		}

		sint16 writeString(const CScriptString& str);
		sint16 writeSString(const CScriptString& str);

		sint8 writeUInt8ByPos(const uint8& val, sint32 pos)
		{
			if (!writeBufferByPos((char*)&val, sizeof(uint8), pos))
			{
				return 0;
			}

			return 1;
		}

		sint8 writeUInt16ByPos(const uint16& val, sint32 pos)
		{
			if (!writeBufferByPos((char*)&val, sizeof(uint16), pos))
			{
				return 0;
			}

			return 2;
		}

		sint8 writeUInt32ByPos(const uint32& val, sint32 pos)
		{
			if (!writeBufferByPos((char*)&val, sizeof(uint32), pos))
			{
				return 0;
			}

			return 4;
		}

		sint8 writeUInt64ByPos(const uint64& val, sint32 pos)
		{
			if (!writeBufferByPos((char*)&val, sizeof(uint64), pos))
			{
				return 0;
			}

			return 8;
		}
	};

	// @todo 记录一次序列化长度
	class CMemInputStream : public CMemInStream
	{
	public:
		CMemInputStream(){}
		CMemInputStream(uint32 maxSize){ init(maxSize); }
		virtual ~CMemInputStream(){}

	public:
		bool serialBuffer(char *buff, uint32 len)
		{
			if ((len + this->_curPos) <= this->_maxBufferLen)
			{
				memcpy(buff, this->_buffer + this->_curPos, len);
				this->_curPos += len;
				return true;
			}

			assert(false);
			return false;
		}

	public:
		bool peakBuffer(char* buff, uint32 len, uint32 skipPos)
		{
			if ((len + this->_curPos + skipPos) <= this->_maxBufferLen)
			{
				memcpy(buff, this->_buffer + this->_curPos + skipPos, len);
				return true;
			}

			return false;
		}

	public:
		sint8 readInt8()
		{
			sint8 val = 0;
			serial(val);
			return val;
		}
		uint8 readUInt8()
		{
			uint8 val = 0;
			serial(val);
			return val;
		}
		sint16 readInt16()
		{
			sint16 val = 0;
			serial(val);
			return val;
		}
		uint16 readUInt16()
		{
			uint16 val = 0;
			serial(val);
			return val;
		}
		sint32 readInt32()
		{
			sint32 val = 0;
			serial(val);
			return val;
		}
		uint32 readUInt32()
		{
			uint32 val = 0;
			serial(val);
			return val;
		}
		const CScriptString readSString();
		const CScriptString readString();

		sint64 readInt64()
		{
			sint64 val = 0;
			serial(val);
			return val;
		}
		uint64 readUInt64()
		{
			uint64 val = 0;
			serial(val);
			return val;
		}
		uint8 peakUInt8(sint32 skipPos)
		{
			uint8 val = 0;
			peakBuffer((char*)&val, sizeof(uint8), skipPos);
			return val;
		}
		uint16 peakUInt16(sint32 skipPos)
		{
			uint16 val = 0;
			peakBuffer((char*)&val, sizeof(uint16), skipPos);
			return val;
		}
		uint32 peakUInt32(sint32 skipPos)
		{
			uint32 val = 0;
			peakBuffer((char*)&val, sizeof(uint32), skipPos);
			return val;
		}
		uint64 peakUInt64(sint32 skipPos)
		{
			uint64 val = 0;
			peakBuffer((char*)&val, sizeof(uint64), skipPos);
			return val;
		}
	};
}

namespace lua_tinker
{
	CScriptString read(lua_State *L, int index);
	void push(lua_State* L, CScriptString str);
};

#endif