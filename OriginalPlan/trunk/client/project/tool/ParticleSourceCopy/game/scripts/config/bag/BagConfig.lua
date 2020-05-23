--
-- Author: changao
-- Date: 2014-06-19
--

local BagCfg = class("BagCfg")

function BagCfg:ctor(  )
	self._chapterDungeon = {}
end

function BagCfg:init(  )
	--��ʼ������
	self._BagCfg = ConfigMgr:requestConfig("item",nil,true)
	
end

--��ȡĳ��������Ϣ
function BagCfg:getDungeon( id )
	local dInfo = self._BagCfg[id]
	if dInfo then
		dInfo.id = id
	end
	return dInfo
end

--��ȡĳ���½���Ϣ
function BagCfg:getChapter( id )
	return self._chapterCfg[id]
end

--��ȡ��һ������id
function BagCfg:getNextDungeonId( id )
	if id == 0 then
		id = 1
	else
		local dInfo = self:getDungeon(id)
		if dInfo then
			return dInfo.next
		else
			return id
		end
	end
end


--��ȡ�½ڵ� �����б�
function BagCfg:getChaptherDungeon(id)
	local list = self._chapterDungeon[id]
	if list then
		return list
	else
		list = {}
		local chapter = self:getChapter(id)
		local dId = chapter.min  --��ʼ����id
		while true do
			local dInfo = self:getDungeon(dId)
			if dInfo == nil then
				break
			end
			list[#list+1] = dInfo
			if dId == chapter.max then  --�½ڵĽ���id��
				break
			end
			dId = dInfo.next
		end
		self._chapterDungeon[id] = list
	end
	return list
end


return BagCfg.new()