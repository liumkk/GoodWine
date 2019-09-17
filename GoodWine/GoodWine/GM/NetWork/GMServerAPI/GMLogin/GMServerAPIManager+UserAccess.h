//
//  GMServerAPIManager+UserAccess.h
//  GoodWine
//
//  Created by LMK on 2019/7/3.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMServerAPIManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface GMServerAPIManager (UserAccess)

/**
 登录
 
 @param userName 用户号
 @param password 密码
 @param succeedBlock succeedBlock
 @param failedBlock failedBlock
 @return return
 */
- (NSURLSessionDataTask *)asyncLoginWithUserName:(NSString *)userName
                                        password:(NSString *)password
                                    succeedBlock:(void(^)(GMUserCenterInfoModel * model))succeedBlock
                                     failedBlock:(void(^)(NSError *error))failedBlock;

- (NSURLSessionDataTask *)asyncQueryAuthCodeWithPhoneNum:(NSString *)phoneNum
                                            succeedBlock:(void (^)(void))succeedBlock
                                             failedBlock:(void (^)(NSError * error))failedBlock;

- (NSURLSessionDataTask *)asynclogoutSucceedBlock:(void (^)(void))succeedBlock
                                      failedBlock:(void (^)(NSError * error))failedBlock;

- (NSURLSessionDataTask *)asyncModifyPasswordWithPhoneNum:(NSString *)phoneNum
                                                 password:(NSString *)password
                                                 authCode:(NSString *)authCode
                                             succeedBlock:(void (^)(void))succeedBlock
                                              failedBlock:(void (^)(NSError * error))failedBlock;
@end

NS_ASSUME_NONNULL_END
