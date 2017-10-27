//
//  WSRefreshHeader.m
//  FrameTemplate
//
//  Created by zws on 2017/10/27.
//  Copyright © 2017年 vma. All rights reserved.
//

#import "WSRefreshHeader.h"

@interface WSRefreshHeader ()

@property (weak, nonatomic) UILabel *label;
@property (weak, nonatomic) UIActivityIndicatorView *loading;

@end

@implementation WSRefreshHeader

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
    
    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    loading.color = MAIN_COLOR;
    [self addSubview:loading];
    self.loading = loading;
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews {
    [super placeSubviews];
    
    self.label.frame = self.bounds;
    self.loading.center = self.label.center;
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change {
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change {
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState;
    switch (state) {
        case MJRefreshStateIdle:
            [self.loading stopAnimating];
            self.label.text = @"下拉即可更新...";
            break;
        case MJRefreshStatePulling:
            [self.loading stopAnimating];
            self.label.text = @"松开立即更新...";
            break;
        case MJRefreshStateRefreshing:
            [self.loading startAnimating];
            self.label.text = @"";
            break;
        default:
            break;
    }
}

@end
