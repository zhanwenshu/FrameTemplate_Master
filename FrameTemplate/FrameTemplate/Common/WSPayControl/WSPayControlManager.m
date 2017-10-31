//
//  WSPayControlManager.m
//  FrameTemplate
//
//  Created by zws on 2017/10/31.
//  Copyright © 2017年 vma. All rights reserved.
//

#import "WSPayControlManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"

@implementation WSPayControlManager

+(WSPayControlManager*)shareManager
{
    static dispatch_once_t onceToken;
    static WSPayControlManager * handler;
    
    dispatch_once(&onceToken, ^{
        handler = [[WSPayControlManager alloc] init];
    });
    
    return handler;
}

- (BOOL)WXPay:(NSDictionary*)orderInfo {
    PayReq * req = [[PayReq alloc] init];
    req.partnerId = [orderInfo objectForKey:@"partnerid"];
    req.prepayId = [orderInfo objectForKey:@"package_str"];
    req.nonceStr = [orderInfo objectForKey:@"nonce_str"];
    req.timeStamp = [[orderInfo objectForKey:@"timestamp"] intValue];
    req.package = @"Sign=WXPay";
    req.sign = [orderInfo objectForKey:@"pay_sign"];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"WXPayNotification"  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wxPayNotification:) name:kWXPayNotification object:nil];
    
    return [WXApi sendReq:req];
}

- (void)wxPayNotification:(NSNotification*)notification {
    NSDictionary *info = notification.userInfo;
    if (_delegate && [_delegate respondsToSelector: @selector(wxPayCallBack:)]) {
        [_delegate wxPayCallBack: info];
    }
}

- (BOOL)ALiPay:(NSString*)orderInfo
{
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"com.vma.FireCampus";
    
    if (orderInfo != nil) {
        [[AlipaySDK defaultService] payOrder:orderInfo fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            
            if (_delegate && [_delegate respondsToSelector: @selector(aliPayCallBack:)]) {
                [_delegate aliPayCallBack: resultDic];
            }
            
        }];
    }
    
    return YES;
}

@end
