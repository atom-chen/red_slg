#ifndef _SHARED_MEMORY_H_
#define _SHARED_MEMORY_H_

#include "types_def.h"

namespace GXMISC
{
	// @TODO 测试可用性
#ifdef OS_WINDOWS
	typedef const char *TSharedMemId;
#else
	typedef key_t TSharedMemId;
#endif

	/**
	* @brief 
	* ToSharedMemId: 将一个整数转换成TSharedMemId
	* FMT_SMID: 类似于打印语法的格式化类型. Ex: gxDebug( "Segment %"FMT_SMID" was created", sharedMemId );
	*/
#ifdef OS_WINDOWS
#define DToSharedMemId( id ) gxToString( "NeLSM_%d", id ).c_str()
#define DFmtSmid "s"
#else
#define DToSharedMemId( id ) (id)
#define DFmtSmid "d"
#endif

	/**
	* @brief 共享内存API包装类
	*        在winidows下使用文件映射,在linux下使用共享内存(shm)
	* @note: 在linux下, 必须加上阻止内存段被交换出去的选项
	*/
	class CSharedMemory
	{
	public:

		/**
		* @brief 创建共享内存,
		*        共享内存的ID必须没有被用过, id(0x3a732235)已经为Gx内存管理器预留
		* @return 返回分配的共享内存
		*/
		static void *		CreateSharedMemory( TSharedMemId sharedMemId, uint32 size );

		/**
		* @brief 获取指定ID的共享内存块
		* @return 返回共享内存块,大小在创建时已经被指定
		*/
		static void *		AccessSharedMemory( TSharedMemId sharedMemId );

		/**
		* @brief 关闭(分离)共享内存块
		*/
		static bool			CloseSharedMemory( void * accessAddress );

		/**
		* @brief 销毁共享内存
		* @param force为true 强制释放, 如果指定共享内存ID的共享内存不在管理列表中存在并且已经创建则也释放掉
		* @note 必须由创建共享内存的进程释放, 而不是由访问共享内存的进程释放
		*       这个方法在winodws下不存在, 因为它在windows下是自动释放的
		*       在unix下, 共享段实际上在最后一个被分离的时候自动释放
		*       即在调用destroyShareMemory()后, 这个段仍然可以被其他进程访问,直到它调用closeShareMemory()
		*/
		static void DestroySharedMemory( TSharedMemId sharedMemId, bool force=false );
	};


} // GXMISC


#endif // _SHARED_MEMORY_H_