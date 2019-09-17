//
//  GMServerAPIManager+HomePage.m
//  GoodWine
//
//  Created by LMK on 2019/7/8.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMServerAPIManager+HomePage.h"

@implementation GMServerAPIManager (HomePage)

- (NSURLSessionDataTask *)asyncQueryHomePageInfoWithStoreId:(NSString *)storeId
                                               SucceedBlock:(void (^)(HomePageInfoModel *infoModel))succeedBlock
                                                failedBlock:(void (^)(NSError * _Nonnull))failedBlock {
    return
    [ServerClient asyncGetNetworkRequestWithURLString:GMHomePageInfo(storeId) parameter:@"" success:^(NSDictionary * _Nonnull responseDict) {
        if ([[responseDict[@"code"] stringValue] isEqualToString:@"200"]) {
            HomePageInfoModel *infomodel = [HomePageInfoModel homePageInfoModelsWithDictionary:responseDict[@"data"]];
            if (succeedBlock) {
                succeedBlock(infomodel);
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

- (NSURLSessionDataTask *)asyncQueryStoreInfoWithRegionCode:(NSString *)regionCode
                                               succeedBlock:(void (^)(GMStoreInfoModel *infoModel))succeedBlock
                                                failedBlock:(void (^)(NSError * _Nonnull))failedBlock {
    
    if (!regionCode) {
        if (failedBlock) {
            failedBlock([GMNetworkError getParamError]);
        }
        return nil;
    }
    return
    [ServerClient asyncGetNetworkRequestWithURLString:GMGetStoreInfo(regionCode) parameter:@"" success:^(NSDictionary * _Nonnull responseDict) {
        if ([[responseDict[@"code"] stringValue] isEqualToString:@"200"]) {
            GMStoreInfoModel *infomodel = [GMStoreInfoModel storeInfoModelWithDictionary:responseDict[@"data"]];
            if (succeedBlock) {
                succeedBlock(infomodel);
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

//--test 获取商品分类 暂时不用先注释
//- (NSURLSessionDataTask *)asyncQueryProductClassWithSucceedBlock:(void (^)(NSArray<ShoppCarInfoModel *> * _Nonnull))succeedBlock
//                                                     failedBlock:(void (^)(NSError * _Nonnull))failedBlock {
//    
//    return
//    [ServerClient asyncGetNetworkRequestWithURLString:GMOrderClassify parameter:@"" success:^(NSDictionary * _Nonnull responseDict) {
//        if ([[responseDict[@"code"] stringValue] isEqualToString:@"200"]) {
//            NSMutableArray *dataArray = [[NSMutableArray alloc] init];
//            for (NSDictionary *dic in responseDict[@"data"]) {
//                ShoppCarInfoModel *model = [ShoppCarInfoModel shoppCarInfoModelWithDict:dic];
//                [dataArray addObject:model];
//            }
//            if (succeedBlock) {
//                succeedBlock(dataArray);
//            }
//            
//        }else {
//            
//            if (failedBlock) {
//                failedBlock([GMNetworkError getBizWithMessage:responseDict[GM_Net_Key_ErrInfo]]);
//            }
//            
//        }
//    } failure:^(NSError *error) {
//        if (failedBlock) {
//            failedBlock(error);
//        }
//    }];
//}

- (NSURLSessionDataTask *)asyncQueryCouponSucceedBlock:(void (^)(NSArray <CouponInfoModel *> * _Nonnull))succeedBlock
                                           failedBlock:(void (^)(NSError * _Nonnull))failedBlock {
    
    NSMutableDictionary *temParamDict = [[NSMutableDictionary alloc] init];
    
    temParamDict[@"storeId"] = UserCenter.storeId;
    
    return
    [ServerClient asyncGetNetworkRequestWithURLString:GMHomeCoupon(UserCenter.storeId) parameter:@"" success:^(NSDictionary * _Nonnull responseDict) {
        if ([[responseDict[@"code"] stringValue] isEqualToString:@"200"]) {
            NSMutableArray *dataArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in responseDict[@"data"]) {
                CouponInfoModel *model = [CouponInfoModel couponInfoModelsWithDictionary:dic];
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

- (NSURLSessionDataTask *)asyncQueryMyCouponPageNum:(NSString *)pageNum
                                           pageSize:(NSString *)pageSize
                                       SucceedBlock:(void (^)(NSArray <CouponInfoModel *> * _Nonnull))succeedBlock
                                        failedBlock:(void (^)(NSError * _Nonnull))failedBlock {
    
    NSMutableDictionary *temParamDict = [[NSMutableDictionary alloc] init];
    
    temParamDict[@"storeId"] = UserCenter.storeId;
    temParamDict[@"pageSize"] = pageSize;
    temParamDict[@"pageNum"] = pageNum;
    temParamDict[@"useStatus"] = @"0";
    
    return
    [ServerClient asyncGetNetworkRequestWithURLString:GMQueryMyCoupon(pageSize, pageNum, UserCenter.storeId) parameter:temParamDict success:^(NSDictionary * _Nonnull responseDict) {
        if ([[responseDict[@"code"] stringValue] isEqualToString:@"200"]) {
            NSMutableArray *dataArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in responseDict[@"data"]) {
                CouponInfoModel *model = [CouponInfoModel couponInfoModelsWithDictionary:dic];
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

- (NSURLSessionDataTask *)asyncGetCouponWithCouponId:(NSInteger)couponId
                                        succeedBlock:(void (^)(void))succeedBlock
                                         failedBlock:(void (^)(NSError * _Nonnull))failedBlock {
    NSMutableDictionary *temParamDict = [[NSMutableDictionary alloc] init];
    
    temParamDict[@"couponId"] = [NSString stringWithFormat:@"%ld",couponId];
    return
    [ServerClient asyncNetworkRequestWithURL:GMGetCoupon(couponId) parameter:temParamDict success:^(NSDictionary * _Nonnull responseDict) {
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
