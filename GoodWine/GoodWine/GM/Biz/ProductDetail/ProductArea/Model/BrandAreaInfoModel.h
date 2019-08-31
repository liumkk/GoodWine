//
//  BrandAreaInfoModel.h
//  GoodWine
//
//  Created by LMK on 2019/8/27.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface BrandAreaInfoModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *brandId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSString *logo;

+ (instancetype)brandAreaInfoModelWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
