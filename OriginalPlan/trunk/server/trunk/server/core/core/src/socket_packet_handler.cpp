#include "socket_packet_handler.h"
#include "socket_input_stream.h"
#include "socket.h"
#include "net_task.h"

namespace GXMISC
{
    ISocketPacketHandler::ISocketPacketHandler()
    {
        _socket = NULL;
		_unpacketNum = 5;
    }

    ISocketPacketHandler::~ISocketPacketHandler()
    {
		_socket = NULL;
		_unpacketNum = 0;
    }

    void ISocketPacketHandler::setSocket( CSocket* socket )
    {
        _socket = socket;
    }

	bool ISocketPacketHandler::unpacket( CNetSocketLoopTask* task, char* packBuff, sint32 packBuffLen, char* packBuffTempRead, sint32 packBuffTempReadLen )
	{
		sint32 packLen = canUnpacket();
		if(needHandle(PACK_READ))
		{
			// 需要特别处理
			if(packLen > packBuffTempReadLen)
			{
				return false;
			}

			if(packLen != _socket->read(packBuffTempRead, packLen))
			{
				return false;
			}

			if(PACK_HANDLE_OK != onAfterReadFromSocket(packBuffTempRead, packLen, packBuff, packBuffLen))
			{
				return false;
			}

			return doUnpacket(task, packBuff, packBuffLen);
		}
		else
		{
			return doUnpacket(task, packLen);
		}
	}
	bool ISocketPacketHandler::parsePack(CPackHandleAry* packAry, const char* msg, sint32 len)
	{
		return false;
	}
	bool ISocketPacketHandler::doUnpacket( CNetSocketLoopTask* task, sint32 len )
	{
		if(NULL == _socket)
		{
			return false;
		}

		char tempBuff[255];
		memset(tempBuff, 0, sizeof(tempBuff));
		if(!_socket->getInputStream()->peek(tempBuff, getPackHeaderLen())){
			return false;
		}
		char* msg = NULL;
		int msgLen = len;
		if(isVarPacket(tempBuff, getPackHeaderLen())){
			msgLen = getMaxVarPackLen(tempBuff);
			msg = task->allocArg(msgLen);
			gxAssert(msg);
			memset(msg, 0, msgLen);
			char* varPackBuff = new char[len];
			memset(varPackBuff, 0, len);
			if(len != _socket->read(varPackBuff, len))
			{
				delete[] varPackBuff;
				task->freeArg();
				return false;
			}
			onHandleVarUnpacket(msg, varPackBuff, len);
			delete[] varPackBuff;
		}else{
			msg = task->allocArg(msgLen);
			gxAssert(msg);
			memset(msg, 0, msgLen);
			if(len != _socket->read(msg, msgLen))
			{
				task->freeArg();
				return false;
			}
		}

		onRecvPack(msg, msgLen, true);

		return true;
	}

	bool ISocketPacketHandler::doUnpacket( CNetSocketLoopTask* task, char* buff, sint32 len )
	{
		CPackHandleAry packParse;
		if(!parsePack(&packParse, buff, len))
		{
			return false;
		}
		
		for(sint32 i = 0; i < packParse.getPackNum(); ++i)
		{
			/*
			char* msg = task->allocArg(packParse.getPackLen(i)); 
			gxAssert(msg);
			memset(msg, 0, packParse.getPackLen(i));
			memcpy(msg, packParse.getPack(i), packParse.getPackLen(i));

			onRecvPack(msg, packParse.getPackLen(i), true);
			*/

			char* msg = NULL;
			int msgLen = packParse.getPackLen(i);
			if(isVarPacket(packParse.getPack(i), getPackHeaderLen())){
				msgLen = getMaxVarPackLen(packParse.getPack(i));
				msg = task->allocArg(msgLen);
				gxAssert(msg);
				memset(msg, 0, msgLen);
				onHandleVarUnpacket(msg, packParse.getPack(i), packParse.getPackLen(i));
			}else{
				msg = task->allocArg(packParse.getPackLen(i)); 
				gxAssert(msg);
				memset(msg, 0, packParse.getPackLen(i));
				memcpy(msg, packParse.getPack(i), packParse.getPackLen(i));
			}

			onRecvPack(msg, msgLen, true);
		}

		return true;
	}

	void ISocketPacketHandler::setUnpacketNum( sint32 unpacketNum )
	{
		_unpacketNum = unpacketNum;
	}

	CSocket* ISocketPacketHandler::getSocket()
	{
		return _socket;
	}

	sint32 ISocketPacketHandler::getUnpacketNum()
	{
		return _unpacketNum;
	}

