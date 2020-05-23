#ifndef __UE_LUA_TYPED_STREAM_H__
#define __UE_LUA_TYPED_STREAM_H__
#include "stream.h"
#include "LuaType.h"

struct LuaTypedStream :TypedStream
{
	LuaTypedStream(RandomAccessStream* s, bool bigEndian = true) :TypedStream(s, bigEndian)
	{
	};
	virtual ~LuaTypedStream()
	{

	}
	virtual bool destroy()
	{
		delete this;
		return true;
	}

	string getStreamInfo()
	{
		stringstream ss;
		int64_t pos = position();
		ss << pos << ":";
		char data[128] = { 0 };
		int64_t log_begin = pos > 100 ? pos - 100 : 0;

		seek(log_begin, 0);
		readn(data, static_cast<int>(pos - log_begin));
		ss << data;
		seek(pos, 0);

		return ss.str();
	}

	bool read_luaChar(uint8_t& ch, bool ignoreSpace = true)
	{
		uint8_t readch;
		while (read_uint8(readch))
		{
			if (ignoreSpace && isspace(ch))
			{
				continue;
			}
			else
			{
				ch = readch;
				return true;
			}
		}
		return false;
	}

	bool read_luaCharIgnore(uint8_t& ch, const string& ignoreChars)
	{
		uint8_t readch;
		while (read_uint8(readch))
		{
			if (ignoreChars.find(ch) != ignoreChars.npos)
			{
				continue;
			}
			else
			{
				ch = readch;
				return true;
			}
		}
		return false;
	}

	bool read_luaCharIgnoreAllUntil(uint8_t& ch, uint8_t tilChar, bool ignoreEOF = false)
	{
		uint8_t readch;
		while (read_uint8(readch))
		{
			if (tilChar != readch)
			{
				continue;
			}
			else
			{
				ch = readch;
				return true;
			}
		}
		return ignoreEOF;
	}

	bool read_luaCharIgnoreAllUntil(uint8_t& ch, const string& tilChars, bool ignoreEOF = false)
	{
		uint8_t readch;
		while (read_uint8(readch))
		{
			if (tilChars.find(tilChars) == tilChars.npos)
			{
				continue;
			}
			else
			{
				ch = readch;
				return true;
			}
		}
		return ignoreEOF;
	}

	bool read_luaToken(string& token, bool ignore_left_space = true)
	{
		uint8_t ch = 0;
		vector<uint8_t> prefix;
		string tmp;
		enum { TOKEN_BEGIN, BINARY_TOKEN, VARIABLE_TOKEN, VARIABLE_POINT, VARIABLE_BRACKET };
		int state = TOKEN_BEGIN;
		token.clear();

		if (ignore_left_space)
		{
			for (;;)
			{
				if (!read_uint8(ch))
					return false;

				if (isspace(ch))
					continue;
				break;
			}
			seek(-1, SEEK_CUR);
		}

		while (read_uint8(ch))
		{
			switch (state)
			{
			case TOKEN_BEGIN:
			{
				if (isalpha(ch) || ch == '_')
				{
					seek(-1, SEEK_CUR);
					return read_luaName(token);
				}
				else if (isdigit(ch))
				{
					seek(-1, SEEK_CUR);
					string type;
					return read_luaNumber(token, type);
				}

				switch (ch)
				{
				case '+': case '*':	case '/': case '%':
				case '(': case ')':	case '{': case '}':
				case '^': case '#': case '?':

				case ':': case ';': case ',':

				case '\'':case '\"':

				case ']': // ]] ]]-- ]==]
					token.push_back(ch);
					return true;
					break;

				case '~': case '=':	case '<': case '>':
				case '&': case '|': case '-':
					state = BINARY_TOKEN;
					token.push_back(ch);
					break;
				case '[':
					state = VARIABLE_BRACKET; token.push_back(ch); break;
				case '.':
					state = VARIABLE_POINT;	token.push_back(ch); break;
				default:
					seek(-1, SEEK_CUR);
					return false;// unexpected chars, not token. space and the other
				}
			}
				break;
			case BINARY_TOKEN:
			{
				switch (token[0])
				{
				case '~':
					if (ch == '=')
					{
						token.push_back(ch);
					}
					else
					{
						m_msg = "error after ~";
						m_msg += getStreamInfo();
						return false;
					}
					break;
				case '=':
				case '<':
				case '>':				
					if (ch == '=')
					{
						token.push_back(ch);
					}
					else
					{
						seek(-1, SEEK_CUR);
						return true;
					}
					break;
				case '-':
					if (ch == '-')
					{
						token.push_back(ch);
					}
					else
					{
						seek(-1, SEEK_CUR);
						return true;
					}
					break;
				case '&':
				case '|':
					if (ch == token[0])
					{
						token.push_back(ch);
					}
					else
					{
						m_msg = "error after ";
						m_msg.push_back(ch);
						m_msg += getStreamInfo();
						return false;
					}
					break;
				default:
					return false;
				}
				return true;
			}
				break;
			case VARIABLE_POINT:
			{
				if (ch == '.')
				{
					token.push_back(ch);
					if (token.length() == 3)
					{
						return true;
					}
				}
				else
				{
					seek(-1, SEEK_CUR);
					return true;
				}
			}
				break;
			case VARIABLE_BRACKET:
			{
				if (ch == '[')
				{
					token.push_back(ch);
					return true;
				}
				else if (ch == '=')
				{
					token.push_back(ch);
				}
				else
				{
					seek(-1, SEEK_CUR);
					for (size_t i = 1; i != token.size(); i++)
					{
						ungetc(token[i]);
					}
					token.resize(1);
					return true;
				}
			}
				break;
			default:
				m_msg = "error ";
				m_msg += getStreamInfo();
				break;
			}
		}
		if (state == BINARY_TOKEN)
		{
			return true;
		}
		else if (state == VARIABLE_POINT)
		{
			return true;
		}
		else if (state == VARIABLE_BRACKET && token.size() == 1)
		{
			return true;
		}

		return false;
	}

