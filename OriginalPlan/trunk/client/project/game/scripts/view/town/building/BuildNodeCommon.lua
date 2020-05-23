--
-- Author: lyc
-- Date: 2016-05-24 15:19:00
--

local BuildNodeCommon = {}

function BuildNodeCommon.getCenterPosOfNode(majorCityMap, nodeName)
	local node = majorCityMap:getNodeByName(nodeName)
	local nodeX, nodeY = node:getPosition()
	local size = node:getContentSize()
	return ccp(nodeX+size.width/2, nodeY+size.height/2)
end

return BuildNodeCommon