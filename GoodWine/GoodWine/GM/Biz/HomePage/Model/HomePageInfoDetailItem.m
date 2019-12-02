//
//  HomePageInfoDetailItem.m
//  GoodWine
//
//  Created by LMK on 2019/7/12.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "HomePageInfoDetailItem.h"

@implementation HomePageInfoDetailItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{@"productId"   : @"id",
             @"picUrl"      : @"pic"
             };
    
}

+ (instancetype)homePageInfoDetailItemWithDict:(NSDictionary *)dict {
    return [MTLJSONAdapter modelOfClass:[HomePageInfoDetailItem class] fromJSONDictionary:dict error:nil];
}

+ (NSValueTransformer *)productIdJSONTransformer{
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber * number, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",number];
    }];
}

@end
