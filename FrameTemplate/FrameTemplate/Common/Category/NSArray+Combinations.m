//
//  NSArray+Combinations.m
//  Combin
//
//  Created by Legolas on 15/1/22.
//  Copyright (c) 2015年 com.tiger. All rights reserved.
//

#import "NSArray+Combinations.h"

@implementation NSArray(Combinations)

- (NSArray *)combinationsWithChoiceCount:(NSInteger)choiceCount {
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    if (self.count > 0 && choiceCount <= self.count) {
        NSMutableArray *signArray = [self signArrayWithChoiceCount:choiceCount];
        [result addObject:[self combineArrayWithSignArray:signArray choiceCount:choiceCount]];
        
        if (choiceCount < self.count) {
            BOOL isEnd = false;
            BOOL isFindFirst;
            BOOL isSwap;
            int position = 0;
            while (!isEnd) {
                isFindFirst = false;
                isSwap = false;
                for (int i = 0; i < self.count; i++) {
                    if (!isFindFirst && [signArray[i] integerValue] != 0) {
                        position = i;
                        isFindFirst = YES;
                    }
                    if ([signArray[i] integerValue] != 0 && [signArray[i+1] integerValue] == 0) {
                        signArray[i] = @(0);
                        signArray[i+1] = @(1);
                        isSwap = YES;
                        for (int j = 0; j < i - position; j++) {
                            signArray[j] = signArray[position + j];
                        }
                        for (int j = i - position; j < i; j++) {
                            signArray[j] = @(0);
                        }
                        if ((position == i) && (i + 1 == self.count - choiceCount)) {
                            isEnd = YES;
                        }
                        if (isSwap) {
                            break;
                        }
                    }
                }
                
                [result addObject:[self combineArrayWithSignArray:signArray choiceCount:choiceCount]];
                
            }
        }
    }

//    NSLog(@"sign Array%@",result);
    return result;
}

- (NSMutableArray *)combineArrayWithSignArray:(NSArray *)signArray choiceCount:(NSInteger)choiceCount {
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:choiceCount];
    for (int i = 0; i < self.count; i++) {
        NSInteger sign = [[signArray objectAtIndex:i] integerValue];
        if (sign == 1) {
            [result addObject:[self objectAtIndex:i]];
        }
    }
    return result;
}

- (NSMutableArray *)signArrayWithChoiceCount:(NSInteger)choiceCount {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    for (int i = 0; i < self.count; i++) {
        if (i < choiceCount) {
            [array addObject:@(1)];
        }else {
            [array addObject:@(0)];
        }
    }
    return array;
}

@end
