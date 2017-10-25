//
//  UITextView+Addition.m
//  91Market
//
//  Created by Lin Benjie on 12-7-24.
//  Copyright (c) 2012 Bodong ND. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "UITextView+Addition.h"

@implementation UITextView (Addition)

- (void)setBorder {
    self.layer.cornerRadius = 8.0;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [[UIColor colorWithRed:181.0 / 255 green:181.0 / 255 blue:181.0 / 255 alpha:1] CGColor];
}

- (void)addKeyboardButtonsWithNextTitle:(NSString *)nextTitle doneTitle:(NSString *)doneTitle target:(id)target nextAction:(SEL)nextAction doneAction:(SEL)doneAction {
    UIToolbar *topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 36)];
    [topView setBarStyle:UIBarStyleDefault];
    
    UIBarButtonItem *btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc]initWithTitle:nextTitle style:UIBarButtonItemStyleBordered target:target action:nextAction];
    
    UIBarButtonItem *doneButton = nil;
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
