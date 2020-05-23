-------------------------------------------------------------------------=---
-- Name:        dialog.wx.lua
-- Purpose:     Dialog wxLua sample, a temperature converter
--              Based on the C++ version by Marco Ghislanzoni
-- Author:      J Winwood, John Labenski
-- Created:     March 2002
-- Copyright:   (c) 2001 Lomtick Software. All rights reserved.
-- Licence:     wxWidgets licence
-------------------------------------------------------------------------=---

-- Load the wxLua module, does nothing if running from wxLua, wxLuaFreeze, or wxLuaEdit
package.cpath = package.cpath..";./?.dll;./?.so;../lib/?.so;../lib/vc_dll/?.dll;../lib/bcc_dll/?.dll;../lib/mingw_dll/?.dll;"
require("wx")

-- IDs of the controls in the dialog
ID_HOST_ADDR      		= 1  	-- IP地址
ID_HOST_PORT    			= 2  	-- 端口
ID_ACCOUNT_ID       	= 3		-- 账号ID
ID_OPEN_DYNAMIC_MAP   = 4		-- 开启副本
ID_CHANGE_MAP   			= 5		-- 切换地图
ID_LOGIN_GAME					= 6		-- 登陆游戏
ID_DYNAMIC_MAP_ID			= 7		-- 副本ID
ID_NORMAL_MAP_ID			= 8		-- 普通场景ID
ID_LOG_LIST_BOX				= 9		-- 日志列表框
ID_SERVER_TIMER				= 10	-- 服务器更新定时器

-- Create the dialog, there's no reason why we couldn't use a wxFrame and
-- a frame would probably be a better choice.
dialog = wx.wxDialog(wx.NULL, wx.wxID_ANY, "游戏测试客户端",
                     wx.wxDefaultPosition, wx.wxDefaultSize)

-- Create a wxPanel to contain all the buttons. It's a good idea to always
-- create a single child window for top level windows (frames, dialogs) since
-- by default the top level window will want to expand the child to fill the
-- whole client area. The wxPanel also gives us keyboard navigation with TAB key.
panel = wx.wxPanel(dialog, wx.wxID_ANY)

-- Layout all the buttons using wxSizers
local mainSizer = wx.wxBoxSizer(wx.wxVERTICAL)

---------------------------------------
--- 登陆
local loginSizer  = wx.wxFlexGridSizer( 0, 5, 5, 15 )
--loginSizer:AddGrowableCol(1, 0)
local staticText = wx.wxStaticText( panel, wx.wxID_ANY, "登陆：")
local hostIP = wx.wxTextCtrl( panel, ID_HOST_ADDR, "127.0.0.1", wx.wxDefaultPosition, wx.wxDefaultSize, wx.wxTE_PROCESS_ENTER )
local hostPort = wx.wxTextCtrl( panel, ID_HOST_PORT, "7010", wx.wxDefaultPosition, wx.wxDefaultSize, wx.wxTE_PROCESS_ENTER )
local accountTxt   = wx.wxTextCtrl( panel, ID_ACCOUNT_ID, "11", wx.wxDefaultPosition, wx.wxDefaultSize, wx.wxTE_PROCESS_ENTER )
local loginBut     = wx.wxButton( panel, ID_LOGIN_GAME, "登陆")
loginSizer:Add( staticText, 0, wx.wxALIGN_CENTER_VERTICAL+wx.wxALL, 5 )
loginSizer:Add( hostIP, 0, wx.wxALIGN_CENTER_VERTICAL+wx.wxALL, 5 )
loginSizer:Add( hostPort, 0, wx.wxALIGN_CENTER_VERTICAL+wx.wxALL, 5 )
loginSizer:Add( accountTxt, 0, wx.wxALIGN_CENTER_VERTICAL+wx.wxALL, 5 )
loginSizer:Add( loginBut, 0, wx.wxALIGN_CENTER_VERTICAL+wx.wxALL, 5 )

---------------------------------------
--- 副本
--local sceneSizeer = wx.wxFlexGridSizer( 0, 3, 0, 0 )
--sceneSizeer:AddGrowableCol(1, 0)
local sceneSizeer = loginSizer
staticText = wx.wxStaticText( panel, wx.wxID_ANY, "开启副本：")
local dynaMapID = wx.wxTextCtrl( panel, ID_DYNAMIC_MAP_ID, "1001", wx.wxDefaultPosition, wx.wxDefaultSize, wx.wxTE_PROCESS_ENTER )
local openDynaMap = wx.wxButton( panel, ID_OPEN_DYNAMIC_MAP, "开启")
sceneSizeer:Add( staticText, 0, wx.wxALIGN_CENTER_VERTICAL+wx.wxALL, 5 )
sceneSizeer:Add( dynaMapID, 0, wx.wxALIGN_CENTER_VERTICAL+wx.wxALL, 5 )
staticText = wx.wxStaticText( panel, wx.wxID_ANY, "")
sceneSizeer:Add( staticText, 0, wx.wxALIGN_CENTER_VERTICAL+wx.wxALL, 5 )
sceneSizeer:Add( staticText, 0, wx.wxALIGN_CENTER_VERTICAL+wx.wxALL, 5 )
sceneSizeer:Add( openDynaMap, 0, wx.wxALIGN_CENTER_VERTICAL+wx.wxALL, 5 )

