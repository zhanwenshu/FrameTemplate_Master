//
//  WSRequestInfoList.m
//  FrameTemplate
//
//  Created by zws on 2017/10/25.
//  Copyright © 2017年 vma. All rights reserved.
//

#import "WSRequestInfoList.h"

#define PAGE_COUNT  10   // 页数
#define START_PAGE  1    // 起始页数
#define kPageCount  @"page_size"
#define kPage       @"page_no"

@interface WSRequestInfoList ()

@property (nonatomic, assign) NSUInteger page; // 页数
@property (nonatomic, copy) NSString *action;
@property (nonatomic, copy) NSString *modelName;
@property (nonatomic, copy) NSMutableArray *tempList; // 临时列表数据
@property (nonatomic, copy) WSRequestInfoListSuccessBlock successBlock;
@property (nonatomic, copy) WSRequestFailureBlock failureBlock;

@end

@implementation WSRequestInfoList

- (instancetype)initWithAction:(NSString*)action model:(NSString*)modelName params:(id)params successBlock:(WSRequestInfoListSuccessBlock)successBlock failureBlock:(WSRequestFailureBlock)failureBlock {
    if (self = [super init]) {
        _action = action;
        _modelName = modelName;
        _params = [NSMutableDictionary dictionaryWithDictionary:params];
        _params[kPageCount] = @(PAGE_COUNT);
        _successBlock = successBlock;
        _failureBlock = failureBlock;
        _page = START_PAGE;
        _tempList = [NSMutableArray array];
    }
    
    return self;
}

#pragma -mark 公共方法

- (void)reloadListData {
    _page = 0;
    [self request];
}

- (void)requestNextListData {
    _page++;
    [self request];
}

#pragma -mark 私有方法

- (void)request {
    _params[kPage] = @(_page);
    __weak WSRequestInfoList *weakSelf = self;
    [WSNetworkManager postWithAction:_action params:_params successBlock:^(NSInteger errCode, id data, NSString *action, NSString *msg) {
        if (errCode == 0) {
            if (weakSelf.page == START_PAGE) {
                [weakSelf.tempList removeAllObjects];
            }
            
            NSArray *array = (NSArray*)data;
            // 判断是否已经加载所有数据
            BOOL isAllData = array.count < PAGE_COUNT ? YES:NO;
            
            for (NSDictionary *dict in array) {
                NSObject *obj = [NSClassFromString(_modelName) whc_ModelWithJson:dict];
                [weakSelf.tempList addObject:obj];
            }
            
            weakSelf.list = [NSMutableArray arrayWithArray:weakSelf.tempList];
            
            if (weakSelf.successBlock) {
                weakSelf.successBlock(errCode, weakSelf.list, action, msg, isAllData);
            }
        }
    } failureBlock:^(NSError *error, NSString *errorDesc) {
        if (weakSelf.failureBlock) {
            weakSelf.failureBlock(error, [error localizedDescription]);
        }
    }];
}

@end
