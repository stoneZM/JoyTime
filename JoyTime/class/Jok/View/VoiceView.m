//
//  VoiceView.m
//  BaiSi
//
//  Created by stone on 16/9/13.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "VoiceView.h"
#import "VideoTool.h"
#import "ShowPhotoViewController.h"

@interface VoiceView()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *totalLb;
@property (weak, nonatomic) IBOutlet UILabel *currentLb;


@end


@implementation VoiceView
+(instancetype)standVoiceView{
   
    return [[[NSBundle mainBundle]loadNibNamed:@"VioceView"owner:nil options:nil] lastObject];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPic)];
    [self.imageView addGestureRecognizer:tap];
}

-(void)showPic{
    
    ShowPhotoViewController* vc = [[ShowPhotoViewController alloc]init];
    vc.model = self.model;
    //推出控制器
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
}

-(void)setJok:(UserJokModel *)jok{
    
    _jok = jok;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:jok.thumbnail]];
    self.totalLb.text = jok.duration;
    self.currentLb.text = jok.duration;
}


-(void)setModel:(JokDataModel *)model{
    _model = model;

    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.thumbnail]];
    self.totalLb.text = model.duration;
    self.currentLb.text = model.duration;


}
- (IBAction)playBtn:(UIButton *)sender {

    sender.selected = !sender.selected;
    
    if (sender.isSelected) {
        [VideoTool playAudioWithURL:self.model.audioUrl];
    }else{
        [VideoTool pausePlayAudio];
    }
}




@end
