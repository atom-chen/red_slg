#include "stdcore.h"
#include "shared_memory.h"
#include "debug.h"
#include "types_def.h"

#ifdef OS_WINDOWS
#else
#	include <sys/types.h>
#	include <sys/ipc.h>
#	include <sys/shm.h>
#endif


namespace GXMISC
{
	/// 内存映射保存表, 共享内存的创建和销毁必须在同一进程
#ifdef OS_WINDOWS
	std::map<void*, HANDLE>			AccessAddressesToHandles;
#else
	std::map<TSharedMemId, int>		SharedMemIdsToShmids;
#endif

	void			*CSharedMemory::CreateSharedMemory( TSharedMemId sharedMemId, uint32 size )
	{
#ifdef OS_WINDOWS

		// 通过虚拟交换文件创建后台文件映射(不是数据文件)
		HANDLE hMapFile = CreateFileMappingA( INVALID_HANDLE_VALUE, NULL, PAGE_READWRITE, 0, size, sharedMemId ); // @TODO UNICODE
		if ( (hMapFile == NULL) || (GetLastError() == ERROR_ALREADY_EXISTS) )
		{
			uint32 errNum = GetLastError();
			gxWarning( "SHDMEM: Cannot create file mapping for smid {0}: error {1}{2}, mapFile {3}", sharedMemId, errNum, (GetLastError()==ERROR_ALREADY_EXISTS) ? " (already exists) ": "", (uint64)hMapFile );
			return NULL;
		}

		// 将文件映射到内存地址空间
		void *accessAddress = MapViewOfFile( hMapFile, FILE_MAP_ALL_ACCESS, 0, 0, 0 );
		AccessAddressesToHandles.insert( std::make_pair( accessAddress, hMapFile ) );
		return accessAddress;

#else

		// 创建共享内存段
		int shmid = shmget( sharedMemId, size, IPC_CREAT | IPC_EXCL | 0666 );
		if ( shmid == -1 )
		{
			return NULL;
		}
		SharedMemIdsToShmids.insert( std::make_pair( sharedMemId, shmid ) );

		// 映射段到内存地址空间
		void *accessAddress = (void*)shmat( shmid, 0, 0 );
		if ( accessAddress == (void*)-1 )
			return NULL;
		else
			return accessAddress;
#endif
	}


	void			*CSharedMemory::AccessSharedMemory( TSharedMemId sharedMemId )
	{
#ifdef OS_WINDOWS
		// 通过名字打开已经存在的文件映射
		HANDLE hMapFile = OpenFileMappingA( FILE_MAP_ALL_ACCESS, false, sharedMemId ); // @TODO UNICODE
		if ( hMapFile == NULL )
			return NULL;

		// 将文件映射到内存地址空间
		void *accessAddress = MapViewOfFile( hMapFile, FILE_MAP_ALL_ACCESS, 0, 0, 0 );
		AccessAddressesToHandles.insert( std::make_pair( accessAddress, hMapFile ) );
		return accessAddress;

#else
		// 打开已经存在的共享内存段
		int shmid = shmget( sharedMemId, 0, 0666 );
		if ( shmid == -1 )
			return NULL;

		// 将段映射到内存地址空间
		void *accessAddress = (void*)shmat( shmid, 0, 0 );
		if ( accessAddress == (void*)-1 )
			return NULL;
		else
			return accessAddress;

#endif
	}


	bool			CSharedMemory::CloseSharedMemory( void *accessAddress )
	{
#ifdef OS_WINDOWS

		bool result = true;

		if ( UnmapViewOfFile( accessAddress ) == 0 )
		{
			uint32 errNum = GetLastError();
			gxWarning( "SHDMEM: UnmapViewOfFile failed: error {0}", errNum );
			result = false;
		}

		std::map<void*,HANDLE>::iterator im = AccessAddressesToHandles.find( accessAddress );
		if ( im != AccessAddressesToHandles.end() )
		{
			if ( ! CloseHandle( (*im).second ) )
			{
				uint32 errNum = GetLastError();
				gxWarning( "SHDMEM: CloseHandle failed: error {0}, mapFile {0}", errNum, (uint64)(*im).second );
			}
			AccessAddressesToHandles.erase( im );
			return result;
		}
		else
		{
			return false;
		}

#else
		// 将内存地址段分离
		return ( shmdt( accessAddress ) != -1 );

#endif
	}

	void        CSharedMemory::DestroySharedMemory( TSharedMemId sharedMemId, bool force )
	{
#ifndef OS_WINDOWS
		std::map<TSharedMemId,int>::iterator im = SharedMemIdsToShmids.find( sharedMemId );
		if ( im != SharedMemIdsToShmids.end() )
		{
			shmctl( (*im).second, IPC_RMID, 0 );
			SharedMemIdsToShmids.erase( im );
		}
		else if ( force )
		{
			// 如果共享内存存在, 则释放
			int shmid = shmget( sharedMemId, 0, 0666 );
			if ( shmid != -1 )
			{
				shmctl( shmid, IPC_RMID, 0 );
			}
		}
#endif
	}


} // GXMISC
