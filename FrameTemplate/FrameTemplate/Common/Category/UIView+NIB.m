//
//  UIView+NIB.m
//  NdGameCenter
//
//  Created by Lin Benjie on 10-12-01.
//  Copyright 2010 NetDragon WebSoft Inc.. All rights reserved.
//

#import "UIView+NIB.h"

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

@end