local Mask = {}

--[[--
--遮罩层次的划分与界面容器的划分保持一致
--容器层次：scene、hud、hudTop、popup、popupTop、notify、top
--分割容器的遮罩层分别为 
  scene_hud、
  hud_hudTop、
  hudTop_popup、
  popup_popupTop、
  popupTop_notify、
  notify_top、
  highest
--0xzzzz: 第N层遮罩层的触摸优先级为：0x0N00,其紧挨着的上面的容器的优先级为0x0N01-0x0Nff
]]

Mask.priority = {
  scene_hud      = -0x0100,
  hud_hudTop     = -0x0200,
  hudTop_popup   = -0x0300,
  popup_popupTop = -0x0400,
  popupTop_notify= -0x0500,
  notify_top     = -0x0600,
  highest        = -0x0700
}

Mask.container = {
  scene    =   {min =  0x0000,max = -0x00ff},
  hud      =   {min = -0x0101,max = -0x01ff},
  hudTop   =   {min = -0x0201,max = -0x02ff},
  popup    =   {min = -0x0301,max = -0x03ff},
  popupTop =   {min = -0x0401,max = -0x04ff},
  notify   =   {min = -0x0501,max = -0x05ff},
  top      =   {min = -0x0601,max = -0x06ff}
}
return Mask