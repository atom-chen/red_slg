set system=%1
echo %system%
%bin% --sheet %program%\project\game\res\ui\%system%\%system%.pvr.ccz --data %program%\project\game\res\ui\%system%\%system%.plist --format cocos2d --max-size 2048 --trim-mode None --size-constraints AnySize --opt RGBA8888 --disable-rotation --padding 1 %program%\project\assets\ui\%system%\
if %errorlevel% neq 0 goto ERROR
goto SUCCESS

:ERROR
pause

:SUCCESS
