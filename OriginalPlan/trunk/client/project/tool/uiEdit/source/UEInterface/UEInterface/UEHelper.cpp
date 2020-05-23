#include "UEHelper.h"
#include "UEInterface.h"
#include "LuaUtils.h"
//---------------------------------------------------------------------------
bool ButtonEx::operator==(const ButtonEx& rhs)const
{
	return imageDisabled == rhs.imageDisabled && imageDown == rhs.imageDown && imageChecked == rhs.imageChecked;
}
bool ButtonEx::operator!= (const ButtonEx& rhs)const
{
    return !((*this) == rhs);
}
ButtonEx::ButtonEx()
{
    clear();
}
void ButtonEx::clear()
{
    imageDown.clear();
    imageDisabled.clear();
	imageChecked.clear();
}
int ButtonEx::getLength()const
{
	return ::getLength(imageDown) + ::getLength(imageDisabled) + ::getLength(imageChecked);
}
bool ButtonEx::toBinary(TypedStream* ts)
{
    if (!ts->write_string(imageDown)) return false;
    if (!ts->write_string(imageDisabled)) return false;
	if (!ts->write_string(imageChecked)) return false;
    return true;
}

bool ButtonEx::fromBinary(TypedStream* ts)
{
    if (!ts->read_string(imageDown)) return false;
    if (!ts->read_string(imageDisabled)) return false;
	if (!ts->read_string(imageChecked)) return false;
    return true;
}

bool ButtonEx::toReadable(TypedStream* ts)
{
    (void)ts;
    return true;
}

bool ButtonEx::toLuaValue(LuaValue& val)const
{
    if (!val.isTable())
        return false;
	if (!imageDown.empty())
		val[MK_STR(imageDown)] = imageDown;
	if (!imageDisabled.empty())
		val[MK_STR(imageDisabled)] = imageDisabled;
	if (!imageChecked.empty())
		val[MK_STR(imageChecked)] = imageChecked;
    return true;
}
bool ButtonEx::fromLuaValue(const LuaValue& val)
{
    if (!val.isTable())
        return false;

	if (!val.getTable()->getValueString(MK_STR(imageDown), imageDown)) imageDown.clear();
    if (!val.getTable()->getValueString(MK_STR(imageDisabled), imageDisabled)) imageDisabled.clear();
	if (!val.getTable()->getValueString(MK_STR(imageChecked), imageChecked)) imageChecked.clear();
    return true;
}
//---------------------------------------------------------------------------
bool ProgressBarEx::operator==(const ProgressBarEx& rhs)const
{
    if (x != rhs.x || y != rhs.y || width != rhs.width || height != rhs.height)
        return false;

    return barImage == rhs.barImage;
}

bool ProgressBarEx::operator!= (const ProgressBarEx& rhs)const
{
    return !((*this) == rhs);
}

