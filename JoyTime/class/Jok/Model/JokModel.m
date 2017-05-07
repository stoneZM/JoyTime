//
//  JokTextModel.m
//  JoyTime
//
//  Created by stone on 2017/1/11.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "JokModel.h"
#import "JokNetwork.h"



@implementation JokModel



+ (NSDictionary*)mj_objectClassInArray
{
    return @{ @"data" : [JokDataModel class] };
}

@end



@implementation JokDataModel

+ (NSDictionary*)mj_replacedKeyFromPropertyName
{
   
    return @{@"jid":@"id"};
}

@end






