require "api/lua/cpprootdir"
require "api/lua/cppapi"

do return{

TMXLayer = {
  description = "",
  type = "class",
  inherits = "Node ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "TMXLayer",
      valuetype = "TMXLayer",
    },
    getPositionAt={
      description = "",
      type = "method",
      args="(Vec2: tileCoordinate)",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    setLayerOrientation={
      description = "",
      type = "method",
      args="(int: orientation)",
      returns = "void",
      valuetype = "void"
    },
    getLayerSize={
      description = "",
      type = "method",
      args="()",
      returns = "Size",
      valuetype = "Size"
    },
    setMapTileSize={
      description = "",
      type = "method",
      args="(Size: size)",
      returns = "void",
      valuetype = "void"
    },
    getLayerOrientation={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setProperties={
      description = "",
      type = "method",
      args="(unordered_map<basic_string<char>, cocos2d::Value, hash<string>, equal_to<basic_string<char> >, allocator<pair<const basic_string<char>, cocos2d::Value> > >: properties)",
      returns = "void",
      valuetype = "void"
    },
    setLayerName={
      description = "",
      type = "method",
      args="(string: layerName)",
      returns = "void",
      valuetype = "void"
    },
    removeTileAt={
      description = "",
      type = "method",
      args="(Vec2: tileCoordinate)",
      returns = "void",
      valuetype = "void"
    },
    setupTiles={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setupTileSprite={
      description = "",
      type = "method",
      args="(Sprite*: sprite,Vec2: pos,int: gid)",
      returns = "void",
      valuetype = "void"
    },
    getMapTileSize={
      description = "",
      type = "method",
      args="()",
      returns = "Size",
      valuetype = "Size"
    },
    getProperty={
      description = "",
      type = "method",
      args="(string: propertyName)",
      returns = "Value",
      valuetype = "Value"
    },
    setLayerSize={
      description = "",
      type = "method",
      args="(Size: size)",
      returns = "void",
      valuetype = "void"
    },
    getLayerName={
      description = "",
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    setTileSet={
      description = "",
      type = "method",
      args="(TMXTilesetInfo*: info)",
      returns = "void",
      valuetype = "void"
    },
    getTileSet={
      description = "",
      type = "method",
      args="()",
      returns = "TMXTilesetInfo*",
      valuetype = "TMXTilesetInfo"
    },
    getTileAt={
      description = "",
      type = "method",
      args="(Vec2: tileCoordinate)",
      returns = "Sprite*",
      valuetype = "Sprite"
    },
    create={
	  description = "",
      type = "method",
      args="(TMXTilesetInfo*: tilesetInfo,TMXLayerInfo*: layerInfo,TMXMapInfo*: mapInfo)",
      returns = "TMXLayer*",
      valuetype = "TMXLayer"
    },
  },
},

TMXTiledMap = {
  description = "",
  type = "class",
  inherits = "Node ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "TMXTiledMap",
      valuetype = "TMXTiledMap",
    },
    setObjectGroups={
      description = "",
      type = "method",
      args="(Vector<cocos2d::TMXObjectGroup *>: groups)",
      returns = "void",
      valuetype = "void"
    },
    getProperty={
      description = "",
      type = "method",
      args="(string: propertyName)",
      returns = "Value",
      valuetype = "Value"
    },
    setMapSize={
      description = "",
      type = "method",
      args="(Size: mapSize)",
      returns = "void",
      valuetype = "void"
    },
    getObjectGroup={
      description = "",
      type = "method",
      args="(string: groupName)",
      returns = "TMXObjectGroup*",
      valuetype = "TMXObjectGroup"
    },
    getTileSize={
      description = "",
      type = "method",
      args="()",
      returns = "Size",
      valuetype = "Size"
    },
    getMapSize={
      description = "",
      type = "method",
      args="()",
      returns = "Size",
      valuetype = "Size"
    },
    getProperties={
      description = "",
      type = "method",
      args="()",
      returns = "unordered_map<basic_string<char>, cocos2d::Value, hash<string>, equal_to<basic_string<char> >, allocator<pair<const basic_string<char>, cocos2d::Value> > >",
      valuetype = "unordered_map<basic_string<char>, cocos2d::Value, hash<string>, equal_to<basic_string<char> >, allocator<pair<const basic_string<char>, cocos2d::Value> > >"
    },
    getPropertiesForGID={
      description = "",
      type = "method",
      args="(int: GID)",
      returns = "Value",
      valuetype = "Value"
    },
    setTileSize={
      description = "",
      type = "method",
      args="(Size: tileSize)",
      returns = "void",
      valuetype = "void"
    },
    setProperties={
      description = "",
      type = "method",
      args="(unordered_map<basic_string<char>, cocos2d::Value, hash<string>, equal_to<basic_string<char> >, allocator<pair<const basic_string<char>, cocos2d::Value> > >: properties)",
      returns = "void",
      valuetype = "void"
    },
    getLayer={
      description = "",
      type = "method",
      args="(string: layerName)",
      returns = "TMXLayer*",
      valuetype = "TMXLayer"
    },
    getMapOrientation={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setMapOrientation={
      description = "",
      type = "method",
      args="(int: mapOrientation)",
      returns = "void",
      valuetype = "void"
    },
    create={
	  description = "",
      type = "method",
      args="(string: tmxFile)",
      returns = "TMXTiledMap*",
      valuetype = "TMXTiledMap"
    },
    createWithXML={
	  description = "",
      type = "method",
      args="(string: tmxString,string: resourcePath)",
      returns = "TMXTiledMap*",
      valuetype = "TMXTiledMap"
    },
  },
},

}
end