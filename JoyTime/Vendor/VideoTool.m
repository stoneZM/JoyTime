//
//  VideoTool.m
//  BaiSi
//
//  Created by stone on 2016/10/2.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "VideoTool.h"


static AVPlayer* player = nil;
static NSString* _url=nil;



@implementation VideoTool


+(void)playAudioWithURL:(NSString *)url{

    if (url == nil) {
        return ;
    }
    //如果传入的rul相同表示继续播放
    if ([_url isEqualToString:url]) {
        [player play];
        return ;
    }
    NSURL* playURL = [NSURL URLWithString:url];
    //否则暂停原来的yinpin，开启新的音频
    [self stopPlayAudio];
    player = [AVPlayer playerWithURL:playURL];
    [player play];
    _url = url;
}


+(void)stopPlayAudio{

    [player pause];
    player = nil;
    _url = nil;
}


+(void)pausePlayAudio{
    [player pause];
}


@end
