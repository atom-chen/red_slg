#include <stdio.h>
#include <stdlib.h>
#include <malloc.h>

#include "ini.h"
#include "stdcore.h"
#include "debug.h"
#include "base_util.h"
#include "common.h"

namespace GXMISC
{
    //初始化
    CIni::CIni()
    {
        _dataLen = 0;
        _data = NULL;
        _indexNum = 0;
        _indexList = NULL;
		_point = 0;
		_line = 0;
		_word = 0;
		memset(_value, 0, sizeof(_value));
		memset(_ret, 0, sizeof(_ret));
		memset( _fileName, 0, MAX_PATH ) ;
    }

    //初始化
    CIni::CIni( const char *filename )
    {
		_dataLen = 0;
		_data = NULL;
		_indexNum = 0;
		_indexList = NULL;
		_point = 0;
		_line = 0;
		_word = 0;
		memset(_value, 0, sizeof(_value));
		memset(_ret, 0, sizeof(_ret));
		memset( _fileName, 0, MAX_PATH ) ;

        open(filename);	
    }

	CIni::CIni( char* dataBuff, sint32 len )
	{
		_dataLen = 0;
		_data = NULL;
		_indexNum = 0;
		_indexList = NULL;
		_point = 0;
		_line = 0;
		_word = 0;
		memset(_value, 0, sizeof(_value));
		memset(_ret, 0, sizeof(_ret));
		memset( _fileName, 0, MAX_PATH ) ;

		_data = new char[len+1];
		memset(_data, 0, len+1);
		memcpy(_data, dataBuff, len);
		_dataLen = len;
		//初始化索引
		initIndex();
	}

    //析构释放
    CIni::~CIni()
    {
        if( _dataLen != 0 )
        {
            DSafeDeleteArray( _data );
            _dataLen = 0;
        }

        if( _indexNum != 0 )
        {
            DSafeDeleteArray( _indexList );
            _indexNum = 0;
        }
    }

    //读入文件
    bool CIni::open( const char *filename )
    {
		gxStrcpy(_fileName, (sint32)MAX_PATH-1, filename, (sint32)strlen(filename));

		DSafeDeleteArray( _data );

        //获取文件长度
        FILE* fp;
        fp = fopen(filename,"rb");
        if(fp == 0)
        {
            _dataLen = -1;
        }
        else
        {
            fseek( fp, 0L, SEEK_END );
            _dataLen	= ftell( fp );
            fclose(fp);
        }


        //文件存在
        if( _dataLen > 0 )
        {
            _data = new char[_dataLen+10];
            memset( _data, 0, _dataLen+10) ;

            FILE *fp;
            fp=fopen(filename, "rb");
			gxAssertEx( fp!=NULL, "FileName={0}", filename );
            fread(_data, _dataLen, 1, fp);		//读数据
            fclose(fp);

            //初始化索引
            initIndex();
            return true;
        }
        else	// 文件不存在
        {
            // 找不到文件
            _dataLen=1;
            _data = new char[_dataLen+10];
            memset(_data, 0, _dataLen+10);
            initIndex();
        }

        return false;
    }

	bool CIni::open( const char* dataBuff, sint32 len )
	{
		_data = new char[len+10];
		memset(_data, 0, len+10);
		memcpy(_data, dataBuff, len);
		_dataLen = len;
		//初始化索引
		initIndex();
		return true;
	}

    //关闭文件
    void CIni::close()
    {
        if( _dataLen != 0 )
        {
            DSafeDeleteArray( _data );
            _dataLen = 0;
        }

        if( _indexNum != 0 )
        {
            DSafeDeleteArray( _indexList );
            _indexNum = 0;
        }
    }

    //写入文件
    bool CIni::save(char *filename)
    {
        if( filename==NULL )
        {
            filename=_fileName;
        }

        FILE *fp;
        fp=fopen(filename, "wb");
        gxAssertEx( fp!=NULL, filename );

        fwrite(_data, _dataLen, 1, fp);
        fclose(fp);

        return true;
    }

    //返回文件内容
    char *CIni::getData()
    {
        return _data;	
    }

    //获得文件的行数
    sint32 CIni::getLines(sint32 cur)
    {
        sint32 n=1;
        for(sint32 i=0; i<cur; i++)
        {
            if( _data[i]=='\n' )
                n++;
        }
        return n;
    }

    //获得文件的行数
    sint32 CIni::getLines()
    {
        sint32		n = 0;
        sint32		i;
        for(i=0; i<_dataLen; i++)
        {
            if( _data[i]=='\n' )
                n++;
        }

        if(i>=_dataLen)
        {
            return n+1;
        }

        return n;
    }

