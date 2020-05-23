#ifndef _MY_CRYPT_UTIL_H_
#define _MY_CRYPT_UTIL_H_

#include "core/types_def.h"
#include "core/stdcore.h"

typedef unsigned char byte;	

extern void AESEncrypt(byte* keys, uint32 keyLen, byte* inBlock, uint32 dataLen, std::string& outData, bool outPut = false);
extern void AESDecrypt(byte* keys, uint32 keyLen, byte* inBlock, uint32 dataLen, std::string& outData, bool outPut = false);
extern bool AESEncryptFile(byte* keys, uint32 keyLen, const std::string& fileName, std::string& outData, bool outPut = false);
extern bool AESDecryptFile(byte* keys, uint32 keyLen, const std::string& fileName, std::string& outData, bool outPut = false);

#endif	// _MY_CRYPT_UTIL_H_