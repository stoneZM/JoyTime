//
//  JokNetwork.m
//  JoyTime
//
//  Created by stone on 2017/1/11.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "JokNetwork.h"
#import "JokModel.h"
#import "JokCommentModel.h"
#import "UserDetailModel.h"

@implementation JokNetwork

+(id)getJokDataWithRequestType:(RequestType)type
                          page:(NSString *)page
                     pageCount:(NSString *)count
                completeHandle:(void (^)(id, NSError *))completeHandle
{
   [self setHeader];
    NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
    [params setValue:page forKey:@"p"];
    [params setValue:count forKey:@"c"];
    [params setValue:[NSString stringWithFormat:@"%ld",type] forKey:@"t"];
    
    return [self GET:JokBaseUrl
          parameters:params
   completionHandler:^(id responseObj, NSError *error) {
       completeHandle([JokModel mj_objectWithKeyValues:responseObj],error);  
   }];
}

+(void)requestExecuteZanOrCaiWithJokId:(NSString *)jokId
                                  type:(NSString *)type
                                  flag:(NSString *)flag
                        completeHandle:(void (^)(NSError * error))completeHandle{
    
    NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
    [params setValue:jokId forKey:@"id"];
    [params setValue:type forKey:@"t"];
    [params setValue:flag forKey:@"flag"];
    [self POST:JokClickUrl parameters:params completionHandler:^(id responseObj, NSError *error) {
        completeHandle(error);
    }];
    
}


+(id)getCommentForJokWithJokId:(NSString *)jokId
                          page:(NSInteger )page
                     pageCount:(NSString *)count
                completeHandle:(void (^)(id, NSError *))completeHandle{
   
    NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
     [params setValue:jokId forKey:@"id"];
     [params setValue:[NSString stringWithFormat:@"%ld",page] forKey:@"p"];
     [params setValue:count forKey:@"c"];
    return [self GET:JokCommentUrl parameters:params completionHandler:^(id responseObj, NSError *error) {
        completeHandle([JokCommentModel mj_objectWithKeyValues:responseObj],error);
    }];
}

+(id)addCommentForJokWithJokId:(NSString *)jokid
                       comment:(NSString *)content
                completeHandle:(void (^)(id, NSError *))completeHandle{
    [self setHeader];
    NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
    [params setValue:jokid forKey:@"jid"];
    [params setValue:content forKey:@"comment"];
    
    return [self POST:JokCommentUrl parameters:params completionHandler:^(id responseObj, NSError *error) {
        completeHandle(responseObj,error);
    }];

}


+(void)addOrCancelAttentionToUserWithUid:(NSString *)uid
                                    type:(NSString *)type
                          completeHandle:(void (^)(id responseObj, NSError *error))completeHandle{
    [self setHeader];
    NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
    [params setValue:type forKey:@"t"];
    [params setValue:uid forKey:@"id"];

    [self POST:JokAddAttentionUrl parameters:params
                           completionHandler:^(id responseObj, NSError *error) {
        completeHandle(responseObj,error);
    }];
}


+(void)getAttentionContentWithPage:(NSString *)page
                         pageCount:(NSString *)pageCount
                    completeHandle:(void (^)(id, NSError *))completeHandle{
        [self setHeader];
    
        [self GET:JokAttentionUrl parameters:nil completionHandler:^(id responseObj, NSError *error) {
            completeHandle([JokModel mj_objectWithKeyValues:responseObj],error);
        }];
    
}

+(id)getUserDetailWithId:(NSString *)uid completeHandle:(void (^)(id, NSError *))completeHandle{
    
    NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
    [params setValue:uid forKey:@"id"];
    return [self GET:JokUserDetailUrl parameters:params completionHandler:^(id responseObj, NSError *error) {
        completeHandle([UserDetailModel mj_objectWithKeyValues:responseObj],error);
    }];
}

@end
