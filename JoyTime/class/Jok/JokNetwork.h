//
//  JokNetwork.h
//  JoyTime
//
//  Created by stone on 2017/1/11.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "BaseNetManager.h"

//定义请求的类型
typedef NS_ENUM(NSInteger,RequestType) {

    jok_text = 1,        //文本类型
    jok_img = 2,         // 图片类型
    jok_video = 3,       // 视屏类型
    jok_audio = 4        //音频类型
    
};

@interface JokNetwork : BaseNetManager



/**
 获取段子的主体内容

 @param type 请求的类型
 @param page 当前页数
 @param count 每页请求的数据条数
 @param completeHandle   回调解析完成的对象模型
 @return  NSURLSessionDataTask
 
 */
+(id)getJokDataWithRequestType:(RequestType)type
                          page:(NSString*)page
                     pageCount:(NSString*)count
                completeHandle:(void(^)(id responseObj,NSError *error))completeHandle;


/**
 点赞或踩或分享时发送请求操作数据库

 @param jokId 段子的id
 @param type  0-代表点踩  1-代表点赞  2-代表分享
 @param flag 0表示减操作 1表示加操作
 @param completeHandle 返回该段子的点击数
 */
+(void)requestExecuteZanOrCaiWithJokId:(NSString*)jokId
                                  type:(NSString*)type
                                  flag:(NSString*)flag
                        completeHandle:(void(^)(NSError *error))completeHandle;



/**
 获取段子的评论

 @param jokId 段子的id
 @param page 当前页数
 @param count 总页数
 @param completeHandle JokCommentModel的回调
 */
+ (id)getCommentForJokWithJokId:(NSString*)jokId
                             page:(NSInteger)page
                        pageCount:(NSString*)count
                   completeHandle:(void(^)(id responseObj,NSError* error))completeHandle;


/**
 发表评论

 @param jokid 段子的id
 @param content 评论的内容
 @param completeHandle 回调评论的相关信息
 */
+ (id)addCommentForJokWithJokId:(NSString*)jokid
                        comment:(NSString*)content
                 completeHandle:(void(^)(id responseObj,NSError* error))completeHandle;



/**
 加关注或者取消关注

 @param uid 要关注的人的id
 @param type 0-取消关注 1-加关注
 @param completeHandle 回调是否增加或取消关注成功
 
 */
+(void)addOrCancelAttentionToUserWithUid:(NSString*)uid
                                  type:(NSString*)type
                        completeHandle:(void(^)(id responseObj,NSError* error))completeHandle;


/**
 获取关注人的一些段子内容

 @param page  待用
 @param pageCount 待用
 @param completeHandle 用户信息
 */
+(void)getAttentionContentWithPage:(NSString*)page
                         pageCount:(NSString*)pageCount
                    completeHandle:(void(^)(id responseObj,NSError* error))completeHandle;


/**
 点击头像进入用户详情页

 @param uid 改用户的id
 @param completeHandle 用户的详情列表
 */
+(id)getUserDetailWithId:(NSString*)uid
          completeHandle:(void(^)(id responseObj,NSError* error))completeHandle;


@end