ProgressBarEx::ProgressBarEx()
{
    clear();
}
void ProgressBarEx::clear()
{
    x = 0, y = 0, width = 0, height = 0;
    barImage.clear();
}
int ProgressBarEx::getLength()const
{
    return ::getLength(x) + ::getLength(y) + ::getLength(width) + ::getLength(height) + ::getLength(barImage);
}
bool ProgressBarEx::toBinary(TypedStream* ts)
{
    if (!ts->write_int32(x)) return false;
    if (!ts->write_int32(y)) return false;
    if (!ts->write_int32(width)) return false;
    if (!ts->write_int32(height)) return false;
    if (!ts->write_string(barImage)) return false;
    return true;
}
bool ProgressBarEx::fromBinary(TypedStream* ts)
{
    if (!ts->read_int32(x)) return false;
    if (!ts->read_int32(y)) return false;
    if (!ts->read_int32(width)) return false;
    if (!ts->read_int32(height)) return false;
    if (!ts->read_string(barImage)) return false;
    return true;
}
bool ProgressBarEx::toLuaValue(LuaValue& val)const
{
    if (!val.isTable())
        return false;

    val[MK_STR(x)] = x;
    val[MK_STR(y)] = y;
    val[MK_STR(width)] = width;
    val[MK_STR(height)] = height;
    val[MK_STR(barImage)] = barImage;
    return true;
}
bool ProgressBarEx::fromLuaValue(const LuaValue& val)
{
    if (!val.isTable())
        return false;

    if (!val.getTable()->getValueInt(MK_STR(x), x)) return false;
    if (!val.getTable()->getValueInt(MK_STR(y), y)) return false;
    if (!val.getTable()->getValueInt(MK_STR(width), width)) return false;
    if (!val.getTable()->getValueInt(MK_STR(height), height)) return false;
    if (!val.getTable()->getValueString(MK_STR(barImage), barImage)) return false;
    return true;
}
//---------------------------------------------------------------------------
bool ElemInfo::eq_exist(const ElemInfo& rhs)
{
	(void*)&rhs;
	return true;
}
//---------------------------------------------------------------------------
bool ElemInfo::operator==(const ElemInfo& rhs)const
{
    if (type != rhs.type)
        return false;

    if (cName != rhs.cName || picName != rhs.picName || data != rhs.data)
        return false;

    if (x != rhs.x || y != rhs.y)
        return false;

	if (!((width < 0 || height < 0) && (rhs.width < 0 || rhs.height < 0)))
	{
		if (width != rhs.width || height != rhs.height)
			return false;
	}

    if (tag != rhs.tag)
        return false;

    if (isEnlarge != rhs.isEnlarge || isSTensile != rhs.isSTensile)
        return false;

	if (!text.empty() && !rhs.text.empty())
	{
		if (text != rhs.text || textType != rhs.textType || fontSize != rhs.fontSize || fontColor != rhs.fontColor || align != rhs.align)
			return false;
	}
    switch (type)
    {
    case UI_BUTTON:
        if (buttonEx != rhs.buttonEx)
            return false;
        break;
    case UI_PROGRESS_BAR:
        if (progressBarEx != rhs.progressBarEx)
            return false;
        break;
	case UI_FRAME:
		if (frameType != rhs.frameType)
			return false;
		break;
    }

    return true;
}
bool ElemInfo::operator!= (const ElemInfo& rhs)const
{
    return !((*this) == rhs);
}
ElemInfo::ElemInfo()
{
    clear();
}
void ElemInfo::clear()
{
    type = 0;
	frameType = 0;
    cName.clear();
    picName.clear();
	data.clear();
    x = 0, y = 0, width = 0, height = 0;

	scrollAlign = 0;
    tag = 0;
    isEnlarge = 0;
    isSTensile = 0;

    text.clear();
    textType = 0, fontSize = 18, fontColor = 0, align = 4;
    progressBarEx.clear();
    buttonEx.clear();

    textIndex = -1;
}
int ElemInfo::getLength()
{
    int len = ::getLength(type) + ::getLength(frameType) + ::getLength(cName) + ::getLength(picName) + ::getLength(data);
    len = len + ::getLength(x) + ::getLength(y) + ::getLength(width) + ::getLength(height);
	len = len + ::getLength(scrollAlign) + ::getLength(tag) + ::getLength(isEnlarge) + ::getLength(isSTensile);
    len = len + ::getLength(text) + ::getLength(textType) + ::getLength(fontSize) + ::getLength(fontColor) + ::getLength(align);

    switch (type)
    {
    case UI_BUTTON:
        len = len + buttonEx.getLength();
        break;
    case UI_PROGRESS_BAR:
        len = len + progressBarEx.getLength();
        break;

    }
    return len;
}
bool ElemInfo::toBinary(TypedStream* ts)
{
    if (!ts->write_int16(type)) return false;

    if (!ts->write_string(cName)) return false;
    if (!ts->write_string(picName)) return false;
	if (!text.empty() && !ts->write_string(text)) return false;
	if (!data.empty() && !ts->write_string(data)) return false;

    if (!ts->write_int32(x)) return false;
    if (!ts->write_int32(y)) return false;
    if (!ts->write_int32(width)) return false;
    if (!ts->write_int32(height)) return false;

    if (!ts->write_int16(tag)) return false;
    if (!ts->write_int16(isEnlarge)) return false;
    if (!ts->write_int16(isSTensile)) return false;

    switch (type)
    {
    case UI_BUTTON:
        if (!buttonEx.toBinary(ts)) return false;
        break;
    case UI_PROGRESS_BAR:
        if (!progressBarEx.toBinary(ts)) return false;
        break;
    }
    return true;
}
bool ElemInfo::fromBinary(TypedStream* ts)
{
    if (!ts->read_int16(type)) return false;

    if (!ts->read_string(cName)) return false;
    if (!ts->read_string(picName)) return false;
	if (!ts->read_string(text)) text = "";
	if (!ts->read_string(data)) data = "";

    if (!ts->read_int32(x)) return false;
    if (!ts->read_int32(y)) return false;
    if (!ts->read_int32(width)) return false;
    if (!ts->read_int32(height)) return false;

    if (!ts->read_int16(tag)) return false;
    if (!ts->read_int16(isEnlarge)) return false;
    if (!ts->read_int16(isSTensile)) return false;

    switch (type)
    {
    case UI_BUTTON:
        if (!buttonEx.fromBinary(ts)) return false;
        break;
    case UI_PROGRESS_BAR:
        if (!progressBarEx.fromBinary(ts)) return false;
        break;
    }
    return true;
}



