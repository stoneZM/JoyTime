//
//  BaseModel.m
//  JoyTime
//
//  Created by stone on 2017/1/11.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "BaseModel.h"



@implementation BaseModel

MJExtensionCodingImplementation;

+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName
{
    return [propertyName mj_underlineFromCamel];
}

@end


