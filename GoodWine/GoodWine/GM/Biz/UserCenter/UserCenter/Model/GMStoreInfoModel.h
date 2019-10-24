//
//  GMStoreInfoModel.h
//  GoodWine
//
//  Created by LMK on 2019/8/9.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMStoreInfoModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *storeId;
@property (nonatomic, copy, readonly) NSString *storeName;
@property (nonatomic, copy, readonly) NSString *regionCode;
@property (nonatomic, copy, readonly) NSString *contactPerson;
@property (nonatomic, copy) NSString *contactPhone;
@property (nonatomic, copy, readonly) NSString *province;
@property (nonatomic, copy, readonly) NSString *city;
@property (nonatomic, copy, readonly) NSString *district;
@property (nonatomic, copy, readonly) NSString *address;
@property (nonatomic, copy) NSString *platPhone;

+ (instancetype)storeInfoModelWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
