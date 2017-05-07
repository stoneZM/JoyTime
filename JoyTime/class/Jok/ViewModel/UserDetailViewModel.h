//
//  UserDetailViewModel.h
//  JoyTime
//
//  Created by stone on 2017/1/24.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "BaseViewModel.h"
#import "UserDetailModel.h"

@interface UserDetailViewModel : BaseViewModel

@property (nonatomic,strong)NSString *uid;


-(instancetype)initWithUid:(NSString*)uid;

-(UserDetailModel*)getUserInfo;

-(UserJokModel*)userJokForRow:(NSInteger)row;


@end
