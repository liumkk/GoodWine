//
//  GMServerAPIManager+ShoppCar.h
//  GoodWine
//
//  Created by LMK on 2019/8/8.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMServerAPIManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface GMServerAPIManager (ShoppCar)

- (NSURLSessionDataTask *)asyncQueryShoppCarListWithSucceedBlock:(void (^)(NSArray <ShoppCarInfoModel *> *array))succeedBlock
                                                     failedBlock:(void (^)(NSError *error))failedBlock;

- (NSURLSessionDataTask *)asyncAddShoppCarWithDetailModel:(GMProductDetailModel *)detailModel
                                                  skuItem:(GMProductSkuItem *)skuItem
                                                 quantity:(NSString *)quantity
                                             succeedBlock:(void (^)(void))succeedBlock
                                              failedBlock:(void (^)(NSError * error))failedBlock;

- (NSURLSessionDataTask *)asyncModifyProductNumWithShoppId:(NSString *)shoppId
                                                  quantity:(NSString *)quantity
                                              succeedBlock:(void (^)(void))succeedBlock
                                               failedBlock:(void (^)(NSError * error))failedBlock;
@end

NS_ASSUME_NONNULL_END
