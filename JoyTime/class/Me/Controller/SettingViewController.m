//
//  SettingViewController.m
//  
//
//  Created by stone on 16/9/7.
//
//

#import "SettingViewController.h"
#import "LoginViewController.h"


@interface SettingViewController ()

@end

@implementation SettingViewController
{
    UIView* _footerView;
}

+(instancetype)standSettingVC{
    static SettingViewController* vc  = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        vc = [[UIStoryboard storyboardWithName:NSStringFromClass(self) bundle:nil]instantiateInitialViewController];
    });
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hasLogin) name:LoginSuccedNotifucation object:nil];
   
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([LoginViewController isLogin]){
        [self setFooterView];
    }else{
        if (_footerView) {
            [_footerView removeFromSuperview];
        }
    }
}


-(void)setFooterView{
    
    UIView* footerView = [[UIView alloc]init];
    _footerView = footerView;
    footerView.frame = CGRectMake(0, 0, ZMSCREENW, 100);
    footerView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = footerView;
    self.tableView.height = 40;
    UIButton* logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [footerView addSubview:logoutBtn];
    [logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.top.mas_equalTo(30);
        make.bottom.mas_equalTo(-30);
        make.right.mas_equalTo(-30);
    }];
    [logoutBtn setTitle:@"退出此账号" forState:UIControlStateNormal];
    [logoutBtn setBackgroundColor:[UIColor redColor]];
    logoutBtn.layer.cornerRadius = 5;
    [logoutBtn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
}


#pragma  mark UITableViewDelegate 
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        return ;
    }
    switch (indexPath.row) {
        case 0:
            ZMLog(@"%ld",indexPath.row);
            break;
        case 1:
            ZMLog(@"%ld",indexPath.row);

            break;
        case 2:
            ZMLog(@"%ld",indexPath.row);

            break;
        case 3:
            ZMLog(@"%ld",indexPath.row);

            break;
        case 4:
            ZMLog(@"%ld",indexPath.row);

            break;
        case 5:
            ZMLog(@"%ld",indexPath.row);

            break;
        case 6:
            ZMLog(@"%ld",indexPath.row);

            break;
        case 7:
            ZMLog(@"%ld",indexPath.row);

            break;
        case 8:
            ZMLog(@"%ld",indexPath.row);

            break;
        default:
            ZMLog(@"%ld",indexPath.row);
            break;
    }

}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"功能设置";
    }else{
        return @"其他设置";
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
- (void)logout{
    [[NSNotificationCenter defaultCenter] postNotificationName:LogoutNotification object:nil];
    [LoginViewController logout];
    [SVProgressHUD setMinimumDismissTimeInterval:ZMMinimumDismissTimeInterval];
    [SVProgressHUD showSuccessWithStatus:@"退出成功"];
    __block SettingViewController* bself = self;
    
    double delayInSeconds = 1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [bself popVC];
    });
  
}

-(void)popVC{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)hasLogin{
    [self setFooterView];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    ZMLogfunc;
}

@end
