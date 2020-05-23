#ifndef _CONFIG_TBL_UITL_H_
#define _CONFIG_TBL_UITL_H_

#include "xpath_static.h"

#include "core/multi_index.h"
#include "core/script/script_lua_inc.h"
#include "core/script/lua_tinker.h"
#include "core/service.h"

#include "curl_util.h"
#include "crypt_util.h"
#include "tbl_define.h"

class CCconfigLoaderParam
{
public:
	CCconfigLoaderParam()
	{
		//DZeroSelf;
		encryptKey = "";
		loginName = "";
		loginPwd = "";
		remotePath = false;
		encrypt = false;
	}

public:
	std::string encryptKey;			// º”√‹Key
	std::string loginName;			// µ«¬Ω√˚
	std::string loginPwd;			// µ«¬Ω√‹¬Î
	bool remotePath;				// ‘∂≥Ãµÿ÷∑

	bool encrypt;					//  «∑Òº”√‹
};

class CConfigLoaderBase
{
public:
	virtual bool checkConfig(){ return true;}

protected:
	std::string _configName;
};
typedef std::vector<CConfigLoaderBase*> TTblLoaderVec;

template<typename T, typename KeyT>
class CConfigLoader :
	public GXMISC::CManualSingleton<T>,
	public GXMISC::CHashMultiIndex<KeyT, true>,
	CConfigLoaderBase
{
public:
	typedef GXMISC::CHashMultiIndex<KeyT, true> TBaseType;
	typedef typename TBaseType::Iterator Iterator;
	typedef KeyT* KeyType;

public:
	KeyT* get(uint32 index)
	{
		uint32 count = 0;
		for(typename TBaseType::Iterator iter = TBaseType::begin(); iter != TBaseType::end(); ++iter)
		{
			count++;
			if(count == index)
			{
				return iter->second;
			}
		}

		return NULL;
	}

	bool load(const std::string& name, CCconfigLoaderParam& param)
	{
		std::string fileName = DFileName(name);
		return load(name, fileName, param);
	}

	bool loadByLua(std::string luaTableName, const std::string& name, CCconfigLoaderParam& param)
	{
		lua_tinker::s_object configs = GXMISC::g_LibService->getScriptEngine()->getGlobal(luaTableName.c_str());
		if (!configs)
		{
			return false;
		}

		lua_tinker::s_object config = configs.get<lua_tinker::s_object>(name.c_str());

		sint32 count = 0;
		for (lua_tinker::iterator iter(config), end; iter != end; ++iter, count++)
		{
			typename TBaseType::ValueProType* row = new typename TBaseType::ValueProType();
			readRow(*iter, count, row);
		}

		return true;
	}

	bool load(const std::string& name, const std::string& fileName, CCconfigLoaderParam& param)
	{
		TiXmlDocument *XPRoot;
		XPRoot = new TiXmlDocument();
		_configName = name;
		if(param.remotePath)
		{
			const char* xmlBuff = NULL;
			TUrlDownFile downFile;
			if(!GetUrlFile(downFile, name.c_str(), param.loginName.c_str(), param.loginPwd.c_str()))
			{
				gxError("Can't load config file!{0}", fileName);
				return false;
			}

			std::string outData;
			if(param.encrypt)
			{
				AESDecrypt((byte*)(param.encryptKey.c_str()), (uint32)param.encryptKey.size(), (byte*)downFile.buff, downFile.curLen, outData);
				xmlBuff = outData.c_str();
			}
			else
			{
				xmlBuff = downFile.buff;
			}

			XPRoot->Parse(xmlBuff);

			if(XPRoot->Error())
			{
				gxError("Can't parse config file!{0}", fileName);
				return false;
			}
		}
		else
		{
			if(false == XPRoot->LoadFile(name.c_str()))
			{
				gxError("Can't open xml file! name = {0}", name);
				return false;
			}
		}

		TiXmlElement* element = XPRoot->RootElement()->FirstChildElement();
		uint32 count = 0;
		while(element != NULL)
		{   
			typename TBaseType::ValueProType* row = new typename TBaseType::ValueProType();
			if(NULL == row)
			{
				gxError("Can't new {0}! Line={0}", typeid(typename TBaseType::ValueProType).name(), count);
				return false;
			}

			if(false == readRow(element, count, row))
			{
				return false;
			}

			if(false == row->onAfterLoad(NULL))
			{
				return false;
			}

			element = element->NextSiblingElement();
			count++;
		}

		return onAfterLoad(NULL);
	}

	virtual bool onAfterLoad(void* arg)
	{
		return true;
	}

	virtual bool readRow(ConfigRow* row, sint32 count, KeyT* val){ return false; }
	virtual bool readRow(const lua_tinker::s_object& row, sint32 count, KeyT* val){ return false;  };

	
	virtual bool checkConfig()
	{
		for(Iterator iter = this->begin(); iter != this->end(); ++iter)
		{
			KeyT* pConfig = iter->second;
			if(NULL != pConfig)
			{
				if(!pConfig->onCheck()){
					gxError("Config cant pass check!FileName={0},Key={1}", _configName, (sint32)pConfig->getKey());
					return false;
				}
			}
		}

		return true;
	}
};