bool ElemInfo::toLuaValue(LuaValue& val, const string& textName)const
{
    if (!val.isTable())
        return false;

    val[MK_STR(type)] = type;
    val[MK_STR(cName)] = cName;
    val[MK_STR(picName)] = picName;
    
	if (audio.size() > 0)
	{
		val[MK_STR(audio)] = audio;
	}
	if (data.size() > 0)
	{
		val[MK_STR(data)] = data;
	}
	if (scaleX > 0.000001 || scaleX < -0.000001)
	{
		val[MK_STR(scaleX)] = scaleX;
	}

	if (scaleY > 0.000001 || scaleY < -0.000001)
	{
		val[MK_STR(scaleY)] = scaleY;
	}

	val[MK_STR(x)] = x;
	val[MK_STR(y)] = y;

	if (width > 0 && height > 0)
	{
		val[MK_STR(width)] = width;
		val[MK_STR(height)] = height;
	}    

	switch (type)
	{
	case UI_UISCROLLVIEW:
	case UI_UISCROLLLIST:
	case UI_UISCROLLPAGE:
	{
		val[MK_STR(scrollAlign)] = scrollAlign;
		if (scrollMargin > 0)
		{
			val[MK_STR(scrollMargin)] = scrollMargin;
		}
	}
	default:
		break;
	}

    val[MK_STR(tag)] = tag;
    val[MK_STR(isEnlarge)] = isEnlarge;
    val[MK_STR(isSTensile)] = isSTensile;

    if (!text.empty())
    {
        textIndex = WordsTable::getWordsTable()->getNewUEIndex();
        if (textIndex > 0)
        {
            val[textName] = textIndex;
            WordsTable::getWordsTable()->setUEString(textIndex, text);
			//val[MK_STR(textType)] = textType;
			//val[MK_STR(fontSize)] = fontSize;
			//val[MK_STR(fontColor)] = fontColor;
			//val[MK_STR(align)] = align;
        }
    }

	if (textShade > 0)
	{
		val[MK_STR(textShade)] = textShade;
	}

	if (useRTF == 1)
	{
		val[MK_STR(useRTF)] = useRTF;
	}

    val[MK_STR(textType)] = textType;
    val[MK_STR(fontSize)] = fontSize;
    val[MK_STR(fontColor)] = fontColor;
    val[MK_STR(align)] = align;
	


    switch (type)
    {
    case UI_BUTTON:
    {
        LuaValue btn;
        btn.setTable();
        if (!buttonEx.toLuaValue(btn)) return false;
        val["button"] = btn;
    }
        break;
    case UI_PROGRESS_BAR:
    {
        LuaValue progressBar;
        progressBar.setTable();
        if (!progressBarEx.toLuaValue(progressBar)) return false;
        val["progressBar"] = progressBar;
    }
        break;
	case UI_FRAME:
		val[MK_STR(frameType)] = frameType;
		break;
    }

    return true;
}
bool ElemInfo::fromLuaValue(const LuaValue& val, const string& textName)
{
	if (!val.isTable())
		return false;

	const LuaTableValue* ltv = val.getTable();
	int tmp;
	if (!val.getTable()->getValueInt(MK_STR(type), tmp)) return false; type = static_cast<short>(tmp);

	if (!val.getTable()->getValueString(MK_STR(cName), cName)) return false;
	if (!val.getTable()->getValueString(MK_STR(picName), picName)) return false;

	if (!val.getTable()->getValueString(MK_STR(audio), audio))
	{
	}
	if (!val.getTable()->getValueString(MK_STR(data), data))
	{
	}
	
    if (!val.getTable()->getValueInt(MK_STR(x), x)) return false;
    if (!val.getTable()->getValueInt(MK_STR(y), y)) return false;
	if (!val.getTable()->getValueInt(MK_STR(width), width)) width = -1;
    if (!val.getTable()->getValueInt(MK_STR(height), height)) height = -1;

	if (!val.getTable()->getValueFloat(MK_STR(scaleX), scaleX)) scaleX = 0.0f;
	if (!val.getTable()->getValueFloat(MK_STR(scaleY), scaleY)) scaleY = 0.0f;

	switch (type)
	{
	case UI_UISCROLLVIEW:
	case UI_UISCROLLLIST:
	case UI_UISCROLLPAGE:
	{
		if (!val.getTable()->getValueInt(MK_STR(scrollAlign), scrollAlign)) return false;
		if (!val.getTable()->getValueInt(MK_STR(scrollMargin), scrollMargin)) scrollMargin = 0;
		if (scrollMargin < 0)
			scrollMargin = 0;
	}
	default:
		break;
	}

    if (!val.getTable()->getValueInt(MK_STR(tag), tmp)) return false; tag = static_cast<short>(tmp);
    if (!val.getTable()->getValueInt(MK_STR(isEnlarge), tmp)) return false; isEnlarge = static_cast<short>(tmp);
    if (!val.getTable()->getValueInt(MK_STR(isSTensile), tmp)) return false; isSTensile = static_cast<short>(tmp);

    /*
    if (!val.getTable()->getValueString(MK_STR(text), text))
    {
        text = "";
    }
    */
    int textIndex = -1;
    if (!val.getTable()->getValueInt(textName, textIndex))
    {
        text = "";

		if (!val.getTable()->getValueInt(MK_STR(textType), tmp)) textType = -1;

		if (!val.getTable()->getValueInt(MK_STR(fontSize), fontSize)) fontSize = -1;
		if (!val.getTable()->getValueInt(MK_STR(fontColor), fontColor)) fontColor = -1;
		if (!val.getTable()->getValueInt(MK_STR(align), align)) align = -1;
    }
    else
    {
        text = WordsTable::getWordsTable()->getUEStringDefault(textIndex, "");

		if (!val.getTable()->getValueInt(MK_STR(textType), tmp)) return false; textType = static_cast<short>(tmp);

		if (!val.getTable()->getValueInt(MK_STR(fontSize), fontSize)) return false;
		if (!val.getTable()->getValueInt(MK_STR(fontColor), fontColor)) return false;
		if (!val.getTable()->getValueInt(MK_STR(align), align)) return false;
    }
    
	
	this->textIndex = textIndex;
	if (!val.getTable()->getValueInt(MK_STR(textShade), textShade)) textShade = 0;
	if (!val.getTable()->getValueInt(MK_STR(useRTF), useRTF)) useRTF = 0;
	
    switch (type)
    {
    case UI_BUTTON:
    {
        LuaValue btn;
        if (!ltv->getValue("button", btn))
            return false;

        if (!buttonEx.fromLuaValue(btn))
            return false;
    }
        break;
    case UI_PROGRESS_BAR:
    {
        LuaValue progressBar;
        if (!ltv->getValue("progressBar", progressBar))
            return false;

		if (!progressBarEx.fromLuaValue(progressBar))
            return false;
    }
        break;
	case UI_FRAME:
		if (!val.getTable()->getValueInt(MK_STR(frameType), frameType)) return false;
		break;
    }

    return true;
}

