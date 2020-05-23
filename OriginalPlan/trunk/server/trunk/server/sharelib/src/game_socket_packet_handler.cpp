#include "game_socket_packet_handler.h"

TUnpacketHandlerHash CGameSocketPacketHandler::HandlerHashs;

TUnpacketIDHandlerAry CGameSocketPacketHandler::UnpacketHandlers;

uint32 CGameSocketPacketHandler::UnpacketHandlerNum = 0;

bool CBasePackHandleAry::parse(const char* msg, sint32 len)
{
	_msg = msg;
	_len = len;

	sint32 curLen = 0;
	while(curLen < len)
	{
		CBasePacket* pBasePack = (CBasePacket*)(msg+curLen);
		if(pBasePack->totalLen > (len-curLen))
		{
			return false;
		}

		_pack.push_back(curLen);
		curLen += pBasePack->totalLen;
	}

	gxAssert(curLen == len);
	_pack.push_back(len);
	return true;
}

CBasePacket* CBasePackHandleAry::getBasePack(sint32 index)
{
	return (CBasePacket*)(_msg+_pack[index]);
}

CGameSocketPacketHandler::CGameSocketPacketHandler() : GXMISC::ISocketPacketHandler()
{
	_filterPacket.insert(PACKET_MC_COMPRESS);

	setUnpacketNum(6);
}

void CGameSocketPacketHandler::setAttr(TSockExtAttr* attr)
{
	_attr = attr->packAttr;
}

bool CGameSocketPacketHandler::OnFlushDataToNetLoop(GXMISC::CNetLoopWrap* netWrap, const char* msg, sint32 len, GXMISC::TUniqueIndex_t index)
{
	netWrap->writeMsg(msg, len, index);
	return true;
}

bool CGameSocketPacketHandler::parsePack(GXMISC::CPackHandleAry* packAry, const char* msg, sint32 len)
{
	CBasePackHandleAry parser;
	if(!parser.parse(msg, len))
	{
		return false;
	}

	*packAry = parser;
	return true;
}

bool CGameSocketPacketHandler::needHandle(GXMISC::ISocketPacketHandler::EPackOpt opt)
{
	if(opt == GXMISC::ISocketPacketHandler::PACK_SEND)
	{
		return (_attr.compress || _attr.encrypt);
	}
	else if(opt == GXMISC::ISocketPacketHandler::PACK_READ)
	{
		return (_attr.compress || _attr.encrypt);
	}

	return false;
}

bool CGameSocketPacketHandler::canCompress(CBasePacket* pBasePack)
{
	return true;
}

sint32 CGameSocketPacketHandler::canReadPack(const char* buff, sint32 len)
{
	if(len == 0)
	{
		return 0;
	}

	CBasePacket* pBasePack = (CBasePacket*)buff;
	if(pBasePack->totalLen > len)
	{
		return 0;
	}

	return pBasePack->totalLen;
}

void CGameSocketPacketHandler::onSendPack(const char* msg, sint32 len, bool singalFlag)
{
#if 0
	CBasePackHandleAry packAry;
	if(!packAry.parse(msg, len))
	{
		gxError("Can't parse send msg!");
		return;
	}

	for(sint32 i = 0; i < packAry.getPackNum(); ++i)
	{
		CBasePacket* pBasePack = packAry.getBasePack(i);
		gxInfo("Send pack id={0}", pBasePack->getPacketID());
	}
#endif
}

void CGameSocketPacketHandler::onRecvPack(const char* msg, sint32 len, bool singalFlag)
{
#if 0
	CBasePackHandleAry packAry;
	if(!packAry.parse(msg, len))
	{
		gxError("Can't parse send msg!");
		return;
	}

	for(sint32 i = 0; i < packAry.getPackNum(); ++i)
	{
		CBasePacket* pBasePack = packAry.getBasePack(i);
		gxInfo("Recv pack id={0}", pBasePack->getPacketID());
	}
#endif
}

