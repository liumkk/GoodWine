//
//  GMOrderDetailViewController.h
//  GoodWine
//
//  Created by LMK on 2019/8/31.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMOrderDetailViewController : GMBaseViewController

- (instancetype)initWithModel:(GMMyOrderDetailModel *)model;

- (instancetype)initWithOrderModel:(GMOrderDetailInfoModel *)orderModel;

@property (nonatomic, copy) void(^OrderDetailVCCallBack)(void);

@end

NS_ASSUME_NONNULL_END
