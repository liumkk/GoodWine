//
//  GMServerClient.m
//  GoodWine
//
//  Created by LMK on 2019/6/3.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMServerClient.h"

static CGFloat const ServerClient_RequestTimeOut  = 30.f;

static GMServerClient *_sharedClient = nil;

@implementation GMServerClient

+ (instancetype)sharedClient {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSString *baseUrl = GMServerBaseURL;
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
        
        _sharedClient.requestSerializer = [AFHTTPRequestSerializer serializer];
        [_sharedClient.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [_sharedClient.requestSerializer setValue:[DataManager getCookie] forHTTPHeaderField:Cookie_Key];
        
        _sharedClient.requestSerializer.timeoutInterval = ServerClient_RequestTimeOut;
        _sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
        
//        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
//        securityPolicy.validatesDomainName = NO;
//        securityPolicy.allowInvalidCertificates = YES;
//        _sharedClient.securityPolicy = securityPolicy;
        
    });
    return _sharedClient;
    
}

- (void)setContentTypeJson {
    ServerClient.requestSerializer = [AFJSONRequestSerializer serializer];
    [ServerClient.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
}

- (NSURLSessionDataTask *)asyncNetworkRequestWithURL:(NSString *)url
                                           parameter:(id)param
                                             success:(void (^)(NSDictionary *responseDict))success
                                             failure:(void (^)(NSError *error))failure {
   [_sharedClient.requestSerializer setValue:[DataManager getCookie] forHTTPHeaderField:Cookie_Key];
    NSURLSessionDataTask *task = [self POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSError *error = nil;
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                     options:NSJSONReadingMutableContainers
                                                                       error:&error];
        if (error) {
            if (failure) {
                failure(error);
            }
        }else {
            if (success) {
                success(responseDict);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure([GMNetworkError changeNetError:error]);
        }
    }];
    
    return task;
}

- (NSURLSessionDataTask *)asyncGetNetworkRequestWithURLString:(NSString *)urlString
                                                    parameter:(id)param
                                                      success:(void (^)(NSDictionary *responseDict))success
                                                      failure:(void (^)(NSError *error))failure {
    [_sharedClient.requestSerializer setValue:[DataManager getCookie] forHTTPHeaderField:Cookie_Key];
    NSURLSessionDataTask *task = [self GET:urlString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //1.解析json
        NSError *error = nil;
        NSDictionary *respDict = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                 options:NSJSONReadingAllowFragments
                                                                   error:&error];
        if (error) {
            if (failure) {
                failure(error);
            }
        }else {
            if (success) {
                success(respDict);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure([GMNetworkError changeNetError:error]);
        }
        
    }];
    
    return task;
}

@end


