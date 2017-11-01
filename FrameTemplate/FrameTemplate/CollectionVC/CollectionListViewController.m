//
//  CollectionListViewController.m
//  FrameTemplate
//
//  Created by zws on 2017/10/31.
//  Copyright © 2017年 vma. All rights reserved.
//

#import "CollectionListViewController.h"
#import "WSRefreshCollectionView.h"
#import "CollectionViewCell.h"
#import "NSString+MD5.h"
#import "Base64Util.h"
#import "NSString+DES.h"

static NSString * CollectionViewCellID1 = @"collectionViewCellID1";

@interface CollectionListViewController ()

@property (nonatomic, strong) WSRequestInfoList *infoList;

@end

@implementation CollectionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CollectionView列表实例";
    [self setNavigationBackItem];
    
    [self setup];
    [self requestList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setup {
    CGFloat height = 180;
    UICollectionViewFlowLayout * flowLayout= [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake((kScreenWidth - 30)/2, height);
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView.collectionViewLayout = flowLayout;
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:CollectionViewCellID1];
    
    [self.collectionView setRefreshCategory:BothRefresh]; // 上下拉刷新
}

- (void)requestList {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"notice_type"] = @(3);
    param[@"user_id"] = @(4);
    param[@"school_id"] = @(1);
    param[@"timestamp"] = [common getDateTime:[NSDate date] WithFormatter:@"yyyy-MM-dd HH:mm:ss"];
    NSString *sign =  [NSString stringWithFormat:@"%@,%@,%@", @"fireSchool", param[@"timestamp"], param[@"user_id"]];
    NSString *signAES = [Base64Util encodeBase64:sign];
    NSString *md5 = [[signAES md5HexDigest] md5HexDigest];
    param[@"sign"] = md5;
    
    __weak CollectionListViewController *weakSelf = self;
    
    _infoList = [[WSRequestInfoList alloc]initWithAction:Action_notice_list model:@"MessageModel" params:param successBlock:^(NSInteger errCode, id data, NSString *action, NSString *msg, BOOL isAllData) {
        
        NSLog(@"%@", data);
        
        [weakSelf.collectionView reloadData];
        weakSelf.collectionView.isLoadedAllTheData = isAllData;
        [weakSelf.collectionView doneLoadingTableViewData];
        
    } failureBlock:^(NSError *error, NSString *errorDesc) {
        NSLog(@"%@", errorDesc);
        [weakSelf.collectionView doneLoadingTableViewData];
    }];
    [_infoList reloadListData];
}

#pragma -mark WSRefreshDelegate

- (void)getHeaderDataSoure { // 下拉刷新代理
    [_infoList reloadListData];
}

- (void)getFooterDataSoure { // 上拉刷新代理
    [_infoList requestNextListData];
}

#pragma mark - UICollectionView Delegate
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                         layout:(UICollectionViewLayout *)collectionViewLayout
         insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _infoList.list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellID1 forIndexPath:indexPath];
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
