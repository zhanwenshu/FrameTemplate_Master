//
//  NSDate+Addition.h
//  TigerLottery
//
//  Created by Legolas on 14/12/10.
//  Copyright (c) 2014年 adcocoa. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kMonDay @"周一"
#define kNumberOne @"01"
#define kDateFormat @"dd"

@interface NSDate (Addition)

- (NSString *)weekDay;

- (NSString *)formateDate:(NSString *)formate;

- (NSString *)setTimeInterval:(NSString *)timeInterval formateDate:(NSString *)formate;

- (NSString *)timeIntervalFromTime:(NSString *)time;

@end
