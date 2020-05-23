#include <stdlib.h>
#include <stdio.h>
#include <iostream>
#include <sstream>

#include "inifile.h"
#include "memory_util.h"
#include "debug.h"

using namespace std;

namespace GXMISC{

	int INI_BUF_SIZE=2048;

	CIniFile::CIniFile()
	{
		flags_.push_back("#");
		flags_.push_back(";");
		_dataLen = 0;
		_data = NULL;
	}

	bool CIniFile::parse(const string &content,string &key,string &value,char c/*= '='*/)
	{
		int i = 0;
		size_t len = content.length();

		while(i < (int)len && content[i] != c){
			++i;
		}
		if(i >= 0 && i < (int)len){
			key = string(content.c_str(),i);
			value = string(content.c_str()+i+1,len-i-1);
			return true;
		}

		return false;
	}

	int CIniFile::getLine(string &str, FILE *fp)
	{
		size_t plen = 0;
		size_t buf_size = INI_BUF_SIZE*sizeof(char);

		char *buf =(char *) malloc(buf_size);
		char *pbuf = NULL;
		char * p = buf;

		if(buf == NULL){
			fprintf(stderr,"no enough memory!exit!\n");
			exit(-1);
		}

		memset(buf,0,buf_size);
		size_t total_size = buf_size;
		while(fgets(p,(int)buf_size,fp) != NULL){
			plen = strlen(p);

			if( plen > 0 && p[plen-1] != '\n' && !feof(fp)){

				total_size = strlen(buf)+buf_size;
				pbuf = (char *)realloc(buf,total_size);

				if(pbuf == NULL){
					free(buf);
					fprintf(stderr,"no enough memory!exit!\n");
					exit(-1);
				}

				buf = pbuf;

				p = buf + strlen(buf);

				continue;
			}else{
				break;
			}
		}

		str = buf;

		free(buf);
		buf = NULL;
		return (int)str.length();

	}

	int CIniFile::getLine(std::string&str, std::stringstream& stream)
	{
		str = "";
		if (stream.eof())
		{
			return 0;
		}

		getline(stream, str);
		return str.length();
	}

	bool CIniFile::open(const string &filename)
	{	
		release();
		fname_ = filename;
		FILE *fp = fopen(filename.c_str(),"r");
		if(fp == NULL ){
			return false;
		}

		bool ret = parseFileData(fp);

		fclose(fp);

		return ret;
	}

	bool CIniFile::open( const char* dataBuff, sint32 len )
	{
		DSafeDeleteArray(_data);

		_data = new char[len+10];
		memset(_data, 0, len+10);
		memcpy(_data, dataBuff, len);

		std::stringstream ss(_data);
		return parseFileData(ss);
	}

	int CIniFile::save()
	{
		return saveas(fname_);
	}

	int CIniFile::saveas(const string &filename)
	{
		string data = "";
		for(iterator sect = sections_.begin(); sect != sections_.end(); ++sect){
			if(sect->second->comment != ""){
				data += sect->second->comment;	
				data += delim;
			}
			if(sect->first != ""){
				data += string("[")+sect->first + string("]");	
				data += delim;
			}

			for(CIniSection::iterator item = sect->second->items.begin(); item != sect->second->items.end(); ++item){
				if(item->comment != ""){
					data += item->comment;	
					data += delim;
				}
				data += item->key+"="+item->value;
				data += delim;
			}
		}

		FILE *fp = fopen(filename.c_str(),"w");

		fwrite(data.c_str(),1,data.length(),fp);

		fclose(fp);

		return 0;
	}
	CIniSection *CIniFile::getSection(const string &section /*=""*/)
	{
		iterator it = sections_.find(section);
		if(it != sections_.end()){
			return it->second;
		}

		return NULL;
	}

	string CIniFile::readText(const string &section,const string &key)
	{
		string value,comment;

		int ret = getValue(section,key,value,comment);
		if(ret == RET_ERR)
		{
			// @TODO 抛出异常
			return "";
		}

		return value;
	}
	bool CIniFile::readTextIfExist( const string &section,const string &key, char* str, int size )
	{
		string value, comment;
		int ret = getValue(section,key,value,comment);

		if(ret != RET_ERR)
		{
			int minLen = min(size-1, (int)value.length());
			memcpy(str, value.c_str(), minLen);
			str[minLen] = '\0';
			return true;
		}

		return ret != RET_ERR;
	}
	bool CIniFile::readTextIfExist(const std::string &section,const std::string &key, std::string& str)
	{
		string comment;
		int ret = getValue(section,key,str,comment);
		return ret != RET_ERR;
	}
	int CIniFile::readInt(const string &section,const string &key)
	{
		string value,comment;

		int ret = getValue(section,key,value,comment);
		if(ret == RET_ERR)
		{
			// @TODO 抛出异常
			return -1;
		}

		return atoi(value.c_str());
	}

	bool CIniFile::readIntIfExist( const std::string &section,const std::string &key, int& nResult )
	{
		string value, comment;
		int ret = getValue(section,key,value,comment);
		
		if(ret != RET_ERR)
		{
			nResult = atoi(value.c_str());
		}
		
		return ret != RET_ERR;
	}

