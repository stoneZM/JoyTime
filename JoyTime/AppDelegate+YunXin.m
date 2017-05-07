//
//  AppDelegate+YunXin.m
//  JoyTime
//
//  Created by stone on 2017/1/15.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "AppDelegate+YunXin.h"
#import "NIMChatManagerProtocol.h"
#import "NTESSessionListViewController.h"



@implementation AppDelegate (YunXin)



-(void)initializeWithYunXinApplication:(UIApplication *)application{
    
    NSString* appKey = @"5d98173538fb68bdb8752a12993def13";

    NSString* cerName= @"ENTERPRISE";
    [[NIMSDK sharedSDK] registerWithAppID:appKey
                                  cerName:cerName];
    
    NSString* accid = [StoreTool getValuesForKey:USERACCID];
    NSString* yunXinToken = [StoreTool getValuesForKey:USERYXTOKEN];

    //登录云信
    if (accid&&yunXinToken) {
            [[[NIMSDK sharedSDK] loginManager] login:accid token:yunXinToken completion:^(NSError * _Nullable error) {
                if (error) {
                    ZMLog(@"登录失败");
                }else{
                    ZMLog(@"登录成功");
                }
            }];
    }
    
    
    [self commonInitListenEvents];
}



- (void)commonInitListenEvents
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(logout:)
                                                 name:LogoutNotification
                                               object:nil];
    
    [[[NIMSDK sharedSDK] loginManager] addDelegate:self];
}


-(void)autoLogin:(NSString *)account token:(NSString *)token{
    NSString* accid = [StoreTool getValuesForKey:USERACCID];
    NSString* yunXinToken = [StoreTool getValuesForKey:USERYXTOKEN];
    
    //登录云信
    if (accid&&yunXinToken) {
        [[[NIMSDK sharedSDK] loginManager] autoLogin:accid
                                               token:yunXinToken];
    }
    ZMLog(@"%@", [[[NIMSDK sharedSDK] loginManager] currentAccount]);
}


-(void)logout:(NSNotification*)note
{
   [[[NIMSDK sharedSDK] loginManager] logout:^(NSError *error){
       ZMLog(@"-----------退出成功--------");
   }];
}

-(void)onAutoLoginFailed:(NSError *)error{
    ZMLog(@"自动登录失败");
}

/**
 *  被踢(服务器/其他端)回调
 *
 *  @param code        被踢原因
 *  @param clientType  发起踢出的客户端类型
 */
- (void)onKick:(NIMKickReason)code clientType:(NIMLoginClientType)clientType{
    ZMLog(@"被踢(服务器/其他端)回调");
}








@end
