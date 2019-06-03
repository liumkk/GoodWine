//
//  GMServerClient.h
//  GoodWine
//
//  Created by LMK on 2019/6/3.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "AFHTTPSessionManager.h"

NS_ASSUME_NONNULL_BEGIN

#define ServerClient                [GMServerClient sharedClient]

@interface GMServerClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

- (NSURLSessionDataTask *)asyncNetworkRequestWithURL:(NSString *)url
                                           parameter:(id)param
                                             success:(void (^)(NSDictionary *responseDict))success
                                             failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