	bool read_luaEscapeString(string& str, const string& escapeBegin = "")
	{
		enum{ ESCAPE_BEGIN_START, ESCAPE_BEGIN_ING, ESCAPE_STRING, ESCAPE_END_ING, ESCAPE_END };
		int state = ESCAPE_BEGIN_START;
		uint8_t ch = 0;
		//		int64_t pos = position();
		string endstr;
		string tmp;
		str.clear();
		if (escapeBegin.size() > 0)
		{
			if (escapeBegin.size() == 1)
				return false;

			if (escapeBegin[0] == '[' && escapeBegin[escapeBegin.length() - 1] == '[')
			{
				for (size_t i = 1; i + 1 != escapeBegin.size(); ++i)
				{
					if (escapeBegin[i] != '=')
						return false;
				}
			}
			else
			{
				return false;
			}

			endstr = escapeBegin;
			state = ESCAPE_STRING;
			endstr[0] = ']';
			endstr[escapeBegin.length() - 1] = ']';
		}
		while (read_uint8(ch))
		{
			switch (state)
			{
			case ESCAPE_BEGIN_START:
			{
				if (ch == '[')
				{
					endstr.push_back(']');
					state = ESCAPE_BEGIN_ING;
				}
				else
				{
					seek(-1, SEEK_CUR);
					return false;
				}
			}
				break;
			case ESCAPE_BEGIN_ING:
			{
				if (ch == '[')
				{
					endstr.push_back(']');
					state = ESCAPE_STRING;
				}
				else if (ch == '=')
				{
					endstr.push_back('=');
				}
				else
				{
					seek(-1, SEEK_CUR);
					for (size_t i = 1; i != endstr.length(); ++i)
						ungetc('=');
					ungetc('[');
					return false;
				}
			}
				break;
			case ESCAPE_STRING:
			{
				if (ch == ']')
				{
					tmp.push_back(']');
					state = ESCAPE_END_ING;
				}
				else
				{
					str.push_back(ch);
				}
			}
				break;
			case ESCAPE_END_ING:
			{
				if (ch == ']')
				{
					if (tmp.length() + 1 == endstr.length())
					{
						return true;
					}
					else
					{
						str += tmp;
						tmp.resize(1);
					}
				}
				else if (ch == '=' && tmp.length() + 1 != endstr.length())
				{
					tmp.push_back('=');
				}
				else
				{
					str += tmp;
					str.push_back(ch);
					tmp.clear();
					state = ESCAPE_STRING;
				}
			}
				break;
			default:
				m_msg = "error ";
				m_msg += getStreamInfo();
				break;
			}
		}

		return false;
	}
	bool read_luaName(string& name)
	{
		enum{ NAME_BEGIN, NAME_CHUNCK };
		int state = NAME_BEGIN;
		uint8_t ch = 0;
		name.clear();
		while (read_uint8(ch))
		{
			switch (state)
			{
			case NAME_BEGIN:
			{
				if (ch == '_' || isalpha(ch))
				{
					state = NAME_CHUNCK;
				}
				else
				{
					seek(-1, SEEK_CUR);
					return false;
				}
			}
				break;
			case NAME_CHUNCK:
			{
				if (ch != '_' && !isalnum(ch))
				{
					seek(-1, SEEK_CUR);
					return true;
				}
			}
				break;
			default:
				m_msg = "error ";
				m_msg += getStreamInfo();
				return false;
			}
			name.push_back(ch);
		}
		return true;
	}

