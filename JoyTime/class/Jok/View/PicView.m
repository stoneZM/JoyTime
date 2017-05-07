//
//  PicView.m
//  BaiSi
//
//  Created by stone on 16/9/10.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "PicView.h"
#import "DALabeledCircularProgressView.h"
#import "ShowPhotoViewController.h"

@interface PicView()

@property (weak, nonatomic) IBOutlet UIImageView *isgifImageView;
@property (weak, nonatomic) IBOutlet UIButton *lookBigPicBt;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;


@end


@implementation PicView

+(instancetype)standPicView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.lookBigPicBt.hidden = YES;
    self.isgifImageView.hidden = YES;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
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
    
    self.progressView.progress = 0;
    _jok = jok;
    if ([jok.type isEqualToString:@"gif"])
    {
        [self setIsBigPic:false];
        self.isgifImageView.hidden = NO;
        
    }else{
        [self setIsBigPic:([jok.height floatValue]>1500)];
        ZMLog(@"%lf",[jok.height floatValue]);
        self.isgifImageView.hidden = YES;
        self.imageView.clipsToBounds = YES;
    }
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:jok.imgUrl] placeholderImage:nil options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        self.progressView.hidden = NO;
        CGFloat progress = receivedSize * 1.0 / expectedSize;
        [self.progressView setProgress:progress animated:YES];
        self.progressView.progressLabel.textColor = [UIColor whiteColor];
        NSString* text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
        text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
        self.progressView.progressLabel.text = text;
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.progressView.hidden = YES;
    }];
}

-(void)setModel:(JokDataModel *)model{
   
     self.progressView.progress = 0;
    _model = model;
    if ([model.type isEqualToString:@"gif"])
    {
        [self setIsBigPic:false];
        self.isgifImageView.hidden = NO;
        
    }else{
        [self setIsBigPic:([model.height floatValue]>1500)];
        self.isgifImageView.hidden = YES;
        self.imageView.clipsToBounds = YES;
    }
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:nil options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        self.progressView.hidden = NO;
        CGFloat progress = receivedSize * 1.0 / expectedSize;
        [self.progressView setProgress:progress animated:YES];
        self.progressView.progressLabel.textColor = [UIColor whiteColor];
        NSString* text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
        text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
        self.progressView.progressLabel.text = text;
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.progressView.hidden = YES;
    }];

}


-(void)setIsBigPic:(BOOL)isBigPic{
   
    self.lookBigPicBt.hidden = !isBigPic;

}


@end
