//
//  JokViewModel.h
//  JoyTime
//
//  Created by stone on 2017/1/12.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "BaseViewModel.h"
#import "JokNetwork.h"
#import "JokModel.h"


@interface JokViewModel : BaseViewModel


//请求的类型
@property (nonatomic,assign)RequestType type;
//请求的当前页数
@property (nonatomic,assign)NSInteger curPage;
//总页数
@property (nonatomic,assign)NSInteger totalPage;


-(instancetype)initWithRequestType:(RequestType)type;

-(JokDataModel*)getJokForCellAtRow:(NSInteger)row;

@end
