//
//  BaseNetManager.m
//  BaseProject
//
//  Created by stone on 16/6/16.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseNetManager.h"

static AFHTTPSessionManager *manager = nil;

@implementation BaseNetManager


+ (AFHTTPSessionManager *)sharedAFManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript",@"text/plain", nil];
    });
    return manager;
}
+(NSString *)percentPathWithPath:(NSString *)path params:(NSDictionary *)params{
    NSMutableString *percentPath =[NSMutableString stringWithString:path];
    NSArray *keys = params.allKeys;
    NSInteger count = keys.count;
    for (int i = 0; i < count; i++) {
        if (i == 0) {
            [percentPath appendFormat:@"?%@=%@", keys[i], params[keys[i]]];
        }else{
            [percentPath appendFormat:@"&%@=%@", keys[i], params[keys[i]]];
        }
    }
    //把字符串中的中文转为%号形势
    NSCharacterSet* set = [NSCharacterSet URLFragmentAllowedCharacterSet];
    return [percentPath stringByAddingPercentEncodingWithAllowedCharacters:set];
}

+ (id)GET:(NSString *)path parameters:(NSDictionary *)params completionHandler:(void(^)(id responseObj, NSError *error))complete{

    ZMLog(@"Get Request Path: %@, Params:%@", path, params);
    NSString* finalPath = [self percentPathWithPath:path params:params];
    return [[self sharedAFManager] GET:finalPath parameters:nil progress:^(NSProgress * _Nonnull downloadProgress){
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        complete(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD setMinimumDismissTimeInterval:1];
        [SVProgressHUD showErrorWithStatus:@"网络开小差了啊!"];

        complete(nil,error);

    }];

}

+ (id)POST:(NSString *)path parameters:(NSDictionary *)params completionHandler:(void(^)(id responseObj, NSError *error))complete{

    ZMLog(@"Post Request Path: %@, Params:%@", path, params);
    return [[self sharedAFManager] POST:path parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

            complete(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"网络开小差了啊!"];
            complete(nil, error);
    }];
}

//设置header头信息
+ (void)httpSetValue:(NSString *)value forHTTPHeaderKey:(NSString *)key{
    
    AFHTTPSessionManager* manager = [self sharedAFManager];
    
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    [manager.requestSerializer setValue:value forHTTPHeaderField:key];
}

+ (void)setHTTPHeaderValuesForKeys:(NSDictionary *)dict{
    
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self httpSetValue:obj forHTTPHeaderKey:key];
    }];
}

//设置header头:uid,appToken
+(void)setHeader{
    
    NSString* uid = [StoreTool getValuesForKey:USERID];
    NSString* appToken = [StoreTool getValuesForKey:USERAPPTOKEN];
    if (!uid&&!appToken) {
        return;
    }
    NSDictionary* dic = @{@"uid":uid,@"appToken":appToken};
    [self setHTTPHeaderValuesForKeys:dic];
}





@end
