//
//  ComposeViewController.m
//  BaiSi
//
//  Created by stone on 16/9/7.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "ComposeViewController.h"
#import "ButtonModel.h"
#import "CustomButton.h"
#import "ComposePicController.h"
#import "TZImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "UINavigationBar+Awesome.h"
#define  CancelBtnHeight 40
#define  MargintoTop     300
#import "LoginViewController.h"


static NSInteger animationIndex = 3;

@interface ComposeViewController ()<TZImagePickerControllerDelegate,UICollectionViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong)NSArray* items;
@property (nonatomic,strong)NSMutableArray* buttons;
@property (nonatomic,strong)NSTimer* timer;
@property (nonatomic,assign)BOOL isAppear;
@property (nonatomic,strong)UIImageView* sloganIV;

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;

@end

@implementation ComposeViewController

//#pragma mark - 系统回调函数
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
    [self setupUI];
    [self addCancelBtn];
    self.isAppear = YES;
    [self addTimer];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)addCancelBtn{
    UIButton* cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.view addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.height.mas_equalTo(CancelBtnHeight);
    }];
    cancelBtn.backgroundColor = [UIColor whiteColor];
}
#pragma mark - 取消按钮的点击监听
-(void)dismiss{
    [self addTimer];
//    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 自定义方法
-(NSMutableArray *)buttons{
    if (_buttons == nil) {
        _buttons = [[NSMutableArray alloc]init];
    }
    return _buttons;
}

-(NSArray *)items{
    if (_items == nil) {
        _items = [ButtonModel getItems];
    }
    return _items;
}

-(void)addTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(startAnimation) userInfo:nil repeats:YES];
}


-(void)startAnimation{

    if (animationIndex < 0 ){
        [self.timer invalidate];
        animationIndex = self.items.count-1;
        self.isAppear = !self.isAppear;
        if (self.isAppear == YES) {
            [self dismissViewControllerAnimated:NO completion:nil];
        }
    }else{
        [self oneButtonAnimation:self.buttons[animationIndex]];
        animationIndex--;
    }
}



-(void)oneButtonAnimation:(UIButton*)button{

    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:3 options:UIViewAnimationOptionTransitionNone animations:^{
        if (self.isAppear) {
            button.hidden = NO;
            button.transform = CGAffineTransformIdentity;
            self.sloganIV.transform = CGAffineTransformIdentity;
        }else{
            button.transform = CGAffineTransformMakeTranslation(0, ZMSCREENH);
        }

    } completion:^(BOOL finished) {

    }];
}

-(void)removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}


-(void)setupUI{
    
    CGFloat margin = 20;
    CGFloat width = (ZMSCREENW - 4*margin)/3;

    self.sloganIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self.view addSubview:self.sloganIV];
    [self.sloganIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.top.mas_equalTo(100);
    }];
    self.sloganIV.transform = CGAffineTransformMakeTranslation(0, -ZMSCREENH);
    for (int i=0; i<self.items.count; i++) {
        CustomButton* button = [[CustomButton alloc]init];
        CGFloat col = i % 3;
        CGFloat row = i / 3;
        CGFloat x = margin*(col+1) + width*col;
        CGFloat y = MargintoTop + width*row + margin*row;;
        button.frame = CGRectMake(x, y, width, width);
        button.model = self.items[i];
        button.transform = CGAffineTransformMakeTranslation(0, -ZMSCREENH);
        button.hidden = YES;
        [button addTarget:self action:@selector(clickComposeItem:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i+100;
        [self.buttons addObject:button];
        [self.view addSubview:button];
    }
}

#pragma mark - 按钮的事件监听
-(void)clickComposeItem:(UIButton*)button{
   //TODO: 6个按钮的点击事件
    NSInteger tag = button.tag;
    if (![LoginViewController isLogin]) {
        LoginViewController* logvc = [[LoginViewController alloc]init];
        [self presentViewController:logvc animated:YES completion:nil];
    }else if (tag == 101) {
        ComposePicController* vc = [[ComposePicController alloc]init];
        UINavigationController* navi = [[UINavigationController alloc]initWithRootViewController:vc];
        [self presentViewController:navi                                                                                                                                                                   animated:YES completion:nil];
    }else{
        ComposePicController* vc = [[ComposePicController alloc]init];
        UINavigationController* navi = [[UINavigationController alloc]initWithRootViewController:vc];
        [self presentViewController:navi                                                                                                                                                                   animated:YES completion:nil];
    }
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self addTimer];
//    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void)dealloc{
    ZMLogfunc;
}

@end
