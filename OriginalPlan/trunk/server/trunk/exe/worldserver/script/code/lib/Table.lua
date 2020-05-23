-------------------------------------------------------
-- ����: �õ���Ĵ�С
-- ����: ��
-- ����: ��Ĵ�С
function tableGetSize(tab)
	if type(tab) ~= "table"
	then
		return 0;
	end
	
	local size = 0;
	for i,v in pairs(tab) do
		size = size+1;
	end

	return size;
end

-------------------------------------------------------
-- ����: ����������, ����2���ӵ���1��
-- ����: ��1, ��2
-- ����: ���Ӻ���±�
function tableConnect(tab1, tab2)
	local tab = {};
	if type(tab1) ~= "table" 
	then
		return tab;
	end

	tab = tab1;
	if type(tab2) ~= "table" 
	then
		return tab;
	end
	
	for i,v in pairs(tab2) do
		tab[i] = v;
	end
	
	return tab;
end

-------------------------------------------------------
-- ����: ����������, ����2���ӵ���1��
-- ����: ��1, ��2
-- ����: ���Ӻ���±�
function tableConnect2(tab1, tab2)
	local tab = tab1;

	for i,v in pairs(tab2) do
		table.insert(tab, v);
	end
	
	return tab;
end

-------------------------------------------------------
-- ����: �Ƿ��ڱ���
-- ����: ��,�����ҵ�Ԫ��
-- ����: true��false
function tableIsExist(tab, elem)
	for i,v in pairs(tab) do
		if elem == v then
			return v;
		end
	end

	return nil;
end

-------------------------------------------------------
-- ����: ����˳���б�ת����˳���
-- ����: ת��ǰ�ı�
-- ����: ת����ı�
function tableChange(tab)
	local tab1 = {};
	for i,v in pairs(tab) do
		table.insert(tab1, v);
	end

	return tab1;
end
