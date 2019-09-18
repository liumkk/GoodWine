//
//  GMServerAPIManager+ShoppCar.m
//  GoodWine
//
//  Created by LMK on 2019/8/8.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMServerAPIManager+ShoppCar.h"

@implementation GMServerAPIManager (ShoppCar)

- (NSURLSessionDataTask *)asyncQueryShoppCarListWithSucceedBlock:(void (^)(NSArray<ShoppCarInfoModel *> * _Nonnull))succeedBlock
                                                     failedBlock:(void (^)(NSError * _Nonnull))failedBlock {
    
    return
    [ServerClient asyncGetNetworkRequestWithURLString:GMShoppCarList(UserCenter.storeId) parameter:@"" success:^(NSDictionary * _Nonnull responseDict) {
        if ([[responseDict[@"code"] stringValue] isEqualToString:@"200"]) {
            NSMutableArray *dataArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in responseDict[@"data"]) {
                ShoppCarInfoModel *model = [ShoppCarInfoModel shoppCarInfoModelWithDict:dic];
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
    
    [ServerClient setContentTypeJson];
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

- (NSURLSessionDataTask *)asyncModifyProductNumWithShoppId:(NSString *)shoppId
                                                  quantity:(NSString *)quantity
                                              succeedBlock:(void (^)(void))succeedBlock
                                               failedBlock:(void (^)(NSError * _Nonnull))failedBlock {
    
    NSMutableDictionary *temParamDict = [[NSMutableDictionary alloc] init];

    temParamDict[@"id"] = shoppId;
    temParamDict[@"quantity"] = quantity;
    
    return
    [ServerClient asyncNetworkRequestWithURL:GMModifyProductNum(shoppId, quantity) parameter:temParamDict success:^(NSDictionary * _Nonnull responseDict) {
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
