//
//  GMServerAPIManager+GMMyCenter.h
//  GoodWine
//
//  Created by LMK on 2019/8/3.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMServerAPIManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface GMServerAPIManager (GMMyCenter)

- (NSURLSessionDataTask *)asyncQueryAddressWithSucceedBlock:(void (^)(NSArray *array))succeedBlock
                                                failedBlock:(void (^)(NSError *error))failedBlock;

- (NSURLSessionDataTask *)asyncAddAddressWithName:(NSString *)name
                                         phoneNum:(NSString *)phoneNum
                                          address:(NSString *)address
                                    detailAddress:(NSString *)detailAddress
                                     succeedBlock:(void (^)(void))succeedBlock
                                      failedBlock:(void (^)(NSError * error))failedBlock;

@end

NS_ASSUME_NONNULL_END
