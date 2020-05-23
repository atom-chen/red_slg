--[[
	class:		HomogeneousMat3x3
	desc:		3*3的齐次线性坐标，用于变换2维坐标
				该矩阵有6个自由度
	author:		郑智敏
--]]

local HomogeneousMat3x3 = class('HomogeneousMat3x3')

--初始化为单位齐次矩阵,或者是copyTarget的复制
function HomogeneousMat3x3:ctor( copyTarget )
	-- body
	if nil == copyTarget then
		self.mat = {
			[1] = {[1] = 1, [2] = 0, [3] = 0,},
			[2] = {[1] = 0, [2] = 1, [3] = 0,},
		}
	else
		self:copy(copyTarget)
	end
end

--获得该矩阵的逆矩阵
function HomogeneousMat3x3:getInverse(  )
	-- body
	local determinant = self.mat[1][1] * self.mat[2][2] - self.mat[1][2] * self.mat[2][1]
	assert(0 ~= determinant)

	local inverseMat = HomogeneousMat3x3.new()
	inverseMat.mat[1][1] =  self.mat[2][2] / determinant
	inverseMat.mat[1][2] = -1 * self.mat[1][2] / determinant
	inverseMat.mat[1][3] = (self.mat[1][2] * self.mat[2][3] - self.mat[1][3] * self.mat[2][2]) / determinant
	inverseMat.mat[2][1] = -1 * self.mat[2][1] / determinant
	inverseMat.mat[2][2] = self.mat[1][1] / determinant
	inverseMat.mat[2][3] = -1 * (self.mat[1][1] * self.mat[2][3] - self.mat[1][3] * self.mat[2][1]) / determinant

	return inverseMat
end

--复制target矩阵的值
function HomogeneousMat3x3:copy( target )
	-- body
	for row = 1,3,1 do
		for col = 1,3,1 do
			self.mat[row][col] = target.mat[row][col]
		end
	end
end

--获得该矩阵右乘target矩阵的结果，返回该结果矩阵的值，调用该接口的矩阵不变
function HomogeneousMat3x3:getRightMultiply( target )
	-- body
	local resultMat = HomogeneousMat3x3.new()
	resultMat.mat[1][1] = target.mat[1][1] * self.mat[1][1] + target.mat[1][2] * self.mat[2][1]
	resultMat.mat[1][2] = target.mat[1][1] * self.mat[1][2] + target.mat[1][2] * self.mat[2][2]
	resultMat.mat[1][3] = target.mat[1][1] * self.mat[1][3] + target.mat[1][2] * self.mat[2][3] + target.mat[1][3]
	resultMat.mat[2][1] = target.mat[2][1] * self.mat[1][1] + target.mat[2][2] * self.mat[2][1]
	resultMat.mat[2][2] = target.mat[2][1] * self.mat[1][2] + target.mat[2][2] * self.mat[2][2]
	resultMat.mat[2][3] = target.mat[2][1] * self.mat[1][3] + target.mat[2][2] * self.mat[2][3] + target.mat[2][3]

	return resultMat
end

--用该矩阵转换一个点pos，返回转换后的位置
function HomogeneousMat3x3:transformPos( pos )
	-- body
	local resultPos = ccp(0,0)
	resultPos.x = self.mat[1][1] * pos.x + self.mat[1][2] * pos.y + self.mat[1][3]
	resultPos.y = self.mat[2][1] * pos.x + self.mat[2][2] * pos.y + self.mat[2][3]

	return resultPos
end

return HomogeneousMat3x3