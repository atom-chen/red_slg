--
-- Author: wdx
-- Date: 2014-05-21 16:09:14
--

local RushSkill = class("RushSkill",Skill)

function RushSkill:ctor(  )
	Skill.ctor(self)
end

function RushSkill:start( ... )
	Skill.start(self)
end

function RuskSkill:run(dt)
	if Skill.run(dt) == false then 
		return 
	end

	
end