//---------------------------------------------------------------------------
UIDataItem::UIDataItem()
{
    m_available = false;
}
UIDataItem::UIDataItem(const ElemInfo& ele)
{
    m_available = true;
    m_eleInfo = ele;
}
bool UIDataItem::operator==(const UIDataItem& rhs)const
{
    return m_eleInfo == rhs.m_eleInfo;
}
bool UIDataItem::operator!= (const UIDataItem& rhs)const
{
    return !((*this) == rhs);
}
int UIDataItem::getLength()
{
    return ::getLength(len) + m_eleInfo.getLength();
}
bool UIDataItem::toBinary(TypedStream* ts)
{
    if (!ts->write_int32(len)) return false;
    if (!m_eleInfo.toBinary(ts)) return false;
    return true;
}
bool UIDataItem::fromBinary(TypedStream* ts)
{
    if (!ts->read_int32(len)) return false;
    if (!m_eleInfo.fromBinary(ts)) return false;
    return true;
}
bool UIDataItem::toLuaValue(LuaValue& val, const string& textName)const
{
    return m_eleInfo.toLuaValue(val, textName);
}
bool UIDataItem::fromLuaValue(const LuaValue& val, const string& textName)
{
    return m_eleInfo.fromLuaValue(val, textName);
}


//---------------------------------------------------------------------------
bool UIDataFormat::operator==(const UIDataFormat& rhs)const
{
    return count == rhs.count && alignment == rhs.alignment && m_item == rhs.m_item;
}
bool UIDataFormat::operator!= (const UIDataFormat& rhs)const
{
    return !((*this) == rhs);
}
UIDataFormat::UIDataFormat()
{
    clear();
}
void UIDataFormat::clear()
{
    len = 0;
    count = 0;
    version = 0;
    alignment = 0;
    memset(padding, 0, sizeof(padding));
    m_item.clear();
 }
