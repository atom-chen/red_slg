--[[
UIInfo
inherit：none
desc：UINode相关内容实用的常量
author：changao
date: 2014-06-03

]]--

local UIInfo = {}
UIInfo.alignment = {}
UIInfo.mul = "×"
-- 水平对齐
UIInfo.alignment.LEFT = "left"
UIInfo.alignment.CENTER = "center"
UIInfo.alignment.RIGHT = "right"

-- 竖直对齐
UIInfo.alignment.BOTTOM = "bottom"
UIInfo.numberPrefix = 'com_sz'

UIInfo.expedetionBlueNumberPrefix = 'com_lan'
UIInfo.expedetionGreenNumberPrefix = 'com_lv'
UIInfo.expedetionYellowNumberPrefix = 'defender_bsts'

for k,v in pairs(UIInfo.alignment) do
	UIInfo.alignment[k:lower()] = v
	UIInfo[k] = v
	UIInfo[k:lower()] = v
end

UIInfo.color = {}
UIInfo.color.red 					= ccc3(254,0,0)
UIInfo.color.gray 					= ccc3(167,167,167)
UIInfo.color.white					= ccc3(255,255,255)
UIInfo.color.silver					= ccc3(79,101,125)--ccc3(196,217,234)
UIInfo.color.black					= ccc3(34,36,40)
UIInfo.color.green					= ccc3(2,156,13)--ccc3(146,195,85)
UIInfo.color.blue					= ccc3(53,87,114)
UIInfo.color.purple					= ccc3(171,91,255)
UIInfo.color.yellow					= ccc3(255,254,0)
UIInfo.color.brown					= ccc3(67,19,0)--ccc3(64,15,10)
UIInfo.color.cyan					= ccc3(24,254,0)


UIInfo.color.button_disabled 		= ccc3(199,180,141)
UIInfo.color.dark_yellow 			= ccc3(242,194,106)
UIInfo.color.orange 				= ccc3(216,114,18)
UIInfo.color.pink					= ccc3(204,51,0)
UIInfo.color.dark_blue				= ccc3(55,125,174)
UIInfo.color.button_blue			= ccc3(36,44,120)
UIInfo.color_string = {}

UIInfo.outline = {black=1,green=2,orange=3,blue=4,red=5,purple=6,white=7,}

for name,color in pairs(UIInfo.color) do
	local str = string.format("rgb(%s,%s,%s)", color.r, color.g, color.b)
	UIInfo.color_string[name] = str
	UIInfo.color_string[name:upper()] = str
	UIInfo.color[name:upper()] = color
	UIInfo[name:upper()] = color
	UIInfo[name] = color
end

function UIInfo.getOutlineColor(outline)
	local outlineColor = nil
	if type(outline) == "number" then
		local colors = {display.COLOR_BLACK, UIInfo.color.green, UIInfo.color.orange, UIInfo.color.blue, UIInfo.color.red,UIInfo.color.purple,UIInfo.color.white,}
		outlineColor = colors[outline]
	elseif type(outline) == "string" then
		outlineColor = UIInfo.color[outline]
	elseif type(outline) == "userdata" then
		outlineColor = outline
	end
	return outlineColor
end

UIInfo.button = {padding={
--['#com_btn_2.png']={bottom=2},
},
}

UIInfo.image = {clip={
-- ['#com_landi.png'] = true
}
}

function UIInfo.createTextInfo(text, fontSize, fontName, fontColor, align, valign, useRTF, shadow, outline)
	local textInfo = {fontSize=fontSize, fontName=fontName, fontColor=fontColor, align=align, valign=valign, useRTF=useRTF, shadow=shadow,outline=outline}
	return textInfo
end

function UIInfo.setTextInfo(textInfo, text, fontSize, fontName, fontColor, align, valign, useRTF, shadow, outline)
	textInfo.fontSize = fontSize == nil and textInfo.fontSize or fontSize
	textInfo.fontName = fontName == nil and textInfo.fontName or fontName
	textInfo.text = text
	textInfo.fontColor = fontColor == nil and textInfo.fontColor or fontColor
	textInfo.align = align == nil and textInfo.align or align
	textInfo.valign = valign == nil and textInfo.valign or valign
	textInfo.useRTF = useRTF == nil and textInfo.useRTF or useRTF
	textInfo.shadow = shadow == nil and textInfo.shadow or shadow
	textInfo.outline = outline == nil and textInfo.outline or outline
	--if outline == nil then
end



local __number = {__hundred={'C','CC','CCC','CD','D','DC','DCC','DCCC','CM'},
__ten={'X','XX','XXX','XL','L','LX','LXX','LXXX','MC'},
__units={'I','II','III','IV','V','VI','VII','VIII','IX'}}

function __number.toRome(num)
	local n = num%1000
	local nstr = ""
	if n >= 100 then
		nstr = nstr .. __number.__hundred[math.floor(n/100)]
		n = n % 100
	end
	if n >= 10 then
		nstr = nstr .. __number.__ten[math.floor(n/10)]
		n = n % 10
	end
	if n > 0 then
		nstr = nstr .. __number.__units[math.floor(n)]
	end
	return nstr
end

UIInfo.number = __number
return UIInfo
