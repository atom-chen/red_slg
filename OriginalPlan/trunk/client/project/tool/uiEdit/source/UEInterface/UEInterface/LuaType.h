#ifndef __UIEDIT_LUA_TYPE_H__
#define __UIEDIT_LUA_TYPE_H__
//#include <cctype>
#include <set>
#include <map>
#include <string>
#include "stream.h"
using namespace std;


struct LuaBasicValue
{
private:
	string type;
	string value;
public:
	LuaBasicValue()
	{
		setNil();
	}
	LuaBasicValue(int val)
	{
		set(val);
	}
	LuaBasicValue(float val)
	{
		set(val);
	}
	LuaBasicValue(const string& val)
	{
		set(val);
	}
	LuaBasicValue(const LuaBasicValue& rhs)
	{
		type = rhs.type;
		value = rhs.value;
	}
	LuaBasicValue& operator=(const LuaBasicValue& rhs)
	{
		if (&rhs != this)
		{
			type = rhs.type;
			value = rhs.value;
		}
		return *this;
	}
	// boolean < string < int & float 
	bool operator<(const LuaBasicValue& rhs)
	{
		if (rhs.isNil())
			return false;

		if (isNil())
			return true;

		if (type != rhs.type)
		{
			if (rhs.type == "boolean")
				return false;

			if (type == "boolean")
				return true;

			if (rhs.type == "string")
				return false;

			if (type == "string")
				return true;

			double l = type == "int" ? this->getInt() : this->getFloat();
			double r = rhs.type == "int" ? rhs.getInt() : rhs.getFloat();
			return l < r;
		}
		else
		{
			if (type == "int")
			{
				return getInt() < rhs.getInt();
			}
			if (type == "float")
			{
				return getFloat() < rhs.getFloat();
			}
			// "false" < "true", so boolean and string are  same
			return value < rhs.value;
		}
	}

	int getInt()const
	{
		assert(isInt());
		return GetValueFromLuaString<int>(value);
	}
	float getFloat()const
	{
		assert(isFloat());
		return GetValueFromLuaString<float>(value);
	}
	float getNumber()const
	{
		assert(isNumber());
		return GetValueFromLuaString<float>(value);
	}
	bool getBoolean()const
	{
		assert(isBoolean());
		return GetValueFromLuaString<bool>(value);
	}
	string getString()const
	{
		assert(isString());
		return getValueString();
	}
	inline bool isNil()const{ return type == "nil"; }
	inline bool isBoolean()const{ return type == "boolean"; }
	inline bool isInt()const{ return type == "int"; }
	inline bool isFloat()const{ return type == "float"; }
	inline bool isNumber()const{ return type == "int" || type == "float" || type == "number"; }
	inline bool isString()const{ return type == "string"; }

	bool setNil()
	{
		type = "nil";
		value = "nil"; // Í³Ò»Êä³ö
		return true;
	}
	bool set(bool val)
    {
        type = "bool";
        value = val ? "true" : "false";
        return true;
    }

	bool set(size_t val)
	{
		type = "int";
		value = to_string(val);
		return true;
	}

	bool set(int val)
	{
		type = "int";
		value = to_string(val);
		return true;
	}

	bool set(float val)
	{
		type = "float";
		value = to_string(val);
		return true;
	}

	bool set(const char* val)
	{
		type = "string";
		value = val;
		return true;
	}

	bool set(const string& val)
	{
		type = "string";
		value = val;
		return true;
	}
	
	template<typename T>
	bool setValue(const string& typeString, T val)
	{
		this->type = typeString;
		stringstream ss;
		ss << val;
		this->value = ss.str();
		return true;
	}
	
	bool setValue(const string& typeString, const string& val)
	{
		this->type = typeString;
		this->value = val;
		return true;
	}
	string getValueString()const
	{
		return value;
	}
	string setValueString(const string& val)
	{
		string t = value;
		value = val;
		return t;
	}
	string getType()const
	{
		return type;
	}
	string setType(string typeString)
	{
		string t = type;
		type = typeString;
		return t;
	}

	string tostring()const
	{
		if (type == "int" || type == "float" || (type == "string" && is_valid_lua_name(value)))
		{
			return value;
		}
		return value;
	}
	string asReadableTableKeyString()const
	{
		if (type == "string")
		{
			if (is_valid_lua_name(value))
			{
				return value;
			}
			return "[" + to_readable_string(value) + "]";
		}
		if (type == "int" || type == "float" || type == "boolean" || type == "number")
		{
			return "[" + value + "]";
		}

		assert(false);
		return "";
	}

	string asReadableString()const
	{
		if (type == "string")
		{			
			return to_readable_string(value);
		}		
		return value;		
	}

public:
	template<typename T>
	static string to_string(const T& val)
	{
		stringstream ss;		
		ss << val;
		return ss.str();
	}

