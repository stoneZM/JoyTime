//
//  PlaceHolderView.m
//  JoyTime
//
//  Created by stone on 2017/1/18.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "PlaceHolderView.h"
#import "LoginViewController.h"
@implementation PlaceHolderView

+(instancetype)standPlaceHoldView{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}


- (IBAction)LoginBtn:(id)sender {
    
    LoginViewController* vc = [[LoginViewController alloc]init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
}

@end
