//
//  FollowModel.m
//  JoyTime
//
//  Created by stone on 2017/1/22.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "FollowModel.h"

@implementation FollowModel

+ (NSDictionary*)mj_objectClassInArray
{
    return @{ @"data" : [JokUserModel class] };
}

@end
