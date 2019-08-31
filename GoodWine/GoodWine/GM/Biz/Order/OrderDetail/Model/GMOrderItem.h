//
//  GMOrderItem.h
//  GoodWine
//
//  Created by LMK on 2019/8/31.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMOrderItem : NSObject

@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *productSkuId;
@property (nonatomic, copy) NSString *productSkuCode;
@property (nonatomic, copy) NSString *orderSn;
@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSString *productPic;
@property (nonatomic, copy) NSString *productName;
@property (nonatomic, copy) NSString *productBrand;
@property (nonatomic, copy) NSString *productSn;
@property (nonatomic, copy) NSString *productPrice;
@property (nonatomic, copy) NSString *productQuantity;
@property (nonatomic, copy) NSString *productCategoryId;
@property (nonatomic, copy) NSString *couponAmount;
@property (nonatomic, copy) NSString *realAmount;

@end

NS_ASSUME_NONNULL_END
