//
//  JokViewModel.m
//  JoyTime
//
//  Created by stone on 2017/1/12.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "JokViewModel.h"

@interface JokViewModel()



@end

@implementation JokViewModel



-(instancetype)initWithRequestType:(RequestType)type{
    
    if (self=[super init]) {
        self.type = type;
        self.curPage = 0;
        self.totalPage = 1;
        
    }
    return self;
}


/**
 从网络上获取数据
 */
-(void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle{
   
//    if (self.curPage > self.totalPage+1) {
//        NSError *error = [[NSError alloc]initWithDomain:NSPOSIXErrorDomain code:1 userInfo:nil];
//        completionHandle(error);
//        return ;
//    }
    [JokNetwork getJokDataWithRequestType:self.type
                                    page:[NSString stringWithFormat:@"%ld",self.curPage]
                               pageCount:RequestCountPerPage
                          completeHandle:^(id responseObj, NSError *error) {
                             
                              JokModel* model = responseObj;
                              
//                           self.totalPage = [model.total integerValue];
                             if (self.curPage == 0 ) {
                                 if (!error) {
                                      [self.dataArr removeAllObjects];
                                      //刷新时进行归档操作
                                      [self archiveObjc:model setupAllowedPropertyNames:@[@"data"] identifier:[NSString stringWithFormat:@"%ld",(long)self.type]];
                                  }
                              }
                               [self.dataArr addObjectsFromArray:model.data];
                                completionHandle(error);
                              
                          }];
    
}

//获取磁盘缓存的数据
-(void)getCacheDataCompletionHandle:(void (^)(BOOL))completionhandle{
    [self unarchiveObjForClassName:@"JokModel"
                     identifier:[NSString stringWithFormat:@"%ld",(long)self.type]
                 completeHandle:^(id responObj, BOOL isSuccess) {
                     
                     JokModel* model = (JokModel*)responObj;
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

-(JokDataModel*)getJokForCellAtRow:(NSInteger)row{
    JokDataModel* model = self.dataArr[row];
    return model;
}









@end
