//
//  AttentionViewModel.m
//  JoyTime
//
//  Created by stone on 2017/1/17.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "AttentionViewModel.h"
#import "JokNetwork.h"
#import "JokModel.h"
@implementation AttentionViewModel


-(void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle{
    
    [self.dataArr removeAllObjects];
    [JokNetwork getAttentionContentWithPage:@"" pageCount:@"" completeHandle:^(id responseObj, NSError *error) {
        JokModel* model = (JokModel*)responseObj;
        [self.dataArr addObjectsFromArray:model.data];
        completionHandle(error);
    }];
    
}

-(JokDataModel*)getJokForCellAtRow:(NSInteger)row{
    JokDataModel* model = self.dataArr[row];
    return model;
}

@end