void UIDataFormat::push_back(const UIDataItem& item)
{
    count++;
    m_item.push_back(item);
}
void UIDataFormat::setAlignment(int align)
{
    alignment = align;
}
int UIDataFormat::getLength()
{
    int totalLen = 0;
    totalLen = totalLen + ::getLength(len) + ::getLength(count) + ::getLength(version) + ::getLength(padding);

    for (size_t i = 0; i != m_item.size(); ++i)
    {
        totalLen += m_item[i].getLength();
    }
    return totalLen;
}
bool UIDataFormat::toBinary(TypedStream* ts)
{
    if (!ts->write_int32(len)) return false;
    if (!ts->write_int32(count)) return false;
    if (!ts->write_int32(version)) return false;
    if (sizeof(padding) != ts->writen(padding, sizeof(padding))) return false;

    for (size_t i = 0; i != m_item.size(); ++i)
    {
        if (!m_item[i].toBinary(ts))
        {
            return false;
        }
    }
    return true;
}
bool UIDataFormat::fromBinary(TypedStream* ts)
{
    if (!ts->read_int32(len)) return false;
    if (!ts->read_int32(count) && count < 0) return false;
    if (!ts->read_int32(version)) return false;
    if (sizeof(padding) != ts->writen(padding, sizeof(padding))) return false;

    m_item.resize(count);

    for (size_t i = 0; i != m_item.size(); ++i)
    {
        if (!m_item[i].fromBinary(ts))
        {
            return false;
        }
    }
    return true;
}
bool UIDataFormat::toLuaValue(LuaValue& val, const string& textName)const
{
    val.setNone();
    val.setTable();

    val["count"] = count;
    val["alignment"] = alignment;
    int itemSize = static_cast<int>(m_item.size());
    for (int i = 0; i != itemSize; ++i)
    {
        val[i + 1].setTable();
        if (!m_item[i].toLuaValue(val[i + 1], textName))
            return false;
    }
    return true;
}
bool UIDataFormat::fromLuaValue(const LuaValue& val, const string& textName)
{
    if (!val.isTable())
        return false;

    if (!val.getTable()->getValueInt("count", count))
        return false;

    if (!val.getTable()->getValueInt("alignment", alignment))
    {
        alignment = 0;
    }

    LuaTableValue::const_iterator it = val.getTable()->begin();
    LuaTableValue::const_iterator it_end = val.getTable()->end();

    for (; it != it_end; ++it)
    {
        if (it->first.isBasic())
        {
            LuaBasicValue* basic = it->first.getBasic();
            int idx;
            if (basic->isInt())
            {
                idx = basic->getInt();
                if (idx > 0)
                {
                    m_item.push_back(UIDataItem());
                    if (!m_item.back().fromLuaValue(it->second, textName))
                        return false;
                }
            }
        }
    }

    return true;
}

