@echo off

@rem 设置cpp临时目录
@if exist cppfile ( rd /Q /S cppfile )
@mkdir cppfile

@rem 设置代码目录
@set codepath=..\..\..\trunk\server\sharelib\src\
@set curPath=%~dp0
@if [%1] neq [] (set codepath=%~dp0%1\)

@rem 读取文档生成配置并拷贝过来
@call readconfig.bat config.ini doc_config doc_config
@if exist %codepath%%doc_config% ( copy "%codepath%%doc_config%" . /Y )  else exit

@rem 读取所有的节
@call readconfig.bat config.ini sections sections

@rem 拷贝所有文件到目录
@for %%s in (%sections%) do @ (
	@for /F "eol=; tokens=1,2 delims== " %%i in (%doc_config%) do @(
		@if %%s==%%i (
			for %%f in (%%j) do @(
				@if exist "%codepath%%%f" ( copy "%codepath%%%f" cppfile\ /Y )
			)
		)
	)
)

@rem 创建文件目录
@if exist doc ( @rd /Q /S doc )
@mkdir doc

@rem 重组成lua使用的文件
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

@rem 生成大的packet.h文件
@cd exe
@lua.exe CppToDoxy.lua
::@move /Y packet.h ..\doc\packet.h.bak
@move /Y packet.h ..\doc\packet.h
::@iconv.exe -f GB2312 -t UTF-8 ..\doc\packet.h.bak > ..\doc\packet.h

@rem 调用doxygen生成文档
@doxygen.exe Doxyfile.ini

@rem 删除packet.h
@del /Q ..\doc\packet.h.bak
@del /Q ..\doc\packet.h

@rem 执行html替换脚本
@lua.exe DoxyHtmlReplace.lua

@rem 删除cpp文件
@cd ..
@if exist cppfile ( rd /Q /S cppfile )

@rem 替换index.html文件
@if exist doc\packet\index.html.html (
	del /Q doc\packet\index.html
	move /Y doc\packet\index.html.html doc\packet\index.html
)

@if exist %luaname% ( del /Q %luaname% )
@if exist %doc_config% ( del /Q %doc_config% )