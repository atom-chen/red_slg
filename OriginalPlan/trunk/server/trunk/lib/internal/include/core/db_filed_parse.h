#ifndef _DB_FILED_PARSE_H_
#define _DB_FILED_PARSE_H_

#include <vector>

#include "db_types_def.h"
#include "base_util.h"
#include "db_util.h"
#include "carray.h"
#include "fix_array.h"
#include "game_time.h"
#include "game_exception.h"
#include "stream_impl.h"

namespace GXMISC
{
	enum EDbColFlag{
		_DBCOL_NOT_READ_ = 1,					// 不可读
		_DBCOL_NOT_WRITE_ = 2,					// 不可写
		_DBCOL_NOT_CHECK_NAME_ = 4,				// 不需要检查名字
		_DBCOL_WRITENAMEBACK_ = 8				// 写回名字
	};

	enum EDbFiledFlag{
		DB_FILED_FLAG_MAIN_KEY = 0x1,			// 主键字段
		DB_FILED_FLAG_AUTO_INC = 0x2,			// 自动增长字段
	};

	enum EDbFiledUseFlag
	{
		DB_FILED_USE_FALSE = 0x1,				// 使用域
		DB_FILED_USE_TRUE = 0x2,				// 不使用域
	};

	typedef std::vector<uint8> TDBBuffer;
	// 数据库字段转换函数, 返回转换后的长度
	// 如果返回值小于0则表示转换失败
	typedef sint32(*TDbFiledConvertion)(TDBBuffer& destBuffer, const void* buffer, sint32 buffLen, GXMISC::TDBVersion_t dbVersion);

	template<typename T>
	sint32 DefaultDbToDataFunc( TDBBuffer& destBuffer, const void* buffer, sint32 buffLen, TDBVersion_t dbVersion )
	{
		FUNC_BEGIN("DB_MOD;");

		destBuffer.resize(sizeof(T));
		T* obj = (T*)destBuffer.data();
		CMemInputStream outputStream;
		outputStream.init(buffLen,(char*)buffer);
		if(outputStream.serial(*obj) <= 0){
			return -1;
		}

		return 1;

		FUNC_END(-1);
	}

	template<typename T>
	sint32 DefaultDataToDbFunc( TDBBuffer& destBuffer, const void* buffer, sint32 buffLen, TDBVersion_t dbVersion )
	{
		FUNC_BEGIN("DB_MOD;");

		T* obj = (T*)buffer;
		CMemTempOutputStream<sizeof(T)> outputStream;
		if( outputStream.serial(*obj) <= 0){
			return -1;
		}

		destBuffer.assign(outputStream.data(), outputStream.data()+outputStream.size());

		return 1;

		FUNC_END(-1);
	}

	template<typename T>
	static TDbFiledConvertion GetDefaultDbToDataFunc(T& m){
		return &DefaultDbToDataFunc<T>;
	}

	template<typename T>
	static TDbFiledConvertion GetDefaultDataToDbFunc(T& m){
		return &DefaultDataToDbFunc<T>;
	}

