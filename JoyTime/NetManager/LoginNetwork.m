//
//  LoginNetwork.m
//  JoyTime
//
//  Created by stone on 2017/1/13.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "LoginNetwork.h"
#import "LoginModel.h"

@implementation LoginNetwork

+(id)requestLoginWithAccount:(NSString *)account
                    passWord:(NSString *)pwd
              completeHandle:(void (^)(id, NSError *))completeHandle{
    
    NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
    [params setValue:account forKey:@"account"];
    [params setValue:pwd forKey:@"pwd"];

  return  [self GET:JokLoginUrl parameters:params completionHandler:^(id responseObj, NSError *error) {
      completeHandle([LoginModel mj_objectWithKeyValues:responseObj],error);
  }];
}


+(id)requestRegWithAccount:(NSString *)account
                  password:(NSString *)pwd
                  nickName:(NSString *)nickName
                profileImg:(NSString *)profileImg
            completeHandle:(void (^)(id, NSError *))completeHandle{
    
    return nil;
}



@end
