//
//  ClacAmountInfoModel.m
//  GoodWine
//
//  Created by LMK on 2019/8/21.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "CalcAmountInfoModel.h"

@implementation CalcAmountInfoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
             @"totalAmount"     : @"totalAmount",
             @"freightAmount"   : @"freightAmount",
             @"payAmount"       : @"payAmount"
             };
    
}

+ (NSValueTransformer *)totalAmountJSONTransformer{
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber * number, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",number];
    }];
}

+ (NSValueTransformer *)freightAmountJSONTransformer{
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber * number, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",number];
    }];
}

+ (NSValueTransformer *)payAmountJSONTransformer{
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber * number, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",number];
    }];
}

@end
