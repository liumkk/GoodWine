//
//  GMServerAPIManager+Product.m
//  GoodWine
//
//  Created by LMK on 2019/8/17.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMServerAPIManager+Product.h"

@implementation GMServerAPIManager (Product)

- (NSURLSessionDataTask *)asyncQueryProductDetailWithProductId:(NSString *)productId
                                                  succeedBlock:(void (^)(ProductInfoModel *_Nonnull))succeedBlock
                                                   failedBlock:(void (^)(NSError * _Nonnull))failedBlock {
    
    return
    [ServerClient asyncGetNetworkRequestWithURLString:GMProductDetail(productId) parameter:@"" success:^(NSDictionary * _Nonnull responseDict) {
        if ([[responseDict[@"code"] stringValue] isEqualToString:@"200"]) {
            ProductInfoModel *model = [ProductInfoModel productInfoModelWithDictionary:responseDict[@"data"]];
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

- (NSURLSessionDataTask *)asyncQueryProductEvaluateWithProductId:(NSString *)productId
                                                    succeedBlock:(void (^)(NSArray<ProductEvaluateInfoModel *> * _Nonnull))succeedBlock
                                                     failedBlock:(void (^)(NSError * _Nonnull))failedBlock {
    return
    [ServerClient asyncGetNetworkRequestWithURLString:GMProductEvaluate(productId) parameter:@"" success:^(NSDictionary * _Nonnull responseDict) {
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        if ([[responseDict[@"code"] stringValue] isEqualToString:@"200"]) {
            for (NSDictionary *dic in responseDict[@"data"]) {
                ProductEvaluateInfoModel *model = [ProductEvaluateInfoModel productEvaluateInfoModelWithDictionary:dic];
                [dataArray addObject:model];
            }
            if (succeedBlock) {
                succeedBlock(dataArray);
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

- (NSURLSessionDataTask *)asyncAddEvaluateWithContent:(NSString *)content
                                              orderId:(NSString *)orderId
                                          productStar:(NSString *)productStar
                                            anonymous:(NSString *)anonymous
                                         deliveryStar:(NSString *)deliveryStar
                                     satisfactionStar:(NSString *)satisfactionStar
                                         succeedBlock:(void (^)(void))succeedBlock
                                          failedBlock:(void (^)(NSError * _Nonnull))failedBlock {
    
    NSMutableDictionary *temParamDict = [[NSMutableDictionary alloc] init];
    
    temParamDict[@"content"] = content;
    temParamDict[@"createTime"] = [NSString getCurrentTime];
    
    temParamDict[@"memberIcon"] = UserCenter.userInfoModel.icon;
    temParamDict[@"memberId"] = UserCenter.userInfoModel.memberId;
    temParamDict[@"memberNickname"] = UserCenter.userInfoModel.nickname;
    
    
    temParamDict[@"orderId"] = orderId;
    temParamDict[@"anonymous"] = anonymous;
    
    temParamDict[@"productStar"] = productStar;
    temParamDict[@"deliveryStar"] = deliveryStar;
    temParamDict[@"satisfactionStar"] = satisfactionStar;
    
    return
    [ServerClient asyncNetworkRequestWithURL:GMAddShoppCar parameter:temParamDict success:^(NSDictionary * _Nonnull responseDict) {
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

- (NSURLSessionDataTask *)asyncAddShoppCarWithDetailModel:(GMProductDetailModel *)detailModel
                                                  skuItem:(GMProductSkuItem *)skuItem
                                                 quantity:(NSString *)quantity
                                             succeedBlock:(void (^)(void))succeedBlock
                                              failedBlock:(void (^)(NSError * _Nonnull))failedBlock {
    
    NSMutableDictionary *temParamDict = [[NSMutableDictionary alloc] init];
    
    temParamDict[@"quantity"] = quantity;
    temParamDict[@"memberId"] = UserCenter.userInfoModel.memberId;
    temParamDict[@"memberNickname"] = UserCenter.userInfoModel.nickname;
    temParamDict[@"storeId"] = UserCenter.storeId;
    
    temParamDict[@"productSkuId"] = skuItem.productSkuId;
    temParamDict[@"productSkuCode"] = skuItem.skuCode;
    temParamDict[@"price"] = skuItem.price;
    temParamDict[@"sp1"] = skuItem.sp1;
    
    temParamDict[@"productId"] = detailModel.productId;
    temParamDict[@"productName"] = detailModel.brandName;
    temParamDict[@"productPic"] = detailModel.pic;
    temParamDict[@"productSubTitle"] = detailModel.detailDesc;
    temParamDict[@"productSn"] = detailModel.productSn;
    
    return
    [ServerClient asyncNetworkRequestWithURL:GMAddShoppCar parameter:temParamDict success:^(NSDictionary * _Nonnull responseDict) {
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

- (NSURLSessionDataTask *)asyncQueryBrandClassWithCateId:(NSString *)cateId
                                            succeedBlock:(void (^)(NSArray<BrandAreaInfoModel *> * _Nonnull))succeedBlock
                                             failedBlock:(void (^)(NSError * _Nonnull))failedBlock {
    
    return
    [ServerClient asyncGetNetworkRequestWithURLString:GMProductBrandList(UserCenter.storeId, cateId) parameter:@"" success:^(NSDictionary * _Nonnull responseDict) {
        if ([[responseDict[@"code"] stringValue] isEqualToString:@"200"]) {
            NSMutableArray *dataArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in responseDict[@"data"]) {
                BrandAreaInfoModel *model = [BrandAreaInfoModel brandAreaInfoModelWithDictionary:dic];
                [dataArray addObject:model];
            }
            if (succeedBlock) {
                succeedBlock(dataArray);
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

- (NSURLSessionDataTask *)asyncQueryProductWithCateId:(NSString *)cateId
                                              brandId:(NSString *)brandId
                                         succeedBlock:(void (^)(NSArray<HomePageTypeItem *> * _Nonnull))succeedBlock
                                          failedBlock:(void (^)(NSError * _Nonnull))failedBlock {
    
    return
    [ServerClient asyncGetNetworkRequestWithURLString:GMProductList(@"10",@"1",UserCenter.storeId,cateId,brandId) parameter:@"" success:^(NSDictionary * _Nonnull responseDict) {
        if ([[responseDict[@"code"] stringValue] isEqualToString:@"200"]) {
            NSMutableArray *dataArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in responseDict[@"data"]) {
                HomePageTypeItem *model = [HomePageTypeItem homePageTypeItemWithDict:dic];
                [dataArray addObject:model];
            }
            if (succeedBlock) {
                succeedBlock(dataArray);
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