--- 切换场景
--sceneSizeer:AddGrowableCol(1, 0)
staticText = wx.wxStaticText( panel, wx.wxID_ANY, "切换场景：")
local mapID = wx.wxTextCtrl( panel, ID_NORMAL_MAP_ID, "10001", wx.wxDefaultPosition, wx.wxDefaultSize, wx.wxTE_PROCESS_ENTER )
local changeMap = wx.wxButton( panel, ID_CHANGE_MAP, "切换")
sceneSizeer:Add( staticText, 0, wx.wxALIGN_CENTER_VERTICAL+wx.wxALL, 5 )
sceneSizeer:Add( mapID, 0, wx.wxALIGN_CENTER_VERTICAL+wx.wxALL, 5 )
staticText = wx.wxStaticText( panel, wx.wxID_ANY, "")
sceneSizeer:Add( staticText, 0, wx.wxALIGN_CENTER_VERTICAL+wx.wxALL, 5 )
sceneSizeer:Add( staticText, 0, wx.wxALIGN_CENTER_VERTICAL+wx.wxALL, 5 )
sceneSizeer:Add( changeMap, 0, wx.wxALIGN_CENTER_VERTICAL+wx.wxALL, 5 )

---------------------------------------
--- 道具

---------------------------------------
--- 日志输出
local logSizeer = wx.wxFlexGridSizer( 0, 2, 0, 17 )
staticText = wx.wxStaticText(panel, wx.wxID_ANY, "日志输出：")
size = wx.wxSize(705, 350);
logListBox = wx.wxListBox(panel,ID_LOG_LIST_BOX,wx.wxDefaultPosition,size,{},wx.wxLB_EXTENDED)
logSizeer:Add(staticText, 0, wx.wxALIGN_CENTER_VERTICAL+wx.wxALL, 5)
logSizeer:Add(logListBox, 0, wx.wxALIGN_CENTER_VERTICAL+wx.wxALL, 5)

mainSizer:Add( loginSizer, 0, wx.wxGROW+wx.wxALIGN_CENTER+wx.wxALL, 5 )
mainSizer:Add( logSizeer, 1, wx.wxGROW+wx.wxALIGN_CENTER+wx.wxALL, 5 )

panel:SetSizer( mainSizer )
mainSizer:SetSizeHints( dialog )

app = wx.wxGetApp();
dialog:Connect(wx.wxEVT_CLOSE_WINDOW,
    function (event)
        dialog:Destroy()
        event:Skip()
				app:ExitMainLoop();
    end)
	
ClientServer = nil;

function AddLogString(tempStr)
	local str = wx.wxArrayString();
	str:Add(tempStr);
	logListBox:InsertItems(str, 0);
end

dialog:Connect(ID_LOGIN_GAME, wx.wxEVT_COMMAND_BUTTON_CLICKED,
	function(event)
		loginBut:Disable();
		arg[1] = accountTxt:GetValue();
		require "client"
		ClientServer = server;
		changeMap:Disable();
	end
)

dialog:Connect(ID_OPEN_DYNAMIC_MAP, wx.wxEVT_COMMAND_BUTTON_CLICKED,
	function(event)
		changeMap:Enable(true);
		openDynaMap:Disable();
		ClientPlayer:sendOpenDynamicMap();
	end
)

dialog:Connect(ID_CHANGE_MAP, wx.wxEVT_COMMAND_BUTTON_CLICKED,
	function(event)
		changeMap:Disable();
		openDynaMap:Enable(true);
		ClientPlayer:sendChangeMap();
	end
)

-- 定时更新
local breathInterval = 20;
function timerServerBreath(event)
	if nil ~= ClientServer then
		ClientServer:loop(0);
	end
end
	
-- ---------------------------------------------------------------------------
-- Centre the dialog on the screen
dialog:Centre()
-- Show the dialog
dialog:Show(true)

local gstimer = wx.wxTimer(app, ID_SERVER_TIMER)
	app:Connect(ID_SERVER_TIMER, wx.wxEVT_TIMER,
		timerServerBreath
	);
gstimer:Start(breathInterval)

-- Call wx.wxGetApp():MainLoop() last to start the wxWidgets event loop,
-- otherwise the wxLua program will exit immediately.
-- Does nothing if running from wxLua, wxLuaFreeze, or wxLuaEdit since the
-- MainLoop is already running or will be started by the C++ program.
app:MainLoop()
