#include "core/string_common.h"

#include "world_login_role_list.h"

const GXMISC::TDbCol TLoginRole::DbCols[] = {
	_DBCOL_TYPE_OFFSET_KEY_("role_uid", TRoleUID_t, _LoginRole, roleUID, GXMISC::DB_FILED_FLAG_MAIN_KEY),
	_DBCOL_TYPE_OFFSET_("obj_uid", TObjUID_t, _LoginRole, objUID),
	_DBCOL_TYPE_OFFSET_("protype_id", TRoleProtypeID_t, _LoginRole, protypeID),
	_DBCOL_TYPE_OFFSET_("name", TRoleName_t, _LoginRole, name),
	_DBCOL_TYPE_OFFSET_("level", TLevel_t, _LoginRole, level),
	_DBCOL_TYPE_OFFSET_("scene_id", TSceneID_t, _LoginRole, sceneID),
	_DBCOL_TYPE_OFFSET_("x", TAxisPos_t, _LoginRole, pos.x),
	_DBCOL_TYPE_OFFSET_("y", TAxisPos_t, _LoginRole, pos.y),
	_DBCOL_TYPE_OFFSET_("create_time", GXMISC::CGameTime, _LoginRole, createTime),
	_DBCOL_TYPE_OFFSET_("logout_time", GXMISC::CGameTime, _LoginRole, logoutTime),
	_DBC_MAX_NULL_(_LoginRole)
};

void CWorldLoginRoleList::addRole(TLoginRole* role){
	clean();
	_roleList.push_back(*role);
}

void CWorldLoginRoleList::getRoleList(TPackLoginRoleArray& roleList) {
	for (uint32 i = 0; i < _roleList.size() && !roleList.isMax(); ++i) {
		roleList.pushBack(_roleList[i].toPackLoginRole());
	}
}

bool CWorldLoginRoleList::selectRole(TRoleUID_t roleUID) 
{
	clean();

	for (uint32 i = 0; i < _roleList.size(); ++i) {
		if (_roleList[i].roleUID == roleUID) {
			_currRoleUID = roleUID;
			_currObjUID = _roleList[i].objUID;
			genStrName();

			if (_currObjUID == INVALID_OBJ_UID) {
				gxWarning("Can't gen temp role uid!RoleUID = {0}", roleUID);
				clean();
				return false;
			}

			gxDebug("select role {0}", toString());

			return true;
		}
	}

	clean();
	gxWarning("Can't select role, role not in role list! RoleUID = {0}", roleUID);
	return false;
}

void CWorldLoginRoleList::delRole(TRoleUID_t roleUID) {
	TLoginRoleVector::iterator iter = _roleList.begin();
	for (uint32 i = 0; i < _roleList.size(); ++i, ++iter) {
		if (_roleList[i].roleUID == roleUID) {
			break;
		}
	}

	if (iter != _roleList.end()) {
		_roleList.erase(iter);
	}

	clean();
}

bool CWorldLoginRoleList::isRole(TRoleUID_t roleUID) {
	for (uint32 i = 0; i < _roleList.size(); ++i) {
		if (_roleList[i].roleUID == roleUID) {
			return true;
		}
	}

	return false;
}

bool CWorldLoginRoleList::isMaxRoleNum() {
	return _roleList.size() >= MAX_ROLE_NUM;
}

TObjUID_t CWorldLoginRoleList::getCurrentObjUID() {
	return _currObjUID;
}

TRoleUID_t CWorldLoginRoleList::getCurrentRoleUID() {
	return _currRoleUID;
}

void CWorldLoginRoleList::clean() {
	_currObjUID = INVALID_OBJ_UID;
	_currRoleUID = INVALID_ROLE_UID;
	genStrName();
}

void CWorldLoginRoleList::genStrName() {
	if (_currObjUID != INVALID_OBJ_UID) {
		gxAssert(_currRoleUID != INVALID_ROLE_UID);
		_strName = GXMISC::gxToString(
			"CurrentRoleUID=%"I64_FMT"u, CurrentObjUID=%u;", _currRoleUID,
			_currObjUID);
	} else {
		gxAssert(_currRoleUID == INVALID_ROLE_UID);
		_strName = "";
	}
}

const char* CWorldLoginRoleList::toString() {
	return _strName.c_str();
}

uint32 CWorldLoginRoleList::size() {
	return (uint32)_roleList.size();
}

TLoginRole* CWorldLoginRoleList::getCurrentRole()
{
	for (uint32 i = 0; i < _roleList.size(); ++i) {
		if (_roleList[i].roleUID == _currRoleUID) {
			return &_roleList[i];
		}
	}

	return NULL;
}

TRoleUID_t CWorldLoginRoleList::getLastLoginRoleUID()
{
	TRoleUID_t roleUID = INVALID_ROLE_UID;
	GXMISC::TGameTime_t gameTime = GXMISC::INVALID_GAME_TIME;
	for(uint32 i = 0; i < _roleList.size(); ++i)
	{
		if(gameTime == GXMISC::INVALID_GAME_TIME || gameTime < _roleList[i].logoutTime.getGameTime())
		{
			roleUID = _roleList[i].roleUID;
			gameTime = _roleList[i].logoutTime;
		}
	}

	return roleUID;
}

TRoleUID_t CWorldLoginRoleList::getFirstRoleUID()
{
	if(_roleList.empty())
	{
		return INVALID_ROLE_UID;
	}

	return _roleList[0].roleUID;
}
