//
//  ShowPhotoViewController.m
//  BaiSi
//
//  Created by stone on 16/9/11.
//  Copyright © 2016年 zm. All rights reserved.
//  

#import "ShowPhotoViewController.h"
#import "DALabeledCircularProgressView.h"
@interface ShowPhotoViewController ()
@property (strong, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) DALabeledCircularProgressView *progressView;
@end

@implementation ShowPhotoViewController

{
    NSString* _imageName;

}

-(DALabeledCircularProgressView *)progressView{
    if (_progressView == nil) {
        _progressView = [[DALabeledCircularProgressView alloc]init];
        [self.view insertSubview:_progressView aboveSubview:self.scrollView];
        [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {

        }];
    }
    return _progressView;
}

-(UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]initWithFrame:self.view.frame];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.scrollView addSubview:_imageView];
       
    }
    return _imageView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:tap];
    [SVProgressHUD setMinimumDismissTimeInterval:1];

}

-(void)setModel:(JokDataModel *)model{
   
    _model = model;
    CGFloat width = [model.width floatValue];
    CGFloat rate = ZMSCREENW / width ;
    CGFloat height = rate * [model.height floatValue];
    
    if (height > ZMSCREENH) {
        self.imageView.frame = CGRectMake(0, 0, ZMSCREENW, height);
        self.scrollView.contentSize = CGSizeMake(0,  height);
         }else{
        self.imageView.size = CGSizeMake(ZMSCREENW, height);
        self.imageView.centerY = ZMSCREENH*0.5;
      }
    [self setImageName:model];
     [self.imageView sd_setImageWithURL:[NSURL URLWithString:_imageName] placeholderImage:[UIImage imageNamed:@"post_placeholderImage"] options:SDWebImageHighPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
         self.progressView.hidden = NO;
         CGFloat progress = receivedSize * 1.0 / expectedSize;
         [self.progressView setProgress:progress animated:YES];
         self.progressView.progressLabel.textColor = [UIColor whiteColor];
         NSString* text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
         text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
         self.progressView.progressLabel.text = text;

     } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
         self.progressView.hidden = YES;
     }];

}

-(void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)dismissBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)svaePhotoBtn:(id)sender {

    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image: didFinishSavingWithError:contextInfo:), nil);

}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{

    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }

}

- (IBAction)repostBtn:(id)sender {

    UMShareTool* shareTool = [[UMShareTool alloc]init];
     NSString* content = @"";
    if (self.model.content.length<20) {
        content = self.model.content;
    }else{
     content = [self.model.content substringToIndex:20];
    }
    [shareTool shareWithContent:content
                          title:@"JoyTime"
                      imageName:@"icon.png"
                            url:self.model.shareUrl];

}

-(void)setImageName:(JokDataModel*)model{
    if (model.imgUrl) {
        _imageName = model.imgUrl;
    }else if(model.thumbnail){
        _imageName = model.thumbnail;
    }
}


@end
