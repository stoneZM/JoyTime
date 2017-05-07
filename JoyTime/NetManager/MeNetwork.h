//
//  MeNetwork.h
//  JoyTime
//
//  Created by stone on 2017/1/22.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "BaseNetManager.h"

@interface MeNetwork : BaseNetManager


/**
 获取我关注人的信息

 */
+ (id) getMyFollowerInfoCompleteHandle:(void(^)(id responseObj,NSError* err))completeHandle;

@end
