set bin="D:\Program Files (x86)\CodeAndWeb\TexturePacker\bin\TexturePacker"
set program=%~dp0..

cd %~dp0
echo build all
set root=%~dp0
pushd %root%


svn update %program%\project\assets
svn update %program%\project\tool
svn update %program%\project\game\res


rem %bin% --sheet %program%\project\game\res\ui\frame.pvr.ccz --data %program%\project\game\res\ui\frame.plist --format cocos2d --max-size 2048 --trim-mode None --size-constraints AnySize --opt RGBA8888 --disable-rotation --padding 0 %program%\project\assets\frame\
rem if %errorlevel% neq 0 goto ERROR

%bin% --sheet %program%\project\game\res\ui\common.pvr.ccz --data %program%\project\game\res\ui\common.plist --format cocos2d --max-size 2048 --trim-mode None --size-constraints AnySize --opt RGBA8888 --disable-rotation --padding 1 %program%\project\assets\common\
if %errorlevel% neq 0 goto ERROR

rem %bin% --sheet %program%\project\game\res\ui\common2.pvr.ccz --data %program%\project\game\res\ui\common2.plist --format cocos2d --max-size 2048 --trim-mode None --size-constraints AnySize --opt RGBA8888 --disable-rotation --padding 0 %program%\project\assets\common2\
rem if %errorlevel% neq 0 goto ERROR
goto SUCCESS
:ERROR
pause

:SUCCESS
echo "over"
