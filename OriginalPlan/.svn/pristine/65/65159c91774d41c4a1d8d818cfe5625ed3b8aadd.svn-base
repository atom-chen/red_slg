cd %~dp0
for /f "delims=," %%i in ('dir /b *.py') do python %%i||goto ERROR
for /f "delims=," %%i in ('dir /b *.lua') do lua %%i||goto ERROR

:ERROR
pause
