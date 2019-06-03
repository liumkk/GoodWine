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
        
        _sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
        [_sharedClient.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        _sharedClient.requestSerializer.timeoutInterval = ServerClient_RequestTimeOut;
        _sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
        
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.validatesDomainName = NO;
        securityPolicy.allowInvalidCertificates = YES;
        _sharedClient.securityPolicy = securityPolicy;
        
    });
    return _sharedClient;
    
}

- (NSURLSessionDataTask *)asyncNetworkRequestWithURL:(NSString *)url
                                           parameter:(id)param
                                             success:(void (^)(NSDictionary *responseDict))success
                                             failure:(void (^)(NSError *error))failure {
    
    NSURLSessionDataTask *task = [self POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                     options:NSJSONReadingMutableContainers
                                                                       error:nil];
        if (success) {
            success(responseDict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure([GMNetworkError changeNetError:error]);
        }
    }];
    
    return task;
}

@end


