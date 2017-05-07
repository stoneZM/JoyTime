//
//  MeViewController.m
//  JoyTime
//
//  Created by stone on 2017/1/11.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "MeViewController.h"
#import "HeaderView.h"
#import "LoginViewController.h"
#import "SettingViewController.h"

@interface MeViewController ()

@property (nonatomic,strong)HeaderView* hearderView;
@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self defaultConfig];
    [self addBtnToNavi];
    [self addChildVc];
    [self registerNotificator];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //    在viewWillDisappear里面重置一下
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}


//添加通知
-(void)registerNotificator{
    //接受通知
    NSNotificationCenter* notification = [NSNotificationCenter defaultCenter];
    [notification addObserver:self selector:@selector(hasLogin) name:LoginSuccedNotifucation object:nil];
    //如果能取出来说明已经登录
    if ([StoreTool getValuesForKey:USERID]) {
        return;
    }
   
}

- (void)hasLogin{
   [[[NIMSDK sharedSDK] loginManager] autoLogin:[StoreTool getValuesForKey:USERACCID] token:[StoreTool getValuesForKey:USERYXTOKEN]];
    self.hearderView.hasLogin = YES;
}

-(void)defaultConfig{
 
    self.navigationItem.title = @"";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    HeaderView* headerView = [[NSBundle mainBundle]loadNibNamed:@"HeaderView" owner:self options:nil].firstObject;
    self.hearderView = headerView;
    headerView.height = ZMSCREENH*0.4;
    self.tableView.tableHeaderView = headerView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
-(void)addBtnToNavi{
    
    UIBarButtonItem* fixBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixBtn.width = 10;
    UIBarButtonItem* setBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"iconSettings"] style:UIBarButtonItemStylePlain target:self action:@selector(setBtn)];
    self.navigationItem.rightBarButtonItems = @[fixBtn,setBtn];
}
-(void)addChildVc{

}

-(void)msgBtn{
    ZMLogfunc;
}
-(void)signBtn{
    ZMLogfunc;
}
-(void)scanBtn{
    ZMLogfunc;
}
-(void)setBtn{
    SettingViewController* vc = [SettingViewController standSettingVC];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    self.hearderView.tableViewOffset = offsetY;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    return cell;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
