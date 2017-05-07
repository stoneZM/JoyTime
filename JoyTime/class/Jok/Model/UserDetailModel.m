//
//  UserDetailModel.m
//  JoyTime
//
//  Created by stone on 2017/1/22.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "UserDetailModel.h"


@implementation UserDetailModel

+ (NSDictionary*)mj_replacedKeyFromPropertyName
{
    
    return @{@"uid":@"id"};
}

+ (NSDictionary*)mj_objectClassInArray
{
    return @{ @"jok" : [UserJokModel class] };
}

@end



@implementation UserJokModel

+ (NSDictionary*)mj_replacedKeyFromPropertyName
{
    
    return @{@"jid":@"id"};
}

@end
