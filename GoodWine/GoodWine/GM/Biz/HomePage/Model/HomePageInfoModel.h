//
//  HomePageInfoModel.h
//  GoodWine
//
//  Created by LMK on 2019/7/12.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomePageInfoModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSArray<HomePageInfoDetailItem *> *advertiseArray;
@property (nonatomic, copy, readonly) NSArray<HomePageTypeItem *> *freshProductArray;
@property (nonatomic, copy, readonly) NSArray<HomePageTypeItem *> *hotProductArray;
@property (nonatomic, copy, readonly) NSArray<HomePageTypeItem *> *storeProductArray;

+ (instancetype)homePageInfoModelsWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
