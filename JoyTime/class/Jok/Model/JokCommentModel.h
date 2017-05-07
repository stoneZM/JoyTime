//
//  JokCommentModel.h
//  JoyTime
//
//  Created by stone on 2017/1/14.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "BaseModel.h"
#import "JokUserModel.h"

@interface JokCommentModel : BaseModel

@property (nonatomic, assign) double err;
@property (nonatomic, strong) NSString* msg;
@property (nonatomic, strong) NSArray *data;

@end


@interface JokCommentDataModel : BaseModel

@property (nonatomic, strong) NSString *jokId;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *likeCount;
@property (nonatomic, strong) NSString *isHot;
@property (nonatomic, strong) JokUserModel *u;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *hateCount;

@end
