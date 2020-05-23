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
function UIAction.shrink(node, onComplete, delay,odds, actionTime)
	if odds == nil then
		odds = 0.93
	end
	if actionTime == nil then
		actionTime = 0.05
	end
	return transition.scaleTo(node, {time=actionTime, scale=odds, delay=delay, onComplete=onComplete})
end

function UIAction.recover(node, onComplete, delay, actionTime)
	if actionTime == nil then
		actionTime = 0.05
	end
	return transition.scaleTo(node, {time=actionTime, scale=1, delay=delay, onComplete=onComplete})
end

function UIAction.flyAction(node, srcPos, destPos, duration, callback)
	node:setPosition(srcPos)
	UIAction.setMoveTo(node, destPos.x, destPos.y, duration or 1, callback)
end


--[[
function UIAction.runeAction(node, destPos, onComplete)
	local mAction = transition.moveTo(node, {x=destPos.x, y=destPos.y, time=1})
	local sAction = transition.scaleTo(sprite, {scale = 1.1, time = 0.3})
	local fAction = transition.fadeOut(sprite, {time = 0.5})
end
--]]

function UIAction.runeAction(node, destPos, onComplete, delay)
	print("function UIAction.runeAction(node, destPos, onComplete, delay)")
	--return transition.scaleTo(node, {time=0.25, scale=1, easing="backout", delay=delay, onComplete=onComplete})
	local mAction = CCMoveTo:create(0.8, destPos)
	local sBegin = CCScaleTo:create(0.1, 1.05)
	local sEnd = CCScaleTo:create(0.09, 1)
	local fadout = CCFadeOut:create(0.2)
	local seq = transition.sequence({mAction, sBegin, sEnd, fadout})
	return transition.execute(node, seq, {delay=delay, onComplete=onComplete})--easing="backout",
end


function UIAction.runeDiskMoveTo(node, destPos, onComplete, delay)
	print("function UIAction.runeDiskMoveTo(node, destPos, onComplete, delay)")
	local mAction = CCMoveTo:create(0.8, destPos)
	local seq = transition.sequence({mAction})
	return transition.execute(node, seq, {delay=delay, onComplete=onComplete})--easing="backout",
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
	@brief 无限旋转
]]
function UIAction.rotateForever(node, rotateTime)
	if nil == rotateTime then
		rotateTime = 2.5
	end

	--print('UIAction.rotate')
	local action = CCRotateBy:create(rotateTime, 360)
	local repeatAction = CCRepeatForever:create(action)
	node:runAction(repeatAction)
end

--[[
	@brief 无限旋转,添加一个appear的效果
]]
function UIAction.rotateForeverEx(node, rotateTime)
	if nil == rotateTime then
		rotateTime = 2.5
	end

	--print('UIAction.rotate')
	local showUp = CCScaleTo:create(0.5, 1)
	node:runAction(showUp)

	local action = CCRotateBy:create(rotateTime, 360)
	local repeatAction = CCRepeatForever:create(action)
	node:runAction(repeatAction)

	--transition.execute(node, showUp, {onComplete=function() node:runAction(repeatAction) end})
end

function UIAction.addImageRotateForever(parent, url, zindex)
	local img = UIImage.new(url, nil, false)
	img:retain()
	img:setAnchorPoint(ccp(0.5, 0.5))
	uihelper.addChild(parent, img, ccp(0.5, 0.5), zindex or 1)
	UIAction.rotateForever(img)
	return img
end

--[[
@brief 放大后恢复原状时， 调用。
@param node CCNode
@param onComplete function
@param delay number
@return CCAction
]]
function UIAction.shrinkRecover(node, onComplete, delay, bigFactor, shinkTime, recoverTime)
	--return transition.scaleTo(node, {time=0.25, scale=1, easing="backout", delay=delay, onComplete=onComplete})
	if bigFactor == nil then
		bigFactor = 1.05
	end
	if shinkTime == nil then
		shinkTime = 0.1
	end
	if recoverTime == nil then
		recoverTime = 0.09
	end
	local actionBegin = CCScaleTo:create(shinkTime, bigFactor)
	local action = CCScaleTo:create(recoverTime, 1)
	local seq = transition.sequence({actionBegin, action})
	return transition.execute(node, seq, {delay=delay, onComplete=onComplete})--easing="backout",
