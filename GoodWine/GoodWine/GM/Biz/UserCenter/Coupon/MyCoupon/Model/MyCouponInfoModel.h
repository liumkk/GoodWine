//
//  MyCouponInfoModel.h
//  GoodWine
//
//  Created by LMK on 2019/9/18.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyCouponInfoModel : NSObject

@property (nonatomic, copy) NSString *myCouponId;
@property (nonatomic, copy) NSString *couponId;
@property (nonatomic, copy) NSString *memberId;
@property (nonatomic, copy) NSString *couponCode;
@property (nonatomic, copy) NSString *memberNickname;
@property (nonatomic, copy) NSString *getType; //获取类型：0->后台赠送；1->主动获取 
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *useStatus; //使用状态：0->未使用；1->已使用；2->已过期

@property (nonatomic, strong) MyCouponItem *couponItem;

@end

NS_ASSUME_NONNULL_END
