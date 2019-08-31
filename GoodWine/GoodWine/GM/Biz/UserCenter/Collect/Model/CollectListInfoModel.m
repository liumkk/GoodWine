//
//  CollectListInfoModel.m
//  GoodWine
//
//  Created by LMK on 2019/8/30.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "CollectListInfoModel.h"

@implementation CollectListInfoModel 

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
             @"collectProductArray"  : @"collectProductList",
             @"collectArray"         : @"collectList"
             };
    
}

+ (instancetype)collectListInfoModelWithDictionary:(NSDictionary *)dic {
    return [MTLJSONAdapter modelOfClass:[CollectListInfoModel class] fromJSONDictionary:dic error:nil];
}

+ (NSValueTransformer *)collectProductArrayJSONTransformer {
    
    return [MTLJSONAdapter arrayTransformerWithModelClass:[CollectProductItem class]];
}

+ (NSValueTransformer *)collectArrayJSONTransformer {
    
    return [MTLJSONAdapter arrayTransformerWithModelClass:[CollectItem class]];
}

@end
