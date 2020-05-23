#include "md5.h"

void MD5_Transform (uint32 *buf, uint32 *in)
{
	uint32 a = buf[0], b = buf[1], c = buf[2], d = buf[3];


	MD5_FF ( a, b, c, d, in[ 0], MD5_S11, (uint32) 3614090360u);  
	MD5_FF ( d, a, b, c, in[ 1], MD5_S12, (uint32) 3905402710u);  
	MD5_FF ( c, d, a, b, in[ 2], MD5_S13, (uint32)  606105819u);  
	MD5_FF ( b, c, d, a, in[ 3], MD5_S14, (uint32) 3250441966u);  
	MD5_FF ( a, b, c, d, in[ 4], MD5_S11, (uint32) 4118548399u);  
	MD5_FF ( d, a, b, c, in[ 5], MD5_S12, (uint32) 1200080426u);  
	MD5_FF ( c, d, a, b, in[ 6], MD5_S13, (uint32) 2821735955u);  
	MD5_FF ( b, c, d, a, in[ 7], MD5_S14, (uint32) 4249261313u);  
	MD5_FF ( a, b, c, d, in[ 8], MD5_S11, (uint32) 1770035416u);  
	MD5_FF ( d, a, b, c, in[ 9], MD5_S12, (uint32) 2336552879u);  
	MD5_FF ( c, d, a, b, in[10], MD5_S13, (uint32) 4294925233u);  
	MD5_FF ( b, c, d, a, in[11], MD5_S14, (uint32) 2304563134u);  
	MD5_FF ( a, b, c, d, in[12], MD5_S11, (uint32) 1804603682u);  
	MD5_FF ( d, a, b, c, in[13], MD5_S12, (uint32) 4254626195u);  
	MD5_FF ( c, d, a, b, in[14], MD5_S13, (uint32) 2792965006u);  
	MD5_FF ( b, c, d, a, in[15], MD5_S14, (uint32) 1236535329u);  


	MD5_GG ( a, b, c, d, in[ 1], MD5_S21, (uint32) 4129170786u);  
	MD5_GG ( d, a, b, c, in[ 6], MD5_S22, (uint32) 3225465664u);  
	MD5_GG ( c, d, a, b, in[11], MD5_S23, (uint32)  643717713u);  
	MD5_GG ( b, c, d, a, in[ 0], MD5_S24, (uint32) 3921069994u);  
	MD5_GG ( a, b, c, d, in[ 5], MD5_S21, (uint32) 3593408605u);  
	MD5_GG ( d, a, b, c, in[10], MD5_S22, (uint32)   38016083u);  
	MD5_GG ( c, d, a, b, in[15], MD5_S23, (uint32) 3634488961u);  
	MD5_GG ( b, c, d, a, in[ 4], MD5_S24, (uint32) 3889429448u);  
	MD5_GG ( a, b, c, d, in[ 9], MD5_S21, (uint32)  568446438u);  
	MD5_GG ( d, a, b, c, in[14], MD5_S22, (uint32) 3275163606u);  
	MD5_GG ( c, d, a, b, in[ 3], MD5_S23, (uint32) 4107603335u);  
	MD5_GG ( b, c, d, a, in[ 8], MD5_S24, (uint32) 1163531501u);  
	MD5_GG ( a, b, c, d, in[13], MD5_S21, (uint32) 2850285829u);  
	MD5_GG ( d, a, b, c, in[ 2], MD5_S22, (uint32) 4243563512u);  
	MD5_GG ( c, d, a, b, in[ 7], MD5_S23, (uint32) 1735328473u);  
	MD5_GG ( b, c, d, a, in[12], MD5_S24, (uint32) 2368359562u);  


	MD5_HH ( a, b, c, d, in[ 5], MD5_S31, (uint32) 4294588738u);  
	MD5_HH ( d, a, b, c, in[ 8], MD5_S32, (uint32) 2272392833u);  
	MD5_HH ( c, d, a, b, in[11], MD5_S33, (uint32) 1839030562u);  
	MD5_HH ( b, c, d, a, in[14], MD5_S34, (uint32) 4259657740u);  
	MD5_HH ( a, b, c, d, in[ 1], MD5_S31, (uint32) 2763975236u);  
	MD5_HH ( d, a, b, c, in[ 4], MD5_S32, (uint32) 1272893353u);  
	MD5_HH ( c, d, a, b, in[ 7], MD5_S33, (uint32) 4139469664u);  
	MD5_HH ( b, c, d, a, in[10], MD5_S34, (uint32) 3200236656u);  
	MD5_HH ( a, b, c, d, in[13], MD5_S31, (uint32)  681279174u);  
	MD5_HH ( d, a, b, c, in[ 0], MD5_S32, (uint32) 3936430074u);  
	MD5_HH ( c, d, a, b, in[ 3], MD5_S33, (uint32) 3572445317u);  
	MD5_HH ( b, c, d, a, in[ 6], MD5_S34, (uint32)   76029189u);  
	MD5_HH ( a, b, c, d, in[ 9], MD5_S31, (uint32) 3654602809u);  
	MD5_HH ( d, a, b, c, in[12], MD5_S32, (uint32) 3873151461u);  
	MD5_HH ( c, d, a, b, in[15], MD5_S33, (uint32)  530742520u);  
	MD5_HH ( b, c, d, a, in[ 2], MD5_S34, (uint32) 3299628645u);  


	MD5_II ( a, b, c, d, in[ 0], MD5_S41, (uint32) 4096336452u);  
	MD5_II ( d, a, b, c, in[ 7], MD5_S42, (uint32) 1126891415u);  
	MD5_II ( c, d, a, b, in[14], MD5_S43, (uint32) 2878612391u);  
	MD5_II ( b, c, d, a, in[ 5], MD5_S44, (uint32) 4237533241u);  
	MD5_II ( a, b, c, d, in[12], MD5_S41, (uint32) 1700485571u);  
	MD5_II ( d, a, b, c, in[ 3], MD5_S42, (uint32) 2399980690u);  
	MD5_II ( c, d, a, b, in[10], MD5_S43, (uint32) 4293915773u);  
	MD5_II ( b, c, d, a, in[ 1], MD5_S44, (uint32) 2240044497u);  
	MD5_II ( a, b, c, d, in[ 8], MD5_S41, (uint32) 1873313359u);  
	MD5_II ( d, a, b, c, in[15], MD5_S42, (uint32) 4264355552u);  
	MD5_II ( c, d, a, b, in[ 6], MD5_S43, (uint32) 2734768916u);  
	MD5_II ( b, c, d, a, in[13], MD5_S44, (uint32) 1309151649u);  
	MD5_II ( a, b, c, d, in[ 4], MD5_S41, (uint32) 4149444226u);  
	MD5_II ( d, a, b, c, in[11], MD5_S42, (uint32) 3174756917u);  
	MD5_II ( c, d, a, b, in[ 2], MD5_S43, (uint32)  718787259u);  
	MD5_II ( b, c, d, a, in[ 9], MD5_S44, (uint32) 3951481745u);  

	buf[0] += a;
	buf[1] += b;
	buf[2] += c;
	buf[3] += d;
}

