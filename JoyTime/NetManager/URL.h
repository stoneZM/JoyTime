//
//  URL.h
//  JoyTime
//
//  Created by stone on 2017/1/11.
//  Copyright © 2017年 stone. All rights reserved.
//

#ifndef URL_h
#define URL_h


#ifdef DEBUG

#define BASEURL         @"http://stone.travelgo365.cn/JoyTime/"
//jok主体内容的url
#define JokBaseUrl          [NSString stringWithFormat:@"%@%@",BASEURL,@"api/baisi.php"]
//点击zan或cai等url
#define JokClickUrl         [NSString stringWithFormat:@"%@%@",BASEURL,@"api/click.php"]
//登录接口
#define JokLoginUrl         [NSString stringWithFormat:@"%@%@",BASEURL,@"api/login.php"]
//评论接口
#define JokCommentUrl       [NSString stringWithFormat:@"%@%@",BASEURL,@"api/comment.php"]
//关注接口
#define JokAddAttentionUrl  [NSString stringWithFormat:@"%@%@",BASEURL,@"api/follow.php"]
//获取关注用户详情的接口
#define JokAttentionUrl     [NSString stringWithFormat:@"%@%@",BASEURL,@"api/myFocus.php"]
//获取推荐好友的接口
#define AddFriendUrl        [NSString stringWithFormat:@"%@%@",BASEURL,@"api/addfriend.php"]
//获取关注人的信息接口
#define FollowerUserInfoUrl [NSString stringWithFormat:@"%@%@",BASEURL,@"api/follow.php"]
//获取用户详情页
#define JokUserDetailUrl    [NSString stringWithFormat:@"%@%@",BASEURL,@"api/user.php"]

#else
#endif

#endif /* URL_h */
