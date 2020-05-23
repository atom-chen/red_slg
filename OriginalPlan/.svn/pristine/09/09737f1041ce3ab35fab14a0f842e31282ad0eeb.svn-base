#ifndef _STAT_LOG_H_
#define _STAT_LOG_H_

#include "core/displayer.h"

class CStatFileLog : public GXMISC::CFileDisplayer
{
public:
	/// Constructor
	CStatFileLog (bool needDeleteByLog, const std::string &displayerName, const uint32 size = GXMISC::LOG_SINGLE_FILE_SIZE,
		bool eraseLastLog = false, bool raw = false) : GXMISC::CFileDisplayer(needDeleteByLog, displayerName, size, eraseLastLog, raw){}

	CStatFileLog (bool needDeleteByLog) : GXMISC::CFileDisplayer(needDeleteByLog){}
	~CStatFileLog (){}

public:
	virtual void doDisplay( const GXMISC::CLogger::TDisplayInfo& args, const char *message )
	{
		if(args._logType == GXMISC::CLogger::LOG_STAT)
		{
			CFileDisplayer::doDisplay(args, message);
		}
	}
};

#endif // STAT_LOG_H_