//
//  GMServerAPIManager.m
//  GoodWine
//
//  Created by LMK on 2019/6/3.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMServerAPIManager.h"

@implementation GMServerAPIManager

singleton_implementation(GMServerAPIManager);

- (NSURLSessionDataTask *)asyncGetTokenWithAppCustomerId:(NSString *)appCustomerId
                                                password:(NSString *)password
                                            succeedBlock:(void(^)(NSString *token))succeedBlock
                                             failedBlock:(void(^)(NSError *error))failedBlock {
    
    if ((!appCustomerId || appCustomerId.length == 0) ||
        (!password || password.length == 0)) {
        if (failedBlock) {
            failedBlock([GMNetworkError getParamError]);
        }
        return nil;
    }
    
    NSMutableDictionary *temParamDict = [[NSMutableDictionary alloc] init];

    temParamDict[@"appCustomerId"] = appCustomerId;
    temParamDict[@"password"] = password;
    
    return
    [ServerClient asyncNetworkRequestWithURL:@"getToken" parameter:temParamDict success:^(NSDictionary *responseDict) {
        if ([responseDict[@"errCode"] isEqualToString:@"0000"]) {
            NSString *token = responseDict[@"token"];
            if (succeedBlock) {
                succeedBlock(token);
            }
            
        }else {
            
            if (failedBlock) {
                failedBlock([GMNetworkError getBizWithMessage:responseDict[GM_Net_Key_ErrInfo]]);
            }
            
        }
    } failure:^(NSError *error) {
        if (failedBlock) {
            failedBlock(error);
        }
    }];
}

@end
