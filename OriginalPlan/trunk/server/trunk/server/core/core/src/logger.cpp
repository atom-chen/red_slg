#include "stdcore.h"
#include "types_def.h"

#ifdef OS_WINDOWS
#	include <process.h>
#else
#	include <unistd.h>
#endif

#include "logger.h"
#include "string_common.h"
#include "common.h"
#include "displayer.h"
#include "debug.h"
#include "path.h"

namespace GXMISC
{
	std::string CLogger::_processName = "<Unknown>";

	CLogger::CLogger() : _logType (LOG_NO), _fileName(NULL), _line(-1), _funcName(NULL), _lockSet(false)
	{
	}

	void CLogger::SetDefaultProcessName ()
	{
#ifdef OS_WINDOWS
		if ((_processName).empty())
		{
			char name[1024];
			GetModuleFileNameA (NULL, name, 1023); // @TODO UNICODE
			_processName = CFile::GetFilename(name);
		}
#else
		if ((_processName).empty())
		{
			_processName = "<Unknown>";
		}
#endif
	}

	void CLogger::SetProcessName (const std::string &processName)
	{
		_processName = processName;
	}

	void CLogger::setPosition (ELogType logType, bool unrepeat, sint32 line, const char *fileName, const char *funcName, const char* module, bool isSync)
	{
		if ( !noDisplayer() )
		{
            enter();
            _lastFileName = _lastFileName;
            _lastLine = _line;
            _lastFuncName = _funcName;
			_lastModuleName = _moduleName;

            _logType = logType;
            _unrepeat = unrepeat;
			_lockSet++;
			_fileName = fileName;
			_line = line;
			_funcName = funcName;
			_moduleName = module;
            _sync = isSync;
		}
	}

	/// Symetric to setPosition(). Automatically called by display...(). Do not call if noDisplayer().
	void CLogger::unsetPosition()
	{
		assert( !noDisplayer() );

		if ( _lockSet > 0 )
		{
            _lastFileName = _lastFileName;
            _lastLine = _line;
            _lastFuncName = _funcName;
            _lastModuleName = _moduleName;

            _logType = LOG_NO;
            _unrepeat = false;
            _fileName = NULL;
            _line = -1;
            _funcName = NULL;
			_moduleName = NULL;
            _sync = false;

			_lockSet--;
            leave();
		}
	}


	void CLogger::addDisplayer (IDisplayer *displayer, bool bypassFilter)
	{
		if (displayer == NULL)
		{
			// Can't gxwarning because recursive call
			printf ("Trying to add a NULL displayer\n");
			return;
		}

		if (bypassFilter)
		{
			TDisplayers::iterator idi = std::find (_bypassFilterDisplayers.begin (), _bypassFilterDisplayers.end (), displayer);
			if (idi == _bypassFilterDisplayers.end ())
			{
				_bypassFilterDisplayers.push_back (displayer);
			}
			else
			{
				gxWarning ("LOG: Couldn't add the displayer, it was already added");
			}
		}
		else
		{
			TDisplayers::iterator idi = std::find (_displayers.begin (), _displayers.end (), displayer);
			if (idi == _displayers.end ())
			{
				_displayers.push_back (displayer);
			}
			else
			{
				gxWarning ("LOG: Couldn't add the displayer, it was already added");
			}
		}
	}

	void CLogger::removeDisplayer (IDisplayer *displayer)
	{
		if (displayer == NULL)
		{
			gxWarning ("LOG: Trying to remove a NULL displayer");
			return;
		}

		TDisplayers::iterator idi = std::find (_displayers.begin (), _displayers.end (), displayer);
		if (idi != _displayers.end ())
		{
			_displayers.erase (idi);
		}

		idi = std::find (_bypassFilterDisplayers.begin (), _bypassFilterDisplayers.end (), displayer);
		if (idi != _bypassFilterDisplayers.end ())
		{
			_bypassFilterDisplayers.erase (idi);
		}
	}

