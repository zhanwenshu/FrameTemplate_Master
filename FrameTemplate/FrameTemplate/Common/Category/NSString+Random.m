//
//  NSString+Random.m
//  HongMi
//
//  Created by Legolas on 16/9/26.
//  Copyright © 2016年 sihe. All rights reserved.
//

#import "NSString+Random.h"

@implementation NSString (Random)

+ (NSString *)randomStringWithLength:(NSInteger)length {
    char data[length];
    for (int i = 0; i < length; i++) {
        data[i] = arc4random_uniform(26) + 'A';
    }
    NSString *str = [[NSString alloc] initWithBytes:data length:length encoding:NSUTF8StringEncoding];
    return str;
}

@end
