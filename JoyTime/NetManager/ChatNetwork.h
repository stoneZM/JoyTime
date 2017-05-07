//
//  ChatNetwork.h
//  JoyTime
//
//  Created by stone on 2017/1/19.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "BaseNetManager.h"

@interface ChatNetwork : BaseNetManager


/**
 获取推荐好友列表

 @param page 当前页数
 @param pageCount 每页展示多少数据
 @param completeHandle 拥有云信账号的用户信息
 */
+(void)getRecommendedFriendWithpage:(NSString*)page
                          pageCount:(NSString*)pageCount
                     completeHandle:(void(^)(id responseObj ,NSError* err))completeHandle;

@end
