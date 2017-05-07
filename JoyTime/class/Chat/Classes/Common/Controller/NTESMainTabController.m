//
//  MainTabController.m
//  NIMDemo
//
//  Created by chris on 15/2/2.
//  Copyright (c) 2015年 Netease. All rights reserved.
//

#import "NTESMainTabController.h"
#import "AppDelegate.h"
#import "NTESSessionListViewController.h"
#import "NTESContactViewController.h"
#import "NIMSDK.h"
#import "UIImage+NTESColor.h"
#import "NTESCustomNotificationDB.h"
#import "NTESNotificationCenter.h"
#import "NTESNavigationHandler.h"
#import "NTESNavigationAnimator.h"
#import "NTESBundleSetting.h"
#import "CustomNavigationController.h"
#import "CustomTabBar.h"
#import "JokViewController.h"
#import "MeViewController.h"
#import "ChatViewController.h"
#import "AttentionController.h"
#import "ComposeViewController.h"
#import "CustomNavigationController.h"

#import "NTESMainTabController.h"
#import "AppDelegate.h"
#import "NTESSessionListViewController.h"
#import "NTESContactViewController.h"
#import "NIMSDK.h"
#import "UIImage+NTESColor.h"
#import "NTESCustomNotificationDB.h"
#import "NTESNotificationCenter.h"
#import "NTESNavigationHandler.h"
#import "NTESNavigationAnimator.h"
#import "NTESBundleSetting.h"
#import <AudioToolbox/AudioToolbox.h>

#define TabbarVC    @"vc"
#define TabbarTitle @"title"
#define TabbarImage @"image"
#define TabbarSelectedImage @"selectedImage"
#define TabbarItemBadgeValue @"badgeValue"
#define TabBarCount 4

typedef NS_ENUM(NSInteger,NTESMainTabType) {
    NTESMainTabTypeJok,       //段子
    NTESMainTabTypeAttention, //关注列表
    NTESMainTabTypeChat,      //聊天
//    NTESMainTabTypeContact,   //通讯录
    NTESMainTabTypeMe,        //我
};



@interface NTESMainTabController ()<NIMSystemNotificationManagerDelegate,NIMConversationManagerDelegate,CustomTabBarDelegate>

@property (nonatomic,strong) NSArray *navigationHandlers;

@property (nonatomic,strong) NTESNavigationAnimator *animator;

@property (nonatomic,assign) NSInteger sessionUnreadCount;

@property (nonatomic,assign) NSInteger systemUnreadCount;

@property (nonatomic,assign) NSInteger customSystemUnreadCount;

@property (nonatomic,copy)  NSDictionary *configs;

@end

@implementation NTESMainTabController

+ (instancetype)instance{
    AppDelegate *delegete = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController *vc = delegete.window.rootViewController;
    if ([vc isKindOfClass:[NTESMainTabController class]]) {
        return (NTESMainTabController *)vc;
    }else{
        return nil;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setTabBar];
    [self setUpSubNav];
    [[NIMSDK sharedSDK].systemNotificationManager addDelegate:self];
    [[NIMSDK sharedSDK].conversationManager addDelegate:self];
    extern NSString *NTESCustomNotificationCountChanged;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onCustomNotifyChanged:) name:NTESCustomNotificationCountChanged object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setUpStatusBar];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //会话界面发送拍摄的视频，拍摄结束后点击发送后可能顶部会有红条，导致的界面错位。
    self.view.frame = [UIScreen mainScreen].bounds;
}