template<typename T, typename KeyT>
class CConfigLoader2 :
	public GXMISC::CManualSingleton<T>,
	public GXMISC::CHashMultiIndex2<KeyT, true>,
	CConfigLoaderBase
{
public:
	typedef GXMISC::CHashMultiIndex2<KeyT, true> TBaseType;
	typedef typename TBaseType::Iterator Iterator;
	typedef KeyT* KeyType;

public:
	KeyT* get(uint32 index)
	{
		uint32 count = 0;
		for(typename TBaseType::Iterator iter = TBaseType::begin(); iter != TBaseType::end(); ++iter)
		{
			count++;
			if(count == index)
			{
				return iter->second;
			}
		}

		return NULL;
	}

	bool load(const std::string& name, CCconfigLoaderParam& param)
	{
		std::string fileName = DFileName(name);;
		return load(name, fileName, param);
	}

	bool load(const std::string& name, const std::string& fileName, CCconfigLoaderParam& param)
	{
		TiXmlDocument *XPRoot;
		XPRoot = new TiXmlDocument();
		_configName = name;
		if(param.remotePath)
		{
			const char* xmlBuff = NULL;
			TUrlDownFile downFile;
			if(!GetUrlFile(downFile, name.c_str(), param.loginName.c_str(), param.loginPwd.c_str()))
			{
				gxError("Can't load config file!{0}", fileName);
				return false;
			}

			std::string outData;
			if(param.encrypt)
			{
				AESDecrypt((byte*)(param.encryptKey.c_str()), (uint32)param.encryptKey.size(), (byte*)downFile.buff, downFile.curLen, outData);
				xmlBuff = outData.c_str();
			}
			else
			{
				xmlBuff = downFile.buff;
			}

			XPRoot->Parse(xmlBuff);

			if(XPRoot->Error())
			{
				gxError("Can't parse config file!{0}", fileName);
				return false;
			}
		}
		else
		{
			if(false == XPRoot->LoadFile(name.c_str()))
			{
				gxError("Can't open xml file! name = {0}", name);
				return false;
			}
		}

		TiXmlElement* element = XPRoot->RootElement()->FirstChildElement();
		uint32 count = 0;
		while(element != NULL)
		{   
			typename TBaseType::ValueProType* row = new typename TBaseType::ValueProType();
			if(NULL == row)
			{
				gxError("Can't new {0}! Line={0}", typeid(typename TBaseType::ValueProType).name(), count);
				return false;
			}

			if(false == readRow(element, count, row))
			{
				return false;
			}

			if(false == row->onAfterLoad(NULL))
			{
				return false;
			}

			element = element->NextSiblingElement();
			count++;
		}

		return onAfterLoad(NULL);
	}

	virtual bool onAfterLoad(void* arg)
	{
		return true;
	}

	virtual bool readRow(ConfigRow* row, sint32 count, KeyT* val) = 0;

	virtual bool checkConfig()
	{
		for(Iterator iter = this->begin(); iter != this->end(); ++iter)
		{
			KeyT* pConfig = iter->second;
			if(NULL != pConfig)
			{
				if(!pConfig->onCheck()){
					gxError("Config cant pass check!FileName={0},Key={1}", _configName, (sint32)pConfig->getKey());
					return false;
				}
			}
		}

		return true;
	}
};

