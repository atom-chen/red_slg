#include "game_rand.h"
#include "world_map_player_mgr.h"
#include "world_player_mgr.h"
#include "rand_name.h"
#include "world_all_user.h"
#include "dirty_word_filter.h"
#include "world_login_player_mgr.h"
#include "world_user_mgr.h"
#include "limit_manager.h"
#include "scene_manager.h"
#include "map_manager.h"
#include "world_sql_manager.h"
#include "server_singleton_var.inl"

//CRandGen RandGen;
CWorldMapPlayerMgr WorldMapPlayerMgr;
CWorldPlayerMgr WorldPlayerMgr;
CLoginPlayerMgr LoginPlayerMgr;
CRandRoleName RandRoleNameMgr;
CWorldAllUserMgr WorldAllUserMgr;
CCheckText CheckText;
CWorldUserMgr WorldUserMgr;
CLimitManager LimitManager;
CSceneManager SceneManager;

CSqlConnectionManager SqlConnectionManager;
CMapManager MapMangaer;