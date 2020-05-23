#ifndef _INIFILE_H_
#define _INIFILE_H_

#include <map>
#include <vector>
#include <string>
#include <string.h>

#include "string_common.h"

namespace GXMISC
{
	const int RET_OK  = 0;
	const int RET_ERR = -1;
	const std::string delim = "\n";
	struct IniItem
	{
		std::string key;
		std::string value;
		std::string comment;
	};
	struct CIniSection
	{
		typedef std::vector<IniItem>::iterator iterator;
		iterator begin() {return items.begin();}
		iterator end() {return items.end();}

		std::string name;
		std::string comment;
		std::vector<IniItem> items;
	};

	class CIniFile
	{
	public:	
		CIniFile();
		~CIniFile(){release();}

	public:
		typedef std::map<std::string,CIniSection *>::iterator iterator;
		iterator begin() {return sections_.begin();}
		iterator end() {return sections_.end();}

	public:
		/* 打开并解析一个名为fname的INI文件 */
		bool open(const std::string &fname);
		bool open(const char* dataBuff, sint32 len);				// 打开ini
		/*将内容保存到当前文件*/
		int save();
		/*将内容另存到一个名为fname的文件*/
		int saveas(const std::string &fname);

	protected:
		template<typename T>
		bool parseFileData(T& stream)
		{
			CIniSection *section = NULL;
			string line;
			string comment;

			while (getLine(line, stream) > 0){

				gxTrimright(line, '\n');
				gxTrimright(line, '\r');
				gxTrim(line);

				if (line.length() <= 0){
					continue;
				}

				if (line[0] == '['){
					section = NULL;
					size_t index = line.find_first_of(']');

					if (index == -1){
						//fclose(fp);
						fprintf(stderr, "没有找到匹配的]\n");
						return false;
					}
					size_t len = index - 1;
					if (len <= 0){
						fprintf(stderr, "段为空\n");
						continue;
					}
					string s(line, 1, len);

					if (getSection(s.c_str()) != NULL){
						//fclose(fp);
						fprintf(stderr, "此段已存在:%s\n", s.c_str());
						return false;
					}

					section = new CIniSection();
					sections_[s] = section;

					section->name = s;
					section->comment = comment;
					comment = "";
				}
				else if (isComment(line)){
					if (comment != ""){
						comment += delim + line;
					}
					else{
						comment = line;
					}
				}
				else{
					string key, value;
					size_t pos = line.find_first_of(";");
					if (pos != string::npos)
					{
						comment = line.substr(pos + 1, line.size() - pos);
						line = line.substr(0, pos);
						line = gxTrim(line);
					}
					if (parse(line, key, value)){
						IniItem item;
						item.key = key;
						item.value = value;
						item.comment = comment;

						section->items.push_back(item);
					}
					else{
						fprintf(stderr, "解析参数失败[%s]\n", line.c_str());
						return false;
					}
					comment = "";
				}
			}

			return true;
		}

	public:
		/*获取section段第一个键为key的值,并返回其string型的值*/
		std::string readText(const std::string &section,const std::string &key);
		bool readTextIfExist(const std::string &section,const std::string &key, char* str, int size);
		bool readTextIfExist(const std::string &section,const std::string &key, std::string& str);
		/*获取section段第一个键为key的值,并返回其int型的值*/
		int readInt(const std::string &section,const std::string &key);
		/*如果存在，则读一个整数*/
		bool readIntIfExist(const std::string &section,const std::string &key, int& nResult);
		/*如果存在，则读取指定类型*/
		template<typename T>
		bool readTypeIfExist(const std::string &section,const std::string &key, T& result);

	public:
		/*获取section段第一个键为key的值,并返回其double型的值*/
		double getDoubleValue(const std::string &section,const std::string &key,int &ret);
		/*获取section段第一个键为key的值,并将值赋到value中*/
		int getValue(const std::string &section,const std::string &key, std::string &value);
		/*获取section段第一个键为key的值,并将值赋到value中,将注释赋到comment中*/
		int getValue(const std::string &section,const std::string &key, std::string &value, std::string &comment);
		/*获取section段所有键为key的值,并将值赋到values的vector中*/
		int getValues(const std::string &section, const std::string &key, std::vector<std::string> &values);
		/*获取section段所有键为key的值,并将值赋到values的vector中,,将注释赋到comments的vector中*/
		int getValues(const std::string &section, const std::string &key, std::vector<std::string> &value, std::vector<std::string> &comments);

	public:
		/*判断是否有这个节*/
		bool hasSection(const std::string &section) ;
		/*判断是否有这个Key*/
		bool hasKey(const std::string &section, const std::string &key) ;

	public:
		/* 获取section段的注释 */
		int getSectionComment(const std::string &section, std::string & comment);
		/* 设置section段的注释 */
		int setSectionComment(const std::string &section,const std::string & comment);
		/*获取注释标记符列表*/
		void getCommentFlags(std::vector<std::string> &flags);
		/*设置注释标记符列表*/
		void setCommentFlags(const std::vector<std::string> &flags);

		/*同时设置值和注释*/
		int setValue(const std::string &section,const std::string &key,const std::string &value,const std::string &comment="");
	public:
		/*删除段*/
		void deleteSection(const std::string &section);
		/*删除特定段的特定参数*/
		void deleteKey(const std::string &section, const std::string &key);

	private:
		CIniSection *getSection(const std::string &section="");
		void release();
		int getLine(std::string &str,FILE *fp);
		int getLine(std::string&str, std::stringstream& stream);
		bool isComment(const std::string &str);
		bool parse(const std::string &content,std::string &key,std::string &value,char c= '=');
		void dump();

	private:
		std::map<std::string,CIniSection *> sections_;	// 配置节
		std::string fname_;								// 文件名
		std::vector<std::string> flags_;				// 注释分割符
		sint32			_dataLen;						// 文件长度
		char*			_data;							// 文件内容
	};

	template<typename T>
	bool GXMISC::CIniFile::readTypeIfExist( const std::string &section, const std::string &key, T& result )
	{
		string value,comment;

		int ret = getValue(section,key,value,comment);
		if(ret == RET_ERR)
		{
			// @TODO 抛出异常
			return false;
		}

		gxFromString(value, result);

		return true;
	}
}

#endif // _INIFILE_H_