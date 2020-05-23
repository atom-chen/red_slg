#include "LuaType.h"


LuaValue::LuaValue(const LuaValue& rhs)
{
	m_type = rhs.m_type;
	switch (m_type)
	{
	case LuaValue::NONE_TYPE:
		m_value.ptr = 0;
		break;
	case LuaValue::BASIC_TYPE:
		m_value.basic = new LuaBasicValue(*rhs.m_value.basic);
		break;
	case LuaValue::TABLE_TYPE:
		m_value.table = new LuaTableValue(*rhs.m_value.table);
		break;
	default:
		assert(false);
		break;
	}
}

bool LuaValue::destroy()
{
	switch (m_type)
	{
	case LuaValue::NONE_TYPE:
		return true;
		break;
	case LuaValue::BASIC_TYPE:
		delete m_value.basic;
		break;
	case LuaValue::TABLE_TYPE:
		delete m_value.table;
		break;
	default:
		break;
	}
	m_value.ptr = 0;
	m_type = NONE_TYPE;
	return true;
}

LuaValue& LuaValue::operator[](const LuaValue& val)
{
	if (this->m_type != TABLE_TYPE)
	{
		assert(false);
	}
	return (*this->m_value.table)[val];
}
/*
const LuaValue& LuaValue::operator[](const LuaValue& val)const
{
if (this->m_type != TABLE_TYPE)
{
// error;
}
return (*this->m_value.table)[val];
}
*/
// NONE < BASIC < TABLE
bool LuaValue::operator<(const LuaValue& rhs)const
{
	if (rhs.m_type == NONE_TYPE)
		return false;

	if (this->m_type == NONE_TYPE)
		return true;

	if (this->m_type == BASIC_TYPE)
	{
		if (rhs.m_type == TABLE_TYPE)
		{
			return true;
		}
		// basic
		return (*this->m_value.basic) < (*rhs.m_value.basic);
	}
	return false;
}

LuaValue& LuaValue::operator = (const LuaValue& rhs)
{
	if (&rhs != this)
	{
		if (!this->isNone())
		{
			if (this->m_type == rhs.m_type)
			{
				if (isBasic())
				{
					*(m_value.basic) = *(rhs.m_value.basic);
				}
				else // table
				{
					*(m_value.table) = *(rhs.m_value.table);
				}
			}
			else
			{
				this->destroy();
			}
		}

		if (rhs.isBasic())
		{
			this->m_value.basic = new LuaBasicValue(*rhs.m_value.basic);
		}

		if (rhs.isTable())
		{
			this->m_value.table = new LuaTableValue(*rhs.m_value.table);
		}
		this->m_type = rhs.m_type;
	}
	return *this;
}

string LuaValue::tostring()const
{
	/*
	switch (m_type)
	{
	case LuaValue::NONE_TYPE:
	return "none:none";
	case LuaValue::BASIC_TYPE:
	return "basic:" + m_value.basic->tostring();
	case LuaValue::TABLE_TYPE:
	return "table:" + m_value.table->tostring();
	break;
	default:
	assert(false);
	break;
	}
	return "";
	*/
	return asReadableString();
}
string LuaValue::asReadableTableKeyString()const
{
	assert(m_type == BASIC_TYPE);

	return m_value.basic->asReadableTableKeyString();
}

string LuaValue::asReadableString()const
{
	switch (m_type)
	{
	case LuaValue::NONE_TYPE:
		assert(false);
		return "none:none";
	case LuaValue::BASIC_TYPE:
		return m_value.basic->asReadableString();
	case LuaValue::TABLE_TYPE:
		return m_value.table->tostring();
	default:
		assert(false);
		return "";  // unreachable;
	}
}
void LuaValue::setTable()
{
	switch (m_type)
	{
	case LuaValue::NONE_TYPE:
		m_value.table = new LuaTableValue();
		m_type = TABLE_TYPE;
		break;
	case LuaValue::BASIC_TYPE:
		delete m_value.basic;
		m_value.table = new LuaTableValue();
		m_type = TABLE_TYPE;
		break;
	case LuaValue::TABLE_TYPE:
		break;
	default:
		assert(false);
		break;
	}
}
void LuaValue::setBasic()
{
	switch (m_type)
	{
	case LuaValue::NONE_TYPE:
		m_value.basic = new LuaBasicValue();
		m_type = BASIC_TYPE;
		break;
	case LuaValue::BASIC_TYPE:
		break;
	case LuaValue::TABLE_TYPE:
		delete m_value.table;
		m_value.table = new LuaTableValue();
		m_type = BASIC_TYPE;
		break;
	default:
		assert(false);
		break;
	}
}
void LuaValue::setBasic(int val)
{
	setBasic();
	m_value.basic->set(val);
}
void LuaValue::setBasic(float val)
{
	setBasic();
	m_value.basic->set(val);
}
void LuaValue::setBasic(bool val)
{
	setBasic();
	m_value.basic->set(val);
}
void LuaValue::setBasic(const string& val)
{
	setBasic();
	m_value.basic->set(val);
}


