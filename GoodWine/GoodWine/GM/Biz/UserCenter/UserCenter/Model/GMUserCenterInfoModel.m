//
//  GMUserCenterInfoModel.m
//  GoodWine
//
//  Created by LMK on 2019/7/31.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMUserCenterInfoModel.h"

@implementation GMUserCenterInfoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
             @"memberId" : @"id",
             @"username" : @"username",
             @"nickname" : @"nickname",
             @"password" : @"password",
             @"phone"    : @"phone",
             @"city"     : @"city",
             @"job"      : @"job"
             };
    
}

+ (instancetype)userCenterModelWithDictionary:(NSDictionary *)dic {
    return [MTLJSONAdapter modelOfClass:[GMUserCenterInfoModel class] fromJSONDictionary:dic error:nil];
}

+ (NSValueTransformer *)memberIdJSONTransformer{
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber * number, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",number];
    }];
}

@end
