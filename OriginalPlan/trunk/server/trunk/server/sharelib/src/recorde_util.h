
#ifndef _RECORDE_UTIL_H_
#define _RECORDE_UTIL_H_

#include "core/time/interval_timer.h"
#include "core/game_exception.h"

#include "packet_rx_record.h"
#include "game_util.h"
#include "module_def.h"

template <typename PacketName>
class CRecordeUtil
{
public:
	typedef GXMISC::CManualIntervalTimer RecordeTimer;
public:
	CRecordeUtil() : _isQuickRefresh(false)
	{
		cleanUp();
		_timer.init(DEFAULT_RECORDE_UPDATE_TIME);		// 10秒定时检查

		_msg.recordeData.resize((uint16)(MAX_RECORDE_SECTION_SIZE * MAX_RECORDE_SECTION_NUM));
	}

	~CRecordeUtil()
	{
		cleanUp();
	}

public:
	void					update( uint32 diff )
	{
		_timer.update(diff);
		if ( _timer.isPassed() )
		{
			++_curCount;
			_timer.reset();
			if ( checkNeedSend() )
			{
				sendRecorde();
			}
		}
	}

public:
	void					init()
	{
		_msg.recordeData.resize(MAX_RECORDE_SECTION_NUM * sizeof(TRecordeLen_t));
		TRecordeLen_t recordLen = INVALID_RECORDE_LEN;
		for ( uint8 i=0; i<MAX_RECORDE_SECTION_NUM; ++i )
		{
			char* pRecordeData = _msg.recordeData.data();
			pRecordeData += sizeof(TRecordeLen_t) * i;
			char* pTempRecordeData = (char*)&recordLen;
			memcpy(pRecordeData, pTempRecordeData, sizeof(TRecordeLen_t));
		}
	}

	void					setIsNeedSend( bool isSendNow )
	{
		_isNeedSend = isSendNow;
	}

public:
	template<typename T>
	bool					pushRecorde( TRecordeID_t id, const T& arraydata )
	{
		FUNC_BEGIN(RECORDE_MOD);

		TRecordeLen_t len = arraydata.getRecordeDataLen();
		TRecordeLen_t curLen = _msg.recordeData.size();
		TRecordeLen_t totalLen = curLen + len + sizeof(TRecordeID_t);
		if ( totalLen >= MAX_RECORDE_BUFF_SIZE || _curIndex >= (MAX_RECORDE_SECTION_NUM) )
		{
			// 消息总长度已经超过最大允许长度, 先发送数据
			sendRecorde();
			curLen = _msg.recordeData.size();
			totalLen = curLen + len + sizeof(TRecordeID_t);
			if ( totalLen >= MAX_RECORDE_BUFF_SIZE )
			{
				gxError("The packet size is larger than the max size!!! packet size = {0}, limit max size = {1}", (sint32)totalLen, (sint32)MAX_RECORDE_BUFF_SIZE);
				gxAssert(false);
				return false;
			}
		}

		// 拷贝日志ID
		gxInfo("recordeInfo id = {0} ", (uint16)id);
		char* pData = _msg.recordeData.data();
		char* pTempData = (char*)&id;
		::memcpy(pData, pTempData, sizeof(TRecordeID_t));
		pData += sizeof(TRecordeID_t);

		// 拷贝日志数组到消息内
		pTempData = (char*)&arraydata;
		::memcpy(pData, pTempData, arraydata.data.sizeInBytes());
		pData += arraydata.data.sizeInBytes();

		_msg.recordeData.resize(totalLen);	// 将消息长度置成总长度
		_curIndex++;	// 已经push了多少次

		sendRecorde();

		return true;
		FUNC_END(false);
	}

public:
	template <typename T1, typename T2>
	bool saveRecordeAry( T1& recordeAry, const T2& recordeInfo )
	{
		if(recordeAry.data.isMax())
			return true;

		recordeAry.data.pushBack(recordeInfo);
		return recordeAry.data.isMax();
	}

	template <typename T>
	void sendRecordeAry( TRecordeID_t recordeID, uint32 minNum, T& recordeAry, bool isForce )
	{
		if ( recordeAry.data.empty() )
		{
			recordeAry.data.clear();
			return ;
		}
		if ( !isForce && recordeAry.data.size() < minNum )
		{
			return ;
		}
		pushRecorde(recordeID, recordeAry);
		recordeAry.data.clear();
	}

private:
	bool					checkNeedSend()
	{
		// 数据格式为 total_recorde_len(2 byte) + recrode_id(1 byte) + recorde_data + ....
		if ( _msg.recordeData.size() <= (sizeof(TRecordeID_t) + sizeof(TRecordeLen_t) * MAX_RECORDE_SECTION_NUM) )
		{
			// 表示buff里面没有数据需要发送
			return false;
		}
		if ( _isQuickRefresh || _isNeedSend )
		{
			return true;
		}
		if ( _curCount > DEFAULT_RECORDE_MAX_TIMES )	// 最多十分钟发送BUFF里面的数据
		{
			_curCount = 0;
			return true;
		}
		if ( _msg.recordeData.size() > MIN_RECORDE_BUFF_SEND_SIZE )
		{
			_curCount = 0;
			return true;
		}
		return false;
	}

protected:
	virtual	void			sendMsgToRecorde( PacketName& msg ) = 0;

private:
	void					sendRecorde()
	{
		if(!_msg.recordeData.empty())
		{
			sendMsgToRecorde(_msg);
		}
		cleanUp();
	}

private:
	void					cleanUp()
	{
		_isNeedSend = false;
		_curIndex = 0;
		_curCount = 0;
		_msg.recordeData.clear();
	}
protected:
	bool					_isQuickRefresh;// 是否有数据立即发送

private:
	RecordeTimer			_timer;
	bool					_isNeedSend;	// 是否需要立即发送
	uint8					_curIndex;		// 当前数据索引
	uint16					_curCount;		// 当前有多少个10s没有发送同步数据
	PacketName				_msg;			// 发送的消息
};

#endif