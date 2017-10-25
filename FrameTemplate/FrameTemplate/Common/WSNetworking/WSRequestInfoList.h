//
//  WSRequestInfoList.h
//  FrameTemplate
//
//  Created by zws on 2017/10/25.
//  Copyright © 2017年 vma. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 请求列表数据类，加载一个列表数据的时候使用该列，实现分页加载
 */
@interface WSRequestInfoList : NSObject

@property (nonatomic, copy) NSMutableArray *list;

/**
 请求参数，如若遇到筛选数据变更参数时使用
 */
@property (nonatomic, copy) NSMutableDictionary *params;

/**
 初始化列表数据类

 @param action 请求地址或者方法
 @param modelName 数据结构名称
 @param params 请求参数
 @param successBlock 请求成功回调
 @param failureBlock 请求失败回调
 @return 返回该类实例
 */
- (instancetype)initWithAction:(NSString*)action model:(NSString*)modelName params:(id)params successBlock:(WSRequestInfoListSuccessBlock)successBlock failureBlock:(WSRequestFailureBlock)failureBlock;


/**
 重新加载数据
 */
- (void)reloadListData;

/**
 加载下一页数据
 */
- (void)requestNextListData;

@end
