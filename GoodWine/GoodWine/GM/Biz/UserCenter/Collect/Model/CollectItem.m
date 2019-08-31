//
//  CollectItem.m
//  GoodWine
//
//  Created by LMK on 2019/8/30.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "CollectItem.h"

@implementation CollectItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    NSMutableDictionary *mapping = [[NSDictionary mtl_identityPropertyMapWithModel:self] mutableCopy];
    mapping[@"collectId"] = @"id";
    return mapping;
}

@end
