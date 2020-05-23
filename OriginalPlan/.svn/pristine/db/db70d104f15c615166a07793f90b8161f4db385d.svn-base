local SingleDirectionAvatarExtend = {}

function SingleDirectionAvatarExtend.extend(av)
	av._showFrameOldEx = av._showFrame
	function av:_showFrame(index, action,d)
		d = GameConst.RIGHT
		self:_showFrameOldEx(index, action,d)
	end
end

return SingleDirectionAvatarExtend