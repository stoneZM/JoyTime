//
//  YunXinFriendModel.h
//  JoyTime
//
//  Created by stone on 2017/1/19.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "BaseModel.h"
#import "JokUserModel.h"

@class YunXinFriendUserModel;
@interface YunXinFriendModel : BaseModel

@property (nonatomic, assign) double err;
@property (nonatomic, strong) NSArray <YunXinFriendModel*> *data;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, strong) NSString *page;

@end

@interface YunXinFriendUserModel : BaseModel

@property (nonatomic, strong) JokUserModel *u;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *accid;
@property (nonatomic, strong) NSString *token;

@end
