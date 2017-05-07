//
//  StoreTool.m
//  JoyTime
//
//  Created by stone on 2017/1/13.
//  Copyright © 2017年 stone. All rights reserved.
//

#import "StoreTool.h"

#define CACHESPATH [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
@implementation StoreTool


+(void)ZMsetValue:(NSString *)value forkey:(NSString *)key{
    NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setValue:value forKey:key];
}

+(NSString *)getValuesForKey:(NSString *)key{
    NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault valueForKey:key];
}
+(void)removeValueForKey:(NSString*)key{
    NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:key];
}

+(void)setValueForKeys:(NSDictionary *)params{
    [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self ZMsetValue:obj forkey:key];
    }];
}

+ (void)deleteValuesWithDic:(NSDictionary *)dict{
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self removeValueForKey:key];
    }];
}



//实现归档功能 只需传入要归档的对象和要归档的属性数组
+(void)archiveObjc:(id)obj setupAllowedPropertyNames:(NSArray*)names identifier:(NSString *)identifier{
    
    [[obj class] mj_setupAllowedPropertyNames:^NSArray *{
        return names;
    }];
    NSString* objName = NSStringFromClass([obj class]);
    NSString* path = [self createPath:objName];
    NSString* filePath = [NSString stringWithFormat:@"%@/%@_%@.data",path,objName,identifier];
    [NSKeyedArchiver archiveRootObject:obj toFile:filePath];
}

//实现解档  className:要解档的类名
+(void)unarchiveObjForClassName:(NSString *)className
                     identifier:(NSString *)identifier
                 completeHandle:(void(^)(id responObj,BOOL isSuccess))completionHandle{
    
    NSString* cachesPath = CACHESPATH;
    NSString* archPath = [NSString stringWithFormat:@"%@/Archfile/%@",cachesPath,className];
    NSString* filePath = [NSString stringWithFormat:@"%@/%@_%@.data",archPath,className,identifier];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        completionHandle(nil,NO);
    }
   
    completionHandle([NSKeyedUnarchiver unarchiveObjectWithFile:filePath],YES);
}

//创建缓存文件夹
+ (NSString *)createPath:(NSString *)file
{
    NSString *path = CACHESPATH;
    NSString* archPath = [NSString stringWithFormat:@"%@/Archfile",path];
    NSString *result = [NSString stringWithFormat:@"%@/%@",archPath,file];
    if ([[NSFileManager defaultManager] fileExistsAtPath:result]==YES) {
        return result;
    }
    [[NSFileManager defaultManager] createDirectoryAtPath:result withIntermediateDirectories:YES attributes:nil error:nil];
    return result;
}



@end