	typedef struct _dbCol
	{
		const char*	name;							// 数据库名字
		uint16 type;								// 类型
		uint8 col_flag;								// 标记
		uint8 reserva;								// 备用
		uint32 type_size;							// 类型大小
		uint32 data_offset;							// 字段位移
		unsigned char* data_addr;					// 字段数据地址
		uint16 dbcolsize;							// 整个结构体大小
		TDbFiledConvertion dbFieldToDataFuncPtr;	// 数据库内容转换成缓冲区内容函数
		TDbFiledConvertion dataToDbFiledFuncPtr;	// 缓冲区内容转换成数据库内容函数
		uint8 filed_flag;							// 表字段属性
		GXMISC::TDBVersion_t db_version;			// 数据库版本号
		char szNameBuffer[64];						// 数据库名字写回的缓冲区

		static const struct _dbCol* findbyName(const struct _dbCol* pfirstdbcol, const char* szName)
		{
			if(pfirstdbcol && szName)
			{
				while(pfirstdbcol->name)
				{
					if(strcmp(pfirstdbcol->name, szName) == 0)
					{
						return pfirstdbcol;
					}

					pfirstdbcol++;
				}
			}

			return NULL;
		}

		inline bool isPrimary() const
		{
			return ((filed_flag & DB_FILED_FLAG_MAIN_KEY ) == 1);
		}
		inline bool isAutoInc() const
		{
			return ((filed_flag & DB_FILED_FLAG_AUTO_INC ) == 1);
		}
		inline bool canRead() const
		{
			return ((col_flag & _DBCOL_NOT_READ_) == 0);
		}

		inline bool canWrite() const
		{
			return ((col_flag & _DBCOL_NOT_WRITE_) == 0);
		}

		inline bool checkName() const
		{
			return ((col_flag & _DBCOL_NOT_CHECK_NAME_) == 0);
		}

		inline bool isUse()
		{
			return (reserva & DB_FILED_USE_TRUE) == 1;
		}

		inline bool noUse()
		{
			return !isUse();
		}

		bool writeNameBack(const char* szname)
		{
			if(((col_flag & _DBCOL_NOT_CHECK_NAME_) != 0 && (col_flag & _DBCOL_WRITENAMEBACK_) != 0))
			{
				name = szNameBuffer;
				sint32 srcLen = sint32(sizeof(szNameBuffer) - 1);
				sint32 destLen = sint32(strlen(szname));
				gxStrcpy(szNameBuffer, srcLen, szname, destLen);
				return true;
			}

			return false;
		}

		void clone(const struct _dbCol* pcol)
		{
			memcpy(this, pcol, sizeof(*this));

			if(pcol->name)
			{
				szNameBuffer[0] = 0;
				sint32 srcLen = sint32(sizeof(szNameBuffer) - 1);
				sint32 destLen = sint32(strlen(pcol->name));
				gxStrcpy(szNameBuffer, srcLen, pcol->name, destLen);
				name = szNameBuffer;
			}
			else
			{
				szNameBuffer[0] = 0;
				name = NULL;
			}
		}
	}TDbCol;
	typedef std::vector<TDbCol> TDbColVec;
	typedef std::vector<TDbColVec> TDbColVecs;
	typedef CFixArray<TDbCol, 100> TDbColFixAry;
	typedef CArray<TDbCol, 100> TDbColAry;
	typedef std::vector<TDbColAry> TDbColAryVec;


	struct dbColProxy
	{
		uint8 buffer[sizeof(TDbCol)];
		dbColProxy()
		{
			DZeroSelf;
		}
		TDbCol* getdbCol()
		{
			return ((TDbCol*)&buffer);
		}
	};

	template<typename T>
	class CDbInnerTypeTraits
	{
	public:
		enum{
			DB_TYPE = DB_OBJECT,
		};
	};
	template<>
	class CDbInnerTypeTraits<TTraitTypeTinyAry>
	{
	public:
		enum{
			DB_TYPE = DB_TINY_STR,
		};
	};
	template<>
	class CDbInnerTypeTraits<TTraitTypeSmallAry>
	{
	public:
		enum{
			DB_TYPE = DB_STR,
		};
	};
	template<>
	class CDbInnerTypeTraits<TTraitTypeBigAry>
	{
	public:
		enum{
			DB_TYPE = DB_BIG_STR,
		};
	};
	template<typename T, bool flag = false>
	class CDbSpecialTypeTraits
	{
	public:
		enum{
			DB_TYPE = DB_OBJECT,
		};
	};
	template<typename T>
	class CDbSpecialTypeTraits<T, true>
	{
	public:
		enum{
			DB_TYPE = CDbInnerTypeTraits<typename T::TTraitType>::DB_TYPE,
		};
	};
	template<typename TDbTypeT>
	class CDbTypeTraits
	{
	public:
		template<typename T, typename IT = void>
		struct HasTraitTypeObject
		{
			enum{
				value = false,
			};
		};
		template<typename T>
		struct HasTraitTypeObject<T, typename T::TTraitType>
		{
			enum{
				value = true,
			};
		};

