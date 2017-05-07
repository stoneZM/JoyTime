//
//  VideoTool.h
//  BaiSi
//
//  Created by stone on 2016/10/2.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface VideoTool : NSObject

/*
 开始播放音乐
 */
+(void)playAudioWithURL:(NSString*)url;


/*
 停止播放
 */
+(void)stopPlayAudio;

/*
    暂停播放
 */
+(void)pausePlayAudio;



@end
