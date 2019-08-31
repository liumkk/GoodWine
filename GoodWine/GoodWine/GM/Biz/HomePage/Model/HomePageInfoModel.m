//
//  HomePageInfoModel.m
//  GoodWine
//
//  Created by LMK on 2019/7/12.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "HomePageInfoModel.h"

@implementation HomePageInfoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
             @"advertiseArray"      : @"advertiseList",
             @"freshProductArray":  @"newProductList",
             @"hotProductArray"     : @"hotProductList",
             @"storeProductArray"   : @"storeProductList"
             };
    
}

+ (instancetype)homePageInfoModelsWithDictionary:(NSDictionary *)dic {
    return [MTLJSONAdapter modelOfClass:[HomePageInfoModel class] fromJSONDictionary:dic error:nil];
}

+ (NSValueTransformer *)advertiseArrayJSONTransformer {

    return [MTLJSONAdapter arrayTransformerWithModelClass:[HomePageInfoDetailItem class]];
}

+ (NSValueTransformer *)freshProductArrayJSONTransformer {
    
    return [MTLJSONAdapter arrayTransformerWithModelClass:[HomePageTypeItem class]];
}

+ (NSValueTransformer *)hotProductArrayJSONTransformer {

    return [MTLJSONAdapter arrayTransformerWithModelClass:[HomePageTypeItem class]];
}

+ (NSValueTransformer *)storeProductArrayJSONTransformer {
    
    return [MTLJSONAdapter arrayTransformerWithModelClass:[HomePageTypeItem class]];
}


@end
