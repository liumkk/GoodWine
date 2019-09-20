//
//  AddressInfoModel.h
//  GoodWine
//
//  Created by LMK on 2019/9/20.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddressInfoModel : NSObject

@property (nonatomic, copy) NSString *addressId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *postCode;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *region;
@property (nonatomic, copy) NSString *detailAddress;

@end

NS_ASSUME_NONNULL_END
