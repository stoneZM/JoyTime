//
//  ButtonModel.m
//  BaiSi
//
//  Created by stone on 16/9/7.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "ButtonModel.h"

@implementation ButtonModel

+(NSArray *)getItems{
    NSMutableArray* itemArr = [[NSMutableArray alloc]init];
    for (int i=0; i<[self imageNames].count; i++) {
        ButtonModel* model = [[ButtonModel alloc]initWithImage:[self imageNames][i] name:[self itemName][i]];
        [itemArr addObject:model];
    }
    return [itemArr copy];
}


-(instancetype)initWithImage:(NSString*)imageName name:(NSString*)itemName{
    if (self = [super init]) {
        self.imageName = imageName;
        self.buttonName = itemName;
    }
    return self;
}

+(NSArray*)imageNames{

//    return @[@"publish-audio",@"publish-offline",@"publish-picture",@"publish-review",@"publish-text",@"publish-video"];
     return @[@"text",@"image",@"video",@"audio"];
}
+(NSArray*)itemName{
//    return @[@"发视屏",@"发图片",@"发段子",@"发声音",@"审帖",@"发链接"];
    return @[@"发段子",@"发图片",@"发视屏",@"发声音"];
}



@end
