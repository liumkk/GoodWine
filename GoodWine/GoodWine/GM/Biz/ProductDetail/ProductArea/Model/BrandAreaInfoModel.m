//
//  BrandAreaInfoModel.m
//  GoodWine
//
//  Created by LMK on 2019/8/27.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "BrandAreaInfoModel.h"

@implementation BrandAreaInfoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
             @"brandId"      : @"id",
             @"name"         : @"name",
             @"sort"         : @"sort",
             @"logo"         : @"logo"
             };
    
}

+ (instancetype)brandAreaInfoModelWithDictionary:(NSDictionary *)dic {
    return [MTLJSONAdapter modelOfClass:[BrandAreaInfoModel class] fromJSONDictionary:dic error:nil];
}

+ (NSValueTransformer *)brandIdJSONTransformer{
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber * number, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",number];
    }];
}

+ (NSValueTransformer *)sortJSONTransformer{
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber * number, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",number];
    }];
}

@end
