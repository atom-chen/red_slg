local UIRedPointExtend = {}

function UIRedPointExtend.extend(node, anchorPoint, pointPic)
	if nil == anchorPoint then
		anchorPoint = ccp(1,1)
	end
	if nil == pointPic then
		pointPic = "#com_new.png"
	end

	function node:addRedPoint(pos)
		local typestr = type(pos)
		if not node._littleRedPoint then
			node._littleRedPoint = display.newXSprite(pointPic)
			node:addChild(node._littleRedPoint, 1)

			node._littleRedPoint:setAnchorPoint(anchorPoint)
		end
		--local rpSize = node._littleRedPoint:getContentSize()
		if typestr == "nil" then
			local size = node:getContentSize()
			node._littleRedPoint:setPosition(ccp(size.width, size.height))
		else
			node._littleRedPoint:setPosition(pos)
		end
	end

	function node:removeRedPoint()
		if not node._littleRedPoint then return end
		node._littleRedPoint:removeFromParent()
		node._littleRedPoint = nil
	end

	function node:redPointClear()
		node:removeRedPoint()

		anchorPoint = nil
		pointPic = nil
	end
end

return UIRedPointExtend