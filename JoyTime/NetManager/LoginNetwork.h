//
//  LoginNetwork.h
//  JoyTime
//
//  Created by stone on 2017/1/13.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "BaseNetManager.h"

@interface LoginNetwork : BaseNetManager


/**
 登录接口

 @param account 用户的账号
 @param pwd 密码
 @param completeHandle 返回用户信息和一系列token
 @return NSURLSessionDataTask
 */
+(id)requestLoginWithAccount:(NSString*)account
                    passWord:(NSString*)pwd
              completeHandle:(void(^)(id responseObj,NSError* error))completeHandle;



/**
 注册

 @param account 手机号或者邮箱
 @param pwd 密码
 @param nickName 昵称
 @param profileImg 头像
 @param completeHandle 返回用户信息和一系列token
 @return NSURLSessionDataTask
 */
+(id)requestRegWithAccount:(NSString*)account
                  password:(NSString*)pwd
                  nickName:(NSString*)nickName
                profileImg:(NSString*)profileImg
            completeHandle:(void(^)(id responseObj,NSError* error))completeHandle;



@end
