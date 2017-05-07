//
//  ChatViewController.m
//  JoyTime
//
//  Created by stone on 2017/1/11.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "ChatViewController.h"
#import "NTESSessionListViewController.h"
#import "NTESContactViewController.h"
#import "AddFriendViewController.h"


@interface ChatViewController ()

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ZMGlobolgb;
    self.dataSource = self;
    self.delegate = self;
    
}



-(instancetype)init{
    if (self = [super init]) {
        [self defaultConfig];
        [self addBtnToNavi];
    }
    return self;
}
-(void)defaultConfig{
    self.menuBGColor = [UIColor clearColor];
    self.menuViewStyle = WMMenuViewStyleLine;
    self.titleColorNormal = MenuTitleNormalColor;
    self.titleColorSelected = MenuTitleSelectColor;
    self.menuViewLayoutMode = WMMenuViewLayoutModeCenter;
    self.showOnNavigationBar = YES;
    self.progressWidth = 30;
    self.titleSizeNormal = MenuTitleSizeNormal;
    self.titleSizeSelected = MenutitleSizeSelect;
    //    self.speedFactor = 5;
}
-(void)addBtnToNavi{
    
    UIBarButtonItem* fixBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixBtn.width = -10;
    UIBarButtonItem* setBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"cellFollowClickIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(addFriend)];
    self.navigationItem.rightBarButtonItems = @[fixBtn,setBtn];
}
-(void)addFriend{
    AddFriendViewController* addvc = [[AddFriendViewController alloc]init];
    [self.navigationController pushViewController:addvc animated:YES];
}

#pragma mark - WMPageControllerDelegate
-(NSInteger)numbersOfTitlesInMenuView:(WMMenuView *)menu{
    ZMLogfunc;
    return 2;
}
-(NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return 2;
}
-(NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index{
    if (index == 0) {
        return @"好友";
    }else{
        return @"聊天";
    }
}
-(UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    if (index==1)
        return [[NTESSessionListViewController alloc]init];
    
    return [[NTESContactViewController alloc]init];
    
}



@end
