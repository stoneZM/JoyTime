//
//  AddFriCell.m
//  JoyTime
//
//  Created by stone on 2017/1/20.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "AddFriCell.h"
#import "NTESPersonalCardViewController.h"
@interface AddFriCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImg;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLb;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addBtn;



@end

@implementation AddFriCell
{
    UIColor* _nickNameLbColor;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)addBtnClickAction:(UIButton *)sender {
    ZMLog(@"%@",self.model.accid);
    [self addFriend:self.model.accid];
}

- (void)addFriend:(NSString *)userId{
  
    __weak typeof(self) wself = self;
    
//    id object = [self nextResponder];
//    while (![object isKindOfClass:[UIViewController class]] && object != nil) {
//        object = [object nextResponder];
//    }
//    UIViewController *superController = (UIViewController*)object;
   
    [SVProgressHUD show];
    [[NIMSDK sharedSDK].userManager fetchUserInfos:@[userId] completion:^(NSArray *users, NSError *error) {
        [SVProgressHUD dismiss];
        if (users.count) {
//            NTESPersonalCardViewController *vc = [[NTESPersonalCardViewController alloc] initWithUserId:userId];
//            
//        [superController.navigationController pushViewController:vc animated:YES];
            [self addFriend];
        }else{
            if (wself) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"该用户不存在" message:@"请检查你输入的帐号是否正确" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }];
}

- (void)addFriend{
    NIMUserRequest *request = [[NIMUserRequest alloc] init];
    request.userId = self.model.accid;
    request.operation = NIMUserOperationAdd;
    NSString *successText = request.operation == NIMUserOperationAdd ? @"添加成功" : @"请求成功";
    NSString *failedText =  request.operation == NIMUserOperationAdd ? @"添加失败" : @"请求失败";
    
    [SVProgressHUD show];
    [[NIMSDK sharedSDK].userManager requestFriend:request completion:^(NSError *error) {
        [SVProgressHUD dismiss];
        if (!error) {
            [SVProgressHUD showSuccessWithStatus:successText];
        }else{
            [SVProgressHUD showErrorWithStatus:failedText];
            
        }
    }];
}

-(void)setModel:(YunXinFriendUserModel *)model{
    
    _model = model;
    NSString* prifileImgUrl = [NSString stringWithFormat:@"%@%@",BASEURL,model.u.profileImg];
    [self.profileImg sd_setImageWithURL:[NSURL URLWithString:prifileImgUrl] placeholderImage:[UIImage imageNamed:@""]];
    
    _nickNameLbColor = [model.u.sex isEqualToString:@"M"] ? [UIColor blueColor]:[UIColor redColor];
    _nickNameLb.textColor = _nickNameLbColor;
    self.nickNameLb.text = model.u.nickName;
    
}



@end
