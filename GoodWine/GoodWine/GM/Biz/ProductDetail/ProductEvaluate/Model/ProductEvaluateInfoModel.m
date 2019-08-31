//
//  ProductEvaluateInfoModel.m
//  GoodWine
//
//  Created by LMK on 2019/8/19.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "ProductEvaluateInfoModel.h"

@implementation ProductEvaluateInfoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
             @"evaluateId"           : @"id",
             @"orderId"              : @"orderId",
             @"memberNickName"       : @"memberNickName",
             @"productStar"          : @"productStar",
             @"createTime"           : @"createTime",
             @"memberIcon"           : @"memberIcon",
             @"anonymous"            : @"anonymous",
             @"deliveryStar"         : @"deliveryStar",
             @"satisfactionStar"     : @"satisfactionStar",
             @"content"              : @"content"
             };
    
}

+ (instancetype)productEvaluateInfoModelWithDictionary:(NSDictionary *)dic {
    return [MTLJSONAdapter modelOfClass:[ProductEvaluateInfoModel class] fromJSONDictionary:dic error:nil];
}

+ (NSValueTransformer *)evaluateIdJSONTransformer{
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber * number, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",number];
    }];
}

+ (NSValueTransformer *)orderIdJSONTransformer{
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber * number, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",number];
    }];
}

+ (NSValueTransformer *)deliveryStarJSONTransformer{
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber * number, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",number];
    }];
}

+ (NSValueTransformer *)satisfactionStarJSONTransformer{
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber * number, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",number];
    }];
}

+ (NSValueTransformer *)anonymousJSONTransformer{
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber * number, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",number];
    }];
}

@end
