--
-- Author: wdx
-- Date: 2014-04-28 10:22:29
--
local FightCamera = class("FightCamera")

function FightCamera:ctor()
	--
end

function FightCamera:init()

end

--设置镜头跟踪目标   可能是某个 宠物  或者是某个 magic 等
function FightCamera:setFollowTarget(target)
	self.targetList[#self.targetList+1] = target
end

function FightCamera:removeFollowTarget(target)
	for i,t in ipairs(self.targetList) do
		if t == target then
			table.remove(self.targetList,i)
			break
		end
	end
end

--也可以设置镜头 移动轨迹   path 是一个数组 可存放多个坐标  会根据这些坐标作为轨迹移动
function FightCamera:setCameraPath( path,speed)
	self.cameraPath = path
	self.speed = speed or 10
	local pos = table.remove(path,1)
	self.scene:setPosition(pos.x,pos.y)   --移动场景
end

--设置 缩放镜头
function FightCamera:setScale(scale,speed)
	self.targetScale = scale
	self.speed = speed or 1000

end

--设置锁定相机不动
function FightCamera:lockCamera(x,y,scale)
	self.isLock = true
	if x and y then
		self.scene:setPosition(pos.x,pos.y)   --移动场景
	end
	if scale then
		self.scene:setScale(scale)
	end
end

--取消锁定
function FightCamera:unlockCamera()
	self.isLock = false
end


function FightCamera:start(scene)
	self.targetList = {}
	self.scene = scene
	self.isLock = false

	if self.node == nil then
		self.node = display.newNode()
		self.node:retain()
		self.scene:addChild(self.node)
	end
end

--主要在这里面调整 镜头  跟踪目标
function FightCamera:run( dt )
	if self.isLock then
		return
	end

	if self.targetScale then  --这里可以做  镜头缩放的
		local scale = self.scene:getScale()

		if math.abs(self.targetScale - scale) <= math.abs(self.speed) then   --移动缩放到 目标scale了
			scale = self.targetScale
			self.targetScale = nil
		else
			scale = scale + self.speed
		end

		self.scene:setScale(scale)
		return
	end


	if self.cameraPath and #self.cameraPath then  --有移动轨迹的     后期应该有这个需求
		local targetPos = self.cameraPath[1]   --需要移动过去的目标

		local sceneX,sceneY = self.scene:getPosition()

		--根据 当前场景的 sceneX,sceneY  以一定的速度移动到 目标 targetPos
		local dx = self.speed*( (targetPos.x-sceneX)/(targetPos.y-sceneY))
		local dy = self.speed

		if  math.abs(targetPos.x - sceneX) <= math.abs(dx) then  --假如已经到达 targetPos了
			sceneX = targetPos.x
			sceneY = targetPos.y

			table.remove(self.cameraPath,1)  --那边再继续移动到 cameraPath 的 下一个
		else
			sceneX = sceneX + dx
			sceneY = sceneY + dy
		end

		self.scene:setPosition(sceneX,sceneY)
		return
	end


	local target = self.targetList[#self.targetList]
	local sceneX,sceneY = 0,0
	if target == nil then  --没跟踪目标   那么有一个默认的目标

	else
		--local targetX,targetY = target:getPosition()
		--在这里计算  sceneX sceneY

		local range = target.atkRange

		local startPos,endPos = range:getBorderPos(target,target:getDirection())

		self.node:removeAllChildrenWithCleanup()


		for i=startPos.mx,endPos.mx do
			for j = startPos.my,endPos.my do
				local tile = Tile.new(i,j,0,ccc4f(1,0,0,0.5))
				self.node:addChild(tile)
			end

		end

	end

	--self.scene:setPosition(sceneX,sceneY)   --移动场景

end


return FightCamera.new()