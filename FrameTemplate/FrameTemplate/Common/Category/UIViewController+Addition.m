//
//  UIViewController+Addition.m
//  FrameTemplate
//
//  Created by zws on 2017/11/1.
//  Copyright © 2017年 vma. All rights reserved.
//

#import "UIViewController+Addition.h"

@implementation UIViewController (Addition)

- (void)setNavigationBackItem {
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [backBtn setImage:[UIImage imageNamed:@"arrow_left"] forState:UIControlStateNormal];
    
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBtn addTarget:self action:@selector(popViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)createNavigationRightItemWithImage:(NSString *)image {
    UIButton *helpBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [helpBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    helpBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [helpBtn addTarget:self action:@selector(selectedNavigationRightItem:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:helpBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)createNavigationRightItemWithTitle:(NSString *)title {
    UIButton *helpBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [helpBtn setTitle:title forState:UIControlStateNormal];
    helpBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [helpBtn addTarget:self action:@selector(selectedNavigationRightItem:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:helpBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)createNavigationLeftItemWithImage:(NSString *)image {
    UIButton *helpBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [helpBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    helpBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [helpBtn addTarget:self action:@selector(selectedNavigationLeftItem:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:helpBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)createNavigationLeftItemWithTitle:(NSString *)title {
    UIButton *helpBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [helpBtn setTitle:title forState:UIControlStateNormal];
    helpBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [helpBtn addTarget:self action:@selector(selectedNavigationLeftItem:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:helpBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)pushViewControllerWithIdentifier:(NSString*)identifier values:(NSMutableArray *)values block:(callBlock)block {
    UIViewController * controller = [[NSClassFromString(identifier) alloc] init];
    if (values)
        [controller setValue:values forKey:@"values"];
    
    if (block)
        [controller setValue:block forKey:@"block"];
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)selectedNavigationRightItem:(id)sender {}

- (void)selectedNavigationLeftItem:(id)sender {}

#pragma mark - Private Method

- (void)popViewController:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    NSInteger index = self.navigationController.viewControllers.count - 2;
    if (index >= 0) {
        UIViewController *vc = [self.navigationController.viewControllers objectAtIndex:index];
        self.navigationController.delegate = vc;
    }
}

@end
