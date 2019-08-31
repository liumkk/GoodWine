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
             @"addressId"     : @"id",
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

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self) {
        for (NSString *key in dictionaryValue) {
            __autoreleasing id value = [dictionaryValue objectForKey:key];
            if ([value isEqual:NSNull.null]){
                value = @"";
            }
        }
    }
    return self;
}

+ (NSValueTransformer *)addressIdJSONTransformer{
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber * number, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",number];
    }];
}

@end
