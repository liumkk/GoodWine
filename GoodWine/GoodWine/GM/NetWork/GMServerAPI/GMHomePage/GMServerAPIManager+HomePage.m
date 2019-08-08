//
//  GMServerAPIManager+HomePage.m
//  GoodWine
//
//  Created by LMK on 2019/7/8.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMServerAPIManager+HomePage.h"

@implementation GMServerAPIManager (HomePage)

- (NSURLSessionDataTask *)asyncQueryHomePageInfoWithSucceedBlock:(void (^)(HomePageInfoModel *infoModel))succeedBlock
                                                     failedBlock:(void (^)(NSError * _Nonnull))failedBlock {
    return
    [ServerClient asyncGetNetworkRequestWithURLString:GMHomePageInfo parameter:@"" success:^(NSDictionary * _Nonnull responseDict) {
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

@end
