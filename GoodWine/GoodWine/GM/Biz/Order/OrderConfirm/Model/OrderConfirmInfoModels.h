//
//  OrderConfirmInfoModels.h
//  GoodWine
//
//  Created by LMK on 2019/8/21.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderConfirmInfoModels : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSArray <GMAddressInfoModel *> *addressArray;
@property (nonatomic, strong) NSArray <MyCouponInfoModel *> *couponHistoryArray;
@property (nonatomic, strong) CalcAmountInfoModel *calcAmountModel;

+ (instancetype)orderConfirmInfoModelsWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
