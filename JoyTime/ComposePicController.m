//
//  ComposePicController.m
//  BaiSi
//
//  Created by stone on 2016/10/3.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "ComposePicController.h"
#import "ComposeViewController.h"
#import "TZImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "UINavigationBar+Awesome.h"
//#import "LoginViewController.h"
#import "PicCell.h"
#import "ComposeCollectionView.h"
@interface ComposePicController ()<TZImagePickerControllerDelegate,UICollectionViewDelegate, UIActionSheetDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (weak, nonatomic) IBOutlet ComposeCollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewBottomCons;

@end

@implementation ComposePicController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self addItemToNavi];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addPicAction:) name:@"AddPicActionNotification" object:nil];
   //增加键盘的弹起和落下的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardUP:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboarddown:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardUP:(NSNotification*)noti{
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
        self.textViewBottomCons.constant = 258;
    } completion:nil];
}
-(void)keyboarddown:(NSNotification*)noti{
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
        self.textViewBottomCons.constant = 0;
    } completion:nil];
}


-(void)addPicAction:(NSNotification*)noti{
    ZMLogfunc;
    [self pushImagePickerController];
}


- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
#pragma clang diagnostic pop
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}



-(void)addItemToNavi{

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(compose)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
}

-(void)compose{
      ZMLogfunc;
//    LoginViewController* vc = [[LoginViewController alloc]init];
//    [self presentViewController:vc animated:YES completion:nil];
}
-(void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TZImagePickerController

- (void)pushImagePickerController {

    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:6 columnNumber:4 delegate:self];

//    imagePickerVc.allowTakePicture = YES; // 在内部显示拍照按钮
  
    //    // 2. Set the appearance
    //    // 2. 在这里设置imagePickerVc的外观
    //    [imagePickerVc.navigationBar lt_setBackgroundColor:[UIColor redColor]];
    [imagePickerVc.navigationBar lt_reset];
    [imagePickerVc.navigationBar setBarTintColor:[UIColor redColor]];
    [imagePickerVc.navigationBar lt_setElementsAlpha:0.5];
    imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    imagePickerVc.oKButtonTitleColorNormal = [UIColor blueColor];

    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = YES;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = YES;

    //    // 4. 照片排列按修改时间升序
    //    imagePickerVc.sortAscendingByModificationDate = YES;
    //#pragma mark - 到这里为止

    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - TZImagePickDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    ZMLogfunc;

    self.collectionView.images = photos;

}
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos{
    ZMLogfunc;
    
}
- (void)imagePickerControllerDidCancel:(TZImagePickerController *)picker{
    ZMLogfunc;
}
// If user picking a video, this callback will be called.
// If system version > iOS8,asset is kind of PHAsset class, else is ALAsset class.
// 如果用户选择了一个视频，下面的handle会被执行
// 如果系统版本大于iOS8，asset是PHAsset类的对象，否则是ALAsset类的对象
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset{

}



#pragma mark - UIImagePickerController

- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
        // 无权限 做一个友好的提示
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
#define push @#clang diagnostic pop
    } else { // 调用相机
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            self.imagePickerVc.sourceType = sourceType;
            if(iOS8Later) {
                _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            }
            [self presentViewController:_imagePickerVc animated:YES completion:nil];
        } else {
            NSLog(@"模拟器中无法打开照相机,请在真机中使用");
        }
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self resignFirstResponder];
}

-(void)dealloc{
    ZMLogfunc;
}

@end
