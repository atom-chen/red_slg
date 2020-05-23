简要说明：
Excel转Erlang工具库，目前仅支持office 2007格式，是基于Python编写的一系列小工具，编写前可以参考gift.py的写法，里面要详细说明，请参考，谢谢。

软件安装文件存放在soft文件夹里
生成器所需工具及库如下：
python 2.7
pywin32
setuptools 0.6c11
openpyxl 1.5.6
上面也是安装顺序，设置环境变量，然后安装文件时解压文件到安装目录C:\Python27\Lib\site-packages下，然后进入目录执行python setup.py install即可进行安装
然后，要解决一个编码问题，将以下代码
#!/usr/bin/env python
# -*- coding: UTF-8 -*-
import sys
reload(sys)
sys.setdefaultencoding('utf-8') #IGNORE:E1101

import locale
locale.setlocale(locale.LC_ALL, "")
保存为sitecustomize.py，并放到C:\Python27\Lib\site-packages

				write in 2012.03.02 23:59:59 by King


-----------------------------------------------------------------
| 补充：配置生成脚本框架使用说明 (libs/convert.py)
-----------------------------------------------------------------
基本概念：类型描述  字典 模板替换
类型描述：
	EXCEL第1行：各列字段中文描述
	EXCEL第2行：各列字段类型描述，格式 name:type
		name - 字段英文名
		type - 类型
	EXCEL第3行及以后：数据
	
	目前支持的类型有：
		meta - 直接按EXCEL原样生成数据
		int -  整数
		float - 浮点
		bool - 布尔  (erlang:true/false       XML:1/0)
		str - 字符串 (erlang:<<"text">>       XML:text)
		pair - key-value对   (erlang: {key, value}   XML:<key>value</key>)
		arr - 逗号分隔的数值 (erlang:[1,2,3]         XML:<item>1</item><item>2</item><item>3</item>
		loss - 消耗 (erlang: #loss{}                 XML:<loss><item_id>12345</item_id><num>99</num></loss>)
		gain - 奖励 (erlang: #gain{}                 XML:<gain><item_id>12345</item_id><num>99</num><is_bind>1</is_bind></gain>)
		list(type) - type为以上支持的任一类型，填EXCEL时相应的分多行填写
	
		这些类型均在 conert.py 里实现，并可以继续扩展
		只要实现单元格数据->erlang数据 单元格数据->xml数据 这两个转换即可
		
		EXCEL样例：
		-----------------------------------
		| ID    | 名称     | 是否可爱     |    中文标题头
		-----------------------------------
		|id:int | name:str | is_love:bool |    类型描述
		-----------------------------------
		| 1     | 小鸡     | 1            |    数据行1
		-----------------------------------
		| 2     | 小鸭     | 0            |    数据行2
		-----------------------------------
		|       |          |              |    空行
		-----------------------------------
		

扫描/字典:
	调用 convert_excel_sheet 即可扫描EXCEL
	每一条配置数据，都被扫描生成两个字典 ED XD，并传递给回调函数
	ED : erlang name->value 字典
	XD : xml name->value 字典 
	
	比如上面样例EXCEL中，数据行1扫描后，生成字典：
	ED : {"id"->"1", "name"->"<<"小鸡">>", "is_love"->"true"}
	XD : {"id"->"1", "name"->"小鸡", "is_love"->"1"}
	
	这样，回调函数中直接用name来取出相应的字段值，进行组合拼装就行了
	
模板替换：
	除了自己操作字典进行拼装，
	更好的方法是把字典传给一个模板，进行自动封装
	
	如： template = "get($$id$$) -> #record{name=$$name$$, is_love=$$is_love$$}"
	调用：fill_template_str(template, ED)
	则自动把模板中的 $$id$$  $$name$$ $$is_love$$ 换成相应的字典值，
	并返回替换完毕的结果

-----------------------------------------------------------------
| 补充over
-----------------------------------------------------------------	
		
	
	
