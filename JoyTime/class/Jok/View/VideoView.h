//
//  VideoView.h
//  BaiSi
//
//  Created by stone on 16/9/13.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JokModel.h"
#import "UserDetailModel.h"

@interface VideoView : UIView

@property (nonatomic,assign)NSUInteger flag;
@property (nonatomic,strong)JokDataModel* model;
@property (nonatomic,strong)UserJokModel* jok;

+(instancetype)standVideoView;


@end