- (void)dealloc{
    [[NIMSDK sharedSDK].systemNotificationManager removeDelegate:self];
    [[NIMSDK sharedSDK].conversationManager removeDelegate:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSArray*)tabbars{
    self.sessionUnreadCount  = [NIMSDK sharedSDK].conversationManager.allUnreadCount;
    self.systemUnreadCount   = [NIMSDK sharedSDK].systemNotificationManager.allUnreadCount;
    self.customSystemUnreadCount = [[NTESCustomNotificationDB sharedInstance] unreadCount];
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (NSInteger tabbar = 0; tabbar < TabBarCount; tabbar++) {
        [items addObject:@(tabbar)];
    }
    return items;
}


- (void)setUpSubNav{
    NSMutableArray *handleArray = [[NSMutableArray alloc] init];
    NSMutableArray *vcArray = [[NSMutableArray alloc] init];
    [self.tabbars enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
       
        UIViewController* vc = nil;
        
        NSDictionary * item =[self vcInfoForTabType:[obj integerValue]];
        NSString *vcName = item[TabbarVC];
        NSString *title  = item[TabbarTitle];
        NSString *imageName = item[TabbarImage];
        NSString *imageSelected = item[TabbarSelectedImage];
        if ([obj integerValue] == 0) {
            vc = [JokViewController createJokVC];
        }else{
            Class clazz = NSClassFromString(vcName);
            vc = [[clazz alloc] init];
        }
        vc.hidesBottomBarWhenPushed = NO;
        CustomNavigationController *nav = [[CustomNavigationController alloc] initWithRootViewController:vc];
        nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:title
                                                       image:[UIImage imageNamed:imageName]
                                               selectedImage:[UIImage imageNamed:imageSelected]];
        nav.tabBarItem.tag = idx;
        NSInteger badge = [item[TabbarItemBadgeValue] integerValue];
        if (badge) {
            nav.tabBarItem.badgeValue = [NSString stringWithFormat:@"%zd",badge];
        }
        NTESNavigationHandler *handler = [[NTESNavigationHandler alloc] initWithNavigationController:nav];
        nav.delegate = handler;
        
        [vcArray addObject:nav];
        [handleArray addObject:handler];
    }];
    self.viewControllers = [NSArray arrayWithArray:vcArray];
    self.navigationHandlers = [NSArray arrayWithArray:handleArray];
}


- (void)setUpStatusBar{
    UIStatusBarStyle style = UIStatusBarStyleDefault;
    [[UIApplication sharedApplication] setStatusBarStyle:style
                                                animated:NO];
}



#pragma mark - NIMConversationManagerDelegate
- (void)didAddRecentSession:(NIMRecentSession *)recentSession
           totalUnreadCount:(NSInteger)totalUnreadCount{
    ZMLogfunc;
    self.sessionUnreadCount = totalUnreadCount;
    [self refreshSessionBadge];
}


- (void)didUpdateRecentSession:(NIMRecentSession *)recentSession
              totalUnreadCount:(NSInteger)totalUnreadCount{
    ZMLogfunc;
    [self playNotifySound];
    self.sessionUnreadCount = totalUnreadCount;
    [self refreshSessionBadge];
}


- (void)didRemoveRecentSession:(NIMRecentSession *)recentSession totalUnreadCount:(NSInteger)totalUnreadCount{
    self.sessionUnreadCount = totalUnreadCount;
    [self refreshSessionBadge];
}

- (void)messagesDeletedInSession:(NIMSession *)session{
    self.sessionUnreadCount = [NIMSDK sharedSDK].conversationManager.allUnreadCount;
    [self refreshSessionBadge];
}

- (void)allMessagesDeleted{
    self.sessionUnreadCount = 0;
    [self refreshSessionBadge];
}

#pragma mark - NIMSystemNotificationManagerDelegate
- (void)onSystemNotificationCountChanged:(NSInteger)unreadCount
{
    ZMLogfunc;
    self.systemUnreadCount = unreadCount;
    [self refreshContactBadge];
}

#pragma mark - Notification
- (void)onCustomNotifyChanged:(NSNotification *)notification
{
    ZMLogfunc;
    NTESCustomNotificationDB *db = [NTESCustomNotificationDB sharedInstance];
    self.customSystemUnreadCount = db.unreadCount;
    [self refreshSettingBadge];
}



- (void)refreshSessionBadge{
    ZMLogfunc;
    
    CustomNavigationController *nav = self.viewControllers[NTESMainTabTypeChat];
    nav.tabBarItem.badgeValue = self.sessionUnreadCount ? @(self.sessionUnreadCount).stringValue : nil;
}

- (void)refreshContactBadge{
    ZMLogfunc;
    CustomNavigationController *nav = self.viewControllers[NTESMainTabTypeChat];
    NSInteger badge = self.systemUnreadCount;
    nav.tabBarItem.badgeValue = badge ? @(badge).stringValue : nil;
}

