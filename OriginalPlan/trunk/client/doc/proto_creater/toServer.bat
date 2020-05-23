@echo off
lua toServer.lua

echo "复制生成文件..."
set LOGIN=E:\server\trunk\loginserver\src\proto
set GAME=E:\server\trunk\gameserver\src\proto
copy s\proto_1.erl %LOGIN%
copy s\proto_1.erl %GAME%
copy s\proto_2.erl %LOGIN%
copy s\proto_3.erl %GAME%
copy s\proto_4.erl %GAME%
echo "完成
pause