    ////////////////////////////////////////////////
    // 内部函数
    ////////////////////////////////////////////////

    //计算出所有的索引位置
    void CIni::initIndex()
    {
        _indexNum=0;

        for(sint32 i=0; i<_dataLen; i++)
        {
            //找到
            if( _data[i]=='[' && ( i==0 || _data[i-1]=='\n') )
            {
                _indexNum++;
            }
        }

        //申请内存
        DSafeDeleteArray( _indexList );
        if( _indexNum>0 )
            _indexList=new sint32[_indexNum];

        sint32 n=0;

        for(sint32 i=0; i<_dataLen; i++)
        {
            if( _data[i]=='[' && ( i==0 || _data[i-1]=='\n') )
            {
                _indexList[n]=i+1;
                n++;
            }
        }
    }

    //返回指定标题位置
    sint32 CIni::findIndex(const char *string)
    {
        for(sint32 i=0; i<_indexNum; i++)
        {
            char *str=readText( _indexList[i] );
            if( strcmp(string, str) == 0 )
            {
                return _indexList[i];
            }
        }
        return -1;
    }

    //返回指定数据的位置
    sint32 CIni::findData(sint32 index, const char *string)
    {
        sint32 p=index;	//指针

        while(1)
        {
            p=gotoNextLine(p);
            char *name=readDataName(p);
            if( strcmp(string, name)==0 )
            {
                DSafeDeleteArray( name );
                return p;
            }

            if ( name[0] == '[' )
            {
                DSafeDeleteArray( name );
                return -1;
            }

            DSafeDeleteArray( name );
            if( p>=_dataLen ) return -1;
        }
        return -1;
    }

    //提行
    sint32 CIni::gotoNextLine(sint32 p)
    {
        sint32 i;
        for(i=p; i<_dataLen; i++)
        {
            if( _data[i]=='\n' )
                return i+1;
        }
        return i;
    }

    //在指定位置读一数据名称
    char *CIni::readDataName(sint32 &p)
    {
        char chr;
        char *Ret;
        sint32 m=0;

        Ret=new char[64];
        memset(Ret, 0, 64);

        for(sint32 i=p; i<_dataLen; i++)
        {
            chr = _data[i];

            //结束
            if( chr == '\r' )
            {
                p=i+1;
                return Ret;
            }

            //结束
            if( chr == '=' || chr == ';' )
            {
                p=i+1;
                return Ret;
            }

            Ret[m]=chr;
            m++;
        }
        return Ret;
    }

    //在指定位置读一字符串
    char *CIni::readText(sint32 p)
    {
        char chr;
        char *Ret;
        sint32 n=p, m=0;

        //sint32 LineNum = gotoNextLine(p) - p + 1;
        Ret=(char*)_value;
        memset(Ret, 0, MAX_INI_VALUE);

        for(sint32 i=0; i<_dataLen-p; i++)
        {
            chr = _data[n];

            //结束
            if( chr == ';' || chr == '\r' || chr == '\t' || chr == ']' )
            {
                return Ret;
            }

            Ret[m]=chr;
            m++;
            n++;
        }

        return Ret;
    }

    //加入一个索引
    bool CIni::addIndex(const char *index)
    {
        char str[256];
        memset(str, 0, 256);
        sint32 n=findIndex(index);

        if( n == -1 )	//新建索引
        {
            sprintf(str,"\r\n[%s]",index);
            _data = gxReallocAry(_data, _dataLen, _dataLen+(sint32)strlen(str));	//重新分配内存
            sprintf(&_data[_dataLen], "%s", str);
            _dataLen+=(uint32)(strlen(str));

            initIndex();
            return true;
        }

        return false;	//已经存在
    }

    //在当前位置加入一个数据
    bool CIni::addData(sint32 p, const char *name, const char *string)
    {
        char *str;
        sint32 len=(sint32)(strlen(string));
        str=new char[len+256];
        memset(str, 0, len+256);
        sprintf(str,"%s=%s",name,string);
        len=(sint32)(strlen(str));

        p=gotoNextLine(p);	//提行
        _data = gxReallocAry(_data, _dataLen, _dataLen+len);	//重新分配内存

        char *temp=new char[_dataLen-p];
        memcpy(temp, &_data[p], _dataLen-p);
        memcpy(&_data[p+len], temp, _dataLen-p);	//把后面的搬到末尾
        memcpy(&_data[p], str, len);
        _dataLen+=len;

        DSafeDeleteArray( temp );
        DSafeDeleteArray( str );
        return true;
    }

