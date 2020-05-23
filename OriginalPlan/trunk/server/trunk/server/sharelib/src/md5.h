#ifndef _MD5_H_
#define _MD5_H_

#include "core/types_def.h"

typedef unsigned char MD5_DIGEST[16];

typedef struct {
    uint32 i[2];                    
    uint32 buf[4];                                     
    unsigned char in[64];                               
    MD5_DIGEST digest;      
} MD5_CTX;

static unsigned char MD5_PADDING[64] = {
    0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
};


#define MD5_F(x, y, z) (((x) & (y)) | ((~x) & (z)))
#define MD5_G(x, y, z) (((x) & (z)) | ((y) & (~z)))
#define MD5_H(x, y, z) ((x) ^ (y) ^ (z))
#define MD5_I(x, y, z) ((y) ^ ((x) | (~z)))

#ifndef ROTATE_LEFT
#define ROTATE_LEFT(x, n) (((x) << (n)) | ((x) >> (32-(n))))
#endif

#define MD5_FF(a, b, c, d, x, s, ac) {(a) += MD5_F ((b), (c), (d)) + (x) + (uint32)(ac); (a) = ROTATE_LEFT ((a), (s)); (a) += (b); }
#define MD5_GG(a, b, c, d, x, s, ac) {(a) += MD5_G ((b), (c), (d)) + (x) + (uint32)(ac); (a) = ROTATE_LEFT ((a), (s)); (a) += (b); }
#define MD5_HH(a, b, c, d, x, s, ac) {(a) += MD5_H ((b), (c), (d)) + (x) + (uint32)(ac); (a) = ROTATE_LEFT ((a), (s)); (a) += (b); }
#define MD5_II(a, b, c, d, x, s, ac) {(a) += MD5_I ((b), (c), (d)) + (x) + (uint32)(ac); (a) = ROTATE_LEFT ((a), (s)); (a) += (b); }

#define MD5_S11 7   
#define MD5_S12 12
#define MD5_S13 17
#define MD5_S14 22
#define MD5_S21 5   
#define MD5_S22 9
#define MD5_S23 14
#define MD5_S24 20
#define MD5_S31 4   
#define MD5_S32 11
#define MD5_S33 16
#define MD5_S34 23
#define MD5_S41 6   
#define MD5_S42 10
#define MD5_S43 15
#define MD5_S44 21

extern void MD5_Transform (uint32 *buf, uint32 *in);
extern void MD5Update (MD5_CTX *mdContext, unsigned char *inBuf, unsigned int inLen);
extern void MD5Final(MD5_CTX *mdContext, MD5_DIGEST* pMd5);
extern void MD5Init (MD5_CTX *mdContext, uint32 pseudoRandomNumber);

#endif  