end

--[[
@brief 放大后恢复原状时， 调用。
@param node CCNode
@param onComplete function
@param delay number
@return CCAction
]]
function UIAction.shrinkRecoverForever(node, onComplete, delay, odds, shinkTime, recoverTime)
	--return transition.scaleTo(node, {time=0.25, scale=1, easing="backout", delay=delay, onComplete=onComplete})
	if odds == nil then
		odds = 1.05
	end
	if shinkTime == nil then
		shinkTime = 0.5
	end
	if recoverTime == nil then
		recoverTime = 0.5
	end
	local actionBegin = CCScaleTo:create(shinkTime, odds)
	local action = CCScaleTo:create(recoverTime, 1)
	local seq = transition.sequence({actionBegin, action})
	local repeatAction = CCRepeatForever:create(seq)
	return node:runAction(repeatAction)
end

--[[
@brief 缩小后恢复原状时， 调用。
@param node CCNode
@param onComplete function
@param delay number
@return CCAction
]]
function UIAction.reShrinkRecover(node, onComplete, delay, beTime, enTime)
	--return transition.scaleTo(node, {time=0.25, scale=1, easing="backout", delay=delay, onComplete=onComplete})
	if nil == beTime then
		beTime = 0.1
	end
	if nil == enTime then
		enTime = 0.09
	end
	local actionBegin = CCScaleTo:create(beTime, 0.93)
	local action = CCScaleTo:create(enTime, 1)
	local seq = transition.sequence({actionBegin, action})
	return transition.execute(node, seq, {delay=delay, onComplete=onComplete})--easing="backout",
end


--[[
@brief 节点出现， 变大到正常
@param node CCNode
@param onComplete function
@param delay number
@return CCAction
]]
function UIAction.appear(node, onComplete, delay, lastTime)
	if nil == lastTime then
		lastTime = 0.2
	end
	local actionBegin = CCScaleTo:create(0, 0.2)
	local action = CCScaleTo:create(lastTime, 1)
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
function UIAction.disappear(node, onComplete, delay,  lastTime)
	if nil == lastTime then
		lastTime = 0.2
	end
	local action = CCScaleTo:create(lastTime, 0.2)
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

--[[
@brief 设置节点旋转
@param node CCNode
@return CCAction
]]
function UIAction.setRotateTo(node , rotation, duration,easing)
	return transition.rotateTo(node, {time = duration, rotate = rotation,easing=easing})
end

--[[
@brief 设置节点移动
@param node CCNode
@return CCAction
]]
function UIAction.setMoveTo(node , x, y, duration,onComplete)
	return transition.moveTo(node, {x = x, y = y , time = duration, onComplete=onComplete})
end


--[[
@brief 消失=>重现
@param
--]]

function UIAction.emergeAction(duration)
	local dispear = CCFadeOut:create(duration)
	--local appear = CCFadeIn:create(duration*0.3)
	return transition.sequence({dispear, appear})
end

--[[
@brief 重现=>消失
@param duration 间隔时间
--]]
function UIAction.demergeAction(duration)
	--
	local appear = CCFadeIn:create(duration*0.5)
	local dispear = CCFadeOut:create(duration*0.5)
	return transition.sequence({appear, dispear})
end

--[[
@brief 永久重复
@param action 动作
--]]
function UIAction.foreverAction(action)
	return CCRepeatForever:create(action)
end

