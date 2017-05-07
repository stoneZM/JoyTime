//
//  ComposeTextController.m
//  JoyTime
//
//  Created by stone on 2017/2/9.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "ComposeTextController.h"

@interface ComposeTextController ()

@property (weak, nonatomic) IBOutlet UITextView *textFiled;
@property (weak, nonatomic) IBOutlet UILabel *placeHolderLb;

@end

@implementation ComposeTextController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self addItemToNavi];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hasComposeText) name:@"HasComposeTextNotification" object:nil];
    //增加键盘的弹起和落下的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardUP:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboarddown:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)addItemToNavi{
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(compose)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
}

-(void)compose{
    
}

-(void)hasComposeText{
    ZMLogfunc;
}

-(void)keyboardUP:(NSNotification*)noti{
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
       
    } completion:nil];
}
-(void)keyboarddown:(NSNotification*)noti{
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
       
    } completion:nil];
}







@end
