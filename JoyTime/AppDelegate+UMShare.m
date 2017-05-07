//
//  AppDelegate+UMShare.m
//  JoyTime
//
//  Created by stone on 2017/1/15.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "AppDelegate+UMShare.h"
#import <UMSocialCore/UMSocialCore.h>
@implementation AppDelegate (UMShare)

- (void)initializeWithUMShareApplication:(UIApplication *)application{
    
    [self shareBaseOnUM];
}


-(void)shareBaseOnUM{
    //打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];
    
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"587a39cf1c5dd044e600019b"];
    
    // 获取友盟social版本号
    //NSLog(@"UMeng social version: %@", [UMSocialGlobal umSocialSDKVersion]);
    
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"945b58aef3a271f0" appSecret:@"0ae78dd427619681b04833c79a857b" redirectURL:@"http://mobile.umeng.com/social"];
    
    
    //设置分享到QQ互联的appKey和appSecret
    // U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"100424468"  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
    //设置新浪的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"1333606741"  appSecret:@"4b46fdd8e367bf30164db85ac5b7b9b5" redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    // 如果不想显示平台下的某些类型，可用以下接口设置
    //    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite),@(UMSocialPlatformType_YixinTimeLine),@(UMSocialPlatformType_LaiWangTimeLine),@(UMSocialPlatformType_Qzone)]];
}

@end