	sint32 ISocketPacketHandler::onBeforeFlushToSocket( const char* buff, sint32 len, char* outBuff, sint32& outLen )
	{
		const char* pInBuff = buff;
		sint32 inLen = 0;
		sint32 curOutLen = 0;
		outLen = 0;
		while(true)
		{
			sint32 readLen = canReadPack(pInBuff+inLen, len-inLen);
			if(readLen > 0)
			{
				// 能够读取一个完整的数据包
				sint32 tempOutLen = outLen-curOutLen;
				sint32 retCode = onPackBeforeFlushToSocket(pInBuff+inLen, readLen, outBuff+curOutLen, tempOutLen);
				if(retCode <= PACK_HANDLE_ERR)
				{
					return retCode;
				}
				else if(retCode == PACK_HANDLE_OK)
				{
					// 处理包成功
					if(getSocket())
					{
						getSocket()->write(outBuff, tempOutLen);
					}
					else
					{
						// 成功写入
						curOutLen += tempOutLen;
					}
				}
				else
				{
					return retCode;
				}

				inLen += readLen;
			}
			else if(readLen == 0)
			{
				break;
			}
			else
			{
				return PACK_HANDLE_ERR;
			}
		}

		gxAssert(inLen == len);
		outLen = curOutLen;

		return PACK_HANDLE_OK;
	}

	sint32 ISocketPacketHandler::onAfterReadFromSocket( const char* buff, sint32 len, char* outBuff, sint32& outLen )
	{
		const char* pInBuff = buff;
		sint32 inLen = 0;
		sint32 curOutLen = 0;
		while(true)
		{
			sint32 readLen = canReadPack(pInBuff+inLen, len-inLen);
			if(readLen > 0)
			{
				// 能够读取一个完整的数据包
				sint32 tempOutLen = outLen-curOutLen;
				sint32 retCode = onPackAfterFromSocket(pInBuff+inLen, readLen, outBuff+curOutLen, tempOutLen);
				if(retCode <= PACK_HANDLE_ERR)
				{
					return retCode;
				}
				else if(retCode == PACK_HANDLE_NO)
				{
					return retCode;
				}

				// 处理包成功
				inLen += readLen;
				curOutLen += tempOutLen; 
			}
			else
			{
				break;
			}
		}

		gxAssert(inLen == len);
		outLen = curOutLen;
		return PACK_HANDLE_OK;
	}

	sint32 ISocketPacketHandler::onPackBeforeFlushToSocket( const char* buff, sint32 len, char* outBuff, sint32& outLen )
	{
		return PACK_HANDLE_NO;
	}

	sint32 ISocketPacketHandler::onPackAfterFromSocket( const char* buff, sint32 len, char* outBuff, sint32& outLen )
	{
		return PACK_HANDLE_NO;
	}

	void ISocketPacketHandler::sendPack( const char* msg, uint32 len )
	{
		uint32 oldLen = getSocket()->getOutputLen();
		getSocket()->write(msg, len);
		if((len + oldLen) != (uint32)getSocket()->getOutputLen())
		{
			gxError("Can't write packs to socket!{0}", getSocket()->toString());
			getSocket()->setActive(false);
			return;
		}

		onSendPack(msg, len, false);
	}

	CEmptyPacketHandler::CEmptyPacketHandler() : ISocketPacketHandler()
    {
		setUnpacketNum(1000);
    }

    CEmptyPacketHandler::~CEmptyPacketHandler()
    {
    }

    sint32 CEmptyPacketHandler::canUnpacket()
    {
        return _socket->getInputLen();
    }

    bool CEmptyPacketHandler::unpacket( CNetSocketLoopTask* task, char* packBuff, sint32 packBuffLen, char* packBuffTempRead, sint32 packBuffTempReadLen )
    {
		sint32 len = _socket->getInputLen();
		return doUnpacket(task, len);
    }

	sint32 CEmptyPacketHandler::getPackHeaderLen()
	{
		return 1;
	}

	sint32 CDefaultPacketHandler::getPackHeaderLen()
	{
		return 2;
	}

	sint32 CDefaultPacketHandler::canUnpacket()
	{
		uint16 len = _socket->getInputStream()->peakUint16();
		if(len == 0)
		{
			return 0;
		}

		if(uint32(_socket->getInputLen()) >= len)
		{
			return len;
		}

		return 0;
	}

	bool CDefaultPacketHandler::unpacket( CNetSocketLoopTask* task, char* packBuff, sint32 packBuffLen, char* packBuffTempRead, sint32 packBuffTempReadLen )
	{
		uint16 len = _socket->getInputStream()->peakUint16();
		return doUnpacket(task, len);
	}

	CDefaultPacketHandler::CDefaultPacketHandler()
	{

	}

	CDefaultPacketHandler::~CDefaultPacketHandler()
	{

	}

}