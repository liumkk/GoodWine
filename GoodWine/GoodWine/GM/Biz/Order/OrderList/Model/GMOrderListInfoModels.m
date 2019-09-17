//
//  GMOrderListInfoModels.m
//  GoodWine
//
//  Created by LMK on 2019/9/9.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMOrderListInfoModels.h"

@implementation GMOrderListInfoModels

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"orderId"     : @"id",
             @"orderListArray"  : @"orderItemList"
             };
}

// 声明自定义类参数类型
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"orderListArray" : [GMOrderItem class]};
}

@end
