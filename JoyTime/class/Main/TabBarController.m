//
//  TabBarController.m
//  JoyTime
//
//  Created by stone on 2017/1/11.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "TabBarController.h"
#import "CustomNavigationController.h"
#import "CustomTabBar.h"
#import "JokViewController.h"
#import "MeViewController.h"
#import "ChatViewController.h"
#import "AttentionController.h"
#import "ComposeViewController.h"

@interface TabBarController () <CustomTabBarDelegate>

@end

@implementation TabBarController


//此方法只会调用一次，设置全局的tabBar基调，只需第一次加载时调用
+(void)initialize{
    [self setTabBarAttr];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildVC];
    
    //自定义tabbar , 当一个属性是只读的时候，可以使用kvc来赋值
    CustomTabBar* tabBar = [[CustomTabBar alloc]init];
    tabBar.delagate = self;
    [self setValue:tabBar forKey:@"tabBar"];
}

/**
 添加子控制器
 */
-(void)addChildVC{

//    [self setChildVC:[JokViewController createJokVC] title:@"jok" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    [self setChildVC:[ChatViewController new] title:@"chat" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    [self setChildVC:[AttentionController new] title:@"other" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    [self setChildVC:[MeViewController new] title:@"me" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
}

/**
 初始化自控制器
 */
-(void)setChildVC:(UIViewController*)vc title:(NSString*)title image:(NSString*)image selectedImage:(NSString*)selectedImage{
    ZMLog(@"-----");
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    vc.tabBarItem.title = title;
    //不要在此处设置有关vc的view的属性，因为只要设置了，没显示的时候就已经加载了
    CustomNavigationController* navi = [[CustomNavigationController alloc]initWithRootViewController:vc];
    vc.title = title;
    [self addChildViewController:navi];
}

/**
 设置tabbar文字属性
 */
+(void)setTabBarAttr{
    
    NSMutableDictionary* attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attr[NSForegroundColorAttributeName] = [UIColor grayColor];
    NSMutableDictionary* selectAttr = [NSMutableDictionary dictionary];
    selectAttr[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    selectAttr[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    /**
     当方法后面带有 UI_APPEARANCE_SELECTOR 描述信息时，说明这个属性可以通过appearance来统一设置
     */
    [[UITabBarItem appearance] setTitleTextAttributes:attr forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:selectAttr forState:UIControlStateSelected];
}

-(void)customTabbar:(CustomTabBar *)tabBar didClickComposeBtn:(UIButton *)button{
    ComposeViewController* vc = [[ComposeViewController alloc]init];
    [self presentViewController:vc animated:NO completion:nil];
    //    ComposePicController* vc = [[ComposePicController alloc]init];
    //    [self presentViewController:vc animated:YES completion:nil];
}

@end
