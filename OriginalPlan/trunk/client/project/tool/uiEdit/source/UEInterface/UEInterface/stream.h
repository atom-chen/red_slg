#ifndef __STREAM_FORMAT_T__
#define __STREAM_FORMAT_T__
#include <iostream>
#include <sstream>
#include <cassert>
#include <cstdio>
#include <sstream>
//#include <cctype>
#include <set>
#include <string>
#include <vector>
#include <stdint.h>
#include <windows.h>
#include "DebugUtils.h"
using namespace std;
#include <stdint.h>
#ifdef _MSC_VER

#pragma warning(disable:4996)
#elif (defined __GNUC__)

#elif (!defined __STDINT_H)
typedef signed char int8_t;
typedef unsigned char uint8_t;

typedef signed short int16_t;
typedef unsigned short uint16_t;


typedef int int32_t;
typedef signed int uint32_t;

typedef long long int64_t;
typedef unsigned long long int64_t;
#endif

struct RandomAccessStream
{
	virtual bool is_open() = 0;
	virtual bool close() = 0;
	virtual int64_t seek(int64_t pos, int fromwhere) = 0;
	virtual int64_t position() = 0;
	virtual int64_t length() = 0;
	virtual int readn(void* ptr, int len) = 0;
	virtual int writen(const void* ptr, int len) = 0;
	virtual bool ungetc(uint8_t ch) = 0;
	virtual bool destroy() = 0;
	virtual ~RandomAccessStream(){};
	//	virtual int read(void* ptr, int len) = 0;
	//	virtual int write(const void* ptr, int len) = 0;
};
struct RWFStream : public RandomAccessStream
{
	FILE* m_file;
	RWFStream()
	{
		m_file = 0;
	}
	RWFStream(const char* filename, const char* opt)
	{
		m_file = 0;
		open(filename, opt);
	}

	~RWFStream()
	{
		close();
	}
	virtual bool destroy()
	{
		bool ret = true;
		if (this && this->is_open())
		{
			ret = close();
		}
		delete this;
		return ret;
	}

	bool open(const char* filename, const char* opt)
	{
		if (!filename || !opt)
			return false;

		if (is_open())
		{
			close();
		}
		m_file = fopen(filename, opt);
		return is_open();
	}

	virtual bool is_open()
	{
		return m_file != 0;
	}
	virtual bool close()
	{
		if (!is_open())
			return true;

		fclose(m_file);
		return true;
	}
	virtual int64_t seek(int64_t pos, int fromwhere)
	{
		if (!is_open())
			return -1;

		int64_t old_pos = ftell(m_file);
		fseek(m_file, static_cast<long>(pos), fromwhere);
		return old_pos;
	}
	int64_t position()
	{
		if (!is_open())
			return -1;

		return ftell(m_file);
	}
	virtual int64_t length()
	{
		if (!is_open())
			return -1;

		int64_t pos = position();
		seek(0, 2);
		int64_t len = position();
		seek(pos, 0);
		return len;
	}
	virtual int readn(void* ptr, int len)
	{
		if (!is_open() || len < 0)
			return -1;

		int readlen = 0;
		void* start = ptr;
		while (readlen < len)
		{
			int curlen = read(start, len - readlen);
			if (curlen <= 0)
				return readlen;

			readlen += curlen;
		}

		return readlen;
	}
	virtual int writen(const void* ptr, int len)
	{
		if (!is_open() || len < 0)
			return -1;

		int writtenlen = 0;
		const void* start = ptr;
		while (writtenlen < len)
		{
			int curlen = write(start, len - writtenlen);
			if (curlen <= 0)
				return writtenlen;

			writtenlen += curlen;
		}
		return writtenlen;
	}
	virtual bool ungetc(uint8_t ch)
	{
		return ::ungetc(ch, m_file) != -1;
	}
	virtual int read(void* ptr, int len)
	{
	//	dbg_print((char*)ptr, len);
		return fread(ptr, 1, len, m_file);
	}
	virtual int write(const void* ptr, int len)
	{
		return fwrite(ptr, 1, len, m_file);
	}

	static 
	bool writeToFile(const string& data, const string& path, const string& opt)
	{
		RWFStream rwf(path.c_str(), opt.c_str());
		if (!rwf.is_open())
			return false;

		if (false == rwf.writen(data.c_str(), data.length()))
		{
			return false;
		}
		return true;
	}
	static 
	bool readFromFile(string& data, const string& path, const string& opt)
	{
		RWFStream rwf(path.c_str(), opt.c_str());
		if (!rwf.is_open())
			return false;

		data.resize(static_cast<int>(rwf.length()));

		if (false == rwf.readn(&data[0], data.length()))
		{
			return false;
		}
		return true;
	}
};

