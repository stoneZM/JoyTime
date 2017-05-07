//
//  AttentionController.m
//  BanTang
//
//  Created by stone on 2016/10/20.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "AttentionController.h"
#import "AttentionListController.h"
#import "AttentionUListController.h"
@interface AttentionController ()<WMPageControllerDataSource,WMPageControllerDelegate>

@end

@implementation AttentionController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = ZMGlobolgb;
    self.dataSource = self;
    self.delegate = self;
    
}



-(instancetype)init{
    if (self = [super init]) {
        [self defaultConfig];
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
        return @"攻略";
    }else{
        return @"单品";
    }
}
-(UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    if (index==0)
        return [[AttentionListController alloc]init];
    
    return [[AttentionUListController alloc]init];
   
}





@end
