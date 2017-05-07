//
//  JokModel.m
//  JoyTime
//
//  Created by stone on 2017/1/11.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "JokUserModel.h"


@implementation JokUserModel

+ (NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"uid":@"id"};
}

@end