	bool read_luaNumber(string& numbstr, string& type)
	{
		uint8_t ch;
		uint8_t pre_ch = 0;
		numbstr.clear();
		enum{ NUMBER_BEGIN, NUMBER_INTEGER, NUMBER_POINT, NUMBER_EXPONENT };
		int state = NUMBER_BEGIN;
		while (read_uint8(ch))
		{
			switch (state)
			{
			case NUMBER_BEGIN:
			{
				if (ch == '+' || ch == '-' || isdigit(ch))
				{
					state = NUMBER_INTEGER;
				}
				else
				{
					seek(-1, SEEK_CUR);
					return false;
				}
			}
				break;
			case NUMBER_INTEGER:
			{
				if (!isdigit(ch))
				{
					if (!isdigit(pre_ch))
					{
						seek(-1, SEEK_CUR);
						return false;
					}
					if (ch == 'e' || ch == 'E')
					{
						state = NUMBER_EXPONENT;
					}
					else if (ch == '.')
					{
						state = NUMBER_POINT;
					}
					else
					{
						type = "int";
						seek(-1, SEEK_CUR);
						return true;
					}
				}
			}
				break;
			case NUMBER_POINT:
			{
				if (!isdigit(ch))
				{
					if (!isdigit(pre_ch))
					{
						seek(-1, SEEK_CUR);
						return false;
					}
					if (ch == 'e' || ch == 'E')
					{
						state = NUMBER_EXPONENT;
					}
					else
					{
						type = "float";
						seek(-1, SEEK_CUR);
						return true;
					}
				}
			}
				break;
			case NUMBER_EXPONENT:
			{
				if (!isdigit(ch))
				{
					seek(-1, SEEK_CUR);
					if (!isdigit(pre_ch))
					{
						return false;
					}
					else
					{
						type = "float";
						return true;
					}
				}
			}
				break;
			default:
			{
				m_msg = " error";
				m_msg += getStreamInfo();
				return false;
			}
				break;
			}
			pre_ch = ch;
			numbstr.push_back(ch);
		}
		if (!isdigit(pre_ch))
		{
			return false;
		}
		else
		{
			return true;
		}
	}

	bool read_luaString(string& str, uint8_t quote = 0)
	{
		uint8_t ch = 0;
		str.clear();
		/*if (quote != '\'' && quote != '\"')
		{
		return false;
		}
		*/
		enum{ QU_BEGIN, QU_NOMAL, QU_ESCAPE };
		int state = QU_BEGIN;

		while (read_uint8(ch))
		{
			switch (state)
			{
			case QU_BEGIN:
			{
				if (quote == 0)
				{
					if (ch == '\'' || ch == '\"')
					{
						quote = ch;
					}
				}
				if (quote == ch)
				{
					state = QU_NOMAL;
				}
				else
				{
					seek(-1, SEEK_CUR);
					return false;
				}
			}
				break;
			case QU_NOMAL:
			{
				if (ch == '\\')
				{
					state = QU_ESCAPE;
				}
				else if (ch == quote)
				{
					return true;
				}
				else
				{
					str.push_back((char)ch);
				}
			}
				break;
			case QU_ESCAPE:
			{
				char v = 0;
				switch (ch)
				{
				case 'a':v = '\a'; break;
				case 'b':v = '\b'; break;
				case 'f':v = '\f'; break;
				case 'n':v = '\n'; break;
				case 'r':v = '\r'; break;
				case '\\':v = '\\'; break;
				case 'v':v = '\v'; break;
				case '\'':v = '\''; break;
				case '\"':v = '\"'; break;
				case '[':v = '['; break;
				case ']':v = ']'; break;
				default:
					if (isdigit(ch))
					{
						int val = ch - '0';

						for (;;)
						{
							int8_t second = 0;
							int8_t third = 0;
							if (peek_int(second) && isdigit(second))
							{
								val = val * 16 + (second - '0');
							}
							else
							{
								break;
							}
							seek(1, 1);
							if (peek_int(third) && isdigit(third))
							{
								val = val * 16 + (third - '0');
							}
							else
							{
								break;
							}
							if (val > 0xff)
							{
								val = val / 16;
							}
							else
							{
								seek(1, 1);
							}
						}
						v = (char)(uint8_t)val;
					}
					else
					{
						m_msg = "×ªÒå×Ö·û\\´íÎó ";
						m_msg += getStreamInfo();
						return false;
					}
				}
				str.push_back(v);
				state = QU_NOMAL;
			}
				break;
			default:
				break;
				//unreachable;
			}
		}
		//unreachable;
		return false; // 
	}

