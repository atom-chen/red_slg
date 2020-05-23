
#ifndef _GAME_EXTEND_SOCKET_HANDLER_H_
#define _GAME_EXTEND_SOCKET_HANDLER_H_

#include "core/lib_misc.h"

#include "game_util.h"
#include "md5_ext.h"
#include "game_socket_handler.h"

static const char* Md5KeyStr = "AXGAME";
static const char PACKET_MD5_NUM[] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};

template <typename T>
class CGameExtendSocketHandler : public CGameSocketHandler<T>
{
	typedef CGameSocketHandler<T> TBaseType;
public:
	CGameExtendSocketHandler() : CGameSocketHandler<T>()	{ _isEncryPacket = true; }
	virtual ~CGameExtendSocketHandler()						{}

public:
	virtual bool	onBeforeHandlePacket( CBasePacket* packet )
	{
		if ( packet->totalLen > sizeof(*packet) )
		{
			/*
			TPackLen_t packetLen = packet->totalLen - sizeof(CBasePacket);
			if ( packetLen > (1024 * 9) )
			{
				CGameSocketHandler<T>::kick();
				return true;
			}

			static char tempBuff[1024*10];
			char* packetData = (char*)((char*)packet + sizeof(CBasePacket));
			if ( _isEncryPacket )
			{
				GXMISC::DecryCharArray(packetData, packetLen, tempBuff);
				memcpy(packetData, tempBuff, packetLen);

					// ¼ÓÃÜ¼ì²é
				memcpy(tempBuff+packetLen, Md5KeyStr, strlen(Md5KeyStr));
				MD5_DIGEST realMD5Str;
				MD5Data(tempBuff, packetLen+(sint32)(strlen(Md5KeyStr)), &realMD5Str);
				uint8 highNum = (packet->checkSum >> 8) & 0xFF;
				uint8 lowNum = packet->checkSum & 0xFF;
				uint8 highMD5Index = (realMD5Str[0] >> 4) & 0xF;
				uint8 lowMD5Index = realMD5Str[0] & 0xF;
				uint8 highMD5Num = (uint8)PACKET_MD5_NUM[highMD5Index];
				uint8 lowMD5Num = (uint8)PACKET_MD5_NUM[lowMD5Index];
				if ( highMD5Num != highNum || lowMD5Num != lowNum )
				{
					CGameSocketHandler<T>::kick();
					return false;
				}
				
			}
			*/

			return true;
		}

		return true;
	}

protected:
	bool			_isEncryPacket;
};

#endif