//
//  GMServerAPIManager+GMMyCenter.m
//  GoodWine
//
//  Created by LMK on 2019/8/3.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMServerAPIManager+GMMyCenter.h"

@implementation GMServerAPIManager (GMMyCenter)

- (NSURLSessionDataTask *)asyncQueryAddressWithPageSize:(NSString *)pageSize
                                                pageNum:(NSString *)pageNum
                                           succeedBlock:(void (^)(NSArray * _Nonnull))succeedBlock
                                            failedBlock:(void (^)(NSError * _Nonnull))failedBlock {
    
    return
    [ServerClient asyncGetNetworkRequestWithURLString:GMAllAddress(pageSize, pageNum, UserCenter.storeId) parameter:@"" success:^(NSDictionary * _Nonnull responseDict) {
        if ([[responseDict[@"code"] stringValue] isEqualToString:@"200"]) {
            NSMutableArray *dataArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in responseDict[@"data"]) {
                AddressInfoModel *model = [AddressInfoModel yy_modelWithDictionary:dic];
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

- (NSURLSessionDataTask *)asyncAddAddressWithName:(NSString *)name
                                         phoneNum:(NSString *)phoneNum
                                          address:(NSString *)address
                                    detailAddress:(NSString *)detailAddress
                                     succeedBlock:(void (^)(void))succeedBlock
                                      failedBlock:(void (^)(NSError * _Nonnull))failedBlock {
    if (IsStrEmpty(name) ||
        IsStrEmpty(phoneNum) ||
        IsStrEmpty(address) ||
        IsStrEmpty(detailAddress)) {
        if (failedBlock) {
            failedBlock([GMNetworkError getParamError]);
        }
        return nil;
    }
    
    NSMutableDictionary *temParamDict = [[NSMutableDictionary alloc] init];
    temParamDict[@"storeId"] = UserCenter.storeId;
    temParamDict[@"memberId"] = UserCenter.userInfoModel.memberId;
    temParamDict[@"name"] = name;
    temParamDict[@"phoneNumber"] = phoneNum;
    temParamDict[@"city"] = address;
    temParamDict[@"detailAddress"] = detailAddress;
    [ServerClient setContentTypeJson];
    return
    [ServerClient asyncNetworkRequestWithURL:GMAddAddress parameter:temParamDict success:^(NSDictionary *responseDict) {
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

- (NSURLSessionDataTask *)asyncDeleteAddressWithAddressId:(NSString *)addressId
                                             succeedBlock:(void (^)(void))succeedBlock
                                              failedBlock:(void (^)(NSError * _Nonnull))failedBlock {
    return
    [ServerClient asyncNetworkRequestWithURL:GMDeleteAddress(addressId) parameter:nil success:^(NSDictionary * _Nonnull responseDict) {
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

- (NSURLSessionDataTask *)asyncGetCollectListWithPageSize:(NSString *)pageSize
                                                  pageNum:(NSString *)pageNum
                                             SucceedBlock:(void (^)(CollectListInfoModel * _Nonnull))succeedBlock
                                              failedBlock:(void (^)(NSError * _Nonnull))failedBlock {
    
    return
    [ServerClient asyncGetNetworkRequestWithURLString:GMGetCollectList(pageSize, pageNum, UserCenter.storeId) parameter:@"" success:^(NSDictionary * _Nonnull responseDict) {
        if ([[responseDict[@"code"] stringValue] isEqualToString:@"200"]) {
            CollectListInfoModel *model = [CollectListInfoModel collectListInfoModelWithDictionary:responseDict[@"data"]];
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

- (NSURLSessionDataTask *)asyncDeleteCollectWithProductId:(NSString *)productId
                                             succeedBlock:(void (^)(void))succeedBlock
                                              failedBlock:(void (^)(NSError * _Nonnull))failedBlock {
    
    NSMutableDictionary *temParamDict = [[NSMutableDictionary alloc] init];
    temParamDict[@"productId"] = productId;
    return
    [ServerClient asyncNetworkRequestWithURL:GMDeleteCollect(productId) parameter:temParamDict success:^(NSDictionary * _Nonnull responseDict) {
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

- (NSURLSessionDataTask *)asyncCollectProductWithModel:(GMProductDetailModel *)model
                                          succeedBlock:(void (^)(void))succeedBlock
                                           failedBlock:(void (^)(NSError * _Nonnull))failedBlock {
    
    if (!model) {
        if (failedBlock) {
            failedBlock([GMNetworkError getParamError]);
        }
        return nil;
    }
    
    NSMutableDictionary *temParamDict = [[NSMutableDictionary alloc] init];
    temParamDict[@"deleteStatus"] = @"0";
    temParamDict[@"createTime"] = [NSString getCurrentTime];
    
    temParamDict[@"memberId"] = UserCenter.userInfoModel.memberId;
    temParamDict[@"memberIcon"] = UserCenter.userInfoModel.icon;
    temParamDict[@"memberNickname"] = UserCenter.userInfoModel.nickname;
    temParamDict[@"productId"] = model.productId;
    temParamDict[@"productName"] = model.name;
    temParamDict[@"productPic"] = model.pic;
    temParamDict[@"productPrice"] = model.price;
    temParamDict[@"productSubTitle"] = model.subTitle;
    
    [ServerClient setContentTypeJson];
    return
    [ServerClient asyncNetworkRequestWithURL:GMCollectProduct parameter:temParamDict success:^(NSDictionary *responseDict) {
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
