//
//  VideoView.m
//  BaiSi
//
//  Created by stone on 16/9/13.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "VideoView.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
@interface VideoView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *totalLb;
@property (weak, nonatomic) IBOutlet UILabel *currentLb;

@end


@implementation VideoView

+(instancetype)standVideoView{
    return [[[NSBundle mainBundle]loadNibNamed:@"VideoView"owner:nil options:nil] lastObject];
}


- (IBAction)playBtn:(UIButton *)sender {

    AVPlayer* player = [AVPlayer playerWithURL: [NSURL URLWithString:self.model.videoUrl]];
    [player play];
    [VideoView sharedInstance].player = player;
    [self addSubview:[VideoView sharedInstance].view];
    [VideoView sharedInstance].view.frame = self.bounds;

}
-(void)setModel:(JokDataModel *)model{
    _model = model;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.thumbnail]];
    self.totalLb.text = model.duration;
    self.currentLb.text = model.duration;
}

-(void)setJok:(UserJokModel *)jok{
    _jok = jok;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:jok.thumbnail]];
    self.totalLb.text = jok.duration;
    self.currentLb.text = jok.duration;
}



//使用单例模式创建播放器
+(AVPlayerViewController*)sharedInstance
{
    static AVPlayerViewController* vc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        vc = [AVPlayerViewController new];
    });
    return vc;
}


-(void)setFlag:(NSUInteger)flag{
    [[VideoView sharedInstance].player pause];
    [VideoView sharedInstance].player = nil;
    [[VideoView sharedInstance].view removeFromSuperview];
}





@end