	public:
		enum{
			DB_TYPE = CDbSpecialTypeTraits<TDbTypeT, HasTraitTypeObject<TDbTypeT>::value>::DB_TYPE,
		};
	};
	template<>
	class CDbTypeTraits<uint8>
	{
	public:
		enum{
			DB_TYPE = DB_BYTE,
		};
	};
	template<>
	class CDbTypeTraits<sint8>
	{
	public:
		enum{
			DB_TYPE = DB_BYTES,
		};
	};
	template<>
	class CDbTypeTraits<uint16>
	{
	public:
		enum{
			DB_TYPE = DB_WORD,
		};
	};
	template<>
	class CDbTypeTraits<sint16>
	{
	public:
		enum{
			DB_TYPE = DB_WORDS,
		};
	};
	template<>
	class CDbTypeTraits<uint32>
	{
	public:
		enum{
			DB_TYPE = DB_DWORD,
		};
	};
	template<>
	class CDbTypeTraits<sint32>
	{
	public:
		enum{
			DB_TYPE = DB_DWORDS,
		};
	};
	template<>
	class CDbTypeTraits<uint64>
	{
	public:
		enum{
			DB_TYPE = DB_QWORD,
		};
	};
	template<>
	class CDbTypeTraits<sint64>
	{
	public:
		enum{
			DB_TYPE = DB_QWORDS,
		};
	};
	template<>
	class CDbTypeTraits<float>
	{
	public:
		enum{
			DB_TYPE = DB_FLOAT,
		};
	};
	template<>
	class CDbTypeTraits<double>
	{
	public:
		enum{
			DB_TYPE = DB_DOUBLE,
		};
	};
	template<>
	class CDbTypeTraits<CGameTime>
	{
	public:
		enum{
			DB_TYPE = DB_DATETIME,
		};
	};


	typedef struct _dbColBackup : public TDbCol
	{
	public:
		_dbColBackup(const char* name, uint16 type, uint8 col_flag, uint8 reserva, uint32 type_size, uint32 data_offset,
			unsigned char* data_addr, uint16 dbcolsize, TDbFiledConvertion dbFieldToDataFuncPtr, TDbFiledConvertion dataToDbFiledFuncPtr,
			uint8 filed_flag, GXMISC::TDBVersion_t db_version)
		{
			this->name = name;
			this->type = type;
			this->col_flag = col_flag;
			this->reserva = reserva;
			this->type_size = type_size;
			this->data_offset = data_offset;
			this->data_addr = data_addr;
			this->dbcolsize = dbcolsize;
			this->dbFieldToDataFuncPtr = dbFieldToDataFuncPtr;
			this->dataToDbFiledFuncPtr = dataToDbFiledFuncPtr;
			this->filed_flag = filed_flag;
			this->db_version = db_version;
			memset(szNameBuffer, 0, sizeof(szNameBuffer));
		}

		/*
		template<typename T>
		static _dbColBackup MakeCol(const char* name, T& member, uint8 col_flag, uint8 reserva, uint32 data_offset,
			uint16 dbcolsize, TDbFiledConvertion dbFieldToDataFuncPtr, TDbFiledConvertion dataToDbFiledFuncPtr,
			uint8 filed_flag, GXMISC::TDBVersion_t db_version)
		{
			_dbColBackup dbBackup;
			dbBackup.name = name;
			dbBackup.type = CDbTypeTraits<T>::DB_TYPE;
			dbBackup.col_flag = col_flag;
			dbBackup.reserva = reserva;
			dbBackup.type_size = sizeof(member);
			dbBackup.data_offset = 0;
			dbBackup.data_addr = &member;
			dbBackup.dbcolsize = dbcolsize;
			dbBackup.dbFieldToDataFuncPtr = dbFieldToDataFuncPtr;
			dbBackup.dataToDbFiledFuncPtr = dataToDbFiledFuncPtr;
			dbBackup.filed_flag = filed_flag;
			dbBackup.db_version = db_version;
			memset(dbBackup.szNameBuffer, 0, sizeof(dbBackup.szNameBuffer));

			return dbBackup;
		}
		*/
		template<typename T>
		static sint32 GetDbType(T& member)
		{
			return CDbTypeTraits<T>::DB_TYPE;
		}

	}TDbColBackup;

