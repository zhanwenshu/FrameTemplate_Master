//
//  WSRefreshTableView.m
//  FrameTemplate
//
//  Created by zws on 2017/10/27.
//  Copyright © 2017年 vma. All rights reserved.
//

#import "WSRefreshTableView.h"
#import "WSRefreshHeader.h"
#import "WSRefreshFooter.h"

@interface WSRefreshTableView ()

@property (nonatomic, strong) UIView *noDataView;
@property (nonatomic, strong) UIView *customView;

- (void)addHeaderRefreshView;
- (void)addFooterRefreshView;
- (void)removeHeaderAndFooterView;

@end

@implementation WSRefreshTableView

@synthesize customTableDelegate = _customTableDelegate;
@synthesize isLoadedAllTheData = _isLoadedAllTheData;

#pragma mark - view lifestyle

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return self;
}

#pragma mark - public methods

- (void)setRefreshCategory:(RefreshCategory)refreshCategory{
    [self removeHeaderAndFooterView];
    if (refreshCategory == DropdownRefresh) {
        [self addHeaderRefreshView];
    }else if(refreshCategory == PullRefresh){
        [self addFooterRefreshView];
    }else if(refreshCategory == BothRefresh){
        [self addHeaderRefreshView];
        [self addFooterRefreshView];
    }
}

- (void)setLoadedAllTheData {
    if (_isLoadedAllTheData) {
        [self.mj_footer endRefreshingWithNoMoreData];
    }
    else {
        [self.mj_footer resetNoMoreData];
    }
}

- (void)showNoDataViewWithImage:(UIImage *)image tips:(NSString *)tips {
    if (_noDataView == nil) {
        _noDataView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _noDataView.backgroundColor = [UIColor clearColor];
        [self addSubview:_noDataView];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((_noDataView.frame.size.width - image.size.width) / 2, 50, image.size.width, image.size.height)];
        imageView.image = image;
        [_noDataView addSubview:imageView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.frame.size.height + imageView.frame.origin.y + 15, _noDataView.frame.size.width, 30)];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setText:tips];
        titleLabel.font = [UIFont systemFontOfSize:15];
        [titleLabel setTextColor:UIColorFromHexColor(0x707A7C)];
        [_noDataView addSubview:titleLabel];
    }
    _noDataView.hidden = NO;
    [self bringSubviewToFront:_noDataView];
}

- (void)resetNoDataViewFrame:(CGRect)frame
{
    _noDataView.frame = frame;
}

- (void)hideNoDataView {
    _noDataView.hidden = YES;
}

- (void)showCustomView:(UIView*)view {
    [_customView removeFromSuperview];
    _customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _customView.backgroundColor = [UIColor clearColor];
    [self addSubview:_customView];
    [_customView addSubview:view];
}

- (void)hideCustomView {
    [_customView removeFromSuperview];
}

- (void)beginRefreshing {
    [self.mj_header beginRefreshing];
}

- (void)reloadDataWithAnimate {
    [UIView transitionWithView: self
                      duration: 0.1f
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations: ^(void) {
                        [self reloadData];
                    } completion: ^(BOOL isFinished) {
                    }];
}

#pragma mark - Data Source Loading / Reloading Methods
- (void)doneLoadingTableViewData{
    [self.mj_header endRefreshing];
    
    if (_isLoadedAllTheData) {
        [self.mj_footer endRefreshingWithNoMoreData];
    }
    else {
        [self.mj_footer endRefreshing];
    }
}

#pragma mark - private methods

- (void)addHeaderRefreshView {
    self.mj_header = [WSRefreshHeader headerWithRefreshingBlock:^{
        if (_customTableDelegate && [_customTableDelegate respondsToSelector:@selector(getHeaderDataSoure)]) {
            [_customTableDelegate getHeaderDataSoure];
        }
    }];
}

- (void)addFooterRefreshView {
    self.mj_footer = [WSRefreshFooter footerWithRefreshingBlock:^{
        if (_customTableDelegate && [_customTableDelegate respondsToSelector:@selector(getFooterDataSoure)]) {
            [_customTableDelegate getFooterDataSoure];
        }
    }];
}

- (void)removeHeaderAndFooterView {
    if(self.mj_header != nil) {
        self.mj_header = nil;
    }
    if(self.mj_footer != nil) {
        self.mj_footer = nil;
    }
}

@end
