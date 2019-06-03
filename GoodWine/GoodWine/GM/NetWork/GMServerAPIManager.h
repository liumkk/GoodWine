//
//  GMServerAPIManager.h
//  GoodWine
//
//  Created by LMK on 2019/6/3.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define ServerAPIManager     [GMServerAPIManager shared]

@interface GMServerAPIManager : NSObject

singleton_interface(GMServerAPIManager);

/**
 获取token
 
 @param appCustomerId 用户号
 @param password 密码
 @param succeedBlock succeedBlock
 @param failedBlock failedBlock
 @return return
 */
- (NSURLSessionDataTask *)asyncGetTokenWithAppCustomerId:(NSString *)appCustomerId
                                                password:(NSString *)password
                                            succeedBlock:(void(^)(NSString *token))succeedBlock
                                             failedBlock:(void(^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
