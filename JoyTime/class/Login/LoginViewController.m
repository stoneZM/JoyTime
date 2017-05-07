//
//  LoginViewController.m
//  JokTime
//
//  Created by stone on 16/1/8.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "LoginViewController.h"
#import "ZMCustomtextField.h"
#import "LoginNetwork.h"
#import "LoginModel.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet ZMCustomtextField *account;
@property (weak, nonatomic) IBOutlet ZMCustomtextField *pwd;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginModulLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *registerModulLeadConstraint;
@property (weak, nonatomic) IBOutlet UIView *registerModule;
@property (weak, nonatomic) IBOutlet UIView *loginModule;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.registerModulLeadConstraint.constant = ZMSCREENW;
//    self.registerModule.hidden = YES;
}

-(void)dealloc{

}
- (IBAction)dismissBtn:(id)sender {
    [self resignFirstRespond];
    [self dismissViewControllerAnimated:YES completion:nil];
 
}
- (IBAction)registerBtn:(UIButton*)sender {
 
    [self resignFirstRespond];
    sender.selected = !sender.selected;
    self.loginModulLeftConstraint.constant =  sender.selected? -ZMSCREENW : 0;
    self.registerModulLeadConstraint.constant = sender.selected? 0 : ZMSCREENW;
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:3 options:UIViewAnimationOptionTransitionNone animations:^{
        [self.view layoutSubviews];
    } completion:^(BOOL finished) {
       
    }];
}
- (IBAction)loginBtn:(id)sender {
    ZMLogfunc;
    [LoginNetwork requestLoginWithAccount:self.account.text
                                 passWord:self.pwd.text
                           completeHandle:^(LoginModel* responseObj, NSError *error) {
                               if (error) {
                                   //TODO:提示功能
                                   ZMLog(@"登录出现错误，请检查网络状况!");
                                   return ;
                               }
                               if ([responseObj.err isEqualToString:@"1"]) {
                                   ZMLog(@"%@",responseObj.msg);
                                   return;
                               }
                               NSDictionary* headerInfo = [self storeUserInfo:responseObj];
                               //设置header头
                               [LoginNetwork setHTTPHeaderValuesForKeys:headerInfo];
#warning 给个登录成功的提示
                               //发个通知
                               [[NSNotificationCenter defaultCenter]postNotificationName:LoginSuccedNotifucation object:nil];
                               [self dismissViewControllerAnimated:YES completion:^{
                                   
                               }];
                           }];
    
}
- (IBAction)forgetPwdBtn:(id)sender {
    ZMLogfunc;
}
- (IBAction)QQLoginBtn:(id)sender {
    ZMLogfunc;
}
- (IBAction)weiboLoginBtn:(id)sender {
    ZMLogfunc;
}
- (IBAction)telentLoginBtn:(id)sender {
    ZMLogfunc;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self resignFirstRespond];
}

-(void)resignFirstRespond{
    [self.account resignFirstResponder];
    [self.pwd resignFirstResponder];
}

+(BOOL)isLogin{
    if ([StoreTool getValuesForKey:USERAPPTOKEN]&&[StoreTool getValuesForKey:USERID]) {
        return YES;
    }
    return false;
}


-(NSDictionary*)storeUserInfo:(LoginModel*)model{
    JokUserModel* user = model.userInfo;
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
    [dic setObject:user.nickName forKey:USERNICKNAME];
    [dic setObject:user.yxToken forKey:USERYXTOKEN];
    [dic setObject:user.sex forKey:USERSEX];
    [dic setObject:user.accid forKey:USERACCID];
    [dic setObject:user.appToken forKey:USERAPPTOKEN];
    [dic setObject:user.account forKey:USERACCOUNT];
    [dic setObject:user.uid forKey:USERID];
    [dic setObject:user.profileImg forKey:USERPROFILEIMG];
    [StoreTool setValueForKeys:dic];
    NSDictionary* headerInfo = @{@"appToken":dic[USERAPPTOKEN],@"uid":dic[USERID]};
    return headerInfo;
}

+(void)logout{
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"" forKey:USERNICKNAME];
    [dic setObject:@"" forKey:USERYXTOKEN];
    [dic setObject:@"" forKey:USERSEX];
    [dic setObject:@"" forKey:USERACCID];
    [dic setObject:@"" forKey:USERAPPTOKEN];
    [dic setObject:@"" forKey:USERACCOUNT];
    [dic setObject:@"" forKey:USERID];
    [dic setObject:@"" forKey:USERPROFILEIMG];
    [StoreTool deleteValuesWithDic:dic];
}

@end
