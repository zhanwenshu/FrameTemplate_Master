//
//  WSTableViewController.h
//  FrameTemplate
//
//  Created by zws on 2017/10/27.
//  Copyright © 2017年 vma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSRefreshTableView.h"


/**
 继承WSTableViewController，享有tableview控件，可使用xib初始化tableview
 子类拥有上下拉刷新功能，可自行设定
 */
@interface WSTableViewController : UIViewController

@property (strong, nonatomic) IBOutlet WSRefreshTableView *tableView;

@end
