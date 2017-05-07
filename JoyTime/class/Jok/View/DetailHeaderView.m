//
//  DetailHeaderView.m
//  JoyTime
//
//  Created by stone on 2017/1/24.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "DetailHeaderView.h"
#import "NTESSessionViewController.h"
#import "UIView+NTES.h"
#import "NTESBundleSetting.h"
#import "NTESListHeader.h"
#import "NTESClientsTableViewController.h"
#import "NTESSnapchatAttachment.h"
#import "NTESJanKenPonAttachment.h"
#import "NTESChartletAttachment.h"
#import "NTESWhiteboardAttachment.h"
#import "NTESSessionUtil.h"
#import "JokNetwork.h"
#import "LoginViewController.h"


@interface DetailHeaderView()
@property (weak, nonatomic) IBOutlet UIImageView *profileImg;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLb;
@property (weak, nonatomic) IBOutlet UIButton *addAttentionBtn;
@property (weak, nonatomic) IBOutlet UIButton *chatBtn;


@end


@implementation DetailHeaderView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.profileImg.layer.cornerRadius = 32.5;
    self.profileImg.layer.masksToBounds = YES;
}

-(void)setModel:(UserDetailModel *)model{
    _model = model;
    NSString* attentionBtnTitle = model.hasFollowed?@"已关注":@"加关注";
    UIControlState state = model.hasFollowed?UIControlStateSelected:UIControlStateNormal;
    self.addAttentionBtn.selected = model.hasFollowed;
    [self.addAttentionBtn setTitle:attentionBtnTitle forState:state];
    [self.profileImg sd_setImageWithURL:[NSURL URLWithString:model.profileImg] placeholderImage:[UIImage imageNamed:@"me_avatar_girl"]];
    self.nickNameLb.text = model.nickName;
}

- (IBAction)addAttentionClickAction:(UIButton *)sender {
    
    [SVProgressHUD setMinimumDismissTimeInterval:ZMMinimumDismissTimeInterval];
    if (![LoginViewController isLogin]) {
        [SVProgressHUD showInfoWithStatus:@"只有登陆之后才能关注哦!!"];
        return;
    }
    [self clickAddAttentionBtn:sender];
}

//点击关注按钮事件
-(void)clickAddAttentionBtn:(UIButton*)sender{
    
    sender.selected = !sender.selected;
    NSString* type = sender.selected?@"1":@"0";
    NSString* tipStr = sender.selected?@"关注成功":@"取关成功";
    //点击取消关注时发送通知
    NSString* notiName = sender.selected ? AddAttentionNotification :CancleAttentionNotification;
    [[NSNotificationCenter defaultCenter] postNotificationName:notiName object:nil];
    
    [JokNetwork  addOrCancelAttentionToUserWithUid:self.model.uid
                                              type:type
                                    completeHandle:^(id responseObj, NSError *error) {
                                        NSDictionary* errorInfo = responseObj;
                                        if (error||[errorInfo[@"err"] integerValue] != 0) {
                                            [SVProgressHUD showErrorWithStatus:@"关注失败"];
                                        }else{
                                            self.model.hasFollowed = sender.selected;
                                            [SVProgressHUD showSuccessWithStatus:tipStr];
                                        }
                                    }];
    
}
/**
 点击进入聊天
 */
- (IBAction)chatBtnClickAction:(id)sender {
    NIMSession* session = [NIMSession session:@"f927d121800769fadee187c791e4b48a" type:NIMSessionTypeP2P];
    NTESSessionViewController *vc = [[NTESSessionViewController alloc] initWithSession:session];
    id object = [self nextResponder];
    while (![object isKindOfClass:[UIViewController class]] && object != nil) {
        object = [object nextResponder];
    }
    UIViewController *superController = (UIViewController*)object;
    [superController.navigationController pushViewController:vc animated:YES];
}



@end
