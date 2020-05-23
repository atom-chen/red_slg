#ifndef _ERROR_LOG_H_
#define _ERROR_LOG_H_

#include "core/displayer.h"
#include "core/base_util.h"

class CErrorFileLog : public GXMISC::CFileDisplayer
{
public:
	/// Constructor
	CErrorFileLog (bool needDeleteByLog, const std::string &displayerName, const uint32 size = GXMISC::LOG_SINGLE_FILE_SIZE,
		bool eraseLastLog = false, bool raw = false) : GXMISC::CFileDisplayer(needDeleteByLog, displayerName, size, eraseLastLog, raw){}

	CErrorFileLog (bool needDeleteByLog) : GXMISC::CFileDisplayer(needDeleteByLog){}
	~CErrorFileLog (){}

public:
	virtual void doDisplay( const GXMISC::CLogger::TDisplayInfo& args, const char *message )
	{
		if(args._logType == GXMISC::CLogger::LOG_ERROR)
		{
			CFileDisplayer::doDisplay(args, message);
		}
	}
};

#endif // ERROR_LOG_H_