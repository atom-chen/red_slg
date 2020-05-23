
lua QQFTZ_file_handle.lua
if %errorlevel% neq 0 goto ERROR
goto SUCCESS
:ERROR
pause
:SUCCESS