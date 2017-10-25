//
//  NSDate+Addition.m
//  TigerLottery
//
//  Created by Legolas on 14/12/10.
//  Copyright (c) 2014年 adcocoa. All rights reserved.
//

#import "NSDate+Addition.h"

@implementation NSDate (Addition)

- (NSString *)weekDay {
    NSDateComponents *components = [[NSCalendar autoupdatingCurrentCalendar] components:NSWeekdayCalendarUnit fromDate:self];
    NSInteger weekday = [components weekday];
    NSDictionary *weekdayDic = @{@(1) : @"周日",
                                 @(2) : @"周一",
                                 @(3) : @"周二",
                                 @(4) : @"周三",
                                 @(5) : @"周四",
                                 @(6) : @"周五",
                                 @(7) : @"周六"};
    return [weekdayDic objectForKey:@(weekday)];
}

- (NSString *)formateDate:(NSString *)formate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formate];
    NSString *date = [dateFormatter stringFromDate:self];
    return date;
}

- (NSString *)timeIntervalFromTime:(NSString *)time {
    //当前时间
    NSDate *currDate = [NSDate date];
    NSInteger currTimeInterval = [currDate timeIntervalSince1970];
    //时间间隔
    NSInteger lastTime = time.longLongValue;
    NSInteger intevalTime = currTimeInterval - lastTime;
    
    NSInteger hours = intevalTime / 60 / 60;
    NSInteger minutes = intevalTime / 60;
    NSInteger day = intevalTime / 60 / 60 / 24;
    
    NSDate *lastDate = [NSDate dateWithTimeIntervalSince1970:lastTime];
    NSString *timeStr = nil;
    if (intevalTime <= 59) {
        timeStr = @"刚刚";
    }else if (minutes <= 59){
        timeStr = [NSString stringWithFormat:@"%ld分钟前",minutes];
    }else if (hours < 24){
        timeStr = [NSString stringWithFormat:@"%ld小时前",hours];
    }else if (day < 2){
        timeStr = @"昨天";
    }else {
        timeStr = [lastDate formateDate:@"yyyy/MM/dd"];
    }
    return timeStr;
}



- (NSString *)setTimeInterval:(NSString *)timeInterval formateDate:(NSString *)formate {
    NSTimeInterval interval = [timeInterval longLongValue];
    NSDate *currentDate = [[NSDate alloc] initWithTimeIntervalSince1970:interval];
    NSString *changedStr = [currentDate formateDate:formate];
    return changedStr;
}

@end
