//
//  AppDelegate.m
//  FrameTemplate
//
//  Created by zws on 2017/10/24.
//  Copyright © 2017年 vma. All rights reserved.
//

#import "AppDelegate.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>

#import "ViewController.h"

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] ;
    
    [WXApi registerApp:kWXAppKey];
    
    ViewController *vc = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:vc];
    self.window.rootViewController = navVC;
    
    [self navigationBarConfig];
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if ([url.absoluteString rangeOfString:kWXAppKey options:NSCaseInsensitiveSearch].length > 0) {
        return [WXApi handleOpenURL:url delegate:self];
    }
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([url.absoluteString rangeOfString:kWXAppKey options:NSCaseInsensitiveSearch].length > 0) {
        return [WXApi handleOpenURL:url delegate:self];
    }
    else if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    
    return YES;
}

-(void)onResp:(BaseResp*)resp{
    NSLog(@"resp %d",resp.errCode);
    
    /*
     enum  WXErrCode {
     WXSuccess           = 0,    成功
     WXErrCodeCommon     = -1,  普通错误类型
     WXErrCodeUserCancel = -2,    用户点击取消并返回
     WXErrCodeSentFail   = -3,   发送失败
     WXErrCodeAuthDeny   = -4,    授权失败
     WXErrCodeUnsupport  = -5,   微信不支持
     };
     */
    if ([resp isKindOfClass:[SendAuthResp class]]) {   //授权登录的类。
        if (resp.errCode == 0) {  //成功。
            //这里处理回调的方法 。 通过代理吧对应的登录消息传送过去。
        }
        else{ //失败
            NSLog(@"error %@",resp.errStr);
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登录失败" message:[NSString stringWithFormat:@"reason : %@",resp.errStr] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        }
    }
    else if([resp isKindOfClass:[PayResp class]]){
        switch (resp.errCode) {
            case WXSuccess:
                [[NSNotificationCenter defaultCenter] postNotificationName:kWXPayNotification object:nil userInfo:@{@"code":@(1), @"msg":@"支付成功"}];
                break;
                
            default:
                [[NSNotificationCenter defaultCenter] postNotificationName:kWXPayNotification object:nil userInfo:@{@"code":@(0), @"msg":@"支付失败"}];
                break;
        }
    }
}

- (void)navigationBarConfig {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [[UINavigationBar appearance] setBarTintColor: MAIN_COLOR];
    [[UINavigationBar appearance] setTitleTextAttributes: @{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont boldSystemFontOfSize:18]}];
    [[UIBarButtonItem appearance] setTitleTextAttributes: @{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont boldSystemFontOfSize:16]} forState: 0];
}
@end
