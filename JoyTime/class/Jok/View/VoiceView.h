//
//  VoiceView.h
//  BaiSi
//
//  Created by stone on 16/9/13.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JokModel.h"
#import "UserDetailModel.h"

@interface VoiceView : UIView
@property (weak, nonatomic) IBOutlet UIButton *playBtn;


@property (nonatomic,strong)JokDataModel* model;
@property (nonatomic,strong) UserJokModel* jok;

+(instancetype)standVoiceView;

@end
