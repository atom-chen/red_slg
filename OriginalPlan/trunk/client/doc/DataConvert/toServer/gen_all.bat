@echo off

SET PATH_GAME_ERL=E:/server/trunk/gameserver/src/data
SET PATH_LOGIN_ERL=E:/server/trunk/loginserver/src/data
SET PATH_PHP=E:/server/trunk/php/sys/baseData
del /F /Q erl\*
del /F /Q php\*
python data_all.py

cp erl/*.erl %PATH_GAME_ERL%
cp php/*.php %PATH_PHP%
cp erl/data_md5.erl %PATH_LOGIN_ERL%

TortoiseProc.exe /command:commit /path:%PATH_GAME_ERL%*%PATH_LOGIN_ERL%*%PATH_PHP%

pause
