//
//  MyCouponItem.h
//  GoodWine
//
//  Created by LMK on 2019/9/18.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyCouponItem : NSObject

@property (nonatomic, copy) NSString *couponId;
@property (nonatomic, copy) NSString *type; //优惠卷类型；0->全场赠券；1->会员赠券；2->购物赠券；3->注册赠券 
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *platform; //使用平台：0->全部；1->移动；2->PC
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *minPoint; //使用门槛；0表示无门槛
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, copy) NSString *useType; //使用类型：0->全场通用；1->指定分类；2->指定商品
@property (nonatomic, copy) NSString *note;

@end

NS_ASSUME_NONNULL_END
