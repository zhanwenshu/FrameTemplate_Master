//
//  WSCollectionViewController.m
//  FrameTemplate
//
//  Created by zws on 2017/10/31.
//  Copyright © 2017年 vma. All rights reserved.
//

#import "WSCollectionViewController.h"

static NSString * CollectionViewCellID = @"collectionViewCellID";

@interface WSCollectionViewController ()<WSRefreshDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation WSCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.collectionView) {
        _collectionView = [[WSRefreshCollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
        [self.view addSubview:_collectionView];
    }
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.customTableDelegate = self;
    _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellID forIndexPath:indexPath];
    
    
    return cell;
}

@end
