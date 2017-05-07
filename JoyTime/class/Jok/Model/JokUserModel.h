//
//  JokModel.h
//  JoyTime
//
//  Created by stone on 2017/1/11.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "BaseModel.h"

@interface JokUserModel : BaseModel

@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *profileImg;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *accid;
@property (nonatomic, strong) NSString *yxToken;
@property (nonatomic, strong) NSString *appToken;
@property (nonatomic, strong) NSString *loginTime;

@property (nonatomic, assign) BOOL hasFocused;


@end
