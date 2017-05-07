//
//  PicCell.m
//  BaiSi
//
//  Created by stone on 2016/10/5.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "PicCell.h"

@interface PicCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *delateBtn;
@property (weak, nonatomic) IBOutlet UIButton *addPicBtn;

@end

@implementation PicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    if (self.image == nil) {

    }
}


-(void)setImage:(UIImage *)image{
    if (image == nil) {
        self.delateBtn.hidden = YES;
        self.addPicBtn.userInteractionEnabled = YES;
        self.imageView.hidden = YES;
    }else{
        self.imageView.hidden = NO;
        self.delateBtn.hidden = NO;
        self.addPicBtn.userInteractionEnabled = NO;
        self.imageView.image = image;
    }
}
- (IBAction)addPicAction:(UIButton *)sender {
    NSNotificationCenter* noti = [NSNotificationCenter defaultCenter];
    [noti postNotificationName:@"AddPicActionNotification" object:nil];
}

- (IBAction)deleateAction:(UIButton *)sender {

    NSNotificationCenter* noti = [NSNotificationCenter defaultCenter];
    [noti postNotificationName:@"DelateActionNotification" object:self];

}




@end
