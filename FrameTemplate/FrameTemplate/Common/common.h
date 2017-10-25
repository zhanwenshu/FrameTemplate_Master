//
//  common.h
//  FrameTemplate
//
//  Created by zws on 2017/10/24.
//  Copyright © 2017年 vma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface common : NSObject


/**
 打印信息到日志文件中

 @param title 日志标题
 @param info 日志信息
 */
+ (void)printLogWithTitle:(NSString *)title info:(NSString *)info;


/**
 判断字符串是否为空

 @param string 需要判断的字符串
 @return 是否为空
 */
+ (BOOL)isNullOrEmpty:(NSString *)string;

/**
 获取文件路径

 @param filename 文件名称
 @return 返回文件文件路径
 */
+ (NSString*)GetDocumentFilePath:(NSString*)filename;


/**
 根据传入的时间和时间格式返回需要的时间字符串

 @param date 时间
 @param formatter 时间格式 例如：yyyy/MM/dd HH:mm:ss
 @return 时间字符串
 */
+ (NSString*)getDateTime:(NSDate*)date WithFormatter:(NSString*)formatter;


/**
 压缩图片到指定大小

 @param sourceImage 原图片
 @param size 知道大小
 @return 目标图片
 */
+(UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;


/**
 比较日期，返回今天明天后天

 @param time 当前需要比较的时间
 @return 返回今天、明天、后天
 */
+(NSString *)compareDate:(NSDate *)time;

/**
 计算指定时间与当前的时间差
 
 @param interval  某一指定时间
 @return 多少(秒or分or天or月or年)+前 (比如，3天前、10分钟前)
 */
+(NSString *)compareCurrentTime:(NSTimeInterval)interval;


/**
 手机号码校验

 @param phoneNum 手机号
 @return 是否为正确手机号
 */
+(BOOL)checkPhoneNum:(NSString*)phoneNum;


/**
 描绘像素为1的线条

 @param frame 线条frame
 @return 线条view
 */
+ (UIView *)lineViewWithFrame:(CGRect)frame;


/**
 倒计时

 @param time 倒计时时间秒数
 @return 时间天、时、分、秒
 */
+ (NSString*)getCountdown:(NSInteger)time;
@end
