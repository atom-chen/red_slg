#ifndef _SCRIPT_BASE_H_
#define _SCRIPT_BASE_H_

#include "types_def.h"

namespace GXMISC{
	template<typename TIncInstance, typename TScriptState>
	class CScriptBase
	{
	public:
		CScriptBase() 
			: _scriptState(NULL)
			, _errFn(0)
			, _nParseStatus(-1)
			, _inc(NULL)
			,_initScriptFileName("")
		{
		}

		virtual ~CScriptBase(){
			_inc = NULL;
		}

	public:
		TScriptState* getState() const{
			return _scriptState;
		}

		inline sint32 getErrorFn() const{
			return _errFn;
		}

		inline sint32 getParseStatus() const{
			return _nParseStatus;
		}

	public:
		virtual bool init(TScriptState* pState) = 0;
		virtual bool doScript() = 0;
		virtual bool loadFileToBuffer(TScriptState *L, const char *filename, char* szbuffer, int &maxlen, bool& loadlocal) = 0;
		virtual bool doFile(const char* filename) = 0;
		virtual bool doString(const char* buffer) = 0;
		virtual bool doBuffer(const char* buffer, size_t size) = 0;
		virtual bool isExistFunction(const char* name) = 0;
		virtual bool initScript(const char* fileName) = 0;
		virtual bool uninitScript() = 0;

	public:
		static void ExportScriptAPI();

#include "script_base.inl"

	protected:
		TScriptState *_scriptState;			// �ű������
		sint32 _errFn;						// ������
		sint32 _nParseStatus;				// �ű�����״̬
		TIncInstance* _inc;					// ����ʵ��
		std::string _initScriptFileName;	// ��ʼ���ű�����
	};

	template<typename TIncInstance, typename TScriptState>
	void GXMISC::CScriptBase<TIncInstance, TScriptState>::ExportScriptAPI()
	{
		TIncInstance::ExportAPI();
	}
}

#endif