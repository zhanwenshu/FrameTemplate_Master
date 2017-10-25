//
//  UIView+NIB.h
//  NdGameCenter
//
//  Created by Lin Benjie on 10-12-01.
//  Copyright 2010 NetDragon WebSoft Inc.. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIView (NIB)

+ (id)loadFromNIB;
+ (id)loadFromNIBNamed:(NSString *)nibName;

@end
