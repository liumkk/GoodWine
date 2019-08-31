//
//  ClacAmountInfoModel.h
//  GoodWine
//
//  Created by LMK on 2019/8/21.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface CalcAmountInfoModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *totalAmount;
@property (nonatomic, copy) NSString *freightAmount;
@property (nonatomic, copy) NSString *payAmount;

@end

NS_ASSUME_NONNULL_END
