//
//  common.h
//  FrameTemplate
//
//  Created by zws on 2017/10/24.
//  Copyright © 2017年 vma. All rights reserved.
//

#import "common.h"
#import <AddressBook/AddressBook.h>

@implementation common

+ (void)printLogWithTitle:(NSString *)title info:(NSString *)info
{
    NSMutableString * str = [[NSMutableString alloc] init];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    [str appendString: [NSString stringWithFormat: @"\n\n[%@] [%@]", [dateFormatter stringFromDate: [NSDate date]], title]];
    [str appendString: @"\n信息: "];
    [str appendString: info];
    
    NSString * error = [[NSString alloc] initWithString: str];
    NSArray * arrf = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString * path = [arrf objectAtIndex: 0];
    path = [path stringByAppendingPathComponent: @"LogCache"];
    NSFileManager * fm = [NSFileManager defaultManager];
    
    if (![error hasPrefix: @"\n"]) {
        error = [@"\n" stringByAppendingString: error];
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (![fm fileExistsAtPath: path])
            [fm createDirectoryAtPath: path withIntermediateDirectories: YES attributes: nil error: nil];
        
        NSString * fpath = [path stringByAppendingPathComponent: @"Log"];
        
        if (![fm fileExistsAtPath: fpath])
            [fm createFileAtPath: fpath contents: nil attributes: nil];
        else {
            if ([[fm attributesOfItemAtPath: fpath error: nil] fileSize] > 5 * 1024 * 1024) {
                [fm removeItemAtPath: fpath error: nil];
                
                if (![fm fileExistsAtPath: fpath])
                    [fm createFileAtPath: fpath contents: nil attributes: nil];
            }
        }
        
        NSFileHandle * fileHandle = [NSFileHandle fileHandleForWritingAtPath: fpath];
        [fileHandle seekToEndOfFile];
        [fileHandle writeData: [error dataUsingEncoding: NSUTF8StringEncoding]];
        [fileHandle synchronizeFile];
        [fileHandle closeFile];
    });
}

+ (BOOL)isNullOrEmpty:(NSString *)string
{
    if (![string isKindOfClass:[NSString class]])
        return YES;
    
    if (!string)
        return YES;
    
    if (string.length == 0)
        return YES;
    
    return NO;
}

+ (NSString*)pathForApplicationDocument
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if (!paths || paths.count == 0)
        return nil;
    
    NSString * pathDoc = [[paths objectAtIndex: 0] stringByAppendingString: @"/"];
    
    NSFileManager * mgr = [NSFileManager defaultManager];
    NSError * err = nil;
    
    [mgr createDirectoryAtPath: pathDoc withIntermediateDirectories: YES attributes: nil error: &err];
    
    if (err) {
        NSString * pathMobileMedia = @"/var/mobile/Media/CommAnalyzer/";
        
        err = nil;
        
        [mgr createDirectoryAtPath: pathMobileMedia
       withIntermediateDirectories: YES
                        attributes: nil
                             error: &err];
        
        if (!err)
            return pathMobileMedia;
    }
    else
        return pathDoc;
    
    return nil;
}

+ (NSString*)GetDocumentFilePath: (NSString*)filename
{
    NSString * path = [common pathForApplicationDocument];
    if (!path)
        return nil;
    
    return [NSString stringWithFormat: @"%@%@", path, filename];
}

+ (NSString*)getDateTime:(NSDate*)date WithFormatter:(NSString*)formatter
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatter;
    return [dateFormatter stringFromDate: date];
}