	bool ungetstring(const string& str)
	{
		if (str.empty())
			return true;

		for (size_t i = str.size(); i != 0; --i)
		{
			//if (!ungetc(str[i-1]))
			if (!seek(-1, SEEK_CUR))
			{
				return false;
			}
		}
		return true;
	}
	bool read_luaIgnoreAllComment(bool ignore_left_space = true)
	{
		for (;;)
		{
			string token;
			if (!read_luaToken(token, ignore_left_space))
				return false;

			if (token == "--")
			{
				if (!read_luaIgnoreComment(false))
					return false;
			}
			else
			{
				//dbg_print("unset string:" + token);
				ungetstring(token);
				break;
			}
		}
		return true;
	}
	bool read_luaIgnoreComment(bool includeCommentBegin)
	{
		// read --
		if (includeCommentBegin)
		{
			string token;
			if (!read_luaToken(token, true))
				return false;

			if (token != "--")
			{
				ungetstring(token);
				return false;
			}
		}

		string commentBegin;
		if (!read_luaToken(commentBegin, false))
		{
			uint8_t ch;
			if (read_luaCharIgnoreAllUntil(ch, "\r\n", true))
				return true;
		}
		else
		{
			// [[ or [==[
			if (commentBegin.size() > 1 && commentBegin[0] == '[')
			{
				string comment;
				if (read_luaEscapeString(comment, commentBegin))
					return true;

				return false;
			}
			uint8_t ch;
			if (read_luaCharIgnoreAllUntil(ch, "\r\n", true))
				return true;
		}
		return false; // unreachable
	}

	bool read_luaTableItem(LuaValue& first, LuaValue& second)
	{
		uint8_t ch = 0;
		first.setNone();
		second.setNone();

		enum{ ITEM_MUST_BE_KEY, ITEM_MUST_BE_VALUE, ITEM_CAN_BE_VALUE, ITEM_ERROR };
		int itemInfo = ITEM_ERROR;

		read_luaIgnoreAllComment();
		if (!read_luaChar(ch, true))
			return false;

		if (ch == '}')
		{
			return true;
		}
		else if (ch == '_' || isalpha(ch))	// identifier
		{
			seek(-1, SEEK_CUR);
			string name;
			if (!read_luaName(name))
				return false;

			first.setBasic(name);
			itemInfo = ITEM_MUST_BE_KEY;// not support: {[1] = name};
		}
		else if (ch == '-' || ch == '+' || isdigit(ch)) // number
		{
			seek(-1, SEEK_CUR);
			string number, type;
			if (!read_luaNumber(number, type))
				return false;

			first.setBasic();
			first.getBasic()->setValue(type, number);
			itemInfo = ITEM_MUST_BE_VALUE;
			return true;
		}
		else
		{
			switch (ch)
			{
			case '{':
			{
				seek(-1, SEEK_CUR);
				if (!read_LuaTable(first))
					return false;

				itemInfo = ITEM_MUST_BE_VALUE;
				return true;
			}
				break;
			case '\'':case '\"':
			{
				seek(-1, SEEK_CUR);
				string str;
				if (!read_luaString(str, ch))
					return false;

				first.setBasic(str);
				itemInfo = ITEM_MUST_BE_VALUE;
				return true;
			}
				break;
			case '[':
			{
				seek(-1, SEEK_CUR);
				string token;
				if (!read_luaToken(token, false))
					return false;

				if (token.length() > 1/* && token[0] == '['*/)	// string.
				{
					string str;
					if (!read_luaEscapeString(str, token))
						return false;

					first.setBasic(str);
					itemInfo = ITEM_MUST_BE_VALUE;
					return true;
				}
				else if (token.length() == 1/* && token[0] == '['*/)
				{
					string str, type;
					itemInfo = ITEM_MUST_BE_KEY;

					if (!read_luaIgnoreAllComment(true))
						return false;

					for (;;)
					{
						if (read_luaNumber(str, type))
						{
							first.setBasic();
							first.getBasic()->setValue(type, str);

							break;
						}

						if (read_luaString(str))
						{
							first.setBasic(str);
							break;
						}

						if (!read_luaName(str))
						{
							if (str == "true" || str == "false")
							{
								first.setBasic();
								first.getBasic()->setValue("boolean", str);
								break;
							}
							else
							{
								m_msg = "undefined name:" + str + " ";
								m_msg += getStreamInfo();
							}
						}
						return false;
					}
					
					if (!read_luaIgnoreAllComment(true))
						return false;

					if (!read_luaChar(ch, true) || ch != ']')
						return false;
				}

			}
				break;
			default:
				break;
			}
		}

		if (!read_luaIgnoreAllComment(true))
			return false;

		if (itemInfo == ITEM_MUST_BE_KEY)
		{
			string token;
			if (!read_luaToken(token, false))
				return false;

			if (token != "=")
			{
				m_msg = "\'=\' expected near" + token;
				return false;
			}

			if (!read_luaIgnoreAllComment(true))
				return false;

			if (!read_LuaValue(second))
				return false;
		}

		return true;
	}

