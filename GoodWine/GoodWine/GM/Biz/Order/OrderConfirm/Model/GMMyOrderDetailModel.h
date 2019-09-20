//
//  GMMyOrderDetailModel.h
//  GoodWine
//
//  Created by LMK on 2019/8/31.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMMyOrderDetailModel : NSObject

@property (nonatomic, copy) NSString *memberReceiveAddressId;
@property (nonatomic, copy) NSString *expectedTime;
@property (nonatomic, copy) NSString *payType;
@property (nonatomic, copy) NSString *couponId;
@property (nonatomic, copy) NSString *couponName;

@property (nonatomic, assign) NSInteger state; //0为购物车生成订单详情  1位商品详情生成订单详情

@property (nonatomic, strong) NSArray *idsArray;

@property (nonatomic, strong) GMProductDetailModel *productDetailModel;
@property (nonatomic, strong) GMProductSkuItem *productSkuItem;
@property (nonatomic, copy) NSString *quantity;

@end

NS_ASSUME_NONNULL_END