bool UIDataFormat::getUIDataFormatFromLuaFile(const string& path, UIDataFormat& uiData)
{
    string msg;

	string utf8path = FSUtils::ansitoutf8(path);
	string namepart, filename, ext;
	if (!FSUtils::ExtractPath(utf8path, namepart, ext))
	{
		//	ShowMessage("文件名错误");
		return false;
	}
	filename = namepart + "." + ext;

	string langname = namepart + "_lang.lua";

	assert(UI_SUCCESS(UIDataLanguageClose()));

	if (!UI_SUCCESS(UIDataLanguageCreate(langname.c_str(), 1)))
		return false;

	if (!WordsTable::getWordsTable()->existsUE(filename))
	{
		if (!WordsTable::getWordsTable()->saveAsNewUE(filename, true))
			return false;
	}
	else
	{
		if (!WordsTable::getWordsTable()->setUECurrent(filename))
		{
			return false;
		}
	}

    uiData.clear();

    LuaValue uiDataTable;

	if (!GetLuaReturnTable(path, uiDataTable))
	{
		msg = "get lua table error";
		return false;
	}

	LuaValue abbrs;
	if (GetLuaReturnTable("uilayer_abbr.lua", abbrs))
	{
		if (abbrs.isTable())
		{
			LuaValue index;
			index.setTable();
			LuaTableValue* table = abbrs.getTable();
			for (auto it = table->begin(); it != table->end(); ++it)
			{
				const LuaValue& key = (*it).first;
				const LuaValue& value = (*it).second;
				index[value] = key;
			}

			LuaTableValue& indexTable = *(index.getTable());
			LuaTableValue* uiTable = uiDataTable.getTable();
			for (auto it = uiTable->begin(); it != uiTable->end(); ++it)
			{
				const LuaValue& key = (*it).first;
				const LuaValue& value = (*it).second;
				if (key.isBasic())
				{
					auto basic = key.getBasic();
					if (basic->isNumber())
					{
						auto& ele = *(value.getTable());
						LuaValue newValue;
						newValue.setTable();
						for (auto it = ele.begin(); it != ele.end(); ++it)
						{
							if (indexTable.exists(it->first))
							{
								newValue[indexTable[it->first]] = it->second;
							}
							else
							{
								newValue[it->first] = it->second;
							}
						}
						uiTable->operator[](key) = newValue;
					}
				}
			}
		}
	}

    if (!uiData.fromLuaValue(uiDataTable, "text"))
    {
        return false;
    }
	assert(UI_SUCCESS(UIDataLanguageClose()));
    return true;
}
bool UIDataFormat::setUIDataFormatToLuaFile(const string& path, const UIDataFormat& uiData)
{
    string msg;
    RWFStream rwf(path.c_str(), "wb");
    if (!rwf.is_open())
    {
        return false;
    }
	string utf8path = FSUtils::ansitoutf8(path);
	string namepart, filename, ext;
	if (!FSUtils::ExtractPath(utf8path, namepart, ext))
	{
		//	ShowMessage("文件名错误");
		return false;
	}
	filename = namepart + "." + ext;

	string langname = namepart + "_lang.lua";

	assert(UI_SUCCESS(UIDataLanguageClose()));

	if (!UI_SUCCESS(UIDataLanguageCreate(langname.c_str(), 1)))
		return false;


    WordsTable::getWordsTable()->createNewUE(filename, true);

    LuaTypedStream lts(&rwf);


    LuaValue uiDataTable;

    if (!uiData.toLuaValue(uiDataTable, "text"))
    {
        return false;
    }

	LuaValue abbrs;
	if (GetLuaReturnTable("uilayer_abbr.lua", abbrs))
	{
		if (abbrs.isTable())
		{
			LuaTableValue& indexTable = *(abbrs.getTable());
			LuaTableValue* uiTable = uiDataTable.getTable();
			for (auto it = uiTable->begin(); it != uiTable->end(); ++it)
			{
				const LuaValue& key = (*it).first;
				const LuaValue& value = (*it).second;
				if (key.isBasic())
				{
					auto basic = key.getBasic();
					if (basic->isNumber())
					{
						auto& ele = *(value.getTable());
						LuaValue newValue;
						newValue.setTable();
						for (auto it = ele.begin(); it != ele.end(); ++it)
						{
							if (indexTable.exists(it->first))
							{
								newValue[indexTable[it->first]] = it->second;
							}
							else
							{
								newValue[it->first] = it->second;
							}
						}
						uiTable->operator[](key) = newValue;
					}
				}
			}
		}
	}

    if (!lts.write_string("return "))
        return false;

    if (!lts.write_string(uiDataTable.tostring()))
        return false;




	if (!WordsTable::getWordsTable()->saveAsNewUE(filename, true))
	{
		//	ShowMessage("语言文件保存错误");
		return false;
	}
	//WordsTable::getWordsTable()->deleteUE(filename);
	assert(UI_SUCCESS(UIDataLanguageClose()));
    return true;
}
//---------------------------------------------------------------------------
WordsTable* WordsTable::getWordsTable()
{
    static WordsTable sg_WordsTable;
    return &sg_WordsTable;
}

