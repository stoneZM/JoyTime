//
//  FollowModel.h
//  JoyTime
//
//  Created by stone on 2017/1/22.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "BaseModel.h"
#import "JokUserModel.h"

@interface FollowModel : BaseModel

@property (nonatomic, assign) double err;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSArray *data;

@end
