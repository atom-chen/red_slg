#ifndef _HTTP_SOCKET_HANDLER_H_
#define _HTTP_SOCKET_HANDLER_H_

#include "buffer_socket_handler.h"

template <typename ClassName>
class CHttpHandler : public CBufferSocketHandler<ClassName>
{
public:
	typedef CBufferSocketHandler<ClassName> TBaseType;
	typedef CHttpHandler<ClassName> TMyType;
	typedef std::map<std::string, std::string> TRequestHeaderOptions;

public:
	CHttpHandler(){
		_bufferCurrentPos = 0;
		setRequestHandleTime(250);
		_requestHandleTimer.reset(true);
		_handleTimeoutTime = GXMISC::INVALID_GAME_TIME;
		_startRequestTime = GXMISC::INVALID_GAME_TIME;
	}
	virtual ~CHttpHandler(){}
public:
	virtual GXMISC::EHandleRet handle(char* msg, uint32 len)
	{
		TBaseType::handle(msg, len);

		if(this->_buffer.empty()){
			return GXMISC::HANDLE_RET_OK;
		}

		if(this->isValid()){
			handleRequest();
		}

		return GXMISC::HANDLE_RET_OK;
	}

	virtual bool handleRequest(){
		_requestHandleTimer.reset(true);
		if(!isStartHandle()){
			_startRequestTime = DTimeManager.nowSysTime();
		}
		return true;
	}

	virtual void breath(GXMISC::TDiffTime_t diff){
		TBaseType::breath(diff);
		if(_requestHandleTimer.update(diff) && isStartHandle() && needContinueHandle()){
			handleRequest();
		}

		if(isTimeout()){
			onHandleTimeout();
			this->kick();
		}
	}

	void setRequestHandleTime(GXMISC::TDiffTime_t diffs){
		_requestHandleTimer.setMaxInterval(diffs);
	}
	bool isTimeout(){
		return (DTimeManager.nowSysTime()-_startRequestTime) > _handleTimeoutTime && !this->isInvalid();
	}

	bool isStartHandle(){
		return _startRequestTime != GXMISC::INVALID_GAME_TIME;
	}
	
	bool needContinueHandle(){
		return _bufferCurrentPos < (sint32)this->_buffer.size();
	}
	virtual void onHandleTimeout(){};

	virtual bool check(){ return false; }

public:
	GXMISC::TGameTime_t getStartRequestTime() const { return _startRequestTime; }
	void setStartRequestTime(GXMISC::TGameTime_t val) { _startRequestTime = val; }
	GXMISC::TGameTime_t getHandleTimeoutTime() const { return _handleTimeoutTime; }
	void setHandleTimeoutTime(GXMISC::TGameTime_t val) { _handleTimeoutTime = val; }

protected:
	sint32				_bufferCurrentPos;				// 当前处理完的位置
	GXMISC::CManualIntervalTimer _requestHandleTimer;	// 请求处理定时器
	GXMISC::TGameTime_t _handleTimeoutTime;				// 处理请求超时时间
	GXMISC::TGameTime_t _startRequestTime;				// 开始处理请求的时间
	
};

#endif	// _HTTP_SOCKET_HANDLER_H_