--[[
class: UIAction
inherit: none
desc: 一些动作合集
author：changao
date: 2014-06-14
example：
	local image = UIImage.new("#button.png", CCSize(200, 180), true)
	UIAction.shrink(image)
	UIAction.shrinkRecover(image)
	UIAction.disappear(image)
	UIAction.appear(image)
	UIAction.setTransparent(image)
	UIAction.setTranslucent(image)
	UIAction.setOpaque(image)
]]--
local UIAction = class("UIAction") 

--[[
@brief 按比例缩小
@param node CCNode
@param onComplete function
@param delay number 
@return CCAction 
]]
function UIAction.shrink(node, onComplete, delay)
	return transition.scaleTo(node, {time=0.15, scale=0.85, delay=delay, onComplete=onComplete})
end

--[[
@brief 按比例缩小
@param node CCNode
@param onComplete function
@param delay number 
@return CCAction 
--]]
--[[
function UIAction.shrinkScale(node, scale, onComplete, delay)
	return transition.scaleTo(node, {time=0.15, scale=scale, delay=delay, onComplete=onComplete})
end
--]]

--[[
@brief 缩小后恢复原状时， 调用。
@param node CCNode
@param onComplete function
@param delay number 
@return CCAction 
]]
function UIAction.shrinkRecover(node, onComplete, delay)
	return transition.scaleTo(node, {time=0.25, scale=1, easing="backout", delay=delay, onComplete=onComplete})
end

--[[
@brief 节点出现， 变大到正常
@param node CCNode
@param onComplete function
@param delay number 
@return CCAction 
]]
function UIAction.appear(node, onComplete, delay)
	local actionBegin = CCScaleTo:create(0, 0.2)
	local action = CCScaleTo:create(0.25, 1)
	local seq = transition.sequence({actionBegin, action})
	return transition.execute(node, seq, {easing="backout", delay=delay, onComplete=onComplete})
end

--[[
@brief 节点缩小至消失
@param node CCNode
@param onComplete function
@param delay number 
@return CCAction 
]]
function UIAction.disappear(node, onComplete, delay)
	local action = CCScaleTo:create(0.25, 0.2)
	local actionEnd = CCScaleTo:create(0, 0)
	local seq = transition.sequence({action, actionEnd})
	return transition.execute(node, seq, {delay=delay, onComplete=onComplete})
end

--[[
@brief 设置节点不透明度
@param node CCNode
@param opacity
@return CCAction 
]]
function UIAction.setOpacity(node, opacity)
	return transition.fadeTo(node, {time=0, opacity=opacity})
end

--[[
@brief 设置节点不透明
@param node CCNode
@return CCAction 
]]
function UIAction.setOpaque(node)
	return UIAction.setOpacity(node, 255)
end

--[[
@brief 设置节点半透明
@param node CCNode
@return CCAction 
]]
function UIAction.setTranslucent(node)
	return UIAction.setOpacity(node, 112)
end

--[[
@brief 设置节点完全透明
@param node CCNode
@return CCAction 
]]
function UIAction.setTransparent(node)
	return UIAction.setOpacity(node, 0)
end

return UIAction