//
//  CouponInfoModel.h
//  GoodWine
//
//  Created by LMK on 2019/8/30.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface CouponInfoModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, assign) NSInteger couponId;
@property (nonatomic, assign) NSInteger type; //优惠卷类型；0->全场赠券；1->会员赠券；2->购物赠券；3->注册赠券
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger platform; //使用平台：0->全部；1->移动；2->PC
@property (nonatomic, assign) NSInteger amount; //金额
@property (nonatomic, assign) NSInteger perLimit; //每人限领张数
@property (nonatomic, assign) NSInteger minPoint; //使用门槛；0表示无门槛 ,
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, assign) NSInteger useType; //0->全场通用；1->指定分类；2->指定商品
@property (nonatomic, copy) NSString *note; //备注
@property (nonatomic, assign) NSInteger publishCount; //发行数量
@property (nonatomic, assign) NSInteger useCount; //已使用数量
@property (nonatomic, assign) NSInteger receiveCount; //领取数量
@property (nonatomic, copy) NSString *enableTime; //可以领取的日期
@property (nonatomic, copy) NSString *code; //优惠码
@property (nonatomic, assign) NSInteger receive; //是否领取 0未领取 1已领取


+ (instancetype)couponInfoModelsWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
