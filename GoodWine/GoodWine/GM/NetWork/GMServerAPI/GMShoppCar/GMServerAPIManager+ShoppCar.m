//
//  GMServerAPIManager+ShoppCar.m
//  GoodWine
//
//  Created by LMK on 2019/8/8.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMServerAPIManager+ShoppCar.h"

@implementation GMServerAPIManager (ShoppCar)

- (NSURLSessionDataTask *)asyncQueryShoppCarListWithSucceedBlock:(void (^)(NSArray * _Nonnull))succeedBlock
                                                     failedBlock:(void (^)(NSError * _Nonnull))failedBlock {
    
    return
    [ServerClient asyncGetNetworkRequestWithURLString:GMShoppCarList parameter:@"" success:^(NSDictionary * _Nonnull responseDict) {
        if ([[responseDict[@"code"] stringValue] isEqualToString:@"200"]) {
            NSMutableArray *dataArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in responseDict[@"data"]) {
                GMAddressInfoModel *model = [GMAddressInfoModel addressInfoModelWithDictionary:dic];
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
