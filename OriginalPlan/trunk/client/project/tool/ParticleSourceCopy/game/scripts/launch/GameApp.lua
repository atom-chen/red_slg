require("common.CommonInit")


--配置层、数据层、显示组件库
ConfigMgr = require("config.ConfigMgr")
ModelMgr = require("model.ModelMgr")

uihelper = require("uiLib.uihelper")
ViewMgr = require("view.ViewMgr")



-- luacall = require("launch.luacall")



local GameApp = class("GameApp")

function GameApp:startup(stage,roleInfo)
    self.mainScene = stage
    self.roleInfo = roleInfo

    --流程：加载配置->加载公共纹理->->进入主界面
    --预加载
    self._preLoader = require("launch.Preloader")
    self._preLoader:preLoad(self)

end


function GameApp:getMainScene()
    return self.mainScene
end

--预加载成功
function GameApp:starGame()
    --配置、公共纹理全部加载进来了,开始初始化游戏
    --AudioMgr:init()

    --初始化配置管理器以及资源管理器
    ConfigMgr:init()
    ModelMgr:init()
    ViewMgr:init(self.mainScene)
    -- ParticleMgr:init()

    RoleModel:setRoleInfo(self.roleInfo)
    self._preLoader:dispose()

    self:enterGame()
end


--[[--
  成功进入游戏，开始一些后台逻辑处理，同时进入界面：
  1)一般是进入主城
  2)也有可能时断线重练，需要直接进入战斗界面
]]
function GameApp:enterGame()
   --ModelMgr:startDailyRefresh()
   
   ViewMgr:open(Panel.TEST)   --进入主城
end

return GameApp