	template<typename T>
	static T GetValueFromLuaString(const string& str)
	{
		stringstream ss;
		ss.str(str);
		T val;
		ss >> val;
		return val;
	}

	
	static
	bool is_valid_lua_name(const string& v)
	{
		if (v.empty())
		{
			return false;
		}

		if (v[0] == '_' || isalpha(v[0]))
		{
			for (size_t i = 1; i != v.length(); ++i)
			{
				if (!isalnum(v[i]))
				{
					return false;
				}
			}
			return true;
		}
		return false;
	}
	static
	string to_readable_string(const string& val)
	{
		string s;
		//s.resize(val.length);
		s.reserve(val.length() + 2);
		s.push_back('\"');
		for (size_t i = 0; i != val.length(); ++i)
		{
			uint8_t ch = val[i];
			switch (ch)
			{
			case '\a': ch = 'a'; s.push_back('\\');	break;
			case '\b': ch = 'b'; s.push_back('\\');	break;
			case '\f': ch = 'f'; s.push_back('\\');	break;
			case '\n': ch = 'n'; s.push_back('\\');	break;
			case '\r': ch = 'r'; s.push_back('\\');	break;
			case '\v': ch = 'v'; s.push_back('\\');	break;
			case '\\': 
			case '\'': 
			case '\"': 
		//	case '[':
		//	case ']':
				s.push_back('\\');				
				break;
			}
			s.push_back(ch);
		}
		s.push_back('\"');
		return s;
	}

};

struct LuaTableValue;
struct LuaValue
{
	enum LuaType{ NONE_TYPE, BASIC_TYPE, TABLE_TYPE };
private:
	LuaType m_type;
	union
	{
		LuaBasicValue* basic;
		LuaTableValue* table;
		void* ptr;
	}m_value;

public:
	LuaValue()
	{
		m_type = NONE_TYPE;
		m_value.ptr = 0;
	}
	LuaValue(int val)
	{
		m_type = BASIC_TYPE;
		m_value.basic = new LuaBasicValue();
		m_value.basic->set(val);
	}
	LuaValue(size_t val)
	{
		m_type = BASIC_TYPE;
		m_value.basic = new LuaBasicValue();
		m_value.basic->set(val);
	}
	LuaValue(float val)
	{
		m_type = BASIC_TYPE;
		m_value.basic = new LuaBasicValue();
		m_value.basic->set(val);
	}
	LuaValue(bool val)
	{
		m_type = BASIC_TYPE;
		m_value.basic = new LuaBasicValue();
		m_value.basic->set(val);
	}
	LuaValue(const char* str)
	{
		m_type = BASIC_TYPE;
		m_value.basic = new LuaBasicValue();
		m_value.basic->set(str);
	}
	LuaValue(const string& val)
	{
		m_type = BASIC_TYPE;
		m_value.basic = new LuaBasicValue();
		m_value.basic->set(val);
	}

	LuaValue(const LuaValue& rhs);
	
	~LuaValue()
	{
		destroy();
	}
	virtual bool destroy();
	
	LuaValue& operator=(const LuaValue& rhs);

	string tostring()const;
	string asReadableTableKeyString()const;
	string asReadableString()const;
	bool isNone()const
	{
		return m_type == NONE_TYPE;
	}
	bool isTable()const
	{
		return m_type == TABLE_TYPE;
	}
	bool isBasic()const
	{
		return m_type == BASIC_TYPE;
	}

	void setNone()
	{
		this->destroy();
		m_type = NONE_TYPE;
	}
	void setTable();
	void setBasic();
	void setBasic(int val);
	void setBasic(float val);
	void setBasic(bool val);
	void setBasic(const string& val);
	LuaBasicValue* getBasic(){ return m_type == BASIC_TYPE ? m_value.basic : 0; }
	LuaTableValue* getTable(){ return m_type == TABLE_TYPE ? m_value.table : 0; }
	LuaBasicValue* getBasic()const{ return m_type == BASIC_TYPE ? m_value.basic : 0; }
	LuaTableValue* getTable()const{ return m_type == TABLE_TYPE ? m_value.table : 0; }
	LuaValue& operator[](const LuaValue& val);

	//const LuaValue& operator[](const LuaValue& val)const;
	bool operator<(const LuaValue& rhs)const;
};
struct LuaTableValue
{
	typedef map <LuaValue, LuaValue > items_t;
	items_t m_items;
public:	
	typedef items_t::iterator iterator;
	typedef items_t::const_iterator const_iterator;
	LuaTableValue::iterator begin(){ return m_items.begin(); }
	LuaTableValue::iterator end(){ return m_items.end(); }

	LuaTableValue::const_iterator begin()const{ return m_items.begin(); }	
	LuaTableValue::const_iterator end()const{ return m_items.end(); }
public:
	LuaTableValue(){}
	~LuaTableValue(){}
	LuaTableValue(const LuaTableValue& rhs)
	{
		m_items = rhs.m_items;
	}
	LuaTableValue& operator=(const LuaTableValue& rhs)
	{
		if (&rhs != this)
		{
			m_items = rhs.m_items;
		}
		return *this;
	}
    int count()const{ return m_items.size(); }
	bool exists(const LuaValue& lv)const;
	LuaValue& operator[](const LuaValue& key);

	bool remove(const LuaValue& key);
	int getMinUnusedIndex();
	int getMinLength()const;
	bool getValueString(const LuaValue& key, string& val)const;
	bool getValueInt(const LuaValue& key, int& val)const;
	bool getValueFloat(const LuaValue& key, float& val)const;
	bool getValueBoolean(const LuaValue& key, bool& val)const;
	bool getValue(const LuaValue& key, LuaValue& val)const;
	string tostring()const;
};


#endif