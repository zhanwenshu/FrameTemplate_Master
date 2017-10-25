//
//  NSString+DES.h
//  credit
//
//  Created by 詹文述 on 2017/5/23.
//  Copyright © 2017年 vma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DES)

-(NSString*)decryptUseDESWithKey:(NSString*)key;
-(NSString *)encryptUseDESWithKey:(NSString *)key;

@end
