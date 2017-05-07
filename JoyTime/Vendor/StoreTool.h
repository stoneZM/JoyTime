//
//  StoreTool.h
//  JoyTime
//
//  Created by stone on 2017/1/13.
//  Copyright © 2017年 stone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreTool : NSObject

//userDefault存储
+ (void)ZMsetValue:(NSString*)value forkey:(NSString*)key;
+ (void)setValueForKeys:(NSDictionary*)params;
+ (NSString*)getValuesForKey:(NSString*)key;

//userDefault删除某个字段
+(void)removeValueForKey:(NSString*)key;
+ (void)deleteValuesWithDic:(NSDictionary*)dict;

//归档和解档存储
+ (void)unarchiveObjForClassName:(NSString *)className
                     identifier:(NSString *)identifier
                 completeHandle:(void(^)(id responObj,BOOL isSuccess))completionHandle;
+ (void)archiveObjc:(id)obj setupAllowedPropertyNames:(NSArray*)names identifier:(NSString*)identifier;




@end
