//
//  JokCommentViewModel.h
//  JoyTime
//
//  Created by stone on 2017/1/14.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "BaseViewModel.h"
#import "JokCommentModel.h"
@interface JokCommentViewModel : BaseViewModel


//请求的当前页数
@property (nonatomic,assign)NSInteger curPage;
//总页数
@property (nonatomic,assign)NSInteger totalPage;
//段子id
@property (nonatomic,strong)NSString* jokId;

-(instancetype)initWithJokId:(NSString*)jokId;



-(JokCommentDataModel*)getJokCommentForCellAtRow:(NSInteger)row;

@end
