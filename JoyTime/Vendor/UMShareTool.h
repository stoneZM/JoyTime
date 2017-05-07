//
//  UMShareTool.h
//  JoyTime
//
//  Created by stone on 2017/1/15.
//  Copyright © 2017年 stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UShareUI/UShareUI.h>

@interface UMShareTool : NSObject



/**
 webPage类型分享

 @param content 分享的内容
 @param title 分享的标题
 @param imageName 图片
 @param shareUrl 点击要跳转的地址
 */
-(void)shareWithContent:(NSString*)content
                  title:(NSString*)title
              imageName:(NSString*)imageName
                    url:(NSString*)shareUrl;

@end