	void CLogger::removeDisplayer (const char *displayerName)
	{
		if (displayerName == NULL || displayerName[0] == '\0')
		{
			gxWarning ("LOG: Trying to remove an empty displayer name");
			return;
		}

		TDisplayers::iterator idi;
		for (idi = _displayers.begin (); idi != _displayers.end ();)
		{
			if ((*idi)->getName() == displayerName)
			{
				idi = _displayers.erase (idi);
			}
			else
			{
				idi++;
			}
		}

		for (idi = _bypassFilterDisplayers.begin (); idi != _bypassFilterDisplayers.end ();)
		{
			if ((*idi)->getName() == displayerName)
			{
				idi = _bypassFilterDisplayers.erase (idi);
			}
			else
			{
				idi++;
			}
		}
	}

	IDisplayer *CLogger::getDisplayer (const char *displayerName)
	{
		if (displayerName == NULL || displayerName[0] == '\0')
		{
			gxWarning ("LOG: Trying to get an empty displayer name");
			return NULL;
		}

		TDisplayers::iterator idi;
		for (idi = _displayers.begin (); idi != _displayers.end (); idi++)
		{
			if ((*idi)->getName() == displayerName)
			{
				return *idi;
			}
		}
		for (idi = _bypassFilterDisplayers.begin (); idi != _bypassFilterDisplayers.end (); idi++)
		{
			if ((*idi)->getName() == displayerName)
			{
				return *idi;
			}
		}
		return NULL;
	}

	/*
	* Returns true if the specified displayer is attached to the log object
	*/
	bool CLogger::attached(IDisplayer *displayer) const
	{
		return (find( _displayers.begin(), _displayers.end(), displayer ) != _displayers.end()) ||
			(find( _bypassFilterDisplayers.begin(), _bypassFilterDisplayers.end(), displayer ) != _bypassFilterDisplayers.end());
	}


	void CLogger::displayString (const char *str)
	{
        if(isRepeat())
        {
            return;
        }

		const char *disp = NULL;
		TDisplayInfo localargs, *args = NULL;

		SetDefaultProcessName ();

		if(strchr(str,'\n') == NULL)
		{
			if (_tempString.empty())
			{
				time (&_tempArgs._date);
				_tempArgs._logType = _logType;
				_tempArgs._processName = _processName;
				_tempArgs._threadId = gxGetThreadID();
				_tempArgs._fileName = _fileName;
				_tempArgs._line = _line;
				_tempArgs._funcName = _funcName;
				_tempArgs._moduleName = _moduleName;
				_tempArgs._callstackAndLog = "";
                _tempArgs._sync = _sync;
				
				_tempString = str;
			}
			else
			{
				_tempString += str;
			}
			return;
		}
		else
		{
			if (_tempString.empty())
			{
				time (&localargs._date);
				localargs._logType = _logType;
				localargs._processName = _processName;
				localargs._threadId = gxGetThreadID();
				localargs._fileName = _fileName;
				localargs._line = _line;
				localargs._funcName = _funcName;
				localargs._moduleName = _moduleName;
				localargs._callstackAndLog = "";
                localargs._sync = _sync;

				disp = str;
				args = &localargs;
			}
			else
			{
				_tempString += str;
				disp = _tempString.c_str();
				args = &_tempArgs;
			}
		}

		// send to all bypass filter displayers
		for (TDisplayers::iterator idi=_bypassFilterDisplayers.begin(); idi!=_bypassFilterDisplayers.end(); idi++ )
		{
			(*idi)->display( *args, disp );
		}

		// get the log at the last minute to be sure to have everything
		if(args->_logType == LOG_ERROR || args->_logType == LOG_ASSERT)
		{
            CGxContext::GetStack(args->_callstackAndLog);
		}

		if (passFilter (disp))
		{
			// Send to the attached displayers
			for (TDisplayers::iterator idi=_displayers.begin(); idi!=_displayers.end(); idi++ )
			{
				(*idi)->display( *args, disp );
			}
		}

		_tempString = "";
		unsetPosition();
	}

	/*
	* Display the string with decoration and final new line to all attached displayers
	*/
#ifdef OS_WINDOWS
	void CLogger::_displayGX (const char *format, ...)
#else
	void CLogger::displayGX (const char *format, ...)
#endif
	{
		if ( noDisplayer() )
		{
			return;
		}

		DConvertVargs (str, format, GXMISC::MAX_CSTRING_SIZE);

		if (strlen(str)<GXMISC::MAX_CSTRING_SIZE-1)
			strcat (str, "\n");
		else
			str[GXMISC::MAX_CSTRING_SIZE-2] = '\n';

		displayString (str);
	}

