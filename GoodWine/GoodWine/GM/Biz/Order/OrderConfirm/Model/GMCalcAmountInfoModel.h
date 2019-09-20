//
//  GMCalcAmountInfoModel.h
//  GoodWine
//
//  Created by LMK on 2019/9/20.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMCalcAmountInfoModel : NSObject

@property (nonatomic, copy) NSString *totalAmount;
@property (nonatomic, copy) NSString *freightAmount;
@property (nonatomic, copy) NSString *payAmount;

@end

NS_ASSUME_NONNULL_END
