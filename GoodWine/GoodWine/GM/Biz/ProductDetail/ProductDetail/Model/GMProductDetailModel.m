//
//  GMProductDetailModel.m
//  GoodWine
//
//  Created by LMK on 2019/8/17.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMProductDetailModel.h"

@implementation GMProductDetailModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
             @"productId"           : @"id",
             @"productCategoryId"   : @"productCategoryId",
             @"brandId"             : @"brandId",
             @"name"                : @"name",
             @"pic"                 : @"pic",
             @"brandName"           : @"brandName",
             @"sale"                : @"sale",
             @"subTitle"            : @"subTitle",
             @"originalPrice"       : @"originalPrice",
             @"price"               : @"price",
             @"detailDesc"          : @"detailDesc",
             @"albumPics"           : @"albumPics",
             @"skuArray"            : @"skuList",
             @"productSn"           : @"productSn"
             };
    
}

+ (instancetype)productDetailModelWithDictionary:(NSDictionary *)dic {
    return [MTLJSONAdapter modelOfClass:[GMProductDetailModel class] fromJSONDictionary:dic error:nil];
}

+ (NSValueTransformer *)skuArrayJSONTransformer {
    
    return [MTLJSONAdapter arrayTransformerWithModelClass:[GMProductSkuItem class]];
}

+ (NSValueTransformer *)productIdJSONTransformer{
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber * number, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",number];
    }];
}

+ (NSValueTransformer *)productCategoryIdJSONTransformer{
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber * number, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",number];
    }];
}

+ (NSValueTransformer *)originalPriceJSONTransformer{
    
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