- (void)refreshSettingBadge{
    
    CustomNavigationController *nav = self.viewControllers[NTESMainTabTypeMe];
    NSInteger badge = self.customSystemUnreadCount;
    nav.tabBarItem.badgeValue = badge ? @(badge).stringValue : nil;
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

#pragma mark - NTESNavigationGestureHandlerDataSource
- (CustomNavigationController *)navigationController
{
    return self.selectedViewController;
}


#pragma mark - Rotate

- (BOOL)shouldAutorotate{
    ZMLogfunc;
    BOOL enableRotate = [NTESBundleSetting sharedConfig].enableRotate;
    return enableRotate ? [self.selectedViewController shouldAutorotate] : NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    BOOL enableRotate = [NTESBundleSetting sharedConfig].enableRotate;
    return enableRotate ? [self.selectedViewController supportedInterfaceOrientations] : UIInterfaceOrientationMaskPortrait;
}




#pragma mark - VC
- (NSDictionary *)vcInfoForTabType:(NTESMainTabType)type{
    
    if (_configs == nil)
    {
        _configs = @{
                     @(NTESMainTabTypeJok)     : @{
                             TabbarVC           : @"JokViewController",
                             TabbarTitle        : @"Jok",
                             TabbarImage        : @"tabBar_essence_icon",
                             TabbarSelectedImage: @"tabBar_essence_click_icon",
                             TabbarItemBadgeValue: @(self.customSystemUnreadCount)
                             },
                     @(NTESMainTabTypeAttention): @{
                             TabbarVC           : @"AttentionListController",
                             TabbarTitle        : @"关注",
                             TabbarImage        : @"tabBar_friendTrends_icon",
                             TabbarSelectedImage: @"tabBar_friendTrends_click_icon",
                             },
                     @(NTESMainTabTypeChat) : @{
                             TabbarVC           : @"ChatViewController",
                             TabbarTitle        : @"Chat",
                             TabbarImage        : @"icon_message_normal",
                             TabbarSelectedImage: @"icon_message_pressed",
                             TabbarItemBadgeValue: @(self.sessionUnreadCount)
                             },
//                     @(NTESMainTabTypeContact)     : @{
//                             TabbarVC           : @"NTESContactViewController",
//                             TabbarTitle        : @"通讯录",
//                             TabbarImage        : @"tabBar_friendTrends_icon",
//                             TabbarSelectedImage: @"tabBar_friendTrends_click_icon",
//                             TabbarItemBadgeValue: @(self.systemUnreadCount)
//                             },
                     @(NTESMainTabTypeMe)     : @{
                             TabbarVC           : @"MeViewController",
                             TabbarTitle        : @"ME",
                             TabbarImage        : @"tabBar_me_icon",
                             TabbarSelectedImage: @"tabBar_me_click_icon",
                             TabbarItemBadgeValue: @(self.customSystemUnreadCount)
                             },

                     };

    }
    return _configs[@(type)];
}




/**
 设置tabbar文字属性
 */
-(void)setTabBar{
    //自定义tabbar , 当一个属性是只读的时候，可以使用kvc来赋值
    CustomTabBar* tabBar = [[CustomTabBar alloc]init];
    tabBar.delagate = self;
    [self setValue:tabBar forKey:@"tabBar"];
    [self setTabBarAttr];
}

-(void)setTabBarAttr{
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

- (void)playNotifySound {
    //获取路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"message" ofType:@"wav"];
    //定义一个SystemSoundID
    SystemSoundID soundID;
    //判断路径是否存在
    if (path) {
        //创建一个音频文件的播放系统声音服务器
        OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)([NSURL fileURLWithPath:path]), &soundID);
        //判断是否有错误
        if (error != kAudioServicesNoError) {
            NSLog(@"%d",(int)error);
        }
    }
    //播放声音和振动
    AudioServicesPlayAlertSoundWithCompletion(soundID, ^{
        
    });
//    SystemSoundID soundID = 1005;//具体参数详情下面贴出来
//    //播放声音
//    AudioServicesPlaySystemSound(soundID);
}


@end