    //在当前位置修改一个数据的值
    bool CIni::modityData(sint32 p, const char *name, const char *string)
    {
        sint32 n=findData(p, name);

        char *t=readText(n);
        p=n+(sint32)(strlen(t));

        sint32 newlen=(sint32)(strlen(string));
        sint32 oldlen=p-n;

        _data = gxReallocAry(_data, _dataLen, _dataLen+newlen-oldlen);	//重新分配内存

        char *temp=new char[_dataLen-p];
        memcpy(temp, &_data[p], _dataLen-p);
        memcpy(&_data[n+newlen], temp, _dataLen-p);			    //把后面的搬到末尾
        memcpy(&_data[n], string, newlen);
        _dataLen+=newlen-oldlen;

        DSafeDeleteArray( temp );
        return true;
    }

    //把指针移动到本INDEX的最后一行
    sint32 CIni::gotoLastLine(const char *index)
    {
        sint32 n=findIndex(index);
        n=gotoNextLine(n);
        while(1)
        {
            if( _data[n] == '\r' || _data[n] == EOF || _data[n] == -3 || _data[n] == ' ' || _data[n] == '/' || _data[n] == '\t' || _data[n] == '\n' )
            {
                return n;
            }
            else
            {
                n=gotoNextLine(n);
                if( n >= _dataLen ) return n;
            }
        }

        return 0 ;
    }

    /////////////////////////////////////////////////////////////////////
    // 对外接口
    /////////////////////////////////////////////////////////////////////

    //以普通方式读一字符串数据
    char *CIni::readText(const char *index, const char *name, char* str, sint32 size)
    {
        char szTmp[512] ;
        memset( szTmp, 0, 512 ) ;
        sprintf( szTmp, "[%s][%s][%s]", _fileName, index, name ) ;

        sint32 n=findIndex(index);
        gxAssertEx( n != -1, szTmp );

        if ( n == -1 )
            return NULL;

        sint32 m=findData(n, name);
        gxAssertEx( m != -1, szTmp );
        if ( m == -1 )
            return NULL;

        char* ret = readText(m);
        strncpy( str, ret, size ) ;
        return ret ;
    }

    //如果存在则读取
    bool CIni::readTextIfExist(const char *index, const char *name, char* str, sint32 size)
    {
        sint32 n = findIndex(index);

        if( n == -1 )
        {
            return false;
        }

        sint32 m = findData(n, name);

        if( m == -1 )
        {
            return false;
        }

        char* ret = readText(m);
        strncpy( str, ret, size );
        return true;
    }

    bool CIni::readTextIfExist( const char *section, const char* key, std::string& str )
    {
        sint32 n = findIndex(section);

        if( n == -1 )
        {
            return false;
        }

        sint32 m = findData(n, key);

        if( m == -1 )
        {
            return false;
        }

        char* ret = readText(m);
        str = ret;
        return true;
    }

    //在指定的行读一字符串
    char *CIni::readText(const char *index, sint32 lines, char* str, sint32 size)
    {
        char szTmp[512] ;
        memset( szTmp, 0, 512 ) ;
        sprintf( szTmp, "[%s][%s][%d]", _fileName, index, lines ) ;


        sint32 n=findIndex(index);
        gxAssertEx( n != -1, szTmp );

        //跳到指定行数
        n=gotoNextLine(n);
        for(sint32 i=0; i<lines; i++)
        {
            if( n<_dataLen )
                n=gotoNextLine(n);
        }

        //读数据
        while( n<=_dataLen )
        {
            if( _data[n] == '=' )
            {
                n++;
                char* ret = readText(n);
                strncpy( str, ret, size ) ;
                return ret ;
            }
            if( _data[n] == '\r' )
            {
                return NULL;
            }
            n++;
        }

        return NULL;
    }

    //以普通方式读一整数
    sint32 CIni::readInt(const char *index, const char *name)
    {
        char szTmp[512] ;
        memset( szTmp, 0, 512 ) ;
        sprintf( szTmp, "[%s][%s][%s]", _fileName, index, name ) ;

        sint32 n=findIndex(index);
        gxAssertEx( n != -1, szTmp );

        sint32 m=findData(n, name);
        gxAssertEx( m != -1, szTmp );

        char *str=readText(m);
        sint32 ret=atoi(str);
        return ret;
    }

    bool CIni::readIntIfExist(const char *section, const char *key, sint32& nResult)
    {
        sint32 n=findIndex(section);

        if( n == -1 )
            return false;

        sint32 m=findData(n, key);

        if( m == -1 )
            return false;

        char *str=readText(m);
        nResult=atoi(str);
        return true;
    }