	bool read_LuaTable(LuaValue& val)
	{
		val.setTable();

		string token;
		if (false == read_luaToken(token, true) || token != "{")
		{
			m_msg = "read lua token " + token + " error";
			return false;
		}
		LuaValue first;
		LuaValue second;
		int idx = 0;
		while (read_luaTableItem(first, second))
		{
			if (first.isNone() && second.isNone())
			{
				return true; // end of table
			}
			
			if (second.isNone())
			{
				//dbg_print(first.tostring());
				++idx;
				val[LuaValue(idx)] = first;
			}
			else
			{
				//dbg_print(first.tostring());
				//dbg_print("=");
				//dbg_print(second.tostring());
				val[first] = second;
			}

			if (!read_luaIgnoreAllComment(true))
			{
				m_msg = "ignore all comment error";
				return false;
			}
			uint8_t ch;
			if (read_luaChar(ch, false))
			{
				if (ch == ',')
				{
					continue;	// next item
				}
				else if (ch == '}')
				{
					return true; // end of table
				}
				else
				{
					m_msg = "error when occurs ";
					m_msg.push_back(ch);
					return false;
				}
			}
			else
			{
				return false;
			}
		}
		/*
		if (false == read_luaToken(token, true) && token != "}")
		{
		return false;
		}
		*/
		m_msg = "error occucred when read table item";
		return false;
	}
	bool read_LuaValue(LuaValue& val)
	{
		read_luaIgnoreAllComment(true);

		string token;
		if (!read_luaToken(token, false))
			return false;

		uint8_t ch = token[0];
		if (token == "nil")	// identifier
		{
			val.setBasic();
			val.getBasic()->setNil();
			return true;
		}
		else if (token == "true" || token == "false")
		{
			val.setBasic();
			val.getBasic()->setValue("boolean", token);
			return true;
		}
		else if (token.size() > 1 && token[0] == '[')
		{	
			string str;
			if (!read_luaEscapeString(str, token))
				return false;
			
			val.setBasic(str);		
			return true;
		}
		else if (ch == '+' || isdigit(ch) || (ch == '-'/* && token.size() == 1// can't be '--' */)) // number
		{
			ungetstring(token);
			string number, type;
			if (!read_luaNumber(number, type))
				return false;

			val.setBasic();
			val.getBasic()->setValue(type, number);

			return true;
		}
		else if (token.size() == 1)
		{			
			switch (ch)
			{
			case '{':
			{
				seek(-1, SEEK_CUR);
				if (!read_LuaTable(val))
					return false;

				return true;
			}
				break;
			case '\'':case '\"':
			{
				seek(-1, SEEK_CUR);
				string str;
				if (!read_luaString(str, ch))
				{
					m_msg = "error lua string " + str;
					return false;
				}
					

				val.setBasic(str);
				return true;
			}
				break;
			default:
				m_msg = "unexpected " + token;
				return false;
			}
		}
		else
		{
			val = token;
			return true;
		}
//		m_msg = "unexpected " + token;
//		return false;
	}
};


#endif