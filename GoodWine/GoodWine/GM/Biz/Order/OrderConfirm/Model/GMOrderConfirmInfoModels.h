//
//  GMOrderConfirmInfoModels.h
//  GoodWine
//
//  Created by LMK on 2019/9/20.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMOrderConfirmInfoModels : NSObject

@property (nonatomic, strong) NSArray <AddressInfoModel *> *addressArray;
@property (nonatomic, strong) NSArray <MyCouponInfoModel *> *couponHistoryArray;
@property (nonatomic, strong) GMCalcAmountInfoModel *calcAmountModel;

@end

NS_ASSUME_NONNULL_END
