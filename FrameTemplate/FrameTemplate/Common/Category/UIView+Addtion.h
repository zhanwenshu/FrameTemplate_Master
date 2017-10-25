//
//  UIView+Addtion.h
//  91Market
//
//  Created by Lin Benjie on 12-7-24.
//  Copyright (c) 2012 Bodong ND. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIView (Addtion)

+ (id)loadFromNIB;
+ (id)loadFromNIBNamed:(NSString *)nibName;

- (void)setCornerRadius:(float)radius;
- (void)setBorderLineWithColor:(UIColor *)borderColor;
- (void)transform:(CATransform3D)transform;

@end
