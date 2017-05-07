//
//  CarouselView.m
//  JoyTime
//
//  Created by stone on 2017/1/24.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "CarouselView.h"

@interface CarouselView()


@property (weak, nonatomic) IBOutlet UIImageView *profileImg;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLb;
@property (weak, nonatomic) IBOutlet UIImageView *sexImg;

@end


@implementation CarouselView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.profileImg.layer.cornerRadius = 50.0;
    self.profileImg.layer.masksToBounds = YES;
}

-(void)setUserModel:(JokUserModel *)userModel{
    _userModel = userModel;
    [self.profileImg sd_setImageWithURL:[NSURL URLWithString:userModel.profileImg] placeholderImage:[UIImage imageNamed:@""]];
    self.nickNameLb.text = userModel.nickName;
    NSString* imageName = [userModel.sex isEqualToString:@"M"] ? @"Profile_manIcon" : @"Profile_womanIcon";
    self.sexImg.image = [UIImage imageNamed:imageName];
}


@end