bool WordsTable::open(const string& path, bool createIfNoteExists)
{
	/*
	if (path == m_path && m_path != "")
	return true;
	*/

	RWFStream rwf(path.c_str(), "rb");
	if (!rwf.is_open())
	{
		if (!createIfNoteExists)
		{
			return false;
		}

		this->clear();

		m_path = path;
		m_tables.setTable();

		return true;
	}

	this->clear();
	LuaTypedStream lts(&rwf);


	LuaValue returnVal;
	if (!lts.read_LuaValue(returnVal))
	{
		m_msg = "read return error";
		return false;
	}
	else
	{
		if (!returnVal.isBasic() || returnVal.getBasic()->getValueString() != "return")
		{
			m_msg = "unexpected " + returnVal.tostring();
			return false;
		}
	}

	if (!lts.read_LuaValue(m_tables))
	{
		m_msg = "error read the table";
		return false;
	}

	m_path = path;
	return true;
}

/*
bool WordsTable::exists(const string& langFilename)
{
string name, ext;
if (false == FSUtils::ExtractPath(langFilename, name, ext) || name.empty() || ext != "lua")
{
return false;
}

if (!m_table.isTable() || !m_table.getTable()->exists(name))
{
return false;
}
return true;
}
*/
bool WordsTable::save()
{
	RWFStream rwf(m_path.c_str(), "wb");
	TypedStream ts(&rwf);
	if (!ts.is_open())
		return false;

	if (!ts.write_string("return "))
		return false;

	if (!ts.write_string(m_tables.tostring()))
		return false;
	
	return true;
}
bool WordsTable::saveAs(const string& path)
{
	if (RWFStream::writeToFile(m_tables.tostring(), path, "wb"))
	{
		m_path = path;
		return true;
	}
	return false;
}
bool WordsTable::clear()
{
	m_tables.setNone();
	m_workkey.setNone();
	m_workValue.setNone();
	m_msg.clear();
	return true;
}
bool WordsTable::createTmpUE()
{
    m_workkey.setNone();
    m_workValue.setTable();
    return true;
}
bool WordsTable::createNewUE(const string& filename, bool overwrite)
{
	string name, ext;
	if (false == FSUtils::ExtractPath(filename, name, ext) || name.empty() || ext != "lua")
	{
		return false;
	}

	m_workkey = name;
	if (existsUE(name) && !overwrite)
	{
		m_workValue = m_tables[m_workkey];
	}
	else
	{
		m_workValue.setNone();
		m_workValue.setTable();
	}

	return true;
}
bool WordsTable::existsUE(const string& filename)
{
	string name, ext;
	if (false == FSUtils::ExtractPath(filename, name, ext) || name.empty() || ext != "lua")
	{
		return false;
	}

	if (!m_tables.isTable() || !m_tables.getTable()->exists(name))
	{
		return false;
	}
	return true;
}
// after save success
// if filename's fullpath is the same as before, and overwrite is false. the operation should be failed.
bool WordsTable::saveAsNewUE(const string& filename, bool overwrite)
{
	string name, ext;
	if (false == FSUtils::ExtractPath(filename, name, ext) || name.empty() || ext != "lua")
	{
		return false;
	}

	if (existsUE(filename) && !overwrite)
	{
		return false;
	}

	if (!m_tables.isTable())
		return false;

	if (m_workkey.isNone())
	{
		m_workkey = name;
	}

	m_tables[m_workkey] = m_workValue;

	return save();
}
bool WordsTable::saveUE()
{
	if (m_workkey.isNone())
	{
		return false;
	}

	m_tables[m_workkey] = m_workValue;
	return save();
}
bool WordsTable::deleteUE(const string& filename)
{
	string name, ext;
	if (false == FSUtils::ExtractPath(filename, name, ext) || name.empty() || ext != "lua")
	{
		return false;
	}
	if (!m_tables.isTable())
		return false;

	m_tables.getTable()->remove(name);
	return true;
}