	// 有结构体存储的字段
	// 完整的结构赋值
#define _DBCOL_SIZE_OFFSET_FULL_(name,dbtype,type,member,col_flag,dbcolsize,filed_flag,dbToDataFuncPtr,dataToDbFuncPtr,db_version)		\
	{name,dbtype,col_flag,0,sizeof( ((type*)NULL)->member ), (uint32)offsetof(type, member),NULL,	\
	dbcolsize,dbToDataFuncPtr,dataToDbFuncPtr,filed_flag,db_version,{""}}
	// 名字/数据库类型/结构体类型/成员变量
#define _DBCOL_SIZE_OFFSET_(name,dbtype,type,member)				\
	_DBCOL_SIZE_OFFSET_FULL_(name,dbtype,type,member,0,sizeof(GXMISC::TDbCol),0,NULL,NULL,0)
	// 名字/数据库类型/结构体类型/成员变量/转换函数/版本号
#define _DBCOL_SIZE_OFFSET_FUNC_(name,dbtype,type,member,dbToDataFuncPtr,db_version)				\
	_DBCOL_SIZE_OFFSET_FULL_(name,dbtype,type,member,0,sizeof(GXMISC::TDbCol),0,dbToDataFuncPtr,GXMISC::GetDefaultDataToDbFunc(member),db_version)
	// 名字/类型/结构体类型/成员变量
#define _DBCOL_TYPE_OFFSET_(name,dbtype,type,member)				\
	_DBCOL_SIZE_OFFSET_(name,GXMISC::CDbTypeTraits<dbtype>::DB_TYPE,type,member)
	// 名字/类型/结构体类型/成员变量/转换函数/版本号
#define _DBCOL_TYPE_OFFSET_FUNC_(name,dbtype,type,member,dbToDataFuncPtr,db_version)				\
	_DBCOL_SIZE_OFFSET_FUNC_(name,GXMISC::CDbTypeTraits<dbtype>::DB_TYPE,type,member,dbToDataFuncPtr,GXMISC::GetDefaultDataToDbFunc(member),db_version)
	// 名字/数据库类型/结构体类型/成员变量/字段标记(如果当前变量为主键则需要此宏)
#define _DBCOL_TYPE_OFFSET_KEY_(name,dbtype,type,member,filed_flag)		\
	_DBCOL_SIZE_OFFSET_FULL_(name,GXMISC::CDbTypeTraits<dbtype>::DB_TYPE,type,member,0,sizeof(GXMISC::TDbCol),filed_flag,NULL,NULL,0)
	// 名字/数据库类型/结构体类型/成员变量/字段标记(主键宏)
#define _DBCOL_TYPE_OFFSET_MKEY_(name,dbtype,type,member)		\
	_DBCOL_SIZE_OFFSET_FULL_(name,GXMISC::CDbTypeTraits<dbtype>::DB_TYPE,type,member,0,sizeof(GXMISC::TDbCol),GXMISC::DB_FILED_FLAG_MAIN_KEY,NULL,NULL,0)

#define _DBC_SO_		_DBCOL_SIZE_OFFSET_
#define _DBC_SOF_		_DBCOL_SIZE_OFFSET_FULL_

	// 无结构体存储的字段
	// 完整的结构赋值
#define _DBCOL_SIZE_ADDR_FULL_(name,dbtype,member,col_flag,dbcolsize,filed_flag,dbToDataFuncPtr,dataToDbFuncPtr,db_version)		\
	{name,dbtype,col_flag,0,sizeof(member),0,(unsigned char *)&(member),dbcolsize,dbToDataFuncPtr,dataToDbFuncPtr,filed_flag,db_version,{""}}
	// 名字/数据库类型/成员变量
#define _DBCOL_SIZE_ADDR_(name,dbtype,member)		\
	_DBCOL_SIZE_ADDR_FULL_(name,dbtype,member,0,sizeof(GXMISC::TDbCol),0,NULL,NULL,0)
	// 名字/数据库类型/成员变量/转换函数/版本号
#define _DBCOL_SIZE_ADDR_FUNC_(name,dbtype,member,dbToDataFuncPtr,db_version)		\
	_DBCOL_SIZE_ADDR_FULL_(name,dbtype,member,0,sizeof(GXMISC::TDbCol),0,dbToDataFuncPtr,GXMISC::GetDefaultDataToDbFunc(member),db_version)
	// 名字/类型/成员变量
#define _DBCOL_TYPE_ADDR_(name,dbtype,member)		\
	_DBCOL_SIZE_ADDR_FULL_(name,GXMISC::CDbTypeTraits<dbtype>::DB_TYPE,member,0,sizeof(GXMISC::TDbCol),0,NULL,NULL,0)
	// 名字/类型/成员变量/转换函数/版本号
#define _DBCOL_TYPE_ADDR_FUNC_(name,dbtype,member,dbToDataFuncPtr,db_version)		\
	_DBCOL_SIZE_ADDR_FULL_(name,GXMISC::CDbTypeTraits<dbtype>::DB_TYPE,member,0,sizeof(GXMISC::TDbCol),0,dbToDataFuncPtr,GXMISC::GetDefaultDataToDbFunc(member),db_version)
	// 名字/类型/成员变量/转换函数/版本号/字段标记(如果当前变量为主键则需要此宏)
#define _DBCOL_TYPE_ADDR_KEY_(name,dbtype,member,filed_flag)		\
	_DBCOL_SIZE_ADDR_FULL_(name,GXMISC::CDbTypeTraits<dbtype>::DB_TYPE,member,0,sizeof(GXMISC::TDbCol),filed_flag,NULL,NULL,0)
	// 名字/数据库类型/结构体类型/成员变量/字段标记(主键宏)
#define _DBCOL_TYPE_ADDR_MKEY_(name,dbtype,member)		\
	_DBCOL_SIZE_ADDR_FULL_(name,GXMISC::CDbTypeTraits<dbtype>::DB_TYPE,member,0,sizeof(GXMISC::TDbCol),GXMISC::DB_FILED_FLAG_MAIN_KEY,NULL,NULL,0)
#define _DBC_SA_		_DBCOL_SIZE_ADDR_
#define _DBC_SAF_		_DBCOL_SIZE_ADDR_FULL_