	/*
	* Display the string with decoration to all attached displayers
	*/
#ifdef OS_WINDOWS
	void CLogger::_display (const char *format, ...)
#else
	void CLogger::display (const char *format, ...)
#endif
	{
		if ( noDisplayer() )
		{
			return;
		}

		DConvertVargs (str, format, GXMISC::MAX_CSTRING_SIZE);

		displayString (str);
	}

	void CLogger::displayRawString (const char *str)
	{
        if(isRepeat())
        {
            return;
        }

		const char *disp = NULL;
		TDisplayInfo localargs, *args = NULL;

		CLogger::SetDefaultProcessName ();

		if(strchr(str,'\n') == NULL)
		{
			if (_tempString.empty())
			{
				localargs._date = 0;
				localargs._logType = LOG_NO;
				localargs._processName = "";
				localargs._threadId = 0;
				localargs._fileName = NULL;
				localargs._line = -1;
				localargs._callstackAndLog = "";
                
				_tempString = str;
			}
			else
			{
				_tempString += str;
			}
			return;
		}
		else
		{
			if (_tempString.empty())
			{
				localargs._date = 0;
				localargs._logType = LOG_NO;
				localargs._processName = "";
				localargs._threadId = 0;
				localargs._fileName = NULL;
				localargs._line = -1;
				localargs._callstackAndLog = "";

				disp = str;
				args = &localargs;
			}
			else
			{
				_tempString += str;
				disp = _tempString.c_str();
				args = &_tempArgs;
			}
		}

		// send to all bypass filter displayers
		for (TDisplayers::iterator idi=_bypassFilterDisplayers.begin(); idi!=_bypassFilterDisplayers.end(); idi++ )
		{
			(*idi)->display( *args, disp );
		}

		// get the log at the last minute to be sure to have everything
		if(args->_logType == LOG_ERROR || args->_logType == LOG_ASSERT)
		{
            CGxContext::GetStack(args->_callstackAndLog);
		}

		if ( passFilter( disp ) )
		{
			// Send to the attached displayers
			for ( TDisplayers::iterator idi=_displayers.begin(); idi!=_displayers.end(); idi++ )
			{
				(*idi)->display( *args, disp );
			}
		}
		_tempString = "";
		unsetPosition();
	}

	/*
	* Display a string (and nothing more) to all attached displayers
	*/
#ifdef OS_WINDOWS
	void CLogger::_displayRawGX( const char *format, ... )
#else
	void CLogger::displayRawGX( const char *format, ... )
#endif
	{
		if ( noDisplayer() )
		{
			return;
		}

		DConvertVargs (str, format, GXMISC::MAX_CSTRING_SIZE);

		if (strlen(str)<GXMISC::MAX_CSTRING_SIZE-1)
			strcat (str, "\n");
		else
			str[GXMISC::MAX_CSTRING_SIZE-2] = '\n';

		displayRawString(str);
	}

	/*
	* Display a string (and nothing more) to all attached displayers
	*/
#ifdef OS_WINDOWS
	void CLogger::_displayRaw( const char *format, ... )
#else
	void CLogger::displayRaw( const char *format, ... )
#endif
	{
		if ( noDisplayer() )
		{
			return;
		}

		DConvertVargs (str, format, GXMISC::MAX_CSTRING_SIZE);

		displayRawString(str);
	}


#ifdef OS_WINDOWS
	void CLogger::_forceDisplayRaw (const char *format, ...)
#else
	void CLogger::forceDisplayRaw (const char *format, ...)
#endif
	{
		if ( noDisplayer() )
		{
			return;
		}

		DConvertVargs (str, format, GXMISC::MAX_CSTRING_SIZE);

		TDisplayInfo args;
		TDisplayers::iterator idi;

		// send to all bypass filter displayers
		for (idi=_bypassFilterDisplayers.begin(); idi!=_bypassFilterDisplayers.end(); idi++ )
		{
			(*idi)->display( args, str );
		}

		// Send to the attached displayers
		for ( idi=_displayers.begin(); idi!=_displayers.end(); idi++ )
		{
			(*idi)->display( args, str );
		}
	}



