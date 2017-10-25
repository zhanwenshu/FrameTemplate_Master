//
//  NSString+Check.m
//  HongMi
//
//  Created by xiaoling on 16/8/1.
//  Copyright © 2016年 sihe. All rights reserved.
//

#import "NSString+Check.h"

@implementation NSString (Check)

- (BOOL)checkPhoneNumInput {
    NSString *phoneNum = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    NSPredicate *phonePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneNum];
    BOOL isPhoneNum = [phonePredicate evaluateWithObject:self];
    
    NSString *emailStr = @"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$";
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailStr];
    BOOL isEmail = [emailPredicate evaluateWithObject:self];
    
    if (isPhoneNum || isEmail) {
        return YES;
    }else {
        return NO;
    }
}

- (BOOL)checkNickname {
    NSString * allSpecialSymbol = @"[^\\w\\s]+";
    NSPredicate *specialSymbolPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",allSpecialSymbol];
    
    if ([specialSymbolPredicate evaluateWithObject:self]) {
        return NO;
    }
    
    NSString *nameString = @"[((?=[\x21-\x7e]+)[^A-Za-z0-9])a-zA-Z0-9\u4e00-\u9fa5]+";
    NSPredicate *namePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nameString];
    return [namePredicate evaluateWithObject:self];
}

- (BOOL)isEmpty {
    if (!self) {
        return true;
    } else {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [self stringByTrimmingCharactersInSet:set];
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}

@end