	// 无结构体存储的字段对象
	// 完整的结构赋值
#define _DBCOL_SIZE_OBJ_FULL_(name,dbtype,member,col_flag,dbcolsize,filed_flag,dbToDataFuncPtr,dataToDbFuncPtr,db_version)	\
	GXMISC::TDbColBackup(name,dbtype,col_flag,0,sizeof(member),0,(unsigned char *)&(member),	\
	dbcolsize,dbToDataFuncPtr,dataToDbFuncPtr,filed_flag,db_version)
	// 名字/数据库类型/成员变量
#define _DBCOL_SIZE_OBJ_(name,dbtype,member)	\
	_DBCOL_SIZE_OBJ_FULL_(name,dbtype,member,0,sizeof(GXMISC::TDbCol),0,NULL,NULL,0)
	// 名字/数据库类型/成员变量/转换函数/版本号
#define _DBCOL_SIZE_OBJ_FUNC_(name,dbtype,member,dbToDataFuncPtr,db_version)	\
	_DBCOL_SIZE_OBJ_FULL_(name,dbtype,member,0,sizeof(GXMISC::TDbCol),0,dbToDataFuncPtr,NULL,db_version)
	// 名字/成员变量
#define _DBCOL_TYPE_OBJ_(name,member)		\
	_DBCOL_SIZE_OBJ_FULL_(name,GXMISC::TDbColBackup::GetDbType(member),member,0,sizeof(GXMISC::TDbCol),0,NULL,NULL,0)
	// 名字/成员变量,版本号
#define _DBCOL_OBJ_FUNC_(name,member,db_version)		\
	_DBCOL_SIZE_OBJ_FULL_(name,GXMISC::TDbColBackup::GetDbType(member),member,0,sizeof(GXMISC::TDbCol),0,GXMISC::GetDefaultDbToDataFunc(member),GXMISC::GetDefaultDataToDbFunc(member),db_version)
	// 名字/类型/成员变量/转换函数/版本号
#define _DBCOL_TYPE_OBJ_FUNC_(name,dbtype,member,dbToDataFuncPtr,db_version)		\
	_DBCOL_SIZE_OBJ_FULL_(name,GXMISC::CDbTypeTraits<dbtype>::DB_TYPE,member,0,sizeof(GXMISC::TDbCol),0,dbToDataFuncPtr,GXMISC::GetDefaultDataToDbFunc(member),db_version)
	// 名字/类型/成员变量/转换函数/版本号/字段标记(如果当前变量为主键则需要此宏)
#define _DBCOL_TYPE_OBJ_KEY_(name,member,filed_flag)		\
	_DBCOL_SIZE_OBJ_FULL_(name,GXMISC::TDbColBackup::GetDbType(member),member,0,sizeof(GXMISC::TDbCol),filed_flag,NULL,NULL,0)
	// 名字/类型/成员变量/转换函数/版本号/字段标记(主键宏)
#define _DBCOL_TYPE_OBJ_MKEY_(name,member)		\
	_DBCOL_SIZE_OBJ_FULL_(name,GXMISC::TDbColBackup::GetDbType(member),member,0,sizeof(GXMISC::TDbCol),GXMISC::DB_FILED_FLAG_MAIN_KEY,NULL,NULL,0)
#define _DBC_SO_OBJ_		_DBCOL_SIZE_OBJ_
#define _DBC_SOF_OBJ_		_DBCOL_SIZE_OBJ_FULL_

	// 空值
#define _DBC_NULL_		{NULL,0,0,0,0,0,NULL,sizeof(GXMISC::TDbCol),NULL}
#define _DBC_NULL_MAXOFFSET_(type)		{NULL,0,0,0,sizeof(type),0,NULL,sizeof(GXMISC::TDbCol),NULL,NULL}
#define _DBC_MAX_NULL_(type)	_DBC_NULL_MAXOFFSET_(type)
}


#endif
