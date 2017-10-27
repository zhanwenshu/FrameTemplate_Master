//
//  ViewController.m
//  FrameTemplate
//
//  Created by zws on 2017/10/24.
//  Copyright © 2017年 vma. All rights reserved.
//

#import "ViewController.h"
#import "NSString+MD5.h"
#import "Base64Util.h"
#import "NSString+DES.h"
#import "ListViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"实用Demo";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:@"18305980300" forKey:@"account"];
    [param setObject:[[[@"123456" md5HexDigest] md5HexDigest] md5HexDigest] forKey:@"password"];
    param[@"user_id"] = @(0);
    param[@"school_id"] = @(0);
    param[@"timestamp"] = [common getDateTime:[NSDate date] WithFormatter:@"yyyy-MM-dd HH:mm:ss"];
    NSString *sign =  [NSString stringWithFormat:@"%@,%@,%@", @"fireSchool", param[@"timestamp"], param[@"user_id"]];
    NSString *signAES = [Base64Util encodeBase64:sign];
    NSString *md5 = [[signAES md5HexDigest] md5HexDigest];
    param[@"sign"] = md5;
    
    
    [WSNetworkManager postWithAction:Action_user_login params:param successBlock:^(NSInteger errCode, id data, NSString *action, NSString *msg) {
        NSLog(@"%@", data);
    } failureBlock:^(NSError *error, NSString *errorDesc) {
        
    }];
}

- (IBAction)upload:(id)sender {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:@(4) forKey:@"business_type"];
    
    NSMutableDictionary *imageDict = [NSMutableDictionary dictionary];
    [imageDict setObject:[UIImage imageNamed:@"tu_01"] forKey:@"image"];
    [imageDict setObject:@"tu_01" forKey:@"fileName"];
    NSArray *images = [NSArray arrayWithObject:imageDict];
    
    [WSNetworkManager uploadWithAction:Action_file_upload images:images params:param successBlock:^(NSInteger errCode, id data, NSString *action, NSString *msg) {
        
    } failureBlock:^(NSError *error, NSString *errorDesc) {
        
    }];
}

- (IBAction)requestListInfo:(id)sender {
    ListViewController *listVC = [[ListViewController alloc]init];
    [self.navigationController pushViewController:listVC animated:YES];
}

@end
