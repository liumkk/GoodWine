//
//  GMServerAPIManager+HomePage.h
//  GoodWine
//
//  Created by LMK on 2019/7/8.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMServerAPIManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface GMServerAPIManager (HomePage)

- (NSURLSessionDataTask *)asyncQueryHomePageInfoWithStoreId:(NSString *)storeId
                                               SucceedBlock:(void (^)(HomePageInfoModel *infoModel))succeedBlock
                                                failedBlock:(void (^)(NSError * error))failedBlock;

- (NSURLSessionDataTask *)asyncQueryStoreInfoWithRegionCode:(NSString *)regionCode
                                               succeedBlock:(void (^)(GMStoreInfoModel *infoModel))succeedBlock
                                                failedBlock:(void (^)(NSError * error))failedBlock;

- (NSURLSessionDataTask *)asyncQueryCouponSucceedBlock:(void (^)(NSArray <CouponInfoModel *> *array))succeedBlock
                                           failedBlock:(void (^)(NSError * error))failedBlock;

- (NSURLSessionDataTask *)asyncQueryMyCouponPageNum:(NSString *)pageNum
                                           pageSize:(NSString *)pageSize
                                       SucceedBlock:(void (^)(NSArray <MyCouponInfoModel *> *array))succeedBlock
                                        failedBlock:(void (^)(NSError * error))failedBlock;

- (NSURLSessionDataTask *)asyncGetCouponWithCouponId:(NSString *)couponId
                                        succeedBlock:(void (^)(void))succeedBlock
                                         failedBlock:(void (^)(NSError * error))failedBlock;

- (NSURLSessionDataTask *)asyncSearchWithSearchName:(NSString *)searchName
                                           pageSize:(NSString *)pageSize
                                            pageNum:(NSString *)pageNum
                                       succeedBlock:(void (^)(NSArray <HomePageTypeItem *> *array))succeedBlock
                                        failedBlock:(void (^)(NSError * error))failedBlock;
@end

NS_ASSUME_NONNULL_END
