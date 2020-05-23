#ifndef _GM_LOG_H_
#define _GM_LOG_H_

#include "core/displayer.h"

class CGmFileLog : public GXMISC::CFileDisplayer
{
public:
	/// Constructor
	CGmFileLog (bool needDeleteByLog, const std::string &displayerName, const uint32 size = GXMISC::LOG_SINGLE_FILE_SIZE,
		bool eraseLastLog = false, bool raw = false) : GXMISC::CFileDisplayer(needDeleteByLog, displayerName, size, eraseLastLog, raw){}

	CGmFileLog (bool needDeleteByLog) : GXMISC::CFileDisplayer(needDeleteByLog){}
	~CGmFileLog (){}

public:
	virtual void doDisplay( const GXMISC::CLogger::TDisplayInfo& args, const char *message )
	{
		if(args._logType == GXMISC::CLogger::LOG_GM)
		{
			CFileDisplayer::doDisplay(args, message);
		}
	}
};

#endif