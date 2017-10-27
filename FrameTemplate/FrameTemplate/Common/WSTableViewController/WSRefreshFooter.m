//
//  WSRefreshFooter.m
//  FrameTemplate
//
//  Created by zws on 2017/10/27.
//  Copyright © 2017年 vma. All rights reserved.
//

#import "WSRefreshFooter.h"

@interface WSRefreshFooter ()

@property (weak, nonatomic) UILabel *label;
@property (weak, nonatomic) UIActivityIndicatorView *loading;

@end

@implementation WSRefreshFooter

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare {
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 50;
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = MAIN_COLOR;
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
    
    // loading
    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:loading];
    loading.color = MAIN_COLOR;
    self.loading = loading;
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.label.frame = self.bounds;
    self.loading.center = self.label.center;
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            [self.loading stopAnimating];
            self.label.text = @"上拉即载入更多...";
            break;
        case MJRefreshStatePulling:
            [self.loading stopAnimating];
            self.label.text = @"松开立即加载更多...";
            break;
        case MJRefreshStateRefreshing:
            [self.loading startAnimating];
            self.label.text = @"";
            break;
        case MJRefreshStateNoMoreData:
            [self.loading stopAnimating];
            self.label.text = @"";
        default:
            break;
    }
}

@end