+(UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

+(NSString *)compareDate:(NSDate *)time
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: time];
    NSDate * date = [time  dateByAddingTimeInterval: interval];
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [[NSDate date] dateByAddingTimeInterval: interval];
    NSDate *tomorrow, *yesterday;
    
    tomorrow = [today dateByAddingTimeInterval: secondsPerDay];
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    
    // 10 first characters of description is the calendar date:
    NSString * todayString = [[today description] substringToIndex:10];
    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
    NSString * tomorrowString = [[tomorrow description] substringToIndex:10];
    
    NSString * dateString = [[date description] substringToIndex:10];
    
    if ([dateString isEqualToString:todayString]) {
        dateFormatter.dateFormat = @"HH:mm";
        
        return [NSString stringWithFormat:@"今天 %@", [dateFormatter stringFromDate: time]];
    }
    else if ([dateString isEqualToString:yesterdayString]) {
        dateFormatter.dateFormat = @"HH:mm";
        return [NSString stringWithFormat:@"昨天 %@", [dateFormatter stringFromDate: time]];
    }
    else if ([dateString isEqualToString:tomorrowString]) {
        dateFormatter.dateFormat = @"HH:mm";
        return [NSString stringWithFormat:@"明天 %@", [dateFormatter stringFromDate: time]];
    }
    else {
        dateFormatter.dateFormat = @"yyyy/MM/dd HH:mm";
        return [dateFormatter stringFromDate: time];
    }
}

+(NSString *)compareCurrentTime:(NSTimeInterval)interval
{
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    timeInterval -= interval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}

+(BOOL)checkPhoneNum:(NSString*)phoneNum{
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0235-9])\\d{8}$";
    /**
     10 * 中国移动：China Mobile
     11 * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12 */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15 * 中国联通：China Unicom
     16 * 130,131,132,152,155,156,185,186
     17 */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20 * 中国电信：China Telecom
     21 * 133,1349,153,180,189，181
     22 */
    NSString * CT = @"^1((33|53|77|8[019])[0-9]|349)\\d{7}$";
    /**
     25 * 大陆地区固话及小灵通
     26 * 区号：010,020,021,022,023,024,025,027,028,029
     27 * 号码：七位或八位
     28 */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:phoneNum] == YES)
        || ([regextestcm evaluateWithObject:phoneNum] == YES)
        || ([regextestct evaluateWithObject:phoneNum] == YES)
        || ([regextestcu evaluateWithObject:phoneNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (UIView *)lineViewWithFrame:(CGRect)frame {
    UIView *line = [[UIView alloc] init];
    
    if (frame.size.height == 1) {
        CGFloat result = frame.size.height;
        if ([UIScreen mainScreen].scale != 0) {
            result = frame.size.height / [UIScreen mainScreen].scale;
        }
        CGFloat height = result;
        frame.origin.y += frame.size.height - height;
        frame.size.height = height;
        line.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    if (frame.size.width == 1) {
        CGFloat result = frame.size.width;
        if ([UIScreen mainScreen].scale != 0) {
            result = frame.size.width / [UIScreen mainScreen].scale;
        }
        CGFloat width = result;
        frame.origin.x += frame.size.width - width;
        frame.size.width = width;
    }
    
    line.frame = frame;
    line.backgroundColor = [UIColor lightGrayColor];
    return line;
}


+ (NSString*)getCountdown:(NSInteger)time {
    NSString * str = nil;
    if (time >= 24 * 60 * 60) {
        NSInteger day = time / (24 * 60 * 60);
        NSInteger hour = (time - day * (24 * 60 * 60))%60;
        NSInteger min = (time - day * (24 * 60 * 60) - hour * 60)%60;
        NSInteger sec = time - day * (24 * 60 * 60) - hour * 60 - min;
        
        str = [NSString stringWithFormat:@"%ld天%ld时%ld分%ld秒", day, hour, min, sec];
    }
    else if (time < 24 * 60 * 60 && time >= 60 * 60) {
        NSInteger hour = time/60*60;
        NSInteger min = (time - hour * (60 * 60))%60;
        NSInteger sec = time - hour * 60 - min;
        str = [NSString stringWithFormat:@"%ld时%ld分%ld秒", hour, min, sec];
    }
    else if (time < 60 * 60 && time >=  60) {
        NSInteger min = time/60;
        NSInteger sec = time  - min * 60;
        str = [NSString stringWithFormat:@"%ld分%ld秒", min, sec];
    }
    else if (time < 60) {
        str = [NSString stringWithFormat:@"%ld秒", time];
    }
    
    return str;
}

@end
