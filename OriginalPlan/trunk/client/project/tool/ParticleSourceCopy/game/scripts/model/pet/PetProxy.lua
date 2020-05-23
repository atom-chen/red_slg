--[[--
  宠物模型层逻辑处理类
]]

local PetProxy = class("PetProxy")

--[[--
  初始化函数
]]
function PetProxy:init()
  NetCenter:addMsgHandler(MsgType.PET_LIST,{self,self._resPetList},-2)
  NetCenter:addMsgHandler(MsgType.PET_INFO_UPDATE,{self,self._resUpdatePetInfo},-2)
  NetCenter:addMsgHandler(MsgType.PET_EQUIP_UPDATE,{self,self._resUpdatePetEquip},-2)
  NetCenter:addMsgHandler(MsgType.PET_SYNTHESIZE,{self,self._resSynthesizePet},-2)
end

function PetProxy:_resPetList(event)
  local msg = event.msg
  PetModel:removeAllPetInfos()
  for i,v in ipairs(msg) do
    PetModel:addPetInfo(v)
  end
end

function PetProxy:_resUpdatePetInfo(event)
  local msg = event.msg
  --更新宠物对应属性的值
  --{{petinfo},{petinfo}}
  
end

function PetProxy:_resUpdatePetEquip(event)
  local msg = event.msg
  --[[
  msg.petId
  msg.equipId
  msg.isWear 
  ]]
  if msg.isWear then   --如果是穿上装备
    
  else  --如果是卸下装备
  
  end
 
end



--[[--
  向服务器请求合成宠物
]]
function PetProxy:reqSynthesizePet(petId)
  NetCenter:send(MsgType.PET_SYNTHESIZE,petId)
end

function PetProxy:_resSynthesizePet(event)
  local msg = event.msg
  --{{id,key,value},{id,key,value},{id,key,value}}
  for i,v in ipairs(msg) do
    PetModel:updatePetInfo(v[1],v[2],v[3])
  end
end


return PetProxy.new()