struct RWMStream : public RandomAccessStream
{
	uint8_t* 	m_ptr;
	int64_t		m_len;
	int64_t		m_pos;
	RWMStream()
	{
		m_ptr = 0;
		m_len = -1;
		m_pos = -1;
	}
	RWMStream(void* mem_ptr, int64_t len)
	{
		m_ptr = 0;
		m_len = -1;
		m_pos = -1;
		open(mem_ptr, len);
	}
	~RWMStream()
	{
		close();
	}
	virtual bool destroy()
	{
		bool ret = true;
		if (this && this->is_open())
		{
			ret = close();
		}
		delete this;
		return ret;
	}

	bool open(void* mem_ptr, int64_t len)
	{
		m_ptr = (uint8_t*)mem_ptr;
		m_pos = 0;
		m_len = len;
		return is_open();
	}

	virtual bool is_open()
	{
		return m_ptr != 0 && m_len >= 0;
	}
	virtual bool close()
	{
		m_ptr = 0;
		m_len = -1;
		return true;
	}
	virtual int64_t seek(int64_t pos, int fromwhere)
	{
		if (!is_open())
			return -1;

		int64_t old_pos = m_pos;
		int64_t newpos = 0;
		switch (fromwhere)
		{
		case 0:
		{
			newpos = pos;
		}
			break;
		case 1:
		{
			newpos = m_pos + pos;
		}
			break;
		case 2:
		{
			newpos = m_len + pos;
		}
			break;
		default:
			return -1;
		}
		if (newpos <= m_len && newpos >= 0)
		{
			m_pos = newpos;
		}
		else
		{
			return -1;
		}
		return old_pos;
	}
	int64_t position()
	{
		if (!is_open())
			return -1;

		return m_pos;
	}
	virtual int64_t length()
	{
		if (!is_open())
			return -1;

		int64_t pos = position();
		seek(0, 2);
		int64_t len = position();
		seek(pos, 0);
		return len;
	}
	virtual int readn(void* ptr, int len)
	{
		if (!is_open() || len < 0)
			return -1;

		int readlen = 0;
		void* start = ptr;
		while (readlen < len)
		{
			int curlen = read(start, len - readlen);
			if (curlen <= 0)
				return readlen;

			readlen += curlen;
		}
		return readlen;
	}
	virtual int writen(const void* ptr, int len)
	{
		if (!is_open() || len < 0)
			return -1;

		int writtenlen = 0;
		const void* start = ptr;
		while (writtenlen < len)
		{
			int curlen = write(start, len - writtenlen);
			if (curlen <= 0)
				return writtenlen;

			writtenlen += curlen;
		}
		return writtenlen;
	}
	virtual bool ungetc(uint8_t ch)
	{
		if (!is_open())
			return false;

		if (m_pos == 0)
			return false;

		m_pos = m_pos - 1;
		m_ptr[m_pos] = ch;
		return true;
	}
	virtual int read(void* ptr, int len)
	{
		if (!is_open() || len < 0)
		{
			return -1;
		}
		else if (len == 0)
		{
			return 0;
		}

		int64_t endpos = m_pos + len;
		if (endpos > m_len || endpos < 0)
		{
			endpos = m_len;
		}
		memcpy(ptr, m_ptr + m_pos, static_cast<size_t>(endpos - m_pos));
		dbg_print((char*)ptr, len);
		int64_t oldpos = m_pos;
		m_pos = endpos;
		return static_cast<int>(endpos - oldpos);
	}
	virtual int write(const void* ptr, int len)
	{
		if (!is_open() || len < 0)
		{
			return -1;
		}
		else if (len == 0)
		{
			return 0;
		}

		int64_t endpos = m_pos + len;
		if (endpos > m_len || endpos < 0)
		{
			endpos = m_len;
		}
		memcpy(m_ptr + m_pos, ptr, static_cast<size_t>(endpos - m_pos));
		int64_t oldpos = m_pos;
		m_pos = endpos;
		return static_cast<int>(endpos - oldpos);
	}
};