sint32 CGameSocketPacketHandler::onBeforeFlushToSocket(const char* buff, sint32 len, char* outBuff, sint32& outLen)
{
	// @threading 底层多线程函数
	if(!_attr.compress || len < _attr.compressLen || !_attr.compressProtocol)
	{
		// 不需要压缩则不做压缩协议
		return GXMISC::ISocketPacketHandler::onBeforeFlushToSocket(buff, len, outBuff, outLen);
	}

	// 进行压缩协议处理
	CBasePackHandleAry packParse;
	if(false == packParse.parse(buff, len))
	{
		// 包处理错误
		return GXMISC::ISocketPacketHandler::PACK_HANDLE_ERR;
	}

	if(packParse.getPackNum() < _attr.minCompressNum)
	{
		// 不需要压缩则不做压缩协议
		return GXMISC::ISocketPacketHandler::onBeforeFlushToSocket(buff, len, outBuff, outLen);
	}

#define COMPRE_INDEX_DEBUG 1

#ifdef LIB_DEBUG
#if COMPRE_INDEX_DEBUG
	std::vector<sint32> handleIndexs;
#endif
#endif

	sint32 sendNum = 0;
	sint32 index = 0;
	std::vector<char> tempBuff;
	while(index < packParse.getPackNum())
	{
		// 获取包压缩的长度
		sint32 startIndex = index;
		sint32 endIndex = index;
		tempBuff.clear();
		for(;index < packParse.getPackNum();++index,++endIndex)
		{
			gxAssert(endIndex == index);

			CBasePacket* pBasePack = packParse.getBasePack(index);
			if(canCompress(pBasePack))
			{
				// 能够与其他包一起压缩
				if(packParse.getPackLen(startIndex, index+1) >= _attr.compressMaxLen && (index-startIndex) > 0)
				{
					// 达到压缩长度上限, 处理
					endIndex = index;
					break;
				}
				else if((index+1-startIndex) >= _attr.maxCompressNum)
				{
					// 已经达到压缩个数上限, 处理
					onSendPack(packParse.getPack(index), packParse.getPackLen(index), true);
					endIndex = index+1;
					index++;
					break;
				}

				// 压缩到一起
				onSendPack(packParse.getPack(index), packParse.getPackLen(index), true);
			}
			else
			{
				// 单独处理
				if(startIndex != index)
				{
					// 先前已经缓存数据
					endIndex = index;
					break;
				}
				else
				{
					// 当前只有一个包需要处理
					onSendPack(packParse.getPack(index), packParse.getPackLen(index), true);
					endIndex = index+1;
					index++;
					break;
				}
			}
		}

#ifdef LIB_DEBUG
#if COMPRE_INDEX_DEBUG
		for(sint32 i = startIndex; i < endIndex; ++i)
		{
			gxAssert(std::find(handleIndexs.begin(), handleIndexs.end(), i) == handleIndexs.end());
			handleIndexs.push_back(i);
		}
#endif
#endif

		gxAssert(startIndex < endIndex);
		gxAssert(startIndex >= 0);
		gxAssert(endIndex <= packParse.getPackNum());

		if(startIndex >=  endIndex || endIndex > packParse.getPackNum() || packParse.getPackLen(startIndex, endIndex) <= 0)
		{
			gxError("Compess prototcol err!");
		}

		// 将包拷贝到临时数据中
		tempBuff.resize(sizeof(MCCompress)+packParse.getPackLen(startIndex, endIndex));
		MCCompress tempCompressPack;
		MCCompress* pCompress = (MCCompress*)&(tempBuff[0]);
		*pCompress = tempCompressPack;
		pCompress->msg.pushBack(packParse.getPack(startIndex), packParse.getPackLen(startIndex, endIndex));
		sendNum += (endIndex-startIndex);
		pCompress->getPackLen();
		gxAssert(pCompress->msg.size() == packParse.getPackLen(startIndex, endIndex));
		sint32 tempOutLen = outLen;
		sint32 retCode = GXMISC::ISocketPacketHandler::onBeforeFlushToSocket((const char*)pCompress, pCompress->getPackLen(), outBuff, tempOutLen);
		if(GXMISC::ISocketPacketHandler::PACK_HANDLE_OK != retCode)
		{
			return retCode;
		}
	}

#ifdef LIB_DEBUG
#if COMPRE_INDEX_DEBUG
	gxAssert((sint32)handleIndexs.size() == packParse.getPackNum());
#endif
#endif

	if(sendNum != packParse.getPackNum())
	{
		gxError("Compess prototcol err!");
	}

	gxAssert(index == packParse.getPackNum());
	return GXMISC::ISocketPacketHandler::PACK_HANDLE_OK;

}

