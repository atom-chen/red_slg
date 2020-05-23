#ifndef _INI_H_
#define _INI_H_

#include "types_def.h"

namespace GXMISC
{
#define ERROR_DATA      -99999999
#define MAX_INI_VALUE   1024

    //配置文件类
    class CIni
    {
    public:
        CIni();
        CIni(const char* filename);												// 初始化打开配置文件
		CIni(char* dataBuff, sint32 len);										// 初始化数据
        virtual ~CIni();														// 释放内存

	public:
        char				*getData();											// 返回文件内容
        sint32				getLines(sint32);									// 返回文件的行数
        sint32				getLines();											// 返回文件的行数
        bool				open(const char* filename);							// 打开配置文件
		bool				open(const char* dataBuff, sint32 len);				// 打开ini
        void				close();											// 关闭配置文件
        bool				save(char *filename=NULL);							// 保存配置文件
        sint32				findIndex(const char *);							// 返回标题位置

		/// 读取内容
    public:
        //读一个整数
        sint32				readInt(const char *section, const char *key);
        //如果存在，则读一个整数
        bool				readIntIfExist(const char *section, const char *key, sint32& nResult);
        template<typename T>
        bool                readTypeIfExist(const char* section, const char*key, T& result);
        //在指定的行读一整数
        sint32				readInt(const char *section, sint32 lines);	
        //读一个字符串
        char*				readText(const char *section, const char *key, char* str, sint32 size);
        //如果存在则读取
        bool				readTextIfExist(const char *section, const char *key, char* str, sint32 size);
        bool                readTextIfExist(const char *section, const char *key, std::string& str);
        //在指定的行读一字符串
        char*				readText(const char *section, sint32 lines, char* str, sint32 size);	
        //在指定行读一字符名称
        char*				readCaption(const char *section, sint32 lines, char* str, sint32 size);

	public:
        //写一个整数
        bool				write(const char *section, const char *key, sint32 num);			
        //写一个字符串
        bool				write(const char *section, const char *key, char *string);		
        //返回连续的行数（从INDEX到第一个空行）
        sint32				getContinueDataNum(const char *section);	
        //在指定位置读字符串
        char*				readOneLine(sint32);
        sint32				findOneLine(sint32);
        //返回指定字符所在的行数
        sint32				returnLineNum(const char*);

	private:
		void				initIndex();										// 初始化索引
		sint32				findData(sint32, const char *);						// 返回数据位置
		sint32				gotoNextLine(sint32); 								// 提行
		char*				readDataName(sint32 &);								// 在指定位置读一数据名称
		char*				readText(sint32);									// 在指定位置读字符串

		bool				addIndex(const char *);							    // 加入一个索引
		bool				addData(sint32, const char *, const char *);        // 在当前位置加入一个数据
		bool				modityData(sint32, const char *, const char *);		// 在当前位置修改一个数据的值
		sint32				gotoLastLine(const char *section);				    // 把指针移动到本INDEX的最后一行

	private:
		char			_fileName[MAX_PATH];		//文件名
		sint32			_dataLen;					//文件长度
		char*			_data;						//文件内容

		sint32			_indexNum;					//索引数目([]的数目)
		sint32*			_indexList;					//索引点位置列表
		sint32			_point;						//当前指针
		sint32			_line, _word;				//当前行列

		// 临时值
		char			_value[MAX_INI_VALUE] ;		//	值
		char			_ret[MAX_INI_VALUE];		//	返回值
    };

	template<typename T>
	bool GXMISC::CIni::readTypeIfExist( const char* section, const char*key, T& result )
	{
		sint32 n=findIndex(section);

		if( n == -1 )
		{
			return false;
		}

		sint32 m = findData(n, key);

		if( m == -1 )
		{
			return false;
		}

		char *str = readText(m);
		gxFromString(str, result);

		return true;
	}
}

#endif