//
//  GMServerAPIManager+HomePage.h
//  GoodWine
//
//  Created by LMK on 2019/7/8.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMServerAPIManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface GMServerAPIManager (HomePage)

- (NSURLSessionDataTask *)asyncQueryHomePageInfoWithSucceedBlock:(void(^)(HomePageInfoModel *infoModel))succeedBlock
                                                     failedBlock:(void(^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