sint32 CGameSocketPacketHandler::onAfterReadFromSocket(const char* buff, sint32 len, char* outBuff, sint32& outLen)
{
	CBasePackHandleAry packParse;
	if(!packParse.parse(buff, len))
	{
		return GXMISC::ISocketPacketHandler::PACK_HANDLE_ERR;
	}

	if(packParse.getPackNum() != 1)
	{
		return GXMISC::ISocketPacketHandler::PACK_HANDLE_ERR;
	}

	sint32 retCode = GXMISC::ISocketPacketHandler::onAfterReadFromSocket(buff, len, outBuff, outLen);
	if(retCode != GXMISC::ISocketPacketHandler::PACK_HANDLE_OK)
	{
		return retCode;
	}

	CBasePacket* pBasePack = (CBasePacket*)outBuff;
	if(pBasePack->packetID == PACKET_MC_COMPRESS)
	{
		std::vector<char> tempBuff;
		// 压缩协议
		MCCompress* pCompress = (MCCompress*)pBasePack;
		if(pCompress->msg.sizeInBytesNoLen() != 0)
		{
			tempBuff.resize(pCompress->msg.sizeInBytesNoLen());
			memcpy(&(tempBuff[0]), pCompress->msg.data(), pCompress->msg.sizeInBytesNoLen());
			memcpy(outBuff, &(tempBuff[0]), tempBuff.size());
		}
		else
		{
			gxError("Pack handle err, Zip prototcol len=0!");
		}
		outLen = (sint32)tempBuff.size();
	}

	return GXMISC::ISocketPacketHandler::PACK_HANDLE_OK;
}

sint32 CGameSocketPacketHandler::doCompress(const char* buff, sint32 len, char* outBuff, sint32& outLen)
{
	// 输入头
	CBasePacket basePack = *((CBasePacket*)buff);
	const char* pInBuff = (buff+sizeof(CBasePacket));
	sint32 pInLen = len-sizeof(CBasePacket);

	// 输出头
	char* pOutBuff = (outBuff+sizeof(CBasePacket));
	sint32 pOutLen = outLen-sizeof(CBasePacket);

	if(_attr.compress)
	{
		// 压缩
		if(_attr.compressLen < pInLen)
		{
			sint32 tempOutLen = compressBound(pInLen);
			if(tempOutLen > pOutLen)
			{
				// 缓冲区不够
				return GXMISC::ISocketPacketHandler::PACK_HANDLE_NO_BUFF;
			}

			Bytef* pTempInBuff = (Bytef*)pInBuff;										// 压缩数据
			Bytef* pTempOutBuff = (Bytef*)(pOutBuff);									// 压缩后数据输出到缓冲区
			sint32 tempInLen = pInLen;													// 输入长度
			sint32 retCode = compress(pTempOutBuff, (uLongf*)&tempOutLen, pTempInBuff, tempInLen);
			switch(retCode)
			{
			case Z_OK:
				break; 
			case Z_MEM_ERROR:
				{
					return GXMISC::ISocketPacketHandler::PACK_HANDLE_ERR;
				}
			case Z_BUF_ERROR:
				{
					return GXMISC::ISocketPacketHandler::PACK_HANDLE_NO_BUFF;
				}
			}

			pOutLen = tempOutLen;													// 压缩后的协议包长度
			basePack.setCompressed();												// 压缩标记
		}
		else
		{
			// 直接拷贝
			memcpy(pOutBuff, pInBuff, pInLen);
			pOutLen = pInLen;
		}
	}
	else
	{
		// 直接拷贝
		memcpy(pOutBuff, pInBuff, pInLen);
		pOutLen = pInLen;
	}

	// 写入协议头
	basePack.totalLen = (TPackLen_t)(sizeof(CBasePacket)+pOutLen);
	memcpy(outBuff, (const char*)(&basePack), sizeof(CBasePacket));
	outLen = basePack.totalLen;

	return GXMISC::ISocketPacketHandler::PACK_HANDLE_OK;
}

sint32 CGameSocketPacketHandler::doEncrypt(const char* buff, sint32 len, char* outBuff, sint32& outLen)
{
	return GXMISC::ISocketPacketHandler::PACK_HANDLE_OK;
}

// 截出来的单个包
sint32 CGameSocketPacketHandler::onPackBeforeFlushToSocket(const char* buff, sint32 len, char* outBuff, sint32& outLen)
{
	const char* pTempInBuff = buff;
	sint32 tempInBuffLen = len;

	CBasePacket* pBasePack = (CBasePacket*)buff;
	gxAssert(pBasePack->totalLen <= outLen);
	if(pBasePack->getPacketID() != PACKET_MC_COMPRESS)
	{
		onSendPack(buff, len, true);
	}

	if(_attr.compress)
	{
		sint32 retCode = doCompress(buff, len, outBuff, outLen);
		if(GXMISC::ISocketPacketHandler::PACK_HANDLE_OK != retCode)
		{
			return retCode;
		}

		pTempInBuff = outBuff;
		tempInBuffLen = outLen;
	}

	// 加密
	if(_attr.encrypt)
	{
		// 			char* pEncryptInBuff = new char[tempInBuffLen];
		// 			sint32 encryptBuffLen = tempInBuffLen;
		// 			memcpy(pEncryptInBuff, pTempInBuff, tempInBuffLen);
		// 			sint32 retCode = doEncrypt(pEncryptInBuff, encryptBuffLen, outBuff, outLen);
		// 			if(retCode != PACK_HANDLE_OK)
		// 			{
		// 				delete [] pEncryptInBuff;
		// 				return retCode;
		// 			}
		// 
		// 			delete [] pEncryptInBuff;
	}

	return GXMISC::ISocketPacketHandler::PACK_HANDLE_OK;
}

