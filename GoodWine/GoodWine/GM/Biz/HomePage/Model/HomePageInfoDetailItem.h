//
//  HomePageInfoDetailItem.h
//  GoodWine
//
//  Created by LMK on 2019/7/12.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomePageInfoDetailItem : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *picUrl;

+ (instancetype)homePageInfoDetailItemWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
