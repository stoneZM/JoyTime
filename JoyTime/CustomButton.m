//
//  CustomButton.m
//  BaiSi
//
//  Created by stone on 16/9/7.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat height = self.height*0.7;
    self.imageView.width = self.width;
    self.imageView.height = height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height*0.3;

    self.imageView.x = 0;
    self.imageView.y = 0;
    self.titleLabel.x = 0;
    self.titleLabel.y = self.height*0.7;

}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

-(void)setUp{
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:13];

}

-(void)setModel:(ButtonModel *)model{
    _model = model;
   
    UIImage* image = [UIImage imageNamed:model.imageName];
    [self setImage:image forState:UIControlStateNormal];
    [self setTitle:model.buttonName forState:UIControlStateNormal];
}


@end
