//
//  CollectionViewCell.m
//  FrameTemplate
//
//  Created by zws on 2017/10/31.
//  Copyright © 2017年 vma. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CollectionViewCell" owner:nil options:nil] firstObject];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
