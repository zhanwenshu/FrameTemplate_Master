//
//  UtilMacro.h
//  FrameTemplate
//
//  Created by zws on 2017/10/24.
//  Copyright © 2017年 vma. All rights reserved.
//

#ifndef UtilMacro_h
#define UtilMacro_h

#define BYTE_TO_MB(byte) ((byte)/1024.0/1024.0)
#define KB_TO_MB(kb) ((kb)/1024.0)
#define BYTE_TO_KB(byte) ((byte)/1024.0)

#define kUserDefaults [NSUserDefaults standardUserDefaults]
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

// UIColor
#define MAIN_COLOR [UIColor colorWithRed:228.f/255.f green:185.f/255.f blue:110.f/255.f alpha:1]
#define MAIN_BLACK_COLOR [UIColor colorWithRed:32.f/255.f green:32.f/255.f blue:32.f/255.f alpha:1]
#define ColorRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define UIColorFromHexColor(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromHexColorA(hexValue,alp) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:alp]

#endif /* UtilMacro_h */
