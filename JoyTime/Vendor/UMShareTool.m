//
//  UMShareTool.m
//  JoyTime
//
//  Created by stone on 2017/1/15.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "UMShareTool.h"
#import "UMSocialSinaHandler.h"
@implementation UMShareTool

{
    NSString* _content;
    NSString* _title;
    NSString* _imageName;
    NSString* _url;
}

- (void)shareWithContent:(NSString *)content title:(NSString *)title imageName:(NSString *)imageName url:(NSString *)shareUrl{
    _content = content;
    _title = title;
    _imageName = imageName;
    _url = shareUrl;
    //显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        [self shareWebPageToPlatformType:platformType];
    }];
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:_title
                                                                             descr:_content
                                                                         thumImage:[UIImage imageNamed:@"icon.png"]];
    //设置网页地址
    shareObject.webpageUrl = _url;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType
                                        messageObject:messageObject
                                currentViewController:self
                                           completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}




@end
