//
//  WSRefreshTableView.h
//  FrameTemplate
//
//  Created by zws on 2017/10/27.
//  Copyright © 2017年 vma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

typedef NS_ENUM(NSInteger, RefreshCategory) {
    BothRefresh = 0,
    DropdownRefresh,
    PullRefresh,
    NoRefresh
};

@protocol WSRefreshTableViewDelegate <NSObject>

@optional
- (void)getHeaderDataSoure;
- (void)getFooterDataSoure;

@end

@interface WSRefreshTableView : UITableView {
    RefreshCategory _refreshCategory;
    CGPoint _point;//判断是上拉还是下拉
    
    BOOL _reloading;
    BOOL _isLoadedAllTheData;//是否已经加载完服务器端所有的数据
}

@property (nonatomic, assign) BOOL isLoadedAllTheData;
@property (nonatomic, weak) id<WSRefreshTableViewDelegate> customTableDelegate;


/**
 数据加载完成后调用此函数，结束刷新动作
 */
- (void)doneLoadingTableViewData;

/**
 设置刷新模式，仅使用下拉、上下拉、下拉，或者不使用上下拉

 @param refreshCategory 刷新模式
 */
- (void)setRefreshCategory:(RefreshCategory)refreshCategory;

- (void)setLoadedAllTheData;


/**
 无数据时使用，添加无数据背景

 @param image 背景图片
 @param tips 提示
 */
- (void)showNoDataViewWithImage:(UIImage *)image tips:(NSString *)tips;


/**
 重新设置无数据frame

 @param frame 要设定的frame
 */
- (void)resetNoDataViewFrame:(CGRect)frame;


/**
 隐藏无数据背景
 */
- (void)hideNoDataView;


/**
 自定义背景

 @param view 自定义的view
 */
- (void)showCustomView:(UIView*)view;


/**
 隐藏自定义背景
 */
- (void)hideCustomView;


/**
 开始刷新
 */
- (void)beginRefreshing;


/**
 刷新后列表的动画
 */
- (void)reloadDataWithAnimate;

@end
