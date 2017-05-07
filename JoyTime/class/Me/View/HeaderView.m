//
//  HeaderView.m
//  BanTang
//
//  Created by stone on 2016/10/22.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "HeaderView.h"
#import "LoginViewController.h"
#import "FollowUserInfoController.h"

@interface HeaderView()
@property (weak, nonatomic) IBOutlet UIButton *LoginBtn;
@property (weak, nonatomic) IBOutlet UIImageView *coverIV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *coverIvCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgTopCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgBottomCons;
@end

static CGFloat coverIvCons = 100;

@implementation HeaderView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.coverIV.layer.cornerRadius = 32.5;
    self.coverIV.layer.masksToBounds = YES;
    if ([StoreTool getValuesForKey:USERAPPTOKEN]) {
        self.hasLogin = YES;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hasLogout) name:LogoutNotification object:nil];
}


-(void)setTableViewOffset:(CGFloat)tableViewOffset{
   
    //偏移量小鱼0的时候，背景图只上下拉伸
    if (tableViewOffset<0) {
        self.LoginBtn.alpha = 1;
        self.bgBottomCons.constant = 60;
        self.bgTopCons.constant = tableViewOffset;
        self.coverIvCons.constant = 100;
        self.coverIV.transform = CGAffineTransformIdentity;
        return ;
    }
    //变换大小
    CGFloat rota = (1 - tableViewOffset/self.height);
    if (rota > 0.55) {
        self.LoginBtn.alpha = 1-(1.0/0.4 * (1-rota));
        self.coverIV.transform = CGAffineTransformMakeScale(rota,rota);
    }
    if (rota < 0.55) {
        self.LoginBtn.alpha = 0;
        self.coverIV.transform = CGAffineTransformMakeScale(0.55,0.55);
    }
    //头像的偏移
    CGFloat constant = coverIvCons - tableViewOffset;
    if (constant > -10) {
        self.coverIvCons.constant = constant;
    }
    if (tableViewOffset > self.height-60-64) {
        self.coverIvCons.constant = constant + 54;
        self.bgBottomCons.constant = constant + 64;
    }
}
- (IBAction)clickLoginBtnAction:(UIButton *)sender {

   LoginViewController* loginVc = [[LoginViewController alloc]init];
    id object = [self nextResponder];
    while (![object isKindOfClass:[UIViewController class]] && object != nil) {
        object = [object nextResponder];
    }
    UIViewController *superController = (UIViewController*)object;
    [superController presentViewController:loginVc animated:YES completion:^{
        
    }];
}



-(void)hasLogout{
    self.LoginBtn.enabled = YES;
    self.coverIV.image = [UIImage imageNamed:@"me_avatar_boy"];
    [self.LoginBtn setTitle:@"请登录" forState:UIControlStateNormal];
}

//被赞数


//被踩数


//关注的人
- (IBAction)meFollowBtnClickAction:(UIButton *)sender {
    FollowUserInfoController* vc = [[FollowUserInfoController alloc]init];
    id object = [self nextResponder];
    while (![object isKindOfClass:[UIViewController class]] && object != nil) {
        object = [object nextResponder];
    }
    UIViewController *superController = (UIViewController*)object;
    [superController.navigationController pushViewController:vc animated:YES];

}


//登录后刷新界面
-(void)setHasLogin:(BOOL)hasLogin{
    
    [[[NIMSDK sharedSDK] loginManager] autoLogin:[StoreTool getValuesForKey:USERACCID] token:[StoreTool getValuesForKey:USERYXTOKEN]];
     [self.LoginBtn setTitle:[StoreTool getValuesForKey:USERNICKNAME] forState:UIControlStateNormal];
    NSString* profileImg = [NSString stringWithFormat:@"%@%@",BASEURL,[StoreTool getValuesForKey:USERPROFILEIMG]];
    [self.coverIV sd_setImageWithURL:[NSURL URLWithString:profileImg] placeholderImage:[UIImage imageNamed:@"me_avatar_boy"]];
    self.LoginBtn.enabled = NO;
}

@end
