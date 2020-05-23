set client_root=E:\program2014\client

cd %~dp0
echo build all
set root=%~dp0
pushd %root%

rem rm %client_root%\project\assets\common\*.*
rem rm %client_root%\project\assets\ui\hero\*.*

rem xcopy E:\program2014\美术输出文件\UI\魔戒英雄界面输出图\共用UI\* %client_root%\project\assets\common\ /y
rem if %errorlevel% neq 0 goto ERROR

rem xcopy E:\program2014\美术输出文件\UI\魔戒英雄界面输出图\英雄界面\*.png %client_root%\project\assets\ui\hero\ /y
rem if %errorlevel% neq 0 goto ERROR
svn update %client_root%\doc
svn update %client_root%\project\assets
svn update %client_root%\project\tool

pushd %client_root%\doc\proto_creater
call %client_root%\doc\proto_creater\toClient_nopause.bat

pushd %root%
python img2pvr.py "%client_root%\project\assets\hero" "%client_root%\project\game\res\hero"

"D:\Program Files (x86)\CodeAndWeb\TexturePacker\bin\TexturePacker" --sheet %client_root%\project\game\res\ui\common.pvr.ccz --data %client_root%\project\game\res\ui\common.plist --format cocos2d --max-size 8192 --trim-mode None --size-constraints NPOT --opt RGBA8888 --disable-rotation %client_root%\project\assets\common\
if %errorlevel% neq 0 goto ERROR

set system=hero
"D:\Program Files (x86)\CodeAndWeb\TexturePacker\bin\TexturePacker" --sheet %client_root%\project\game\res\ui\%system%\%system%.pvr.ccz --data %client_root%\project\game\res\ui\%system%\%system%.plist --format cocos2d --max-size 8192 --trim-mode None --size-constraints NPOT --opt RGBA8888 --disable-rotation %client_root%\project\assets\ui\%system%\
if %errorlevel% neq 0 goto ERROR

set system=dialog
"D:\Program Files (x86)\CodeAndWeb\TexturePacker\bin\TexturePacker" --sheet %client_root%\project\game\res\ui\%system%\%system%.pvr.ccz --data %client_root%\project\game\res\ui\%system%\%system%.plist --format cocos2d --max-size 8192 --trim-mode None --size-constraints NPOT --opt RGBA8888 --disable-rotation %client_root%\project\assets\ui\%system%\
if %errorlevel% neq 0 goto ERROR

set system=bag
"D:\Program Files (x86)\CodeAndWeb\TexturePacker\bin\TexturePacker" --sheet %client_root%\project\game\res\ui\%system%\%system%.pvr.ccz --data %client_root%\project\game\res\ui\%system%\%system%.plist --format cocos2d --max-size 8192 --trim-mode None --size-constraints NPOT --opt RGBA8888 --disable-rotation %client_root%\project\assets\ui\%system%\
if %errorlevel% neq 0 goto ERROR

set system=mail
"D:\Program Files (x86)\CodeAndWeb\TexturePacker\bin\TexturePacker" --sheet %client_root%\project\game\res\ui\%system%\%system%.pvr.ccz --data %client_root%\project\game\res\ui\%system%\%system%.plist --format cocos2d --max-size 8192 --trim-mode None --size-constraints NPOT --opt RGBA8888 --disable-rotation %client_root%\project\assets\ui\%system%\
if %errorlevel% neq 0 goto ERROR

set system=dialog
"D:\Program Files (x86)\CodeAndWeb\TexturePacker\bin\TexturePacker" --sheet %client_root%\project\game\res\ui\%system%\%system%.pvr.ccz --data %client_root%\project\game\res\ui\%system%\%system%.plist --format cocos2d --max-size 8192 --trim-mode None --size-constraints NPOT --opt RGBA8888 --disable-rotation %client_root%\project\assets\ui\%system%\
if %errorlevel% neq 0 goto ERROR

set system=fight_stat
"D:\Program Files (x86)\CodeAndWeb\TexturePacker\bin\TexturePacker" --sheet %client_root%\project\game\res\ui\%system%\%system%.pvr.ccz --data %client_root%\project\game\res\ui\%system%\%system%.plist --format cocos2d --max-size 8192 --trim-mode None --size-constraints NPOT --opt RGBA8888 --disable-rotation %client_root%\project\assets\ui\%system%\
if %errorlevel% neq 0 goto ERROR

set system=dungeon
"D:\Program Files (x86)\CodeAndWeb\TexturePacker\bin\TexturePacker" --sheet %client_root%\project\game\res\ui\%system%\%system%.pvr.ccz --data %client_root%\project\game\res\ui\%system%\%system%.plist --format cocos2d --max-size 8192 --trim-mode None --size-constraints NPOT --opt RGBA8888 --disable-rotation %client_root%\project\assets\ui\%system%\
if %errorlevel% neq 0 goto ERROR

pushd %client_root%\doc\DataConvert\toClient\
python item_to_lua.py
python item_com_to_lua.py
python hero_1_to_lua.py
python eqm_to_lua.py
python resource_to_lua.py
python skill_to_lua.py
python dialog_to_lua.py
python mail_etype_to_lua.py
python vip_to_lua.py
python vip_column_to_lua.py
lua hero_1.lua
python hero_attr_column_to_lua.py


popd
if %errorlevel% neq 0 goto ERROR

goto SUCCESS

:ERROR
pause

:SUCCESS
echo "over"
