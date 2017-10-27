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

- (void)doneLoadingTableViewData;
- (void)setRefreshCategory:(RefreshCategory)refreshCategory;
- (void)setLoadedAllTheData;
- (void)showNoDataViewWithImage:(UIImage *)image tips:(NSString *)tips;
- (void)resetNoDataViewFrame:(CGRect)frame;
- (void)hideNoDataView;
- (void)showCustomView:(UIView*)view;
- (void)hideCustomView;
- (void)beginRefreshing;
- (void)reloadDataWithAnimate;

@end
