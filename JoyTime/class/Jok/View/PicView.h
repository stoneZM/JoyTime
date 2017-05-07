//
//  PicView.h
//  BaiSi
//
//  Created by stone on 16/9/10.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JokModel.h"
#import "UserDetailModel.h"

@interface PicView : UIView

@property (nonatomic,strong) JokDataModel* model;
@property (nonatomic,strong) UserJokModel* jok;

+(instancetype)standPicView;

@end
