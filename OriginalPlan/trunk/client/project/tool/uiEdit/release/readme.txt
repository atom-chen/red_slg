1. UIEditorConfig.xml ��ʹ��
	ResourcePath�µ�pathΪͼƬ·����
		��Щ·��Ϊ�����ڳ�������ҷ��ӣ� �����Ŀ¼��

	StaticResourcePath�µ�pathҲ��ͼƬ·�������ǳ����޷�ֱ�Ӹ��������Ŀ¼��
		����Ҫ���ģ� ����Ҫ�ֶ����� UIEditorConfig.xml��

	LanguagePath �µ�Ŀ¼Ϊ UI�༭����"����"���������������֣� ���ձ����·����
	
2. ����Ĳ����ļ���Ѷ�Ӧ�� layername_lang.lua �� ʹ�õ�ͼƬһ������ ���ɼ���ʹ�á�

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
	
3. �����ļ�
	�����ļ����ĸ�ʽΪ �����ļ������� + _lang.lua. ���� �����ļ� panel.lua �������ļ�Ϊ panel_lang.lua
	
	
4.ʹ�ü���
	ɾ���ؼ���ݼ��� ѡ�к� ctrl+F4
	�ƶ���ݼ��� ѡ�к�alt+����� ��������
	��ѡ ctrl+���
	�ƶ��ɼ����� �Ҽ�֮������϶�
	���� ctrl+s 
	ȫѡ ctrl+a

	