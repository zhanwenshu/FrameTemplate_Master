//
//  WSNetworkRequestBlock.h
//  FrameTemplate
//
//  Created by zws on 2017/10/24.
//  Copyright © 2017年 vma. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 定义请求成功的block

 @param errCode 响应错误码
 @param data 响应数据
 @param action 请求操作
 @param msg 响应信息
 */
typedef void(^WSRequestSuccessBlock)(NSInteger errCode, id data, NSString *action, NSString *msg);

/**
 定义请求列表成功的block
 
 @param errCode 响应错误码
 @param data 响应列表数据
 @param action 请求操作
 @param msg 响应信息
 @param isAllData 是否已加载所有数据
 */
typedef void(^WSRequestInfoListSuccessBlock)(NSInteger errCode, id data, NSString *action, NSString *msg, BOOL isAllData);

/**
 定义请求失败的block

 @param error 错误参数
 */
typedef void(^WSRequestFailureBlock)(NSError *error, NSString *errorDesc);
