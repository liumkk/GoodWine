//
//  CollectProductItem.m
//  GoodWine
//
//  Created by LMK on 2019/8/30.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "CollectProductItem.h"

@implementation CollectProductItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    NSMutableDictionary *mapping = [[NSDictionary mtl_identityPropertyMapWithModel:self] mutableCopy];
    mapping[@"productId"] = @"id";
    return mapping;
}

+ (NSValueTransformer *)productIdJSONTransformer{
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber * number, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",number];
    }];
}

@end