bool WordsTable::setUECurrent(const string& filename)
{
	string name, ext;
	if (false == FSUtils::ExtractPath(filename, name, ext) || name.empty() || ext != "lua")
	{
		return false;
	}

	if (existsUE(filename))
	{
		m_workkey = name;
		m_workValue = m_tables[m_workkey];
		return true;
	}
	return false;
}

int WordsTable::getNewUEIndex()
{
	if (!m_workValue.isTable())
		return -1;

	return m_workValue.getTable()->getMinUnusedIndex();
}

bool WordsTable::setUEString(int idx, const string& str)
{
	if (!m_workValue.isTable())
		return false;

	m_workValue[idx] = str;
	return true;
}
bool WordsTable::getUEString(int idx, string& str)
{
	if (!m_workValue.isTable())
		return false;

	LuaTableValue* tbl = m_workValue.getTable();
	if (!tbl->exists(idx))
		return false;

	LuaValue& strval = (*tbl)[idx];
	if (!strval.isBasic())
		return false;

	str = strval.getBasic()->getValueString();

	return true;
}
string WordsTable::getUEStringDefault(int idx, const string& defaultValue)
{
    string val;
    if (getUEString(idx, val)) {
        return val;
    }
    return defaultValue;
}
bool WordsTable::deleteUEString(int idx)
{
	if (!m_workValue.isTable())
		return false;

	LuaTableValue* tbl = m_workValue.getTable();
	if (!tbl->remove(idx))
		return false;
	return true;
}
string WordsTable::getErrorInfo()
{
	return m_msg;
}
//---------------------------------------------------------------------------
