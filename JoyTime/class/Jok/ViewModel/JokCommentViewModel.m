//
//  JokCommentViewModel.m
//  JoyTime
//
//  Created by stone on 2017/1/14.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "JokCommentViewModel.h"
#import "JokNetwork.h"
@implementation JokCommentViewModel

-(instancetype)initWithJokId:(NSString *)jokId{
    if (self = [super init]) {
        self.totalPage = 1;
        self.jokId = jokId;
    }
    return self;
}

/**
 从网络上获取数据
 */
-(void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle{
    
    if (self.curPage > self.totalPage) {
        self.curPage--;
        NSError* error = [NSError new];
        completionHandle(error);
        return;
    }
    [JokNetwork getCommentForJokWithJokId:self.jokId page:self.curPage pageCount:RequestCountPerPage completeHandle:^(id responseObj, NSError *error) {
                               
                               JokCommentModel* model = (JokCommentModel*)responseObj;
                               if (self.curPage == 0) {
                                   if (!error) {
                                       [self.dataArr removeAllObjects];
                                       //刷新时进行归档操作
                                       [self archiveObjc:model setupAllowedPropertyNames:@[@"data"] identifier:[NSString stringWithFormat:@"%@",self.jokId]];
                                   }
                               }
                               [self.dataArr addObjectsFromArray:model.data];
                               completionHandle(error);
                               
                           }];
    
}

//获取磁盘缓存的数据
-(void)getCacheDataCompletionHandle:(void (^)(BOOL))completionhandle{
    [self unarchiveObjForClassName:@"JokCommentModel"
                        identifier:[NSString stringWithFormat:@"%@",self.jokId]
                    completeHandle:^(id responObj, BOOL isSuccess) {
                        
                        JokCommentModel* model = (JokCommentModel*)responObj;
                        [self.dataArr addObjectsFromArray:model.data];
                        completionhandle(isSuccess);
                    }];
}


-(void)getMoreDataCompletionHandle:(CompletionHandle)completionHandle
{
    self.curPage++;
    [self getDataFromNetCompleteHandle:completionHandle];
}

-(void)refreshDataCompletionHandle:(CompletionHandle)completionHandle
{
    self.curPage = 0;
    [self getDataFromNetCompleteHandle:completionHandle];
}

-(JokCommentDataModel*)getJokCommentForCellAtRow:(NSInteger)row{
    JokCommentDataModel* model = self.dataArr[row];
    return model;
}

@end
