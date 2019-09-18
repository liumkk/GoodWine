//
//  MyCouponItem.m
//  GoodWine
//
//  Created by LMK on 2019/9/18.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "MyCouponItem.h"

@implementation MyCouponItem

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"couponId"     : @"id"
             };
}

@end
