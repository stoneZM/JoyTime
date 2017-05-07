//
//  CustomTabBar.h
//  JoyTime
//
//  Created by stone on 2017/1/11.
//  Copyright © 2017年 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomTabBar;

@protocol CustomTabBarDelegate

-(void)customTabbar:(CustomTabBar*)tabBar didClickComposeBtn:(UIButton*)button;

@end

@interface CustomTabBar : UITabBar <NSObject>


@property (nonatomic,weak)id<CustomTabBarDelegate> delagate;

@end
