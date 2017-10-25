//
//  WSNetworkManager.h
//  FrameTemplate
//
//  Created by zws on 2017/10/24.
//  Copyright © 2017年 vma. All rights reserved.
//

#import "AFNetworking.h"
#import "WSNetworkRequestBlock.h"

@interface WSNetworkManager : AFHTTPSessionManager


/**
 实例网络请求对象，单例方法

 @return 实例对象
 */
+ (instancetype)shareManager;


/**
 POST请求

 @param action 请求地址或者方法
 @param params 请求参数
 @param successBlock 请求成功回调
 @param failureBlock 请求失败回调
 */
+ (void)postWithAction:(NSString*)action params:(id)params successBlock:(WSRequestSuccessBlock)successBlock failureBlock:(WSRequestFailureBlock)failureBlock;

/**
 GET请求
 
 @param action 请求地址或者方法
 @param params 请求参数
 @param successBlock 请求成功回调
 @param failureBlock 请求失败回调
 */
+ (void)getWithAction:(NSString*)action params:(id)params successBlock:(WSRequestSuccessBlock)successBlock failureBlock:(WSRequestFailureBlock)failureBlock;


/**
 上传多张图片

 @param action 请求地址或者方法
 @param images 内容为NSDictionary的原图片数组  
 @param params 需要携带参数
 @param successBlock 请求成功回调
 @param failureBlock 请求失败回调
 */
+ (void)uploadWithAction:(NSString*)action images:(NSArray*)images params:(id)params successBlock:(WSRequestSuccessBlock)successBlock failureBlock:(WSRequestFailureBlock)failureBlock;


/**
 取消所有网络请求，例如：一个页面在请求未完成时，pop当前页面，需要调用此函数来取消当前执行的所有请求
 */
+ (void)cancelAllRequest;

/**
 网络连接检测

 @return 是否不正常
 */
+ (BOOL)checkNetworkStatusError;

@end
