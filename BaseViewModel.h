//
//  BaseViewModel.h
//  BaseProject
//
// Created by stone on 16/6/16.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompletionHandle)(NSError *error);

@protocol BaseViewModelDelegate <NSObject>

@optional
//获取更多
- (void)getMoreDataCompletionHandle:(CompletionHandle)completionHandle;
//刷新
- (void)refreshDataCompletionHandle:(CompletionHandle)completionHandle;
//网络上获取数据
- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle;
//获取缓存数据
-(void)getCacheDataCompletionHandle:(void(^)(BOOL isSuccess))completionhandle;

@end

@interface BaseViewModel : NSObject<BaseViewModelDelegate>

@property(nonatomic,strong) NSMutableArray *dataArr;
@property(nonatomic,strong) NSURLSessionDataTask *dataTask;
- (void)cancelTask;  //取消任务
- (void)suspendTask; //暂停任务
- (void)resumeTask;  //继续任务


-(void)unarchiveObjForClassName:(NSString *)className
                  identifier:(NSString *)identifier
              completeHandle:(void(^)(id responObj,BOOL isSuccess))completionHandle;
-(void)archiveObjc:(id)obj setupAllowedPropertyNames:(NSArray*)names identifier:(NSString*)identifier;


@end
