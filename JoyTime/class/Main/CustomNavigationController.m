//
//  CustomNavigationController.m
//  JoyTime
//
//  Created by stone on 2017/1/11.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "CustomNavigationController.h"

@interface CustomNavigationController ()

@end

@implementation CustomNavigationController

/**
 仅当第一次使用此类的时候，才调用此方法
 */
+(void)initialize{
    
    //设置全局的导航栏样式
     [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
    //去掉导航栏的分割线
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    //清空此代理，能够实现自定义返回按钮时，边缘右滑退出控制器
    self.interactivePopGestureRecognizer.delegate = nil;
}

/**
 设置全局的导航栏返回时的按钮样式
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    ZMLogfunc;
    //只能更改push出来的leftBaritem
    if (self.childViewControllers.count > 0) { //第一个控制器不做处理
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[self naviBtn]];
        viewController.hidesBottomBarWhenPushed = YES;  //push出控制器的时候，隐藏底部
    }
    
    [super pushViewController:viewController animated:animated];
}

-(UIButton*)naviBtn{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button setTitleColor:ZMRGB(235, 78, 65, 1) forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
    [button sizeToFit];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    return button;
}
-(void)back{
    [self popViewControllerAnimated:YES];
}


@end
