#ifndef _PROTOCOL_BASE_DEF_
#define _PROTOCOL_BASE_DEF_

/**
 * 数组
 * 数组起始一字节表示数组长度, 后面表示数据
 */
template<typename T>
struct array{};

/**
 * 数组2
 * 数组起始两字节表示数组长度, 后面表示数据
 */
template<typename T>
struct array2{};

/**
 * 字符串
 * 数组起始一字节表示字符串长度, 后面表示数据
 */
struct string{};

/**
 * 字符串2
 * 数组起始二字节表示字符串长度, 后面表示数据
 */
struct string2{};

#endif