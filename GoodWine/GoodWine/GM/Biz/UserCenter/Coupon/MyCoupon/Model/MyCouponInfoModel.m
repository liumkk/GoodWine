//
//  MyCouponInfoModel.m
//  GoodWine
//
//  Created by LMK on 2019/9/18.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "MyCouponInfoModel.h"

@implementation MyCouponInfoModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"myCouponId"  : @"id",
             @"couponItem"  : @"coupon"
             };
}

// 声明自定义类参数类型
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"couponItem" : [MyCouponItem class]};
}

@end
