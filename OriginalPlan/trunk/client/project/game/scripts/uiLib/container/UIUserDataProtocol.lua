--[[
@brief 给UI控件扩展 UserData 的方法
@author changao
@date 2014-06-25
--]]
local UIUserDataProtocol = {}

function UIUserDataProtocol.extend(object)
	
	function object:setUserData(data)
		self._userData = data
	end
	function object:getUserData()
		return self._userData
	end
	function object:clearUserData()
		self._userData = nil
	end
	
end

return UIUserDataProtocol