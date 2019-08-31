//
//  ProductInfoModel.m
//  GoodWine
//
//  Created by LMK on 2019/8/31.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "ProductInfoModel.h"

@implementation ProductInfoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
             @"productDetailModel"  : @"productDetail",
             @"collectionFlag"      : @"collectionFlag"
             };
    
}

+ (instancetype)productInfoModelWithDictionary:(NSDictionary *)dic {
    return [MTLJSONAdapter modelOfClass:[ProductInfoModel class] fromJSONDictionary:dic error:nil];
}

//+ (NSValueTransformer *)productDetailModelJSONTransformer {
//
//    return [MTLJSONAdapter arrayTransformerWithModelClass:[GMProductDetailModel class]];
//}

@end