template<typename T, typename KeyT>
class CConfigLoader3 :
	public GXMISC::CManualSingleton<T>,
	public GXMISC::CHashMultiIndex3<KeyT, true>,
	CConfigLoaderBase
{
public:
	typedef GXMISC::CHashMultiIndex3<KeyT, true> TBaseType;
	typedef typename TBaseType::Iterator Iterator;
	typedef KeyT* KeyType;

public:
	KeyT* get(uint32 index)
	{
		uint32 count = 0;
		for(typename TBaseType::Iterator iter = TBaseType::begin(); iter != TBaseType::end(); ++iter)
		{
			count++;
			if(count == index)
			{
				return iter->second;
			}
		}

		return NULL;
	}

	bool load(const std::string& name, CCconfigLoaderParam& param)
	{
		std::string fileName = DFileName(name);;
		return load(name, fileName, param);
	}

	bool load(const std::string& name, const std::string& fileName, CCconfigLoaderParam& param)
	{
		TiXmlDocument *XPRoot;
		XPRoot = new TiXmlDocument();
		_configName = name;
		if(param.remotePath)
		{
			const char* xmlBuff = NULL;
			TUrlDownFile downFile;
			if(!GetUrlFile(downFile, name.c_str(), param.loginName.c_str(), param.loginPwd.c_str()))
			{
				gxError("Can't load config file!{0}", fileName);
				return false;
			}

			std::string outData;
			if(param.encrypt)
			{
				AESDecrypt((byte*)(param.encryptKey.c_str()), (uint32)param.encryptKey.size(), (byte*)downFile.buff, downFile.curLen, outData);
				xmlBuff = outData.c_str();
			}
			else
			{
				xmlBuff = downFile.buff;
			}

			XPRoot->Parse(xmlBuff);

			if(XPRoot->Error())
			{
				gxError("Can't parse config file!{0}", fileName);
				return false;
			}
		}
		else
		{
			if(false == XPRoot->LoadFile(name.c_str()))
			{
				gxError("Can't open xml file! name = {0}", name);
				return false;
			}
		}

		TiXmlElement* element = XPRoot->RootElement()->FirstChildElement();
		uint32 count = 0;
		while(element != NULL)
		{   
			typename TBaseType::ValueProType* row = new typename TBaseType::ValueProType();
			if(NULL == row)
			{
				gxError("Can't new {0}! Line={0}", typeid(typename TBaseType::ValueProType).name(), count);
				return false;
			}

			if(false == readRow(element, count, row))
			{
				return false;
			}

			if(false == row->onAfterLoad(NULL))
			{
				return false;
			}

			element = element->NextSiblingElement();
			count++;
		}

		return onAfterLoad(NULL);
	}

	virtual bool onAfterLoad(void* arg)
	{
		return true;
	}

	virtual bool readRow(ConfigRow* row, sint32 count, KeyT* val) = 0;

	virtual bool checkConfig()
	{
		for(Iterator iter = this->begin(); iter != this->end(); ++iter)
		{
			KeyT* pConfig = iter->second;
			if(NULL != pConfig)
			{
				if(!pConfig->onCheck()){
					gxError("Config cant pass check!FileName={0},Key={1}", _configName, (sint32)pConfig->getKey());
					return false;
				}
			}
		}

		return true;
	}
};

template<typename T, typename KeyT>
class CConfigLoader4 :
	public GXMISC::CManualSingleton<T>,
	public GXMISC::CHashMultiIndex4<KeyT, true>,
	CConfigLoaderBase
{
public:
	typedef GXMISC::CHashMultiIndex4<KeyT, true> TBaseType;
	typedef typename TBaseType::Iterator Iterator;
	typedef KeyT* KeyType;

public:
	KeyT* get(uint32 index)
	{
		uint32 count = 0;
		for(typename TBaseType::Iterator iter = TBaseType::begin(); iter != TBaseType::end(); ++iter)
		{
			count++;
			if(count == index)
			{
				return iter->second;
			}
		}

		return NULL;
	}

	bool load(const std::string& name, CCconfigLoaderParam& param)
	{
		std::string fileName = DFileName(name);;
		return load(name, fileName, param);
	}

	bool load(const std::string& name, const std::string& fileName, CCconfigLoaderParam& param)
	{
		TiXmlDocument *XPRoot;
		XPRoot = new TiXmlDocument();
		_configName = name;
		if(param.remotePath)
		{
			const char* xmlBuff = NULL;
			TUrlDownFile downFile;
			if(!GetUrlFile(downFile, name.c_str(), param.loginName.c_str(), param.loginPwd.c_str()))
			{
				gxError("Can't load config file!{0}", fileName);
				return false;
			}

			std::string outData;
			if(param.encrypt)
			{
				AESDecrypt((byte*)(param.encryptKey.c_str()), (uint32)param.encryptKey.size(), (byte*)downFile.buff, downFile.curLen, outData);
				xmlBuff = outData.c_str();
			}
			else
			{
				xmlBuff = downFile.buff;
			}

			XPRoot->Parse(xmlBuff);

			if(XPRoot->Error())
			{
				gxError("Can't parse config file!{0}", fileName);
				return false;
			}
		}
		else
		{
			if(false == XPRoot->LoadFile(name.c_str()))
			{
				gxError("Can't open xml file! name = {0}", name);
				return false;
			}
		}

		TiXmlElement* element = XPRoot->RootElement()->FirstChildElement();
		uint32 count = 0;
		while(element != NULL)
		{   
			typename TBaseType::ValueProType* row = new typename TBaseType::ValueProType();
			if(NULL == row)
			{
				gxError("Can't new {0}! Line={0}", typeid(typename TBaseType::ValueProType).name(), count);
				return false;
			}

			if(false == readRow(element, count, row))
			{
				return false;
			}

			if(false == row->onAfterLoad(NULL))
			{
				return false;
			}

			element = element->NextSiblingElement();
			count++;
		}

		return onAfterLoad(NULL);
	}

	virtual bool onAfterLoad(void* arg)
	{
		return true;
	}

	virtual bool readRow(ConfigRow* row, sint32 count, KeyT* val) = 0;

	virtual bool checkConfig()
	{
		for(Iterator iter = this->begin(); iter != this->end(); ++iter)
		{
			KeyT* pConfig = iter->second;
			if(NULL != pConfig)
			{
				if(!pConfig->onCheck()){
					gxError("Config cant pass check!FileName={0},Key={1}", _configName, (sint32)pConfig->getKey());
					return false;
				}
			}
		}

		return true;
	}
};

#endif