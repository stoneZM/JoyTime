//
//  JokViewController.m
//  JoyTime
//
//  Created by stone on 2017/1/11.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "JokViewController.h"
#import "JokTableViewController.h"

@interface JokViewController ()


@end

@implementation JokViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ZMGlobolgb;
    [self setNavi];
    //    [self addMenu];
}

/**
 提供每个题目所对应的控制器的类型，题目和类型数量必须一致
 */
+(NSArray*)viewControllerClasses{
    NSMutableArray* arr = [NSMutableArray new];
    for (int i = 0; i < [self itemNames].count ; i++) {
        [ arr addObject:[JokTableViewController class]];
    }
    return [arr copy];
}




+(instancetype)createJokVC{
    
    NSArray* vcClass = [self viewControllerClasses];
    JokViewController* wmVC = [[JokViewController alloc]initWithViewControllerClasses:vcClass andTheirTitles:[self itemNames]];
    wmVC.keys = [[self vcKeys] mutableCopy];
    wmVC.values = [[self vcValues] mutableCopy];
    wmVC.menuViewStyle = WMMenuViewStyleLine;
    wmVC.progressWidth = 40;
    wmVC.menuHeight = MenuHeight;
    wmVC.menuView.backgroundColor = ZMRandomColor;
    wmVC.bounces = YES;
    wmVC.titleSizeNormal = MenuTitleSizeNormal;
    wmVC.titleSizeSelected = MenutitleSizeSelect;
    wmVC.titleColorNormal = MenuTitleNormalColor;
    wmVC.titleColorSelected = MenuTitleSelectColor;
    return wmVC;
}

/** 提供每个VC对应的values值数组 */
+ (NSArray *)vcValues{
    NSArray* type = @[@(1),@(2),@(3),@(4)];
    return type;
}
/** 提供每个VC对应的key值数组 */
+ (NSArray *)vcKeys{
    NSMutableArray *arr = [NSMutableArray new];
    for (int i = 0; i <[self itemNames].count; i++){
        [arr addObject:@"type"];
    }
    return [arr copy];
}

/** 提供题目数组 */
+ (NSArray *)itemNames{
    return @[@"段子",@"图片",@"视屏",@"音屏"];
}


-(void)setNavi{
    
//    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
//    UIBarButtonItem* fixItem =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    fixItem.width = TagSubItemSpaceToleft;
//    UIBarButtonItem* item = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" hightlightImage:@"MainTagSubIconClick" target:self action:@selector(mainBtn)];
//    self.navigationItem.leftBarButtonItems = @[fixItem,item];
}

#pragma mark - 左上角按钮的事件监听
-(void)mainBtn{
    ZMLog(@"mianBtn----click");
}
-(void)dealloc{
    ZMLogfunc;
}



@end