--[[
@brief 添加图片的渐隐渐现效果
@param parent CCNode 目标节点
@param times 次数 小于1为一直重复。 否则重复N次。
@param autoDispose boolean 是否自动调用析构
@param callback 回调函数。
@
--]]
function UIAction.addImageEmerge(parent, url, times, autoDispose, callback, zindex, beginOpacity, endOpacity)
	print("function UIAction.addImageEmerge(parent, url)", url)
	local img = nil
	if type(url) == "string" then
		img = UIImage.new(url, nil, false)
		img:retain()
	else
		img = url
	end

	if parent then
		uihelper.addChild(parent, img, ccp(0.5, 0.5), zindex or 1)
		img:setAnchorPoint(ccp(0.5, 0.5))
	end

	local opacityAction = UIOpacityAction.new(beginOpacity or 255, endOpacity or 200, 0.75, times, callback)

	opacityAction:setTarget(img)
	opacityAction:start()

	return opacityAction
end


--[[-- action
function UIAction.addImageEmerge(parent, url, times, autoDispose, callback, zindex)
	print("function UIAction.addImageEmerge(parent, url)", url)
	local img = UIImage.new(url, nil, false)
	img:retain()

	local action = UIAction.demergeAction(3)
	local act
	if times == nil or times < 1 then
		act = UIAction.foreverAction(action)
	elseif times == 1 then
		act = action
	else
		act = CCRepeat:create(action, times)
	end

	if autoDispose ~= false and times and times > 0 then
		act = transition.sequence({act,
			CCCallFunc:create(
				function ()
					 UIAction.removeImageEmerge(img)
				end
				)})
	end

	if callback then
		act = transition.sequence({act, CCCallFunc:create(callback)})
	end

	uihelper.addChild(parent, img, ccp(0.5, 0.5), zindex or 1)
	img:setAnchorPoint(ccp(0.5, 0.5))
	--img:runAction(act)
	transition.execute(img, act)
	return img
end
--]]
function UIAction.addImageEmergeForver(parent, url, zindex)
	return UIAction.addImageEmerge(parent, url, -1, false, nil, zindex)
end

function UIAction.removeImageEmerge(action)
	local node = action:getTarget()
	node:removeFromParent()
	if node.dispose then
		node:dispose()
	end
	node:release()

	action:dispose()
end

function UIAction.removeImageAction(node)
	node:stopAllActions()
	node:removeFromParent()
	if node.dispose then
		node:dispose()
	end
	node:release()
end


function UIAction.upDown(node, duration, pos, destPos)
	node:setPosition(pos)
	local mAction = CCMoveTo:create(duration/2, destPos)
	local rAction = CCMoveTo:create(duration/2, pos)--mAction:reverse()
	local seq = transition.sequence({mAction, rAction})
	local repeatAction = CCRepeatForever:create(seq)
	node:runAction(repeatAction)
end

function UIAction.curveMove(node, duration, posTable,onComplete)
	if #posTable <= 0 then
		return
	end

	local pos = CCPointArray:create(#posTable)

	for i,v in ipairs(posTable) do
		-- table.insert(pos,CCPoint(v.x,v.y))
		pos:add(ccp(v.x,v.y))
	end

	local mAction = CCCardinalSplineTo:create(duration, pos , 0)
	-- node:runAction(mAction)
	return transition.execute(node,mAction,{onComplete=onComplete})
end

function UIAction.shrinkForever(node, onComplete, delay, begainSize,endSize, shinkTime, recoverTime)
	--return transition.scaleTo(node, {time=0.25, scale=1, easing="backout", delay=delay, onComplete=onComplete})
	if begainSize == nil then
		begainSize = 1
	end

	if endSize == nil then
		endSize = 1.05
	end
	if shinkTime == nil then
		shinkTime = 0.5
	end
	if recoverTime == nil then
		recoverTime = 0.5
	end
	local actionBegin = CCScaleTo:create(shinkTime, endSize)
	local action = CCScaleTo:create(recoverTime, begainSize)
	local seq = transition.sequence({actionBegin, action})
	local repeatAction = CCRepeatForever:create(seq)
	return node:runAction(repeatAction)
end

return UIAction