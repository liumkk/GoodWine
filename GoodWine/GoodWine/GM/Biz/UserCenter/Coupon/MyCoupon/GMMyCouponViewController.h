//
//  GMMyCouponViewController.h
//  GoodWine
//
//  Created by LMK on 2019/9/16.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^MyCouponCallBack)(MyCouponInfoModel *model);

@interface GMMyCouponViewController : GMBaseViewController

- (instancetype)initWithArray:(NSArray <MyCouponInfoModel *> *)array;

- (void)myCouponCallBack:(MyCouponCallBack)callBack;

@end

NS_ASSUME_NONNULL_END
