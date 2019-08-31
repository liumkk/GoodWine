//
//  OrderConfirmInfoModels.m
//  GoodWine
//
//  Created by LMK on 2019/8/21.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "OrderConfirmInfoModels.h"

@implementation OrderConfirmInfoModels

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
             @"addressArray"        : @"memberReceiveAddressList",
             @"couponHistoryArray"  : @"couponHistoryDetailList",
             @"calcAmountModel"     : @"calcAmount"
             };
    
}

+ (instancetype)orderConfirmInfoModelsWithDictionary:(NSDictionary *)dic {
    return [MTLJSONAdapter modelOfClass:[OrderConfirmInfoModels class] fromJSONDictionary:dic error:nil];
}

+ (NSValueTransformer *)addressArrayJSONTransformer {
    
    return [MTLJSONAdapter arrayTransformerWithModelClass:[GMAddressInfoModel class]];
}

+ (NSValueTransformer *)couponHistoryArrayJSONTransformer {
    
    return [MTLJSONAdapter arrayTransformerWithModelClass:[CouponHistoryInfoModel class]];
}

+ (NSValueTransformer *)calcAmountModelJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[CalcAmountInfoModel class]];
}

@end
