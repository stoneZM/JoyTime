//
//  JokCell.m
//  JoyTime
//
//  Created by stone on 2017/1/12.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "DetailCell.h"
#import "VoiceView.h"
#import "VideoView.h"
#import "VideoTool.h"
#import "StoreTool.h"
#import "JokNetwork.h"
#import "JokCommentController.h"
#import "PicView.h"
#import "LoginViewController.h"
#import "DetailTableViewController.h"

@interface DetailCell()


@property (weak, nonatomic) IBOutlet UILabel *createTime;
@property (weak, nonatomic) IBOutlet UILabel *contentLb;
@property (weak, nonatomic) IBOutlet UIView *frameView;
@property (weak, nonatomic) IBOutlet UIButton *zanBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentConsH;



@property (strong,nonatomic)  UIImageView* imgView;
@property (strong,nonatomic)  VideoView* videoView;
@property (strong,nonatomic)  VoiceView* voiceView;
@property (nonatomic,strong)  PicView* picView;

@property (nonatomic,strong)  UITapGestureRecognizer* tap;
@end

@implementation DetailCell
{
    NSString* _clickCount;
    NSInteger _clickFlag;
    
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
   
}

-(UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc]init];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        [self.frameView addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _imgView;
}

-(PicView *)picView{
    if (_picView == nil) {
        _picView = [PicView standPicView];
        [self.frameView addSubview:_picView];
        [_picView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
    }
    return _picView;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}



-(void)setJok:(UserJokModel *)jok{
    
    _jok = jok;
    self.createTime.text = jok.createTime;
    self.contentLb.text = jok.content;
    
    //设置按钮的状态
    [self.zanBtn setTitle:jok.zanCount forState:UIControlStateNormal];
    [self.caiBtn setTitle:jok.caiCount forState:UIControlStateNormal];
    [self.shareBtn setTitle:jok.shareCount forState:UIControlStateNormal];
    
    
    NSString* zanKey = [NSString stringWithFormat:@"%@-%@",ZANKEY,jok.jid];
    NSString* caiKey = [NSString stringWithFormat:@"%@-%@",CAIKEY,jok.jid];
    self.zanBtn.selected = [[StoreTool getValuesForKey:zanKey] integerValue];
    self.caiBtn.selected = [[StoreTool getValuesForKey:caiKey] integerValue];
    
    
    if ([jok.type isEqualToString:@"gif"]) {
        
        [self setCellHeight];
        self.picView.jok = jok;
        
    }else if ([jok.type isEqualToString:@"image"]) {
       
        [self setCellHeight];
        self.picView.jok = jok;
      
   
    }else if([jok.type isEqualToString:@"video"]){
        
        self.contentConsH.constant = 250;
        VideoView* videoView = [VideoView standVideoView];
        self.videoView = videoView;
        [self.frameView addSubview:videoView];
        videoView.frame = self.frameView.bounds;
        videoView.jok = jok;
    
    }else if([jok.type isEqualToString:@"audio"]){
        
        [self setCellHeight];
        VoiceView* voiceView = [VoiceView standVoiceView];
        self.voiceView = voiceView;
        [self.frameView addSubview:voiceView];
        voiceView.frame = self.frameView.bounds;
        voiceView.jok = jok;
        
    }else{
        //防止单元格复用，移除单元格中所有子视图
        [self.frameView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        self.contentConsH.constant = 0.00001;
    }
    
}


-(void)setCellHeight{
   
    if ( self.jok.cellHeight) {
        
    }else{
       
        CGFloat scale = [self.jok.width floatValue]/ZMSCREENW;
        CGFloat height = [self.jok.height floatValue]/scale;
        self.jok.cellHeight = height;
    }
    if ([self.jok.height floatValue]> 2000) {
       
        self.contentConsH.constant = 250;
    
    }else{
     
        self.contentConsH.constant = self.jok.cellHeight;
    }
   
}


-(void)prepareForReuse{
    //暂停视频的播放
    if ([self.jok.type isEqualToString:@"video"]) {
        self.videoView.flag = 1;
    }
    
}

/**
 评论按钮的点击事件

 */
- (IBAction)clickCommentBtnAction:(UIButton *)sender {
    id object = [self nextResponder];
    while (![object isKindOfClass:[UIViewController class]] && object != nil) {
        object = [object nextResponder];
    }
    UIViewController *superController = (UIViewController*)object;
    JokCommentController* commentVC = [[JokCommentController alloc]initWithJokId:self.jok.jid];
    [superController.navigationController pushViewController:commentVC animated:YES];
}


/**
 分享按钮的点击事件
 */
- (IBAction)clickShareBtnAction:(UIButton *)sender {
    UMShareTool* shareTool = [[UMShareTool alloc]init];
    NSString* content = [self.jok.content substringToIndex:20];
    [shareTool shareWithContent:content
                          title:@"JoyTime"
                      imageName:@""
                            url:self.jok.shareUrl];
}



#pragma mark - 点赞系列操作

- (IBAction)clickZanBtnAction:(UIButton *)sender {
    ZMLog(@"jokId-%@",self.jok.jid);
    [self clickedBtnisZan:YES clickedBtn:sender];
    
}
- (IBAction)clickCaiBtnAction:(UIButton *)sender {
    [self clickedBtnisZan:NO clickedBtn:sender];
    
}


-(void)clickedBtnisZan:(BOOL)zan clickedBtn:(UIButton*)sender{
    
   
    NSString* count = zan?self.jok.zanCount:self.jok.caiCount;
    
    sender.selected = !sender.selected;
    
    UIControlState state = sender.selected ? UIControlStateSelected : UIControlStateNormal;
    if (sender.selected) {
        _clickCount = [NSString stringWithFormat:@"%ld",[count integerValue]+1];
        _clickFlag = 1;
    }else{
        _clickCount = [NSString stringWithFormat:@"%ld",[count integerValue]-1];
        _clickFlag = 0;
    }

    [sender setTitle:_clickCount forState:state];
    
    if (zan) {
        [self setZanFlag:_clickFlag];
    }else{
       [self setCaiFlag:_clickFlag];
    }
    
}
//当设置此值时，进行存储操作并发送网络请求
-(void)setZanFlag:(NSInteger)zanFlag{
    
    ZMLogfunc;
    NSString* zanKey = [NSString stringWithFormat:@"%@-%@",ZANKEY,self.jok.jid];
    NSString* value = [NSString stringWithFormat:@"%ld",(long)zanFlag];
    NSString* flag = zanFlag==0 ? @"0" : @"1";
    if (zanFlag) {
        self.jok.zanCount = [NSString stringWithFormat:@"%ld",[self.jok.zanCount integerValue]+1];
    }else{
        
        self.jok.zanCount = [NSString stringWithFormat:@"%ld",[self.jok.zanCount integerValue]-1];
    }
    [JokNetwork requestExecuteZanOrCaiWithJokId:self.jok.jid type:@"1" flag:flag completeHandle:^(NSError *error) {
        if (!error) {
            [StoreTool ZMsetValue:value forkey:zanKey];
        }
    }];
}

-(void)setCaiFlag:(NSInteger)caiFlag{
    ZMLogfunc;
    if (caiFlag) {
        self.jok.caiCount = [NSString stringWithFormat:@"%ld",[self.jok.caiCount  integerValue]+1];
    }else{
        self.jok.caiCount  = [NSString stringWithFormat:@"%ld",[self.jok.caiCount  integerValue]-1];
    }
    NSString* caiKey = [NSString stringWithFormat:@"%@-%@",CAIKEY,self.jok.jid];
    NSString* value = [NSString stringWithFormat:@"%ld",(long)caiFlag];
    NSString* flag = caiFlag==0 ? @"0" : @"1";
    [JokNetwork requestExecuteZanOrCaiWithJokId:self.jok.jid type:@"0" flag:flag completeHandle:^(NSError *error) {
        if (!error) {
            [StoreTool ZMsetValue:value forkey:caiKey];
        }
    }];
}




@end
