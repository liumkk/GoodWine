//
//  GMStoreInfoModel.m
//  GoodWine
//
//  Created by LMK on 2019/8/9.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMStoreInfoModel.h"

@implementation GMStoreInfoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"storeId"       : @"id",
             @"storeName"     : @"storeName",
             @"regionCode"    : @"regionCode",
             @"contactPerson" : @"contactPerson",
             @"contactPhone"  : @"contactPhone",
             @"province"      : @"province",
             @"city"          : @"city",
             @"district"      : @"district",
             @"address"       : @"address",
             @"platPhone"     : @"platPhone"
             };
    
}

+ (instancetype)storeInfoModelWithDictionary:(NSDictionary *)dic {
    return [MTLJSONAdapter modelOfClass:[GMStoreInfoModel class] fromJSONDictionary:dic error:nil];
}

+ (NSValueTransformer *)storeIdJSONTransformer{
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber * number, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",number];
    }];
}

@end
