//
//  GMServerAPIManager+Product.h
//  GoodWine
//
//  Created by LMK on 2019/8/17.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMServerAPIManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface GMServerAPIManager (Product)

- (NSURLSessionDataTask *)asyncQueryProductDetailWithProductId:(NSString *)productId
                                                  succeedBlock:(void (^)(ProductInfoModel *model))succeedBlock
                                                   failedBlock:(void (^)(NSError *error))failedBlock;

- (NSURLSessionDataTask *)asyncQueryProductEvaluateWithProductId:(NSString *)productId
                                                    succeedBlock:(void (^)(NSArray <ProductEvaluateInfoModel*> *dataArray))succeedBlock
                                                     failedBlock:(void (^)(NSError *error))failedBlock;

- (NSURLSessionDataTask *)asyncAddEvaluateWithContent:(NSString *)content
                                              orderId:(NSString *)orderId
                                          productStar:(NSString *)productStar
                                            anonymous:(NSString *)anonymous
                                         deliveryStar:(NSString *)deliveryStar
                                     satisfactionStar:(NSString *)satisfactionStar
                                         succeedBlock:(void (^)(void))succeedBlock
                                          failedBlock:(void (^)(NSError * error))failedBlock;

/**
 *根据门店id和分类id获取品牌
 */
- (NSURLSessionDataTask *)asyncQueryBrandClassWithCateId:(NSString *)cateId
                                              succeedBlock:(void (^)(NSArray<BrandAreaInfoModel *> *array))succeedBlock
                                               failedBlock:(void (^)(NSError *error))failedBlock;

/**
 *根据分类id和品牌id获取商品
 */
- (NSURLSessionDataTask *)asyncQueryProductWithCateId:(NSString *)cateId
                                              brandId:(NSString *)brandId
                                         succeedBlock:(void (^)(NSArray<HomePageTypeItem *> *array))succeedBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
