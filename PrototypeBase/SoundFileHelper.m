//
//  SoundFileHelper.m
//  DemoV2
//
//  Created by Kenny Liou on 10/26/15.
//  Copyright © 2015 Baidu. All rights reserved.
//

#import "SoundFileHelper.h"

static int const kHeaderSize = 44;

@implementation SoundFileHelper

+ (NSMutableData *) createEmptyData
{
    return [NSMutableData dataWithLength:kHeaderSize];
}

+ (void)writeLittleEndianTo:(unsigned char*)buf withInt32:(int32_t)i {
    buf[0] = i & 0xff;
    buf[1] = (i >> 8) & 0xff;
    buf[2] = (i >> 16) & 0xff;
    buf[3] = (i >> 24) & 0xff;
}

+ (void)writeLittleEndianTo:(unsigned char*)buf withInt16:(int16_t)i {
    buf[0] = i & 0xff;
    buf[1] = (i >> 8) & 0xff;
}

+ (NSData *)writeWavHeader:(NSData *)original sampleRate:(int)sampleRate bitRate:(int)bitRate channel:(int)channel {
    
    NSMutableData * data = [original mutableCopy];
    
    if (data.length < kHeaderSize) {
        return NULL;
    }
    
    int voiceDataLen = (int) data.length - kHeaderSize;
    unsigned char *buffer = (unsigned char *)[data mutableBytes];
    strncpy((char*)buffer, "RIFF", 4);
    buffer += 4;
    [self writeLittleEndianTo:buffer withInt32:voiceDataLen+kHeaderSize-8];
    buffer += 4;
    strncpy((char*)buffer, "WAVE", 4);
    buffer += 4;
    strncpy((char*)buffer, "fmt ", 4);
    buffer += 4;
    [self writeLittleEndianTo:buffer withInt32:16];
    buffer += 4;
    [self writeLittleEndianTo:buffer withInt16:1]; // Type of format (1 is PCM)
    buffer += 2;
    [self writeLittleEndianTo:buffer withInt16:channel];
    buffer += 2;
    [self writeLittleEndianTo:buffer withInt32:sampleRate];
    buffer += 4;
    [self writeLittleEndianTo:buffer withInt32:sampleRate*bitRate*channel/8];
    buffer += 4;
    [self writeLittleEndianTo:buffer withInt16:bitRate*channel/8];
    buffer += 2;
    [self writeLittleEndianTo:buffer withInt16:bitRate];
    buffer += 2;
    strncpy((char*)buffer, "data", 4);
    buffer += 4;
    [self writeLittleEndianTo:buffer withInt32:voiceDataLen];
    
    return data;
}

@end
