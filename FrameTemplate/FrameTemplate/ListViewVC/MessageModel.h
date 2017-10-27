//
//  MessageModel.h
//  FireCampus
//
//  Created by User on 2017/9/4.
//  Copyright © 2017年 vma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property (strong) NSNumber * id;
@property (strong) NSString * title;
@property (strong) NSString * content;
@property (strong) NSNumber * create_time;
@property (strong) NSNumber * status; // 0未读 1已读

@end

