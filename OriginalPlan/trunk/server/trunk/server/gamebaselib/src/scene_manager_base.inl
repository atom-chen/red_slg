
template<typename T>
void CSceneManagerBase::broadcast(T& packet)
{
	for(TBaseType::Iterator iter = begin(); iter != end(); ++iter)
	{
		CMapSceneBase* scene = iter->second;
		if(NULL == scene)
		{
			continue;
		}

		scene->broadCastScene(packet);
	}
}

template<typename T>
void CSceneManagerBase::broadcastChat(T& packet)
{
	for(TBaseType::Iterator iter = begin(); iter != end(); ++iter)
	{
		CMapSceneBase* scene = iter->second;
		if(NULL == scene)
		{
			continue;
		}

		scene->broadCastSceneChat(packet);
	}
}