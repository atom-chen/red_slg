#ifndef __UIEDIT_XML_PATH_H__
#define __UIEDIT_XML_PATH_H__

struct XMLPath
{
private:
	_di_IXMLDocument 	m_xmlNetbargpp;
	UnicodeString		m_path;
public:	
	XMLPath(_di_IXMLDocument& XmlNetbargpp)
	{
		m_xmlNetbargpp = XmlNetbargpp;
		m_xmlNetbargpp->Active = true;
	}
	virtual ~XMLPath()
	{
		m_xmlNetbargpp->Active = false;
	}
	
	bool load(const UnicodeString& path)
	{
		m_path = path;
		m_xmlNetbargpp->LoadFromFile(m_path);
        return true;
	}
	
	bool load(const UnicodeString& path, const UnicodeString& filename)
	{
		m_path = path + "\\" + filename;
		m_xmlNetbargpp->LoadFromFile(m_path);
        return true;
	}
	
	bool save()
	{
		m_xmlNetbargpp->SaveToFile(m_path);
        return true;
	}
	bool saveAs(const UnicodeString& path)
	{
		m_xmlNetbargpp->SaveToFile(path);
        return true;
	}
	bool existText(const UnicodeString& parentName, const UnicodeString& childName, const UnicodeString& text)
	{
		set<UnicodeString> s = getUniqueChildrenText(parentName, childName);
		return s.find(text) != s.end();
	}
	bool uniqueChildren(const UnicodeString& parentName, const UnicodeString& childName)
	{
		set<UnicodeString> s = getUniqueChildrenText(parentName, childName);
		if (!clearChildren(parentName, childName))
			return false;
			
		return addChildren(parentName, childName, s);
	}
	
	set<UnicodeString> getUniqueChildrenText(const UnicodeString& parentName, const UnicodeString& childName)	
	{
		_di_IXMLNode root = m_xmlNetbargpp->DocumentElement;
		_di_IXMLNode UIParentNode = root->ChildNodes->FindNode(parentName);
		set<UnicodeString> s;
        if (!UIParentNode) {
            return s;
        }
		for(int j = UIParentNode->GetChildNodes()->GetCount(); j != 0 ; j--)
		{
			if (UIParentNode->GetChildNodes()->Nodes[j-1]->GetNodeName() == childName)
			{
				UnicodeString text = UIParentNode->GetChildNodes()->Nodes[j-1]->GetText();
				s.insert(text);
			}
		}
		return s;
	}
	
	bool clearChildren(const UnicodeString& parentName, const UnicodeString& childName)
	{
		_di_IXMLNode root = m_xmlNetbargpp->DocumentElement;
		_di_IXMLNode UIParentNode = root->ChildNodes->FindNode(parentName);
        if (!UIParentNode) {
            UIParentNode = root->AddChild(parentName);
        }
		for(int j = UIParentNode->GetChildNodes()->GetCount(); j != 0 ; j--)
		{
			if (UIParentNode->GetChildNodes()->Nodes[j-1]->GetNodeName() == childName)
			{
                //UIParentNode
				UIParentNode->GetChildNodes()->Remove(UIParentNode->GetChildNodes()->Nodes[j-1]);
			}
		}
		return true;
	}
	
	bool addChildren(const UnicodeString& parentName, const UnicodeString& childName, const set<UnicodeString>& childrenText)
	{
		_di_IXMLNode root = m_xmlNetbargpp->DocumentElement;
		_di_IXMLNode UIParentNode = root->ChildNodes->FindNode(parentName);
        if (!UIParentNode) {
            UIParentNode = root->AddChild(parentName);
        }
		for (set<UnicodeString>::const_iterator it = childrenText.begin(); it != childrenText.end(); ++it)
		{
			_di_IXMLNode node = UIParentNode->AddChild(childName);
			node->SetText(*it);
		}
		return true;		
	}
	bool addChildren(const UnicodeString& parentName, const UnicodeString& childName, const UnicodeString& childText)
	{
		_di_IXMLNode root = m_xmlNetbargpp->DocumentElement;
		_di_IXMLNode UIParentNode = root->ChildNodes->FindNode(parentName);
		if (!UIParentNode) {
            UIParentNode = root->AddChild(parentName);
        }
		_di_IXMLNode node = UIParentNode->AddChild(childName);
		node->SetText(childText);
		return true;		
	}
};

struct XMLResPath: public XMLPath
{
	XMLResPath(_di_IXMLDocument& XmlNetbargpp):XMLPath(XmlNetbargpp){}
	virtual ~XMLResPath(){};
	
	set<UnicodeString> getUnique(const UnicodeString& parentName)
	{
		set<UnicodeString> setText = getUniqueChildrenText(parentName, "path");
		set<UnicodeString> setPath;
		for (set<UnicodeString>::iterator it = setText.begin(); it != setText.end(); ++it)
		{
			UnicodeString str = *it;
			// dealwith
			setPath.insert(str);
		}
		return setPath;
	}
	
	bool clear(const UnicodeString& parentName)
	{
		return clearChildren(parentName, "path");
	}
	
	bool unique(const UnicodeString& parentName)
	{
		set<UnicodeString> setPath = getUnique(parentName);
		clear(parentName);
		return addChildren(parentName, "path", setPath);
	}
	bool clearOne(const UnicodeString& parentName, const UnicodeString& onePath)
	{
		set<UnicodeString> setPath = getUnique(parentName);
		set<UnicodeString>::iterator it = setPath.find(onePath);
		if (it == setPath.end())
		{
			return true;
		}
		setPath.erase(it);
		clear(parentName);
		addChildren(parentName, "path", setPath);
		return true;
	}
	bool clearRes()
	{
		return clear("ResourcePath");
	}
	bool clearRes(const UnicodeString& path)
	{
		return clearOne("ResourcePath", path);
	}
};

#endif