struct TypedStream :RandomAccessStream
{
	RandomAccessStream* m_stream;
	bool 				m_bigEndian;
	string 				m_msg;
	TypedStream(RandomAccessStream* s, bool bigEndian = true) :m_stream(s)
	{
		m_bigEndian = bigEndian;
	};
	~TypedStream()
	{
		m_stream->close();
	}
	virtual bool destroy()
	{
		bool ret = true;
		if (this && this->is_open())
		{
			ret = close();
		}
		delete this;
		return ret;
	}
	bool setEndian(bool bigEndian)
	{
		bool b = m_bigEndian;
		m_bigEndian = bigEndian;
		return b;
	}
	virtual bool is_open()
	{
		return m_stream->is_open();
	}
	virtual bool close()
	{
		return m_stream->close();
	}
	virtual int64_t seek(int64_t pos, int fromwhere)
	{
		return m_stream->seek(pos, fromwhere);
	}
	virtual int64_t position()
	{
		return m_stream->position();
	}
	virtual int64_t length()
	{
		return m_stream->length();
	}
	virtual int readn(void* ptr, int len)
	{
		return m_stream->readn(ptr, len);
	}
	virtual int writen(const void* ptr, int len)
	{
		return m_stream->writen(ptr, len);
	}
	virtual bool ungetc(uint8_t ch)
	{
		//string str = "ungetc:";
		//str.push_back(ch);
		//dbg_print(str);
		//return m_stream->ungetc(ch);
		bool ret = m_stream->ungetc(ch);
		if (ret == false)
		{
			DWORD err = GetLastError();
			char errinfo[512] = { 0 };
			sprintf(errinfo, "last ungetc error : 0x%x", err);
			dbg_print(errinfo);
		}
		return ret;
	}
	template<int count, typename T>
	bool read_intn(T& val)
	{
		uint8_t arr[count];
		if (readn(&arr, count) != count)
		{
			return false;
		}

		T tmp = 0;
		if (m_bigEndian)
		{
			for (int i = 0; i < count; i++)
			{
				tmp = (tmp << 8) | (T)(arr[i]);
			}
		}
		else
		{
			for (int i = 0; i < count; i++)
			{
				tmp = (tmp << 8) | (T)(arr[count - i - 1]);
			}
		}
		val = tmp;
		return true;
	}

	virtual bool read_uint8(uint8_t& val)
	{
		if (readn(&val, 1) == 1)
		{
			//string str = "read_uint8:";
			//char data[16];
			//sprintf(data, "0x%X:(%c)", val, val);
			//str.append(data);
			//dbg_print(str);
			return true;
		}
		else
		{
			return false;
		}
	}
	virtual bool read_uint16(uint16_t& val)
	{
		return read_intn<2>(val);
	}
	virtual bool read_uint32(uint32_t& val)
	{
		return read_intn<4>(val);
	}
	virtual bool read_uint64(uint64_t& val)
	{
		return read_intn<8>(val);
	}

	virtual bool read_int8(int8_t& val)
	{
		return read_uint8(*(uint8_t*)&val);
	}
	virtual bool read_int16(int16_t& val)
	{
		return read_uint16(*(uint16_t*)&val);
	}
	virtual bool read_int32(int32_t& val)
	{
		return read_uint32(*(uint32_t*)&val);
	}
	virtual bool read_int64(int64_t& val)
	{
		return read_uint64(*(uint64_t*)&val);
	}

	virtual bool read_string(string& val)
	{
		int len = 0;
		if (!read_int32(len))
		{
			return false;
		};
		val.resize(len);
		return len == readn(&val[0], len);
	}

	template<typename T>
	bool peek_int(T& v)
	{
		int64_t pos = position();
		bool ret = read_intn<sizeof(v)>(v);
		seek(pos, 0);
		return ret;
	}

	template<int count, typename T>
	bool write_intn(T val)
	{
		uint8_t arr[count];

		if (m_bigEndian)
		{
			for (int i = 0; i < count; i++)
			{
				uint8_t tmp = (uint8_t)((val >> i) & 0xff);
				arr[count - i - 1] = tmp;
			}
		}
		else
		{
			for (int i = 0; i < count; i++)
			{
				uint8_t tmp = (uint8_t)((val >> i) & 0xff);
				arr[i] = tmp;
			}
		}
		if (writen(&arr, count) != count)
		{
			return false;
		}
		return true;
	}

	virtual bool write_uint8(uint8_t val)
	{
		return writen(&val, 1) == 1;
	}
	virtual bool write_uint16(uint16_t val)
	{
		return write_intn<2>(val);
	}
	virtual bool write_uint32(uint32_t val)
	{
		return write_intn<4>(val);
	}
	virtual bool write_uint64(uint64_t val)
	{
		return write_intn<8>(val);
	}

	virtual bool write_int8(int8_t val)
	{
		return write_uint8(*(uint8_t*)&val);
	}
	virtual bool write_int16(int16_t val)
	{
		return write_uint16(*(uint16_t*)&val);
	}
	virtual bool write_int32(int32_t val)
	{
		return write_uint32(*(uint32_t*)&val);
	}
	virtual bool write_int64(int64_t val)
	{
		return write_uint64(*(uint64_t*)&val);
	}

	virtual bool write_string(const string& val)
	{

		int len = val.length();
		/*
		if (!write_int32(len))
		{
			return false;
		};
		*/
		return len == writen(&val[0], len);
	}
	//	virtual int read(void* ptr, int len) = 0;
	//	virtual int write(const void* ptr, int len) = 0;

	virtual string getErrorInfo()const
	{
		return m_msg;
	}
};

#endif