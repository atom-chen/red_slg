@echo off

@rem ����cpp��ʱĿ¼
@if exist cppfile ( rd /Q /S cppfile )
@mkdir cppfile

@rem ���ô���Ŀ¼
@set codepath=..\..\..\trunk\server\sharelib\src\
@set curPath=%~dp0
@if [%1] neq [] (set codepath=%~dp0%1\)

@rem ��ȡ�ĵ��������ò���������
@call readconfig.bat config.ini doc_config doc_config
@if exist %codepath%%doc_config% ( copy "%codepath%%doc_config%" . /Y )  else exit

@rem ��ȡ���еĽ�
@call readconfig.bat config.ini sections sections

@rem ���������ļ���Ŀ¼
@for %%s in (%sections%) do @ (
	@for /F "eol=; tokens=1,2 delims== " %%i in (%doc_config%) do @(
		@if %%s==%%i (
			for %%f in (%%j) do @(
				@if exist "%codepath%%%f" ( copy "%codepath%%%f" cppfile\ /Y )
			)
		)
	)
)

@rem �����ļ�Ŀ¼
@if exist doc ( @rd /Q /S doc )
@mkdir doc

@rem �����luaʹ�õ��ļ�
@SETLOCAL ENABLEDELAYEDEXPANSION
@set luaname=exe\FilterCppFiles.lua
@set luabakname=exe\FilterCppFiles.bak
@set luaendname=exe\FilterCppFileEnd.bak
@if exist %luaname% ( del /Q %luaname% )
@echo off > %luaname%
@FOR /F "tokens=*" %%i in (%luabakname%) do @(
	@echo %%i >> %luaname%
)
@echo. >> %luaname%
@for %%s in (%sections%) do @ (
	@set filelist=%%s = {
	@for /F "eol=; tokens=1,2 delims== " %%i in (doc_config.ini) do @(
		@if %%s==%%i (
			for %%f in (%%j) do @(
				@set filelist=!filelist!"%%f",
			)
		)
	)
	@set filelist=!filelist!};
	@echo !filelist! >> %luaname%
)
@echo. >> %luaname%
@FOR /F "tokens=*" %%i in (%luaendname%) do @(
	@echo %%i >> %luaname%
)

@rem ���ɴ��packet.h�ļ�
@cd exe
@lua.exe CppToDoxy.lua
::@move /Y packet.h ..\doc\packet.h.bak
@move /Y packet.h ..\doc\packet.h
::@iconv.exe -f GB2312 -t UTF-8 ..\doc\packet.h.bak > ..\doc\packet.h

@rem ����doxygen�����ĵ�
@doxygen.exe Doxyfile.ini

@rem ɾ��packet.h
@del /Q ..\doc\packet.h.bak
@del /Q ..\doc\packet.h

@rem ִ��html�滻�ű�
@lua.exe DoxyHtmlReplace.lua

@rem ɾ��cpp�ļ�
@cd ..
@if exist cppfile ( rd /Q /S cppfile )

@rem �滻index.html�ļ�
@if exist doc\packet\index.html.html (
	del /Q doc\packet\index.html
	move /Y doc\packet\index.html.html doc\packet\index.html
)

@if exist %luaname% ( del /Q %luaname% )
@if exist %doc_config% ( del /Q %doc_config% )