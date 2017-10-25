//
//  UITextField+Addition.m
//  Lemon
//
//  Created by Legolas on 13-12-27.
//  Copyright (c) 2013年 Adcocoa. All rights reserved.
//

#import "UITextField+Addition.h"
#import "UIView+Layout.h"

@implementation UITextField (Addition)

- (void)setTextFiledLeftView:(NSString *)imageName rect:(CGRect)frame {
    self.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageNamed:imageName];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 53, 46)];
    imageView.centerY = view.centerY;
    view.backgroundColor = [UIColor clearColor];
    [view addSubview:imageView];
    self.leftView = view;
}

- (void)setLeftOffset:(CGFloat)offset {
    self.leftViewMode = UITextFieldViewModeAlways;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, offset, 0)];
    self.leftView = view;
}

- (void)addKeyboardButtonsWithNextTitle:(NSString *)nextTitle doneTitle:(NSString *)doneTitle target:(id)target nextAction:(SEL)nextAction doneAction:(SEL)doneAction {
    UIToolbar *topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 36)];
    [topView setBarStyle:UIBarStyleDefault];
    
    UIBarButtonItem *btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc]initWithTitle:nextTitle style:UIBarButtonItemStyleBordered target:target action:nextAction];
    
    UIBarButtonItem * doneButton = nil;
    if (doneAction == nil) {
        doneButton = [[UIBarButtonItem alloc]initWithTitle:doneTitle style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyboard)];
    } else {
        doneButton = [[UIBarButtonItem alloc]initWithTitle:doneTitle style:UIBarButtonItemStyleDone target:target action:doneAction];
    }
    
    NSArray *buttonsArray = [NSArray arrayWithObjects:nextButton, btnSpace, doneButton,nil];
    
    [topView setItems:buttonsArray];
    [self setInputAccessoryView:topView];
}

- (void)dismissKeyboard {
    [self resignFirstResponder];
}


@end
