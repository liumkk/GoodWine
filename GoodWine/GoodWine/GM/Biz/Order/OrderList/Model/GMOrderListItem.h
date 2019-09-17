//
//  GMOrderListItem.h
//  GoodWine
//
//  Created by LMK on 2019/9/9.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMOrderListItem : NSObject

@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *productSkuId;
@property (nonatomic, copy) NSString *productSkuCode;
@property (nonatomic, copy) NSString *orderSn;
@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSString *productPic;
@property (nonatomic, copy) NSString *productName;
@property (nonatomic, copy) NSString *productSn;
@property (nonatomic, copy) NSString *productPrice;
@property (nonatomic, copy) NSString *productQuantity;

@end

NS_ASSUME_NONNULL_END
