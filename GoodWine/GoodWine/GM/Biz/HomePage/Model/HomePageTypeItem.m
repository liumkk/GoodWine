//
//  HomePageTypeItem.m
//  GoodWine
//
//  Created by LMK on 2019/7/22.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "HomePageTypeItem.h"

@implementation HomePageTypeItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
             @"brandId"         : @"brandId",
             @"name"            : @"name",
             @"pic"             : @"pic",
             @"brandName"       : @"brandName",
             @"sale"            : @"sale",
             @"subTitle"        : @"subTitle",
             @"originalPrice"   : @"originalPrice",
             @"price"           : @"price",
             @"promotionPrice"  : @"promotionPrice",
             @"publishStatus"   : @"publishStatus",
             @"recommandStatus" : @"recommandStatus",
             @"verifyStatus"    : @"verifyStatus"
             };
    
}

+ (instancetype)homePageTypeItemWithDict:(NSDictionary *)dict {
    return [MTLJSONAdapter modelOfClass:[HomePageTypeItem class] fromJSONDictionary:dict error:nil];
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

+ (NSValueTransformer *)promotionPriceJSONTransformer{
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber * number, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",number];
    }];
}

@end
