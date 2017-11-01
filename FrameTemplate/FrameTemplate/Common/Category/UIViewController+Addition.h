//
//  UIViewController+Addition.h
//  FrameTemplate
//
//  Created by zws on 2017/11/1.
//  Copyright © 2017年 vma. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^callBlock)(id object);

@interface UIViewController (Addition)<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

/**
 设置返回按钮
 */
- (void)setNavigationBackItem;


/**
 设置右边按钮

 @param image 图片
 */
- (void)createNavigationRightItemWithImage:(NSString *)image;

/**
 设置右边按钮
 
 @param title 标题
 */
- (void)createNavigationRightItemWithTitle:(NSString *)title;

/**
 设置左边按钮
 
 @param image 图片
 */
- (void)createNavigationLeftItemWithImage:(NSString *)image;

/**
 设置左边按钮
 
 @param title 标题
 */
- (void)createNavigationLeftItemWithTitle:(NSString *)title;


/**
 push 页面

 @param identifier ViewController
 @param values 传值
 @param block 回调
 */
- (void)pushViewControllerWithIdentifier:(NSString*)identifier values:(NSMutableArray *)values block:(callBlock)block;

- (void)selectedNavigationRightItem:(id)sender;
- (void)selectedNavigationLeftItem:(id)sender;

@end
