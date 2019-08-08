//
//  ShoppCarInfoModel.h
//  GoodWine
//
//  Created by LMK on 2019/8/8.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShoppCarInfoModel : MTLModel

@property (nonatomic, copy) NSString *productName;
@property (nonatomic, copy) NSString *productSubTitle;
@property (nonatomic, copy) NSString *currentPrice;

@end

NS_ASSUME_NONNULL_END
