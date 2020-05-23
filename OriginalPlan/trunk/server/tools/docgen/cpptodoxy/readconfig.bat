@FOR /F "eol=; tokens=1,2 delims== " %%i in (%1) do @(
	@if %2==%%i set %3=%%j & exit /b 1
)

@set files=''
exit /b 0