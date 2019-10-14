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
    
    [ServerClient setContentTypeUrlencoded];
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

- (NSURLSessionDataTask *)asyncQueryAuthCodeWithPhoneNum:(NSString *)phoneNum
                                            succeedBlock:(void (^)(void))succeedBlock
                                             failedBlock:(void (^)(NSError * _Nonnull))failedBlock {
    
    return
    [ServerClient asyncGetNetworkRequestWithURLString:GMAuthCode(phoneNum) parameter:@"" success:^(NSDictionary * _Nonnull responseDict) {
        if ([[responseDict[@"code"] stringValue] isEqualToString:@"200"]) {
            if (succeedBlock) {
                succeedBlock();
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

- (NSURLSessionDataTask *)asynclogoutSucceedBlock:(void (^)(void))succeedBlock
                                      failedBlock:(void (^)(NSError * _Nonnull))failedBlock {
    
    return
    [ServerClient asyncGetNetworkRequestWithURLString:GMLogout parameter:@"" success:^(NSDictionary * _Nonnull responseDict) {
        if ([[responseDict[@"code"] stringValue] isEqualToString:@"200"]) {
            if (succeedBlock) {
                succeedBlock();
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

- (NSURLSessionDataTask *)asyncRegisterWithUserName:(NSString *)userName
                                           PhoneNum:(NSString *)phoneNum
                                           password:(NSString *)password
                                           authCode:(NSString *)authCode
                                       succeedBlock:(void (^)(void))succeedBlock
                                        failedBlock:(void (^)(NSError * _Nonnull))failedBlock {
    if (IsStrEmpty(phoneNum) ||
        IsStrEmpty(password) ||
        IsStrEmpty(authCode)) {
        if (failedBlock) {
            failedBlock([GMNetworkError getParamError]);
        }
        return nil;
    }
    
    NSMutableDictionary *temParamDict = [[NSMutableDictionary alloc] init];
    
    userName = [userName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   
//    temParamDict[@"nickname"] = nickName;
//    temParamDict[@"telephone"] = phoneNum;
//    temParamDict[@"password"] = password;
//    temParamDict[@"authCode"] = authCode;
    
    [ServerClient setContentTypeJson];
    return
    [ServerClient asyncNetworkRequestWithURL:GMRegister(userName,password,phoneNum,authCode) parameter:temParamDict success:^(NSDictionary *responseDict) {
        if ([[responseDict[@"code"] stringValue] isEqualToString:@"200"]) {
            if (succeedBlock) {
                succeedBlock();
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

- (NSURLSessionDataTask *)asyncModifyPasswordWithPhoneNum:(NSString *)phoneNum
                                                 password:(NSString *)password
                                                 authCode:(NSString *)authCode
                                    succeedBlock:(void (^)(void))succeedBlock
                                     failedBlock:(void (^)(NSError * _Nonnull))failedBlock {
    if (IsStrEmpty(phoneNum) ||
        IsStrEmpty(password) ||
        IsStrEmpty(authCode)) {
        if (failedBlock) {
            failedBlock([GMNetworkError getParamError]);
        }
        return nil;
    }
    
    NSMutableDictionary *temParamDict = [[NSMutableDictionary alloc] init];
    
    temParamDict[@"telephone"] = phoneNum;
    temParamDict[@"password"] = password;
    temParamDict[@"authCode"] = authCode;
    
    [ServerClient setContentTypeJson];
    return
    [ServerClient asyncNetworkRequestWithURL:GMModifyPassword(phoneNum,password,authCode) parameter:temParamDict success:^(NSDictionary *responseDict) {
        if ([[responseDict[@"code"] stringValue] isEqualToString:@"200"]) {
            if (succeedBlock) {
                succeedBlock();
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
