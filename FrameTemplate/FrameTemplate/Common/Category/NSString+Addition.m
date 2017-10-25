//
//  NSString+Addition.m
//  TigerLottery
//
//  Created by Legolas on 14/12/9.
//  Copyright (c) 2014年 adcocoa. All rights reserved.
//

#import "NSString+Addition.h"

@implementation NSString (Addition)

- (CGSize)adaptSizeWithFont:(UIFont *)font {
    CGSize size;
    if ([self respondsToSelector:@selector(sizeWithAttributes:)]) {
        size = [self sizeWithAttributes:@{NSFontAttributeName : font}];
    }else {
        size = [self sizeWithFont:font];
    }
    return size;
}

- (CGSize)adaptSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size {
    CGSize adaptSize;
    if ([self respondsToSelector:@selector(sizeWithAttributes:)]) {
        adaptSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
    }else {
        adaptSize = [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByTruncatingTail];
    }
    return adaptSize;
}

- (CGSize)adaptSizeWithAttributes:(NSDictionary *)attributes constrainedToSize:(CGSize)size {
    CGSize adaptSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    return adaptSize;
}

- (NSMutableAttributedString *)colorAttributedString {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    NSString *scannerStr = [NSString stringWithString:self];
    NSScanner *scanner = [NSScanner scannerWithString:scannerStr];
    NSString *text;
    NSString *color;
    NSInteger location = 0;
    while (![scanner isAtEnd]) {
        [scanner scanUpToString:@"<color='" intoString:NULL];
        [scanner scanString:@"<color='" intoString:NULL];
        [scanner scanUpToString:@"'>" intoString:&color];
        [scanner scanString:@"'>" intoString:NULL];
        [scanner scanUpToString:@"</color>" intoString:&text];
        NSString *colorText = [NSString stringWithFormat:@"<color='%@'>%@</color>", color, text];
        if (colorText) {
            NSRange textRange = [scannerStr rangeOfString:colorText options:NSCaseInsensitiveSearch];
            if (textRange.location != NSNotFound) {
                location += textRange.location;
                
                NSMutableAttributedString *colorStr = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName : [UIColor redColor]}];
                [attributedString replaceCharactersInRange:NSMakeRange(location, textRange.length) withAttributedString:colorStr];
                location += text.length;
                scannerStr = [scannerStr substringFromIndex:textRange.location + textRange.length];
            }else {
                break;
            }
        }else {
            break;
        }
    }
    return attributedString;
}

- (NSMutableAttributedString *)attributedStringWithSeparatedStrings:(NSArray *)separators trailingStrings:(NSArray *)trailings color:(UIColor *)color {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    for (int i = 0; i < separators.count; i++) {
        NSString *separator = [separators objectAtIndex:i];
        NSString *trailing = [trailings objectAtIndex:i];
        NSString *scannerStr = [NSString stringWithString:self];
        NSScanner *scanner = [NSScanner scannerWithString:scannerStr];
        NSString *colorText;
        NSInteger location = 0;
        while (![scanner isAtEnd]) {
            [scanner scanUpToString:separator intoString:NULL];
            [scanner scanString:separator intoString:NULL];
            [scanner scanUpToString:trailing intoString:&colorText];
            [scanner scanString:trailing intoString:NULL];
            if (colorText) {
                NSRange textRange = [scannerStr rangeOfString:[NSString stringWithFormat:@"%@%@%@", separator, colorText, trailing] options:NSCaseInsensitiveSearch];
                if (textRange.location != NSNotFound) {
                    location += textRange.location;
                    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(location, textRange.length)];
                    location += textRange.length;
                    scannerStr = [scannerStr substringFromIndex:textRange.location + textRange.length];
                }else {
                    break;
                }
            }else {
                break;
            }
        }
    }
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
    return attributedString;
}

- (NSMutableAttributedString *)attributedStringWithSeparatedString:(NSString *)separator trailingString:(NSString *)trailing color:(UIColor *)color {
    NSMutableAttributedString *attributedString = [self attributedStringWithSeparatedStrings:@[separator] trailingStrings:@[trailing] color:color];
    return attributedString;
}


- (NSMutableAttributedString *)changeFontAndColor:(UIFont *)font color:(UIColor *)color subStringArray:(NSArray *)subArray {
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self];
    for (NSString *rangeStr in subArray) {
        NSRange range = [self rangeOfString:rangeStr options:NSBackwardsSearch];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
        [attributedStr addAttribute:NSFontAttributeName value:font range:range];
    }
    return attributedStr;
}

- (NSMutableAttributedString *)changeFontAndColor:(UIFont *)font color:(UIColor *)color backgroudColor:(UIColor *)bcolor subStringArray:(NSArray *)subArray {
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self];
    for (NSString *rangeStr in subArray) {
//        font = kFZLTXHJWFont(20);
        NSRange range = [self rangeOfString:rangeStr options:NSBackwardsSearch];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
        [attributedStr addAttribute:NSBackgroundColorAttributeName value:bcolor range:range];
        [attributedStr addAttribute:NSFontAttributeName value:font range:range];
//        CGSize size = [attributedStr size];
//        [attributedStr drawInRect:CGRectMake(0, 0, size.width + 10, size.height + 10)];
    }
    return attributedStr;
}

- (NSMutableAttributedString *)changeTextContent:(UIFont *)font color:(UIColor *)color subStringArray:(NSArray *)subArray lineSpace:(CGFloat)space{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self];
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    [paraStyle setLineSpacing:space];
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paraStyle range:NSMakeRange(0, self.length)];
    for (NSString *rangeStr in subArray) {
        NSRange range = [self rangeOfString:rangeStr options:NSBackwardsSearch];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
        [attributedStr addAttribute:NSFontAttributeName value:font range:range];
    }
    return attributedStr;
}

- (NSMutableAttributedString *)changeTextContent:(UIFont *)font color:(UIColor *)color subStringArray:(NSArray *)subArray lineSpace:(CGFloat)space firstLineHeadIndent:(CGFloat)indent{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self];
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    [paraStyle setLineSpacing:space];
    paraStyle.firstLineHeadIndent = indent;
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paraStyle range:NSMakeRange(0, self.length)];
    for (NSString *rangeStr in subArray) {
        NSRange range = [self rangeOfString:rangeStr options:NSBackwardsSearch];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
        [attributedStr addAttribute:NSFontAttributeName value:font range:range];
    }
    return attributedStr;
}

- (CGSize)adaptSizeWithContent:(UIFont *)font constrainedToSize:(CGSize)size lineSpace:(CGFloat)space{
    CGSize adaptSize;
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    [paraStyle setLineSpacing:space];
    if ([self respondsToSelector:@selector(sizeWithAttributes:)]) {
        adaptSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font, NSParagraphStyleAttributeName : paraStyle} context:nil].size;
    }else {
        adaptSize = [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    }
    return adaptSize;
}

- (CGSize)adaptSizeWithContent:(UIFont *)font constrainedToSize:(CGSize)size paraStyle:(NSMutableParagraphStyle*)paraStyle {
    CGSize adaptSize;
    if ([self respondsToSelector:@selector(sizeWithAttributes:)]) {
        adaptSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font, NSParagraphStyleAttributeName : paraStyle} context:nil].size;
    }else {
        adaptSize = [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    }
    return adaptSize;
}

@end