void MD5Init (MD5_CTX *mdContext, uint32 pseudoRandomNumber)
{
	mdContext->i[0] = mdContext->i[1] = (uint32)0;

	mdContext->buf[0] = (uint32)0x67452301 + (pseudoRandomNumber * 11);
	mdContext->buf[1] = (uint32)0xefcdab89 + (pseudoRandomNumber * 71);
	mdContext->buf[2] = (uint32)0x98badcfe + (pseudoRandomNumber * 37);
	mdContext->buf[3] = (uint32)0x10325476 + (pseudoRandomNumber * 97);
}

void MD5Update (MD5_CTX *mdContext, unsigned char *inBuf, unsigned int inLen)
{
	uint32 in[16];
	int mdi = 0;
	unsigned int i = 0, ii = 0;


	mdi = (int)((mdContext->i[0] >> 3) & 0x3F);


	if ((mdContext->i[0] + ((uint32)inLen << 3)) < mdContext->i[0])
		mdContext->i[1]++;
	mdContext->i[0] += ((uint32)inLen << 3);
	mdContext->i[1] += ((uint32)inLen >> 29);

	while (inLen--)
	{

		mdContext->in[mdi++] = *inBuf++;


		if (mdi == 0x40)
		{
			for (i = 0, ii = 0; i < 16; i++, ii += 4)
				in[i] = (((uint32)mdContext->in[ii+3]) << 24) |
				(((uint32)mdContext->in[ii+2]) << 16) |
				(((uint32)mdContext->in[ii+1]) << 8) |
				((uint32)mdContext->in[ii]);

			MD5_Transform (mdContext->buf, in);
			mdi = 0;
		}
	}
}

void MD5Final(MD5_CTX *mdContext, MD5_DIGEST* pMd5)
{
	uint32 in[16];
	int mdi = 0;
	unsigned int i = 0, ii = 0, padLen = 0;

	in[14] = mdContext->i[0];
	in[15] = mdContext->i[1];

	mdi = (int)((mdContext->i[0] >> 3) & 0x3F);

	padLen = (mdi < 56) ? (56 - mdi) : (120 - mdi);
	MD5Update (mdContext, MD5_PADDING, padLen);


	for (i = 0, ii = 0; i < 14; i++, ii += 4)
		in[i] = (((uint32)mdContext->in[ii+3]) << 24) |
		(((uint32)mdContext->in[ii+2]) << 16) |
		(((uint32)mdContext->in[ii+1]) <<  8) |
		((uint32)mdContext->in[ii]);
	MD5_Transform (mdContext->buf, in);

	for (i = 0, ii = 0; i < 4; i++, ii += 4){
		mdContext->digest[ii]   = (unsigned char)( mdContext->buf[i]        & 0xFF);
		mdContext->digest[ii+1] = (unsigned char)((mdContext->buf[i] >>  8) & 0xFF);
		mdContext->digest[ii+2] = (unsigned char)((mdContext->buf[i] >> 16) & 0xFF);
		mdContext->digest[ii+3] = (unsigned char)((mdContext->buf[i] >> 24) & 0xFF);
		((unsigned int*)pMd5)[i]=*((unsigned int*)&mdContext->digest[ii]);
	}
}