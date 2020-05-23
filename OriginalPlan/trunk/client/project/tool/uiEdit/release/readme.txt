1. UIEditorConfig.xml 的使用
	ResourcePath下的path为图片路径。
		这些路径为可以在程序中拖曳添加， 清除的目录项

	StaticResourcePath下的path也是图片路径，但是程序无法直接更改清除该目录。
		若需要更改， 则需要手动更改 UIEditorConfig.xml。

	LanguagePath 下的目录为 UI编辑器中"内容"输入框内输入的文字， 最终保存的路径。
	
2. 保存的布局文件需把对应的 layername_lang.lua 和 使用的图片一起打包。 方可继续使用。

UIEditorConfig.xml sample:


<Root>
	<ResourcePath path="res\">
		<path>E:\program2014\client\project\game\res\ui\item\</path></ResourcePath>
	<StaticResourcePath>
		<path>E:\program2014\client\project\assets\common</path>
	</StaticResourcePath>
	<LanguagePath>
		<path>E:\program2014\client\project\game\res\uilayer\zh_cn\</path></LanguagePath>
	<SpritePath>
		<path>.\Sprite</path>
	</SpritePath>
	<SpriteTargetPath>
		<path>.\SpriteTarget</path>
	</SpriteTargetPath>
</Root>
	
3. 语言文件
	语言文件名的格式为 布局文件的名字 + _lang.lua. 例如 布局文件 panel.lua 的语言文件为 panel_lang.lua
	
	
4.使用技巧
	删除控件快捷键， 选中后 ctrl+F4
	移动快捷键， 选中后按alt+方向键 上下左右
	多选 ctrl+左键
	移动可见区域， 右键之后左键拖动
	保存 ctrl+s 
	全选 ctrl+a

	