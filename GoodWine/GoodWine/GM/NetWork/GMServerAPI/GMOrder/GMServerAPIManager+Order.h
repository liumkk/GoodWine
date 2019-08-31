//
//  GMServerAPIManager+Order.h
//  GoodWine
//
//  Created by LMK on 2019/8/21.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMServerAPIManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface GMServerAPIManager (Order)

- (NSURLSessionDataTask *)asyncQueryOrderConfirmWithShoppCarIds:(NSArray *)array
                                                   succeedBlock:(void (^)(OrderConfirmInfoModels *infoModel))succeedBlock
                                                    failedBlock:(void (^)(NSError *error))failedBlock;

- (NSURLSessionDataTask *)asyncDeleteProductWithShoppCarIds:(NSArray *)array
                                               succeedBlock:(void (^)(void))succeedBlock
                                                failedBlock:(void (^)(NSError *error))failedBlock;

- (NSURLSessionDataTask *)asyncQueryOrderConfirmWithProductModel:(GMProductDetailModel *)detailModel
                                                         skuItem:(GMProductSkuItem *)skuItem
                                                        quantity:(NSString *)quantity
                                                    succeedBlock:(void (^)(OrderConfirmInfoModels *infoModel))succeedBlock
                                                     failedBlock:(void (^)(NSError *error))failedBlock;

- (NSURLSessionDataTask *)asyncQueryOrderDetailWithModel:(GMMyOrderDetailModel *)model
                                            succeedBlock:(void (^)(GMOrderDetailInfoModel * model))succeedBlock
                                             failedBlock:(void (^)(NSError * error))failedBlock;

- (NSURLSessionDataTask *)asyncQueryOrderDetailProductWithModel:(GMMyOrderDetailModel *)model
                                                   succeedBlock:(void (^)(GMOrderDetailInfoModel * model))succeedBlock
                                                    failedBlock:(void (^)(NSError * error))failedBlock;

- (NSURLSessionDataTask *)asyncDeleteOrder:(NSString *)orderId
                              succeedBlock:(void (^)(void))succeedBlock
                               failedBlock:(void (^)(NSError * error))failedBlock;

- (NSURLSessionDataTask *)asyncGetPayData:(NSString *)orderId
                             succeedBlock:(void (^)(void))succeedBlock
                              failedBlock:(void (^)(NSError * error))failedBlock;

@end

NS_ASSUME_NONNULL_END
