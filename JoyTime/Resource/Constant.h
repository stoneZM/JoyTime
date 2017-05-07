//
//  Constant.h
//  JoyTime
//
//  Created by stone on 2017/1/13.
//  Copyright © 2017年 stone. All rights reserved.
//

#ifndef Constant_h
#define Constant_h



#ifdef DEBUG
#define ZMLog(...) NSLog(__VA_ARGS__)
#else
#define ZMLog(...)
#endif

/**打印所执行的方法*/
#define ZMLogfunc ZMLog(@"%s",__func__)

/***屏幕的宽高**/
#define ZMSCREENW [UIScreen mainScreen].bounds.size.width
#define ZMSCREENH [UIScreen mainScreen].bounds.size.height

/***每页请求的数据量**/
#define RequestCountPerPage  @"20"


/*提示展示的时间*/
#define ZMMinimumDismissTimeInterval 1
#define ZMSVProgressDismiss  [SVProgressHUD setMinimumDismissTimeInterval:ZMMinimumDismissTimeInterval]

#define ZANKEY  @"zanKey"
#define CAIKEY  @"caiKey"

//用户信息
#define USERID       @"userId"
#define USERNICKNAME @"userNickName"
#define USERACCOUNT  @"userAccount"
#define USERPWD      @"userPassword"
#define USERAPPTOKEN @"userAppToken"
#define USERYXTOKEN  @"userYXToken"
#define USERACCID    @"userAccid"
#define USERSEX      @"userSex"
#define USERPROFILEIMG @"userImg"

//iCarouselSwitchType
#define iCarouselSwitchType @"iCarouselSwitchType"

//发送通知系列名称
#define LoginBtnClickedNotification  @"LoginBtnClickedNotification"
#define LoginSuccedNotifucation      @"LoginSuccedNotifucation"
#define LogoutNotification           @"LogoutNotification"
#define CancleAttentionNotification  @"CancleAttentionNotification"
#define AddAttentionNotification     @"AddAttentionNotification"


#endif /* Constant_h */
