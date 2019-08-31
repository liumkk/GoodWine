//
//  GMOrderDetailInfoModel.h
//  GoodWine
//
//  Created by LMK on 2019/8/31.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMOrderDetailInfoModel : NSObject

@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *orderSn;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *totalAmount;
@property (nonatomic, copy) NSString *payAmount;
@property (nonatomic, copy) NSString *couponAmount;
@property (nonatomic, copy) NSString *discountAmount;
@property (nonatomic, copy) NSString *payType; //支付方式：0->未支付；1->支付宝；2->微信 ,
@property (nonatomic, copy) NSString *sourceType; //订单来源：0->PC订单；1->app订单
@property (nonatomic, copy) NSString *status; //订单状态：0->待付款；1->待发货；2->已发货；3->已完成；4->已关闭；5->无效订单
@property (nonatomic, copy) NSString *receiverName;
@property (nonatomic, copy) NSString *receiverPhone;
@property (nonatomic, copy) NSString *receiverPostCode;
@property (nonatomic, copy) NSString *receiverProvince;
@property (nonatomic, copy) NSString *receiverCity;
@property (nonatomic, copy) NSString *receiverRegion;
@property (nonatomic, copy) NSString *receiverDetailAddress;
@property (nonatomic, copy) NSString *confirmStatus;
@property (nonatomic, copy) NSString *deleteStatus;
@property (nonatomic, strong) NSArray <GMOrderItem *>*orderArray;


@end

NS_ASSUME_NONNULL_END
