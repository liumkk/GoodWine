//
//  GMAddressInfoModel.m
//  GoodWine
//
//  Created by LMK on 2019/8/3.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMAddressInfoModel.h"

@implementation GMAddressInfoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
             @"name"          : @"name",
             @"phoneNumber"   : @"phoneNumber",
             @"postCode"      : @"postCode",
             @"province"      : @"province",
             @"city"          : @"city",
             @"region"        : @"region",
             @"detailAddress" : @"detailAddress"
             };
    
}

+ (instancetype)addressInfoModelWithDictionary:(NSDictionary *)dic {
    return [MTLJSONAdapter modelOfClass:[GMAddressInfoModel class] fromJSONDictionary:dic error:nil];
}

@end
