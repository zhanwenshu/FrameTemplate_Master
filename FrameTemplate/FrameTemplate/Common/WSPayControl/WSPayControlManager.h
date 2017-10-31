//
//  WSPayControlManager.h
//  FrameTemplate
//
//  Created by zws on 2017/10/31.
//  Copyright © 2017年 vma. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WSPayControlManagerDelegate <NSObject>

@optional

/**
 微信回调 code = 1为支付成功  code = 0为支付失败
 
 @param resultDic 回调结果
 */
- (void)wxPayCallBack:(NSDictionary*)resultDic;


/**
 支付宝回调 resultStatus = 9000为支付成功 其余为失败
 
 @param resultDic 回调结果
 */
- (void)aliPayCallBack:(NSDictionary*)resultDic;

@end

@interface WSPayControlManager : NSObject

@property (assign) id<WSPayControlManagerDelegate> delegate;

+(WSPayControlManager*)shareManager;

/**
 微信支付，数据全由后端处理好后，返回dictionary

 @param orderInfo 订单信息
 @return 发送请求支付是否成功
 */
- (BOOL)WXPay:(NSDictionary*)orderInfo;


/**
 支付宝支付，数据全由后端处理好后，返回字符串

 @param orderInfo 订单信息
 @return 发送请求支付是否成功
 */
- (BOOL)ALiPay:(NSString*)orderInfo;

@end
