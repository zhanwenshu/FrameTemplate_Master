//
//  UITextField+Addition.h
//  Lemon
//
//  Created by Legolas on 13-12-27.
//  Copyright (c) 2013年 Adcocoa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Addition)

- (void)setTextFiledLeftView:(NSString *)imageName rect:(CGRect)frame;
- (void)setLeftOffset:(CGFloat)offset;
- (void)addKeyboardButtonsWithNextTitle:(NSString *)nextTitle doneTitle:(NSString *)doneTitle target:(id)target nextAction:(SEL)nextAction doneAction:(SEL)doneAction;

@end
