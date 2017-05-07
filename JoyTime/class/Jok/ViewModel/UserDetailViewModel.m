//
//  UserDetailViewModel.m
//  JoyTime
//
//  Created by stone on 2017/1/24.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "UserDetailViewModel.h"
#import "JokNetwork.h"


@implementation UserDetailViewModel

{
    UserDetailModel* _userInfo;
}

-(instancetype)initWithUid:(NSString *)uid{
    if (self = [super init]) {
        self.uid = uid;
    }
    return self;
}

-(void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle{
    
    [JokNetwork getUserDetailWithId:self.uid
                     completeHandle:^(id responseObj, NSError *error) {
                         UserDetailModel* model = responseObj;
                         _userInfo = model;
                         [self.dataArr addObjectsFromArray:model.jok];
                         completionHandle(error);
    }];
}

-(UserDetailModel*)getUserInfo{
    return _userInfo;
}

-(UserJokModel *)userJokForRow:(NSInteger)row{
    UserJokModel* model = self.dataArr[row];
    return model;
}

@end
