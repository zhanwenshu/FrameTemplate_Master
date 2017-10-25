//
//  UIView+TableHeadView.m
//  91Market
//
//  Created by Fan Lin on 8/13/12.
//  Copyright (c) 2012 ND. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "UITableView+TableHeadView.h"

@implementation UITableView (TableHeadView)

- (void)showOnTableHeadView:(NSString *)noticeWord {
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 48)];
    headLabel.layer.borderColor = [[UIColor colorWithRed:224.0 / 255.0 green:224.0 / 255.0 blue:224.0 / 255.0 alpha:1.0] CGColor];
    headLabel.layer.borderWidth = 1.0;
    headLabel.text = noticeWord;
    headLabel.backgroundColor = [UIColor clearColor];
    headLabel.font = [UIFont systemFontOfSize:18.0];
    headLabel.textAlignment = NSTextAlignmentCenter;
    self.tableHeaderView = headLabel;
}

@end
