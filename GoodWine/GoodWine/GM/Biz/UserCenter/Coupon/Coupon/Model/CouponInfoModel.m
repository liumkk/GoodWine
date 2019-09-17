//
//  CouponInfoModel.m
//  GoodWine
//
//  Created by LMK on 2019/8/30.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "CouponInfoModel.h"

@implementation CouponInfoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    NSMutableDictionary *mapping = [[NSDictionary mtl_identityPropertyMapWithModel:self] mutableCopy];
    mapping[@"couponId"] = @"id";
    return mapping;
}

+ (instancetype)couponInfoModelsWithDictionary:(NSDictionary *)dic {
    return [MTLJSONAdapter modelOfClass:[CouponInfoModel class] fromJSONDictionary:dic error:nil];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}

@end
