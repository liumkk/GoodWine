//
//  GMAddressInfoModel.h
//  GoodWine
//
//  Created by LMK on 2019/8/3.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMAddressInfoModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *postCode;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *region;
@property (nonatomic, copy) NSString *detailAddress;

+ (instancetype)addressInfoModelWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
