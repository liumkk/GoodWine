//
//  GMOrderDetailInfoModel.m
//  GoodWine
//
//  Created by LMK on 2019/8/31.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMOrderDetailInfoModel.h"

@implementation GMOrderDetailInfoModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"orderId"     : @"id",
             @"orderArray"  : @"orderItemList"
             };
}

// 声明自定义类参数类型
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"orderArray" : [GMOrderItem class]};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _receiverRegion = dic[@"receiverRegion"];
    _receiverRegion = _receiverRegion == nil ? @"" : _receiverRegion;
    return YES;
}

@end
