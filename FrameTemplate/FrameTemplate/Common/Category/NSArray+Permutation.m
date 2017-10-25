//
//  NSArray+Permutation.m
//  TigerLottery
//
//  Created by Legolas on 15/1/22.
//  Copyright (c) 2015年 adcocoa. All rights reserved.
//

#define MAX_PERMUTATION_COUNT   20000

NSInteger *pc_next_permutation(NSInteger *perm, const NSInteger size);
NSInteger *pc_next_permutation(NSInteger *perm, const NSInteger size)
{
    // slide down the array looking for where we're smaller than the next guy
    NSInteger pos1;
    for (pos1 = size - 1; perm[pos1] >= perm[pos1 + 1] && pos1 > -1; --pos1);
    
    // if this doesn't occur, we've finished our permutations
    // the array is reversed: (1, 2, 3, 4) => (4, 3, 2, 1)
    if (pos1 == -1)
        return NULL;
    
    assert(pos1 >= 0 && pos1 <= size);
    
    NSInteger pos2;
    // slide down the array looking for a bigger number than what we found before
    for (pos2 = size; perm[pos2] <= perm[pos1] && pos2 > 0; --pos2);
    
    assert(pos2 >= 0 && pos2 <= size);
    
    // swap them
    NSInteger tmp = perm[pos1]; perm[pos1] = perm[pos2]; perm[pos2] = tmp;
    
    // now reverse the elements in between by swapping the ends
    for (++pos1, pos2 = size; pos1 < pos2; ++pos1, --pos2) {
        assert(pos1 >= 0 && pos1 <= size);
        assert(pos2 >= 0 && pos2 <= size);
        
        tmp = perm[pos1]; perm[pos1] = perm[pos2]; perm[pos2] = tmp;
    }
    
    return perm;
}

#import "NSArray+Permutation.h"

@implementation NSArray(Permutation)

- (NSArray *)allPermutationsArrayofArrays
{
    NSInteger size = [self count];
    NSInteger *perm = malloc(size * sizeof(NSInteger));
    
    for (NSInteger idx = 0; idx < size; ++idx)
        perm[idx] = idx;
    
    NSInteger permutationCount = 0;
    
    --size;
    
    NSMutableArray *perms = [NSMutableArray array];
    
    do {
        NSMutableArray *newPerm = [NSMutableArray array];
        
        for (NSInteger i = 0; i <= size; ++i)
            [newPerm addObject:[self objectAtIndex:perm[i]]];
        
        [perms addObject:newPerm];
    } while ((perm = pc_next_permutation(perm, size)) && ++permutationCount < MAX_PERMUTATION_COUNT);
    free(perm);
    
    return perms;
}

- (void)combin {
    int count = 4;
    int choice = 3;
    NSMutableArray *signArray = [self originArray:count choice:3];
    BOOL isEnd = false;
    BOOL isFindFirst;
    BOOL isSwap;
    int position = 0;
    while (!isEnd) {
        isFindFirst = false;
        isSwap = false;
        for (int i = 0; i < count; i++) {
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
                if ((position == i) && (i + 1 == count - choice)) {
                    isEnd = YES;
                }
                if (isSwap) {
                    break;
                }
            }
        }
    }
}

- (NSMutableArray *)originArray:(NSInteger)count choice:(NSInteger)choice {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++) {
        if (i < choice) {
            [array addObject:@(1)];
        }else {
            [array addObject:@(0)];
        }
    }
    return array;
}

@end
