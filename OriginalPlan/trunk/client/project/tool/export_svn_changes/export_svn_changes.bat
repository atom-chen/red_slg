
set revision_to=5700
set revision_from=5552
set repository=svn://192.168.0.253/client/project/game/res
set target=F:/pack/res
rem svn diff -r%revision_from%:%revision_to% %repository%
rem svn diff --summarize -r%revision_from%:%revision_to% %repository%
rem svn diff --summarize -r%revision_from% %repository%

pushd %~dp0

export_svn_changes.py "svn://192.168.0.253/client/project/game/res" "%target%" %revision_from% %revision_to%
if %errorlevel% neq 0 goto ERROR

goto SUCCESS

:ERROR
pause

:SUCCESS
echo "success over"
