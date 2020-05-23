#include "my_crypt_util.h"

#include "core/file_system_util.h"
#include "cryptocpp/cryptlib.h"
#include "cryptocpp/config.h"
#include "cryptocpp/aes.h"
#include "cryptocpp/modes.h"
#include "cryptocpp/filters.h"

void AESEncrypt(byte* keys, uint32 keyLen, byte* inBlock, uint32 dataLen, std::string& outData, bool outPut)
{
	CryptoPP::AESEncryption aesEncryptor;							// 加密器 
	aesEncryptor.SetKey( keys, keyLen );							// 设定加密密钥
	byte iv[CryptoPP::AES::BLOCKSIZE] = "axjhgame";					// 初始向量组

	CryptoPP::CBC_Mode_ExternalCipher::Encryption cbcEncryption(aesEncryptor, iv);
	CryptoPP::StreamTransformationFilter stfEncryptor(cbcEncryption, new CryptoPP::StringSink(outData));

	stfEncryptor.Put(inBlock, dataLen);
	stfEncryptor.MessageEnd();

	if(outPut)
	{
		std::cout<<"===================OutPut Encryption Data, ByteLen="<<outData.size()<<"==================="<<std::endl;
		for( uint32 i = 0; i<outData.size(); i++) 
		{
			std::cout << std::hex << (0xFF & static_cast<byte>(outData[i])) << " ";
		}

		std::cout << std::endl << std::endl;
	}
}

void AESDecrypt(byte* keys, uint32 keyLen, byte* inBlock, uint32 dataLen, std::string& outData, bool outPut)
{
	byte iv[CryptoPP::AES::BLOCKSIZE] = "axjhgame";
	CryptoPP::AESDecryption aesDecryptor;
	aesDecryptor.SetKey(keys, keyLen);

	CryptoPP::CBC_Mode_ExternalCipher::Decryption cbcDecryption(aesDecryptor, iv);
	CryptoPP::StreamTransformationFilter stfDecryptor(cbcDecryption, new CryptoPP::StringSink(outData));
	stfDecryptor.Put(inBlock, dataLen);
	stfDecryptor.MessageEnd();

	if(outPut)
	{
		std::cout<<"===================OutPut Decryption Data, ByteLen="<<outData.size()<<"==================="<<std::endl;
		for( uint32 i = 0; i<outData.size(); i++) 
		{
			std::cout << std::hex << (0xFF & static_cast<byte>(outData[i])) << " ";
		}

		std::cout << std::endl << std::endl;
	}
}

bool AESEncryptFile(byte* keys, uint32 keyLen, const std::string& fileName, std::string& outData, bool outPut)
{
	std::string data;
	if(!GXMISC::MyReadStringFile(fileName, data))
	{
		return false;
	}

	AESEncrypt(keys, keyLen, (byte*)data.c_str(), (uint32)data.size(), outData, outPut);
	return true;
}

bool AESDecryptFile(byte* keys, uint32 keyLen, const std::string& fileName, std::string& outData, bool outPut)
{
	std::string data;
	if(!GXMISC::MyReadStringFile(fileName, data))
	{
		return false;
	}

	AESDecrypt(keys, keyLen, (byte*)data.c_str(), (uint32)data.size(), outData, outPut);
	return true;
}