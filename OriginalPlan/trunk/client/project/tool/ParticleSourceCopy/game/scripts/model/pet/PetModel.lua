local PetModel = class("PetModel")


function PetModel:init()
  self.petInfos = {}  --玩家当前拥有的宠物信息数组,以id为key
  self.petNum = 0     --当前玩家拥有的宠物数
end

--[[--
  更新宠物的某个属性信息
]]
function PetModel:updatePetInfo(id,key,value)
  local petInfo = self.petInfos[id]
  if petInfo then
    petInfo[key] = value
  end
end

--[[--
  根据宠物的id，获取对应宠物的信息
]]
function PetModel:getPetInfo(id)
  return self.petInfos[id]
end

--[[--
    添加一个宠物的信息
]]
function PetModel:addPetInfo(petInfo)
  self.petInfos[petInfo.id] = petInfo
  self.petNum = self.petNum+1
end

--[[--
    删除一个玩家的宠物信息
]]
function PetModel:removePetInfo(id)
  local petInfo = self.petInfos[id]
  if petInfo then
    self.petInfos[id] = nil
    self.petNum = self.petNum-1
  end
end

--[[--
  清空所有的宠物信息
]]
function PetModel:removeAllPetInfos()
  self.petInfos = nil
  self.petNum = 0
end

--[[--
  返回上阵的宠物的id数组
]]
function PetModel:getDeployedPetInfos()
  local idArr = {}
  for i,v in ipairs(self.petInfos) do
    if v and v.warpos>0 then
      idArr[#idArr+1] = i
    end
  end
  return idArr
end

return PetModel.new()