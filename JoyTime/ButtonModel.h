//
//  ButtonModel.h
//  BaiSi
//
//  Created by stone on 16/9/7.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ButtonModel : NSObject

@property (nonatomic,strong)NSArray* items;

@property (nonatomic,strong)NSString* imageName;
@property (nonatomic,strong)NSString* buttonName;


+(NSArray*)getItems;

@end