    //在指定的行读一整数
    sint32 CIni::readInt(const char *index, sint32 lines)
    {
        char szTmp[512] ;
        memset( szTmp, 0, 512 ) ;
        sprintf( szTmp, "[%s][%s][%d]", _fileName, index, lines ) ;

        sint32 n=findIndex(index);
        gxAssertEx( n != -1, szTmp );

        //跳到指定行数
        n=gotoNextLine(n);
        for(sint32 i=0; i<lines; i++)
        {
            if( n<_dataLen )
                n=gotoNextLine(n);
        }

        //读数据
        while( n<_dataLen )
        {
            if( _data[n] == '=' )
            {
                n++;
                char *str=readText(n);
                sint32 ret=atoi(str);
                return ret;
            }
            if( _data[n] == '\r' )
            {
                return ERROR_DATA;
            }
            n++;
        }

        return ERROR_DATA;
    }

    //在指定的行读一数据名称
    char *CIni::readCaption(const char *index, sint32 lines, char* str, sint32 size)
    {


        char szTmp[512] ;
        memset( szTmp, 0, 512 ) ;
        sprintf( szTmp, "[%s][%s][%d]", _fileName, index, lines ) ;

        sint32 n=findIndex(index);
        gxAssertEx( n != -1, szTmp );

        //跳到指定行数
        n=gotoNextLine(n);
        for(sint32 i=0; i<lines; i++)
        {
            if( n<_dataLen )
                n=gotoNextLine(n);
        }

        char* ret = readDataName(n);
        strncpy( str, ret, size ) ;
        return ret ;
    }

    //以普通方式写一字符串数据
    bool CIni::write(const char *index, const char *name, char *string)
    {
        sint32 n=findIndex(index);
        if( n == -1 )	//新建索引
        {
            addIndex(index);
            n=findIndex(index);
            n=gotoLastLine(index);
            addData(n, name, string);	//在当前位置n加一个数据
            return true;
        }

        //存在索引
        sint32 m=findData(n, name);
        if( m==-1 )		//新建数据
        {
            n=gotoLastLine(index);
            addData(n, name, string);	//在当前位置n加一个数据
            return true;
        }

        //存在数据
        modityData(n, name, string);	//修改一个数据

        return true;
    }

    //以普通方式写一整数
    bool CIni::write(const char *index, const char *name, sint32 num)
    {
        char string[32];
        sprintf(string, "%d", num);

        sint32 n=findIndex(index);
        if( n == -1 )	//新建索引
        {
            addIndex(index);
            n=findIndex(index);
            n=gotoLastLine(index);
            addData(n, name, string);	//在当前位置n加一个数据
            return true;
        }

        //存在索引
        sint32 m=findData(n, name);
        if( m==-1 )		//新建数据
        {
            n=gotoLastLine(index);
            addData(n, name, string);	//在当前位置n加一个数据
            return true;
        }

        //存在数据
        modityData(n, name, string);	//修改一个数据

        return true;
    }

    //返回连续的行数
    sint32 CIni::getContinueDataNum(const char *index)
    {
        sint32 num=0;
        sint32 n=findIndex(index);
        n=gotoNextLine(n);
        while(1)
        {
            if( _data[n] == '\r' || _data[n] == EOF || _data[n] == -3 || _data[n] == ' ' || _data[n] == '/' || _data[n] == '\t' || _data[n] == '\n' )
            {
                return num;
            }
            else
            {
                num++;
                n=gotoNextLine(n);
                if( n >= _dataLen ) return num;
            }
        }

        return 0 ;
    }
    //在指定行读一字符串
    char* CIni::readOneLine(sint32 p)
    {
        sint32 start = findOneLine(p);
        memset(_ret,0,sizeof(_ret));


        for(sint32 i=start; i<_dataLen; i++)
        {
            if( _data[i]=='\n' || _data[i]=='\0')
            {
                memset(_ret,0,sizeof(_ret));
                strncpy(_ret,&_data[start],i-start);
                _ret[i-start] = '\0';
                return _ret;
            }

        }

        return _ret;
    }

    sint32 CIni::findOneLine(sint32 p)
    {
        sint32		n = 0;
        if(p==0)	return -1;
        if(p==1)	return 0;
        for(sint32 i=0; i<_dataLen; i++)
        {
            if ( _data[i]=='\n' )
            {
                n++;
            }
            if ( n==p-1 )				//找到要了要找的的行
            {
                return i+1;
            }
        }

        return -1; //没有找到
    }

    sint32 CIni::returnLineNum(const char* string)
    {
        sint32 p = findIndex(string);
        sint32		n = 0;
        if(p==0)	return -1;
        if(p==1)	return 0;
        for(sint32 i=0; i<p; i++)
        {
            if ( _data[i]=='\n' )
                n++;
        }
        return n;
    }
}
