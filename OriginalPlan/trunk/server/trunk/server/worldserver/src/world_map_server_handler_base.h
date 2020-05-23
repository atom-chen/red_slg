#ifndef _WORLD_MAP_SERVER_HANDLER_BASE_H_
#define _WORLD_MAP_SERVER_HANDLER_BASE_H_

#include "game_socket_handler.h"
#include "base_packet_def.h"
#include "packet_mw_base.h"

typedef GXMISC::EHandleRet (GXMISC::CSocketHandler::*TTransPacketHandler)(CBasePacket* packet, TObjUID_t objUID);
typedef CHashMap<TPacketID_t, TTransPacketHandler> TTransPacketHandlerHash;

class CWorldMapPlayer;
class CWorldMapServerHandlerBase : public CGameSocketHandler<CWorldMapServerHandlerBase>
{
public:
	typedef CGameSocketHandler<CWorldMapServerHandlerBase> TBaseType;

public:
	friend class CWorldMapPlayer;

public:
	CWorldMapServerHandlerBase() : CGameSocketHandler<CWorldMapServerHandlerBase>() {
		_serverID = INVALID_SERVER_ID;
	}

	~CWorldMapServerHandlerBase() {}

protected:
	// ����
	virtual bool start();
	// �ر�
	virtual void close();
	// ֡�¼�
	virtual void breath(GXMISC::TDiffTime_t diff);

public:
	// �˳�
	void quit();

public:
	/// �������������ID
	void setServerID(TServerID_t serverID);
	/// ��ȡ���������ID
	TServerID_t getServerID();
	/// ������־�ַ���
	void genStrName();
	/// ��ȡ�ַ����� 
	const char* toString();
	/// ��ȡ�����������ͼ�������
	CWorldMapPlayer* getWorldMapPlayer();

protected:
	// ��ͼ������ע��
	GXMISC::EHandleRet handleMapServreRegiste(MWRegiste* packet);
	// ���ؽ�ɫ����
	GXMISC::EHandleRet handleLoadRoleData(MWLoadRoleDataRet* packet);
	// �ͷ�MapServer�������Ͻ�ɫ����(����User��Player����)
	GXMISC::EHandleRet handleUnloadRoleData(MWUnloadRoleDataRet* packet);
	// ��ɫ�����˳�
	GXMISC::EHandleRet handleRoleQuit(MWRoleQuit* packet);
	// �û���½
	GXMISC::EHandleRet handleUserLogin(MWUserLogin* packet);
	// ��ɫ�ߵ�
	GXMISC::EHandleRet handleRoleKick(MWRoleKick* packet);
	// ��ɫ����
	GXMISC::EHandleRet handleRoleHeart(MWRoleHeart* packet);
	// ����㲥
	GXMISC::EHandleRet handleBroadCast(MWBroadPacket* packet);
	// ת����ת��
	GXMISC::EHandleRet handleTrans(MWTransPacket* packet);
	// ת�������������
	GXMISC::EHandleRet handleTrans2World(MWTrans2WorldPacket* packet);
	// �����ɫ����
	GXMISC::EHandleRet handleRandRoleName(MWRandRoleName* packet);
	// ��������ɫ��
	GXMISC::EHandleRet handleRenameRoleName(MWRenameRoleName* packet);
	// ��ȡ��������б�
	GXMISC::EHandleRet handleGetRandNameList(MWGetRandNameList* packet);
	// ��ֵ����
	GXMISC::EHandleRet handleRechargeRet(MWRechargeRet* packet);

protected:
	// ��ͼ������ע���¼�
	virtual void onMapServerRegiste(TServerID_t mapServer) {}

	// ע��ת���¼�
protected:
	static void RegisterTransHandler(TPacketID_t id, TTransPacketHandler handler);

	// ����ת��
private:
	GXMISC::EHandleRet doTransToWorld(char* msg, uint32 len, TObjUID_t objUID);

private:
	TServerID_t _serverID;			///< ������ID
	std::string _strName;			///< ��־�ַ���

private:
	static TTransPacketHandlerHash TransPacketHash;		///< ת�������
};

#endif	// _WORLD_MAP_SERVER_HANDLER_BASE_H_