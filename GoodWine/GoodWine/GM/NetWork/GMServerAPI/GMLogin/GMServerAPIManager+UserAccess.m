//
//  GMServerAPIManager+UserAccess.m
//  GoodWine
//
//  Created by LMK on 2019/7/3.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMServerAPIManager+UserAccess.h"

@implementation GMServerAPIManager (UserAccess)

- (NSURLSessionDataTask *)asyncLoginWithUserName:(NSString *)userName
                                        password:(NSString *)password
                                    succeedBlock:(void (^)(GMUserCenterInfoModel * model))succeedBlock
                                     failedBlock:(void (^)(NSError * _Nonnull))failedBlock {
    if (IsStrEmpty(userName) ||
        IsStrEmpty(password)) {
        if (failedBlock) {
            failedBlock([GMNetworkError getParamError]);
        }
        return nil;
    }
    
    NSMutableDictionary *temParamDict = [[NSMutableDictionary alloc] init];
    
    temParamDict[@"username"] = userName;
    temParamDict[@"password"] = password;
    
    return
    [ServerClient asyncNetworkRequestWithURL:GMLogin parameter:temParamDict success:^(NSDictionary *responseDict) {
        if ([[responseDict[@"code"] stringValue] isEqualToString:@"200"]) {
            [DataManager saveCookie];
            GMUserCenterInfoModel *userInfoModel = [GMUserCenterInfoModel userCenterModelWithDictionary:responseDict[@"data"]];
            if (succeedBlock) {
                succeedBlock(userInfoModel);
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