	double CIniFile::getDoubleValue(const string &section,const string &key,int &ret)
	{
		string value,comment;

		ret = getValue(section,key,value,comment);

		return atof(value.c_str());

	}

	int CIniFile::getValue(const string &section,const string &key,string &value)
	{
		string comment;
		return getValue(section,key,value,comment);
	}
	int CIniFile::getValue(const string &section,const string &key,string &value,string &comment)
	{
		CIniSection * sect = getSection(section);

		if(sect != NULL){
			for(CIniSection::iterator it = sect->begin(); it != sect->end(); ++it){
				if(it->key == key){
					value = it->value;
					comment = it->comment;
					return RET_OK;
				}
			}
		}

		return RET_ERR;
	}
	int CIniFile::getValues(const string &section,const string &key,vector<string> &values)
	{
		vector<string> comments;
		return getValues(section,key,values,comments);
	}
	int CIniFile::getValues(const string &section,const string &key,
		vector<string> &values,vector<string> &comments)
	{
		string value,comment;

		values.clear();
		comments.clear();

		CIniSection * sect = getSection(section);

		if(sect != NULL){
			for(CIniSection::iterator it = sect->begin(); it != sect->end(); ++it){
				if(it->key == key){
					value = it->value;
					comment = it->comment;

					values.push_back(value);
					comments.push_back(comment);
				}
			}
		}

		return (values.size() ? RET_OK : RET_ERR);

	}
	bool CIniFile::hasSection(const string &section) 
	{
		return (getSection(section) != NULL);

	}

	bool CIniFile::hasKey(const string &section,const string &key)
	{
		CIniSection * sect = getSection(section);

		if(sect != NULL){
			for(CIniSection::iterator it = sect->begin(); it != sect->end(); ++it){
				if(it->key == key){
					return true;
				}
			}
		}

		return false;
	}
	int CIniFile::getSectionComment(const string &section,string & comment)
	{
		comment = "";
		CIniSection * sect = getSection(section);

		if(sect != NULL){
			comment = sect->comment;
			return RET_OK;
		}

		return RET_ERR;
	}
	int CIniFile::setSectionComment(const string &section,const string & comment)
	{
		CIniSection * sect = getSection(section);

		if(sect != NULL){
			sect->comment = comment;
			return RET_OK;
		}

		return RET_ERR;
	}

	int CIniFile::setValue(const string &section,const string &key,
		const string &value,const string &comment /*=""*/)
	{
		CIniSection * sect = getSection(section);

		string comt = comment;
		if (comt != ""){
			comt = flags_[0] +comt;
		} 
		if(sect == NULL){
			sect = new CIniSection();
			if(sect == NULL){
				fprintf(stderr,"no enough memory!\n");
				exit(-1);
			}
			sect->name = section;
			sections_[section] = sect;
		}

		for(CIniSection::iterator it = sect->begin(); it != sect->end(); ++it){
			if(it->key == key){
				it->value = value;
				it->comment = comt;
				return RET_OK;
			}
		}

		//not found key
		IniItem item;
		item.key = key;
		item.value = value;
		item.comment = comt;

		sect->items.push_back(item);

		return RET_OK;

	}
	void CIniFile::getCommentFlags(vector<string> &flags)
	{
		flags = flags_;
	}
	void CIniFile::setCommentFlags(const vector<string> &flags)
	{
		flags_ = flags;
	}
	void CIniFile::deleteSection(const string &section)
	{
		CIniSection *sect = getSection(section);

		if(sect != NULL){

			sections_.erase(section);	
			delete sect;
		}
	}
	void CIniFile::deleteKey(const string &section,const string &key)
	{
		CIniSection * sect = getSection(section);

		if(sect != NULL){
			for(CIniSection::iterator it = sect->begin(); it != sect->end(); ++it){
				if(it->key == key){
					sect->items.erase(it);
					break;
				}
			}
		}

	}

	void CIniFile::release()
	{
		fname_ = "";

		for(iterator i = sections_.begin(); i != sections_.end(); ++i){
			delete i->second;
		}

		sections_.clear();

	}

	bool CIniFile::isComment(const string &str)
	{
		bool ret =false;
		for(int i = 0; i < (int)flags_.size(); ++i){
			int k = 0;
			if(str.length() < flags_[i].length()){
				continue;
			}
			for(k = 0;k < (int)flags_[i].length(); ++k){
				if(str[k] != flags_[i][k]){
					break;
				}
			}

			if (k == (int)flags_[i].length()){
				ret = true;
				break;
			}
		}

		return ret;
	}
	//for debug
	void CIniFile::dump()
	{
		printf("filename:[%s]\n",fname_.c_str());

		printf("flags_:[");
		for(int i = 0; i < (int)flags_.size(); ++i){
			printf(" %s ",flags_[i].c_str());
		}
		printf("]\n");

		for(iterator it = sections_.begin(); it != sections_.end(); ++it){
			printf("section:[%s]\n",it->first.c_str());
			printf("comment:[%s]\n",it->second->comment.c_str());
			for(CIniSection::iterator i = it->second->items.begin(); i != it->second->items.end(); ++i){
				printf("    comment:%s\n",i->comment.c_str());
				printf("    parm   :%s=%s\n",i->key.c_str(),i->value.c_str());
			}
		}
	}
}
