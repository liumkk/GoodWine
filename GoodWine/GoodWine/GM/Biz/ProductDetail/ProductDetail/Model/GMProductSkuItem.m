//
//  GMProductSkuItem.m
//  GoodWine
//
//  Created by LMK on 2019/8/17.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMProductSkuItem.h"

@implementation GMProductSkuItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
             @"productSkuId" : @"id",
             @"skuCode"   : @"skuCode",
             @"price"     : @"price",
             @"sp1"       : @"sp1",
             @"pic"       : @"pic"
             };
    
}

+ (NSValueTransformer *)productSkuIdJSONTransformer{
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber * number, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",number];
    }];
}

+ (NSValueTransformer *)priceJSONTransformer{
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber * number, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",number];
    }];
}

@end
