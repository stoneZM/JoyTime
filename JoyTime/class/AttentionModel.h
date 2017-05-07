//
//  AttentionModel.h
//  JoyTime
//
//  Created by stone on 2017/1/17.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "BaseModel.h"

@interface AttentionModel : BaseModel

@property (nonatomic, assign) double err;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSArray *data;

@end

@interface AttentionUserModel: BaseModel

@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSArray *jok;
@property (nonatomic, strong) NSString *dataIdentifier;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *profileImg;

@end

@interface  AttentionUserJokModel: BaseModel

@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic, strong) NSString *playcount;
@property (nonatomic, strong) NSString *audioUrl;
@property (nonatomic, strong) NSString *tags;
@property (nonatomic, strong) NSString *zanCount;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *duration;
@property (nonatomic, strong) NSString *thumbUrl;
@property (nonatomic, strong) NSString *shareUrl;
@property (nonatomic, strong) NSString *downloadUrl;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *jokIdentifier;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *shareCount;
@property (nonatomic, strong) NSString *height;
@property (nonatomic, strong) NSString *width;
@property (nonatomic, strong) NSString *thumbnailSmall;
@property (nonatomic, strong) NSString *caiCount;
@property (nonatomic, strong) NSString *content;

@end
