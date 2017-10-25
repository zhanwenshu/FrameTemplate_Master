//
//  UITextView+Addition.h
//  91Market
//
//  Created by Lin Benjie on 12-7-24.
//  Copyright (c) 2012 Bodong ND. All rights reserved.
//

@interface UITextView (Addition)

- (void)setBorder;
- (void)addKeyboardButtonsWithNextTitle:(NSString *)nextTitle doneTitle:(NSString *)doneTitle target:(id)target nextAction:(SEL)nextAction doneAction:(SEL)doneAction;

@end
