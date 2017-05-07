//
//  CustomTabBar.m
//  JoyTime
//
//  Created by stone on 2017/1/11.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "CustomTabBar.h"
//#import "ComposeViewController.h"


@interface CustomTabBar()
@property (nonatomic,strong)UIButton* composeBtn;
@end

@implementation CustomTabBar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.composeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.composeBtn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [self.composeBtn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [self.composeBtn sizeToFit];   //让按钮的大小随图片自适应
        [self addSubview:self.composeBtn];
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        [self.composeBtn addTarget:self action:@selector(composeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


/**
 重写控件，可以重写控制的布局方法
 */
-(void)layoutSubviews{
    [super layoutSubviews];
    self.composeBtn.center = CGPointMake(self.width*0.5, self.height*0.5);
    CGFloat y = 0;
    CGFloat width = self.width * 0.2;
    CGFloat height = self.height;
    NSInteger index = 0;
    for (UIView* button in self.subviews) {
        //判断是否为按钮或者是发布按钮，
        if (button == self.composeBtn || ![button isKindOfClass:[UIControl class]]) {
            continue;
        }
        CGFloat x = width * ((index > 1) ? index+1  : index);
        button.frame = CGRectMake(x, y, width, height);
        index++ ;
    }
}

-(void)composeBtnClick:(UIButton*)button{
    ZMLogfunc;
    [self.delagate customTabbar:self didClickComposeBtn:button];
}



@end