	/*
	* Returns true if the string must be logged, according to the current filter
	*/
	bool CLogger::passFilter( const char *filter )
	{
		bool yes = _positiveFilter.empty();

		bool found;
        std::list<std::string>::iterator ilf;

		// 1. Positive filter
		for ( ilf=_positiveFilter.begin(); ilf!=_positiveFilter.end(); ++ilf )
		{
			found = ( strstr( filter, (*ilf).c_str() ) != NULL );
			if ( found )
			{
				yes = true; // positive filter passed (no need to check another one)
				break;
			}
			// else try the next one
		}
		if ( ! yes )
		{
			return false; // positive filter not passed
		}

		// 2. Negative filter
		for ( ilf=_negativeFilter.begin(); ilf!=_negativeFilter.end(); ++ilf )
		{
			found = ( strstr( filter, (*ilf).c_str() ) != NULL );
			if ( found )
			{
				return false; // negative filter not passed (no need to check another one)
			}
		}
		return true; // negative filter passed
	}


	/*
	* Removes a filter by name. Returns true if it was found.
	*/
	void CLogger::removeFilter( const char *filterstr )
	{
		if (filterstr == NULL)
		{
			_positiveFilter.clear();
			_negativeFilter.clear();
		}
		else
		{
			_positiveFilter.remove( filterstr );
			_negativeFilter.remove( filterstr );
		}
	}

	void CLogger::displayFilter( CLogger *log )
	{
		std::list<std::string>::iterator it;
		log->displayGX ("Positive Filter(s):");
		for (it = _positiveFilter.begin (); it != _positiveFilter.end (); it++)
		{
			log->displayGX ("'%s'", (*it).c_str());
		}
		log->displayGX ("Negative Filter(s):");
		for (it = _negativeFilter.begin (); it != _negativeFilter.end (); it++)
		{
			log->displayGX ("'%s'", (*it).c_str());
		}
	}

	void CLogger::addPositiveFilter( const char *filterstr )
	{
		_positiveFilter.push_back( filterstr );
	}

	void CLogger::addNegativeFilter( const char *filterstr )
	{
		_negativeFilter.push_back( filterstr );
	}

	void CLogger::resetFilters()
	{
		_positiveFilter.clear();
		_negativeFilter.clear();
	}

    CLogger::~CLogger()
    {
        for(TDisplayers::iterator iter = _displayers.begin(); iter != _displayers.end();)
        {
            if((*iter)->isNeedDeleteByLog())
            {
                IDisplayer* displayer = *iter;
                DSafeDelete(displayer);
                iter = _displayers.erase(iter);
            }
            else
            {
                iter++;
            }
        }

        for(TDisplayers::iterator iter = _bypassFilterDisplayers.begin(); iter != _bypassFilterDisplayers.end(); )
        {
            if((*iter)->isNeedDeleteByLog())
            {
                IDisplayer* displayer = *iter;
                DSafeDelete(displayer);
                iter = _bypassFilterDisplayers.erase(iter);
            }
            else
            {
                iter++;
            }
        }
    }

    bool CLogger::isRepeat()
    {
        if(_fileName == NULL || _lastFileName == NULL || _funcName == NULL || _lastFuncName == NULL)
        {
            return false;
        }

        if(_unrepeat)
        {
            return strcmp(_fileName, _lastFileName) == 0 && strcmp(_funcName, _lastFuncName) == 0 && _lastLine == _line;
        }

        return false;
    }

    void CLogger::synLog( const std::string& str )
    {
        _synMsgQue.push(str);
    }

    void CLogger::update( uint32 diff )
    {
        flush();
    }

    void CLogger::flush()
    {
        TSynMsgList lst;
        _synMsgQue.pop(lst, calcLogNum());
        for(TSynMsgList::iterator iter = lst.begin(); iter != lst.end(); ++iter)
        {
            displayRawString(iter->c_str());
        }
    }
    
    // @todo 计算日志写入的个数
    sint32 CLogger::calcLogNum()
    {
        return MAX_SINT32_NUM;
    }

} // GXMISC

