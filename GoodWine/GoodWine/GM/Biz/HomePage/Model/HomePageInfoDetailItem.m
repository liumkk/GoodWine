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
    
    return @{
             @"picUrl"      : @"pic"
             };
    
}

+ (instancetype)homePageInfoDetailItemWithDict:(NSDictionary *)dict {
    return [MTLJSONAdapter modelOfClass:[HomePageInfoDetailItem class] fromJSONDictionary:dict error:nil];
}

@end