bool LuaTableValue::exists(const LuaValue& lv)const
{
    return m_items.find(lv) != m_items.end();
}

LuaValue& LuaTableValue::operator[](const LuaValue& key)
{
    return m_items[key];
}

/*
const LuaValue& LuaTableValue::operator[](const LuaValue& key)const
{
	return m_items[key];
}
*/
bool LuaTableValue::remove(const LuaValue& key)
{
    items_t::iterator it = m_items.find(key);
    if (it != m_items.end())
    {
        m_items.erase(it);
        return true;
    }
    return false;
}

int LuaTableValue::getMinUnusedIndex()
{
    int idx = 0;
    for (items_t::iterator it = m_items.begin(); it != m_items.end(); ++it)
    {
        if (it->first.isBasic())
        {
            LuaBasicValue* lbv = it->first.getBasic();
			if (lbv->isInt())
			{
				int curInt = lbv->getInt();
				if (curInt != idx + 1)
					break;
				idx = curInt;
			}                
        }
    }
    return idx + 1;
}

int LuaTableValue::getMinLength()const
{
	int idx = 1;
	int length = 0;
	while (m_items.find(idx) != m_items.end())
	{
		length = idx;
		idx = idx + 1;
	}

	return length;
}

bool LuaTableValue::getValueString(const LuaValue& key, string& val)const
{
    items_t::const_iterator it = m_items.find(key);
    if (it == m_items.end())
        return false;

    LuaBasicValue* lbv = it->second.getBasic();
    if (!lbv)
        return false;

    if (!lbv->isString())
        return false;

    val = lbv->getString();
    return true;
}
bool LuaTableValue::getValueInt(const LuaValue& key, int& val)const
{
    items_t::const_iterator it = m_items.find(key);
    if (it == m_items.end())
        return false;

    LuaBasicValue* lbv = it->second.getBasic();
    if (!lbv)
        return false;

    if (!lbv->isInt())
        return false;

    val = lbv->getInt();
    return true;
}
bool LuaTableValue::getValueFloat(const LuaValue& key, float& val)const
{
    items_t::const_iterator it = m_items.find(key);
    if (it == m_items.end())
        return false;

    LuaBasicValue* lbv = it->second.getBasic();
    if (!lbv)
        return false;

    if (!lbv->isFloat() && !lbv->isInt())
        return false;

    val = lbv->getFloat();
    return true;
}
bool LuaTableValue::getValueBoolean(const LuaValue& key, bool& val)const
{
    items_t::const_iterator it = m_items.find(key);
    if (it == m_items.end())
        return false;

    LuaBasicValue* lbv = it->second.getBasic();
    if (!lbv)
        return false;

    if (!lbv->isBoolean())
        return false;

    val = lbv->getBoolean();
    return true;
}
bool LuaTableValue::getValue(const LuaValue& key, LuaValue& val)const
{
    items_t::const_iterator it = m_items.find(key);
    if (it == m_items.end())
        return false;

    val = it->second;
    return true;
}
/*
const LuaValue& operator[](const LuaValue& key)const
{
    items_t::const_iterator it = m_items.find(key);
    if (it == m_items.end())
    {
    //	return LuaValue();
        assert(false);
    }

    return it->second;
}
*/
string LuaTableValue::tostring()const
{
    string s = "{";
	int n = getMinLength();
	for (int i = 1; i <= n; ++i)
	{
		auto it = m_items.find(i);
		//if (it != m_items.end())
	//	{
			s += it->second.asReadableString();
			s.append(",");
	//	}
		//s += .asReadableString();
	}
	for (items_t::const_iterator it = m_items.begin(); it != m_items.end(); ++it)
	{
		if (it->first.isBasic())
		{
			if (it->first.isBasic())
			{
				LuaBasicValue* lbv = it->first.getBasic();
				if (lbv->isInt() && lbv->getInt() <= n)
				{
					continue;
				}
			}
		}
		s += it->first.asReadableTableKeyString();
		s.push_back('=');
		s += it->second.asReadableString();
		s.append(",");
	}
	
	
	/*
    for (items_t::const_iterator it = m_items.begin(); it != m_items.end(); ++it)
    {
        s += it->first.asReadableTableKeyString();
        s.push_back('=');
        s += it->second.asReadableString();
        s.append(",");//\n
    }
	*/
    if (s[s.length() - 1] == ',')
    {
        s.resize(s.length() - 1);
    }
    s.push_back('}');
    return s;
}