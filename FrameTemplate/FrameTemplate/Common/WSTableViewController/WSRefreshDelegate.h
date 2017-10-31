//
//  WSRefreshDelegate.h
//  FrameTemplate
//
//  Created by zws on 2017/10/31.
//  Copyright © 2017年 vma. All rights reserved.
//

typedef NS_ENUM(NSInteger, RefreshCategory) {
    BothRefresh = 0,
    DropdownRefresh,
    PullRefresh,
    NoRefresh
};

@protocol WSRefreshDelegate <NSObject>

@optional
- (void)getHeaderDataSoure;
- (void)getFooterDataSoure;

@end
