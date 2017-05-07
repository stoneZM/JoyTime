//
//  LoginModel.h
//  JoyTime
//
//  Created by stone on 2017/1/14.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "BaseModel.h"
#import "JokUserModel.h"
@interface LoginModel : BaseModel

@property (nonatomic, strong) NSString *err;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) JokUserModel* userInfo;

@end
