MathUtil = {}

function MathUtil:RadToAngle(rad)
	return rad/math.pi*180
end

function MathUtil:AngleToRad(angle)
	return angle/180*math.pi
end

--试用于地图的格子
function MathUtil.Distance(srcMx,srcMy,dstMx,detMy)
    local px = srcMx - dstMx
	local py = srcMy - detMy
	return math.sqrt( px* px + py * py )
end

function MathUtil:isEquality( e1,e2)

	return math.floor( e1*10000)== math.floor(e2*10000)
end