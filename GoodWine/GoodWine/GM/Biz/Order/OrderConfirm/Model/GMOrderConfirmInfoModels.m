//
//  GMOrderConfirmInfoModels.m
//  GoodWine
//
//  Created by LMK on 2019/9/20.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMOrderConfirmInfoModels.h"

@implementation GMOrderConfirmInfoModels

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"addressArray"        : @"memberReceiveAddressList",
             @"couponHistoryArray"  : @"couponHistoryDetailList",
             @"calcAmountModel"     : @"calcAmount"
             };
}

// 声明自定义类参数类型
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"addressArray"        : [AddressInfoModel class],
             @"couponHistoryArray"  : [MyCouponInfoModel class],
             @"calcAmountModel"     : [GMCalcAmountInfoModel class]
             };
}

@end
