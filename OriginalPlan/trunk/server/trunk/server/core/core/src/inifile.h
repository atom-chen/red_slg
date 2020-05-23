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
		/* �򿪲�����һ����Ϊfname��INI�ļ� */
		bool open(const std::string &fname);
		bool open(const char* dataBuff, sint32 len);				// ��ini
		/*�����ݱ��浽��ǰ�ļ�*/
		int save();
		/*��������浽һ����Ϊfname���ļ�*/
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
						fprintf(stderr, "û���ҵ�ƥ���]\n");
						return false;
					}
					size_t len = index - 1;
					if (len <= 0){
						fprintf(stderr, "��Ϊ��\n");
						continue;
					}
					string s(line, 1, len);

					if (getSection(s.c_str()) != NULL){
						//fclose(fp);
						fprintf(stderr, "�˶��Ѵ���:%s\n", s.c_str());
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
						fprintf(stderr, "��������ʧ��[%s]\n", line.c_str());
						return false;
					}
					comment = "";
				}
			}

			return true;
		}

	public:
		/*��ȡsection�ε�һ����Ϊkey��ֵ,��������string�͵�ֵ*/
		std::string readText(const std::string &section,const std::string &key);
		bool readTextIfExist(const std::string &section,const std::string &key, char* str, int size);
		bool readTextIfExist(const std::string &section,const std::string &key, std::string& str);
		/*��ȡsection�ε�һ����Ϊkey��ֵ,��������int�͵�ֵ*/
		int readInt(const std::string &section,const std::string &key);
		/*������ڣ����һ������*/
		bool readIntIfExist(const std::string &section,const std::string &key, int& nResult);
		/*������ڣ����ȡָ������*/
		template<typename T>
		bool readTypeIfExist(const std::string &section,const std::string &key, T& result);

	public:
		/*��ȡsection�ε�һ����Ϊkey��ֵ,��������double�͵�ֵ*/
		double getDoubleValue(const std::string &section,const std::string &key,int &ret);
		/*��ȡsection�ε�һ����Ϊkey��ֵ,����ֵ����value��*/
		int getValue(const std::string &section,const std::string &key, std::string &value);
		/*��ȡsection�ε�һ����Ϊkey��ֵ,����ֵ����value��,��ע�͸���comment��*/
		int getValue(const std::string &section,const std::string &key, std::string &value, std::string &comment);
		/*��ȡsection�����м�Ϊkey��ֵ,����ֵ����values��vector��*/
		int getValues(const std::string &section, const std::string &key, std::vector<std::string> &values);
		/*��ȡsection�����м�Ϊkey��ֵ,����ֵ����values��vector��,,��ע�͸���comments��vector��*/
		int getValues(const std::string &section, const std::string &key, std::vector<std::string> &value, std::vector<std::string> &comments);

	public:
		/*�ж��Ƿ��������*/
		bool hasSection(const std::string &section) ;
		/*�ж��Ƿ������Key*/
		bool hasKey(const std::string &section, const std::string &key) ;

	public:
		/* ��ȡsection�ε�ע�� */
		int getSectionComment(const std::string &section, std::string & comment);
		/* ����section�ε�ע�� */
		int setSectionComment(const std::string &section,const std::string & comment);
		/*��ȡע�ͱ�Ƿ��б�*/
		void getCommentFlags(std::vector<std::string> &flags);
		/*����ע�ͱ�Ƿ��б�*/
		void setCommentFlags(const std::vector<std::string> &flags);

		/*ͬʱ����ֵ��ע��*/
		int setValue(const std::string &section,const std::string &key,const std::string &value,const std::string &comment="");
	public:
		/*ɾ����*/
		void deleteSection(const std::string &section);
		/*ɾ���ض��ε��ض�����*/
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
		std::map<std::string,CIniSection *> sections_;	// ���ý�
		std::string fname_;								// �ļ���
		std::vector<std::string> flags_;				// ע�ͷָ��
		sint32			_dataLen;						// �ļ�����
		char*			_data;							// �ļ�����
	};

	template<typename T>
	bool GXMISC::CIniFile::readTypeIfExist( const std::string &section, const std::string &key, T& result )
	{
		string value,comment;

		int ret = getValue(section,key,value,comment);
		if(ret == RET_ERR)
		{
			// @TODO �׳��쳣
			return false;
		}

		gxFromString(value, result);

		return true;
	}
}

#endif // _INIFILE_H_