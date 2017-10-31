//
//  ListViewController.m
//  FrameTemplate
//
//  Created by zws on 2017/10/27.
//  Copyright © 2017年 vma. All rights reserved.
//

#import "ListViewController.h"
#import "NSString+MD5.h"
#import "Base64Util.h"
#import "NSString+DES.h"

@interface ListViewController ()

@property (nonatomic, strong) WSRequestInfoList *infoList;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"请求列表实例";
    
    [self.tableView setRefreshCategory:BothRefresh]; // 上下拉刷新
    
    [self requestList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    __weak ListViewController *weakSelf = self;
    
    _infoList = [[WSRequestInfoList alloc]initWithAction:Action_notice_list model:@"MessageModel" params:param successBlock:^(NSInteger errCode, id data, NSString *action, NSString *msg, BOOL isAllData) {
        
        NSLog(@"%@", data);
        
        [weakSelf.tableView reloadData];
        weakSelf.tableView.isLoadedAllTheData = isAllData;
        [weakSelf.tableView doneLoadingTableViewData];
        
    } failureBlock:^(NSError *error, NSString *errorDesc) {
        NSLog(@"%@", errorDesc);
        [weakSelf.tableView doneLoadingTableViewData];
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

#pragma -mark UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _infoList.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"数据%ld", indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
@end