sint32 CGameSocketPacketHandler::onPackAfterFromSocket(const char* buff, sint32 len, char* outBuff, sint32& outLen)
{
	// 解密
	if(_attr.encrypt)
	{
	}

	// 输入头
	CBasePacket basePack = *((CBasePacket*)buff);
	const char* pInBuff = (buff+sizeof(CBasePacket));
	sint32 pInLen = len-sizeof(CBasePacket);

	// 输出头
	char* pOutBuff = (outBuff+sizeof(CBasePacket));
	sint32 pOutLen = outLen-sizeof(CBasePacket);

	// 解压缩
	if(_attr.compress)
	{
		if(basePack.isCompress())
		{
			Bytef* pTempInBuff = (Bytef*)(pInBuff);
			Bytef* pTempOutBuff = (Bytef*)(pOutBuff);
			sint32 tempOutLen = pOutLen;
			sint32 tempInLen = pInLen;
			sint32 retCode = uncompress(pTempOutBuff, (uLongf*)&tempOutLen, pTempInBuff, tempInLen);
			switch(retCode)
			{
			case Z_OK:
				break; 
			case Z_MEM_ERROR:
				{
					return GXMISC::ISocketPacketHandler::PACK_HANDLE_ERR;
				}
			case Z_BUF_ERROR:
				{
					return GXMISC::ISocketPacketHandler::PACK_HANDLE_NO_BUFF;
				}
			}

			pOutLen = tempOutLen;
			basePack.setUnCompressed();
		}
		else
		{
			// 直接拷贝
			memcpy(pOutBuff, pInBuff, pInLen);
			pOutLen = pInLen;
		}
	}
	else
	{
		// 直接拷贝
		memcpy(pOutBuff, pInBuff, pInLen);
		pOutLen = pInLen;
	}

	// 包处理完成, 拷贝协议头
	basePack.totalLen = (TPackLen_t)(sizeof(CBasePacket)+pOutLen);
	memcpy(outBuff, (const char*)(&basePack), sizeof(CBasePacket));
	outLen = basePack.totalLen;

	return GXMISC::ISocketPacketHandler::PACK_HANDLE_OK;
}

sint32 CGameSocketPacketHandler::canUnpacket()
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

sint32 CGameSocketPacketHandler::getPackHeaderLen()
{
	return sizeof(CBasePacket);
}

sint32 CGameSocketPacketHandler::getMaxVarPackLen(const char* buff)
{
	CBasePacket* packet = (CBasePacket*)buff;
	TUnpacketIDHandler* handler = getUnpacketHandler(packet->packetID);
	if(handler != NULL)
	{
		return handler->packMaxLen;
	}

	return 0;
}

bool CGameSocketPacketHandler::isVarPacket( const char* buff, sint32 len )
{
	if(len < (sint32)sizeof(CBasePacket)){
		return false;
	}

	CBasePacket* packet = (CBasePacket*)buff;
	return HandlerHashs.find(packet->packetID) != HandlerHashs.end();
}

void CGameSocketPacketHandler::Setup()
{
	HandlerHashs.clear();
	for(uint32 i = 0; i < UnpacketHandlerNum; ++i){
		HandlerHashs.insert(std::pair<TPacketID_t, TUnpacketIDHandler>(UnpacketHandlers[i].pid, UnpacketHandlers[i]));
	}
}

TUnpacketIDHandler* CGameSocketPacketHandler::getUnpacketHandler(TPacketID_t packetID)
{
	TUnpacketHandlerHash::iterator iter = HandlerHashs.find(packetID);
	if(iter != HandlerHashs.end())
	{
		return &iter->second;
	}

	return NULL;
}

void CGameSocketPacketHandler::onHandleVarUnpacket( char* buff, const char* varBuff, sint32 len )
{
	CBasePacket* packet = (CBasePacket*)varBuff;
	TUnpacketIDHandler* handler = getUnpacketHandler(packet->getPacketID());
	if(NULL == handler)
	{
		gxAssert(false);
		return;
	}

	if(!handler->func((CBasePacket*)(buff), varBuff, len))
	{
		gxAssert(false);
		return;
	}
}
