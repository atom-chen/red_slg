#undef ENUM_ELEMENT
#undef ENUM_ELEMENT2
#undef BEGIN_ENUM
#undef END_ENUM

#ifndef GENERATE_ENUM_STRINGS
#define ENUM_ELEMENT( element ) element
#define ENUM_ELEMENT2( element, val ) element = val
#define BEGIN_ENUM( ENUM_NAME ) typedef enum tag##ENUM_NAME
#define END_ENUM( ENUM_NAME ) ENUM_NAME; \
    extern char* GetString##ENUM_NAME(enum tag##ENUM_NAME index);
#else
typedef struct { char * desc; int type;} EnumDesc_t;
#define ENUM_ELEMENT( element ) { #element, (int)(element) }
#define ENUM_ELEMENT2( element, val ) { #element, val }
#define BEGIN_ENUM( ENUM_NAME ) EnumDesc_t gs_##ENUM_NAME [] =
#define END_ENUM( ENUM_NAME ) ; char* GetString##ENUM_NAME(enum tag##ENUM_NAME index) \
{ for (int i = 0; i < sizeof(gs_##ENUM_NAME)/sizeof(EnumDesc_t); i++) { \
    if ((int)index == gs_##ENUM_NAME [i].type) return gs_##ENUM_NAME [i].desc; } \
    return "Unknown Enum type!!"; }
#endif


// in *.h
// #if ( !defined(DAYS_H) || defined(GENERATE_ENUM_STRINGS) )
// 
// #if (!defined(GENERATE_ENUM_STRINGS))
// #define DAYS_H
// #endif
// 
// #include "EnumToString.h"
// 
// ///////////////////////////////
// // The enum declaration
// ///////////////////////////////
// BEGIN_ENUM(Days)
// {
//     DECL_ENUM_ELEMENT(sunday),
//         DECL_ENUM_ELEMENT(monday),
//         DECL_ENUM_ELEMENT(tuesday),
//         DECL_ENUM_ELEMENT(wednesday),
//         DECL_ENUM_ELEMENT(thursday),
//         DECL_ENUM_ELEMENT(friday),
//         DECL_ENUM_ELEMENT(saturday)
// }
// END_ENUM(Days)
// 
// #endif // (!defined(DAYS_H) || defined(GENERATE_ENUM_STRINGS))


// in *.cpp
/// The strings associated with the enums are gererated here
// #define GENERATE_ENUM_STRINGS  // Start string generation
// #include "Days.h"             
// #undef GENERATE_ENUM_STRINGS   // Stop string generation
