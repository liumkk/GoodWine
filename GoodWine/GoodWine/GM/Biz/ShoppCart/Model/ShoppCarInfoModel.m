//
//  ShoppCarInfoModel.m
//  GoodWine
//
//  Created by LMK on 2019/8/8.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "ShoppCarInfoModel.h"

@implementation ShoppCarInfoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"shoppCarId"          : @"id",
             @"productSkuId"        : @"productSkuId",
             @"productId"           : @"productId",
             @"productName"         : @"productName",
             @"productSubTitle"     : @"productSubTitle",
             @"productPic"          : @"productPic",
             @"currentPrice"        : @"currentPrice",
             @"quantity"            : @"quantity",
             @"productSkuCode"      : @"productSkuCode",
             @"productId"           : @"productId",
             @"productCategoryId"   : @"productCategoryId",
             @"invalidStatus"       : @"invalidStatus",
             @"createDate"          : @"createDate",
             @"sp1"                 : @"sp1",
             @"productSn"           : @"productSn"
             };
    
}

+ (instancetype)shoppCarInfoModelWithDict:(NSDictionary *)dict {
    return [MTLJSONAdapter modelOfClass:[ShoppCarInfoModel class] fromJSONDictionary:dict error:nil];
}

+ (NSValueTransformer *)shoppCarIdJSONTransformer{
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber * number, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",number];
    }];
}

+ (NSValueTransformer *)productSkuIdJSONTransformer{
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber * number, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",number];
    }];
}

+ (NSValueTransformer *)productIdJSONTransformer{
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber * number, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",number];
    }];
}

+ (NSValueTransformer *)quantityJSONTransformer{
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber * number, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",number];
    }];
}

+ (NSValueTransformer *)currentPriceJSONTransformer{
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber * number, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",number];
    }];
}

+ (NSValueTransformer *)productCategoryIdJSONTransformer{
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber * number, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",number];
    }];
}

+ (NSValueTransformer *)invalidStatusJSONTransformer{
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber * number, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",number];
    }];
}

@end
