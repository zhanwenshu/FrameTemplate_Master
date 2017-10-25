//
//  UIView+Addtion.m
//  91Market
//
//  Created by Lin Benjie on 12-7-24.
//  Copyright (c) 2012 Bodong ND. All rights reserved.
//

#import "UIView+Addtion.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (NIB)

+ (NSString*)nibName {
    return [self description];
}

+ (id)loadFromNIB {
    NSString *nibName = [self nibName];
    return [self loadFromNIBNamed:nibName];
}

+ (id)loadFromNIBNamed:(NSString *)nibName {
    Class klass = [self class];
    NSArray* objects = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
    for (id object in objects) {
        if ([object isKindOfClass:klass]) {
            return object;
        }
    }
    [NSException raise:@"WrongNibFormat" format:@"Nib for '%@' must contain one UIView, and its class must be '%@'", nibName, NSStringFromClass(klass)];
    return nil;
}

- (void)setCornerRadius:(float)radius {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
}

- (void)setBorderLineWithColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = 1.0;
}

- (void)transform:(CATransform3D)transform {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 0.2;
    animation.fromValue = [NSValue valueWithCATransform3D:self.layer.transform];
    animation.toValue = [NSValue valueWithCATransform3D:transform];
    [self.layer addAnimation:animation forKey:@"rotation"];
    self.layer.transform = transform;
}

@end
