//
//  AddressInfoModel.m
//  GoodWine
//
//  Created by LMK on 2019/9/20.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "AddressInfoModel.h"

@implementation AddressInfoModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"addressId"  : @"id"};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _region = dic[@"region"];
    _region = _region == nil ? @"" : _region;
    return YES;
}

@end
