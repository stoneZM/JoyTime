//
//  ChatNetwork.m
//  JoyTime
//
//  Created by stone on 2017/1/19.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "ChatNetwork.h"
#import "YunXinFriendModel.h"

@implementation ChatNetwork

+(void)getRecommendedFriendWithpage:(NSString *)page pageCount:(NSString *)pageCount completeHandle:(void (^)(id, NSError *))completeHandle{
    
    [self setHeader];
    NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
    [params setValue:page forKey:@"p"];
    [params setValue:pageCount forKey:@"c"];
    [self GET:AddFriendUrl parameters:params completionHandler:^(id responseObj, NSError *error) {
        completeHandle([YunXinFriendModel mj_objectWithKeyValues:responseObj],error);
    }];
}

@end
