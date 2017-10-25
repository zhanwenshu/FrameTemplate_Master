//
//  NSString+Addition.h
//  TigerLottery
//
//  Created by Legolas on 14/12/9.
//  Copyright (c) 2014年 adcocoa. All rights reserved.
//

@interface NSString (Addition)

- (CGSize)adaptSizeWithFont:(UIFont *)font;
- (CGSize)adaptSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGSize)adaptSizeWithAttributes:(NSDictionary *)attributes constrainedToSize:(CGSize)size;
- (NSMutableAttributedString *)colorAttributedString;
- (NSMutableAttributedString *)attributedStringWithSeparatedString:(NSString *)separator trailingString:(NSString *)trailing color:(UIColor *)color;
- (NSMutableAttributedString *)attributedStringWithSeparatedStrings:(NSArray *)separators trailingStrings:(NSArray *)trailings color:(UIColor *)color;

/**
 *  改变某些文字的颜色 并单独设置其字体
 *
 *  @param font        设置的字体
 *  @param color       颜色
 *  @param totalString 总的字符串
 *  @param subArray    想要变色的字符数组
 *
 *  @return 生成的富文本
 */
- (NSMutableAttributedString *)changeFontAndColor:(UIFont *)font color:(UIColor *)color subStringArray:(NSArray *)subArray;
- (NSMutableAttributedString *)changeFontAndColor:(UIFont *)font color:(UIColor *)color backgroudColor:(UIColor *)bcolor subStringArray:(NSArray *)subArray;
- (NSMutableAttributedString *)changeTextContent:(UIFont *)font color:(UIColor *)color subStringArray:(NSArray *)subArray lineSpace:(CGFloat)space;
- (NSMutableAttributedString *)changeTextContent:(UIFont *)font color:(UIColor *)color subStringArray:(NSArray *)subArray lineSpace:(CGFloat)space firstLineHeadIndent:(CGFloat)indent;
- (CGSize)adaptSizeWithContent:(UIFont *)font constrainedToSize:(CGSize)size lineSpace:(CGFloat)space;
- (CGSize)adaptSizeWithContent:(UIFont *)font constrainedToSize:(CGSize)size paraStyle:(NSMutableParagraphStyle*)paraStyle;


@end
