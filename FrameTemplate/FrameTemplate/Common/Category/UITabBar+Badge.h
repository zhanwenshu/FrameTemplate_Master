//
//  UITabBar+Badge.h
//  HongMi
//
//  Created by zws on 17/3/10.
//  Copyright © 2017年 sihe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (Badge)



- (void)showBadgeOnItemIndex:(int)index;   //显示小红点
- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点

@end
