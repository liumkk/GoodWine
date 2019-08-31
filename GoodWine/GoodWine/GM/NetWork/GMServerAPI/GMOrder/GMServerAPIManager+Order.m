//
//  GMServerAPIManager+Order.m
//  GoodWine
//
//  Created by LMK on 2019/8/21.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMServerAPIManager+Order.h"

@implementation GMServerAPIManager (Order)

- (NSURLSessionDataTask *)asyncQueryOrderConfirmWithShoppCarIds:(NSArray *)array
                                                   succeedBlock:(void (^)(OrderConfirmInfoModels * _Nonnull))succeedBlock
                                                    failedBlock:(void (^)(NSError * _Nonnull))failedBlock {
    
    NSMutableDictionary *temParamDict = [[NSMutableDictionary alloc] init];
    
    temParamDict[@"storeId"] = UserCenter.storeId;
    temParamDict[@"ids"] = array;
    
    [ServerClient setContentTypeJson];
    return
    [ServerClient asyncNetworkRequestWithURL:GMOrderConfirmFromShoppCar parameter:temParamDict success:^(NSDictionary * _Nonnull responseDict) {
        if ([[responseDict[@"code"] stringValue] isEqualToString:@"200"]) {
            OrderConfirmInfoModels *model = [OrderConfirmInfoModels orderConfirmInfoModelsWithDictionary:responseDict[@"data"]];
            if (succeedBlock) {
                succeedBlock(model);
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

- (NSURLSessionDataTask *)asyncDeleteProductWithShoppCarIds:(NSArray *)array
                                               succeedBlock:(void (^)(void))succeedBlock
                                                failedBlock:(void (^)(NSError * _Nonnull))failedBlock {
    
    NSMutableDictionary *temParamDict = [[NSMutableDictionary alloc] init];
    
    temParamDict[@"ids"] = array;
    
    [ServerClient setContentTypeJson];
    return
    [ServerClient asyncNetworkRequestWithURL:GMDeleteProductForShoppCar parameter:temParamDict success:^(NSDictionary * _Nonnull responseDict) {
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

- (NSURLSessionDataTask *)asyncQueryOrderConfirmWithProductModel:(GMProductDetailModel *)detailModel
                                                         skuItem:(GMProductSkuItem *)skuItem
                                                        quantity:(NSString *)quantity
                                                    succeedBlock:(void (^)(OrderConfirmInfoModels * _Nonnull))succeedBlock
                                                     failedBlock:(void (^)(NSError * _Nonnull))failedBlock {
    
    NSMutableDictionary *temParamDict = [[NSMutableDictionary alloc] init];
    
    temParamDict[@"quantity"] = quantity;
    temParamDict[@"storeId"] = UserCenter.storeId;
    temParamDict[@"memberId"] = UserCenter.userInfoModel.memberId;
    temParamDict[@"memberNickname"] = UserCenter.userInfoModel.nickname;
    
    
    temParamDict[@"productSkuId"] = skuItem.productSkuId;
    temParamDict[@"productSkuCode"] = skuItem.skuCode;
    temParamDict[@"price"] = skuItem.price;
    temParamDict[@"sp1"] = skuItem.sp1;
    
    temParamDict[@"productId"] = detailModel.productId;
    temParamDict[@"productCategoryId"] = detailModel.productCategoryId;
    temParamDict[@"productName"] = detailModel.brandName;
    temParamDict[@"productPic"] = detailModel.pic;
    temParamDict[@"productSubTitle"] = detailModel.detailDesc;
    temParamDict[@"productSn"] = detailModel.productSn;
    
    [ServerClient setContentTypeJson];
    return
    [ServerClient asyncNetworkRequestWithURL:GMOrderConfirmFromProduct parameter:temParamDict success:^(NSDictionary * _Nonnull responseDict) {
        if ([[responseDict[@"code"] stringValue] isEqualToString:@"200"]) {
            OrderConfirmInfoModels *model = [OrderConfirmInfoModels orderConfirmInfoModelsWithDictionary:responseDict[@"data"]];
            if (succeedBlock) {
                succeedBlock(model);
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

- (NSURLSessionDataTask *)asyncQueryOrderDetailWithModel:(GMMyOrderDetailModel *)model
                                            succeedBlock:(void (^)(GMOrderDetailInfoModel * _Nonnull))succeedBlock
                                             failedBlock:(void (^)(NSError * _Nonnull))failedBlock {
    
    NSMutableDictionary *temParamDict = [[NSMutableDictionary alloc] init];
    
    temParamDict[@"storeId"] = UserCenter.storeId;
    temParamDict[@"ids"] = model.idsArray;
    temParamDict[@"memberReceiveAddressId"] =model.memberReceiveAddressId;
    temParamDict[@"expectedTime"] = model.expectedTime;
    temParamDict[@"payType"] = model.payType;
    
    [ServerClient setContentTypeJson];
    return
    [ServerClient asyncNetworkRequestWithURL:GMOrderDetailFromShoppCar parameter:temParamDict success:^(NSDictionary * _Nonnull responseDict) {
        if ([[responseDict[@"code"] stringValue] isEqualToString:@"200"]) {
            GMOrderDetailInfoModel *model = [GMOrderDetailInfoModel yy_modelWithDictionary:responseDict[@"data"]];
            if (succeedBlock) {
                succeedBlock(model);
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

- (NSURLSessionDataTask *)asyncQueryOrderDetailProductWithModel:(GMMyOrderDetailModel *)model
                                                   succeedBlock:(void (^)(GMOrderDetailInfoModel * _Nonnull))succeedBlock
                                                    failedBlock:(void (^)(NSError * _Nonnull))failedBlock {
    
    NSMutableDictionary *temParamDict = [[NSMutableDictionary alloc] init];
    
    temParamDict[@"storeId"] = UserCenter.storeId;
    temParamDict[@"memberReceiveAddressId"] =model.memberReceiveAddressId;
    temParamDict[@"expectedTime"] = model.expectedTime;
    temParamDict[@"payType"] = model.payType;

    temParamDict[@"quantity"] = model.quantity;
    temParamDict[@"memberId"] = UserCenter.userInfoModel.memberId;
    temParamDict[@"memberNickname"] = UserCenter.userInfoModel.nickname;
    
    
    temParamDict[@"productSkuId"] = model.productSkuItem.productSkuId;
    temParamDict[@"productSkuCode"] = model.productSkuItem.skuCode;
    temParamDict[@"price"] = model.productSkuItem.price;
    temParamDict[@"sp1"] = model.productSkuItem.sp1;
    
    temParamDict[@"productId"] = model.productDetailModel.productId;
    temParamDict[@"productCategoryId"] = model.productDetailModel.productCategoryId;
    temParamDict[@"productName"] = model.productDetailModel.brandName;
    temParamDict[@"productPic"] = model.productDetailModel.pic;
    temParamDict[@"productSubTitle"] = model.productDetailModel.detailDesc;
    temParamDict[@"productSn"] = model.productDetailModel.productSn;
    
    [ServerClient setContentTypeJson];
    return
    [ServerClient asyncNetworkRequestWithURL:GMOrderDetailFromProduct parameter:temParamDict success:^(NSDictionary * _Nonnull responseDict) {
        if ([[responseDict[@"code"] stringValue] isEqualToString:@"200"]) {
            GMOrderDetailInfoModel *model = [GMOrderDetailInfoModel yy_modelWithDictionary:responseDict[@"data"]];
            if (succeedBlock) {
                succeedBlock(model);
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

- (NSURLSessionDataTask *)asyncDeleteOrder:(NSString *)orderId
                              succeedBlock:(void (^)(void))succeedBlock
                               failedBlock:(void (^)(NSError * _Nonnull))failedBlock {
    
    NSMutableDictionary *temParamDict = [[NSMutableDictionary alloc] init];
    
    temParamDict[@"orderId"] = orderId;
    
    [ServerClient setContentTypeJson];
    return
    [ServerClient asyncNetworkRequestWithURL:GMDeleteOrder(orderId) parameter:temParamDict success:^(NSDictionary * _Nonnull responseDict) {
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

- (NSURLSessionDataTask *)asyncGetPayData:(NSString *)orderId
                             succeedBlock:(void (^)(void))succeedBlock
                              failedBlock:(void (^)(NSError * _Nonnull))failedBlock {
    
    NSMutableDictionary *temParamDict = [[NSMutableDictionary alloc] init];
    
    temParamDict[@"orderId"] = orderId;
    
    [ServerClient setContentTypeJson];
    return
    [ServerClient asyncNetworkRequestWithURL:GMGetPayData(orderId) parameter:temParamDict success:^(NSDictionary * _Nonnull responseDict) {
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
