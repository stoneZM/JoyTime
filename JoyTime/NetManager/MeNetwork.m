//
//  MeNetwork.m
//  JoyTime
//
//  Created by stone on 2017/1/22.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "MeNetwork.h"
#import "FollowModel.h"

@implementation MeNetwork

+(id)getMyFollowerInfoCompleteHandle:(void(^)(id responseObj,NSError* err))completeHandle{
    
    [self setHeader];
    return [self GET:FollowerUserInfoUrl parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completeHandle([FollowModel mj_objectWithKeyValues:responseObj],error);
    }];
        

}

@end
