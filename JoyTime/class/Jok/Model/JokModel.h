//
//  JokTextModel.h
//  JoyTime
//
//  Created by stone on 2017/1/11.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "BaseModel.h"
#import "JokUserModel.h"

@class JokDataModel;

@interface JokModel : BaseModel

@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString  *page;
@property (nonatomic, strong) NSString *total;
@property (nonatomic, assign) double err;
@property (nonatomic, strong) NSArray  *data;
@end


@interface JokDataModel : BaseModel

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *jid;
@property (nonatomic, strong) NSString *downloadUrl;
@property (nonatomic, strong) NSString *thumbUrl;
@property (nonatomic, strong) NSString *width;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *height;
@property (nonatomic, strong) NSString *duration;
@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic, strong) NSString *playcount;
@property (nonatomic, strong) NSString *videoUrl;
@property (nonatomic, strong) NSString *thumbnailSmall;
@property (nonatomic, strong) NSString *audioUrl;
@property (nonatomic, strong) JokUserModel *u;
@property (nonatomic, strong) NSString *zanCount;
@property (nonatomic, strong) NSString *shareCount;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *caiCount;
@property (nonatomic, strong) NSString *tags;
@property (nonatomic, strong) NSString *shareUrl;

@property (nonatomic, assign) NSInteger zanFlag;
@property (nonatomic, assign) NSInteger caiFlag;
@property (nonatomic,assign ) CGFloat   cellHeight;

@end



