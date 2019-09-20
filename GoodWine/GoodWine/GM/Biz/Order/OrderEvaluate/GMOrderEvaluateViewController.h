//
//  GMOrderEvaluateViewController.h
//  GoodWine
//
//  Created by LMK on 2019/9/19.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^OrderEvaluateCallBack)(void);

@interface GMOrderEvaluateViewController : GMBaseViewController

- (instancetype)initWithModel:(GMOrderItem *)model;

- (void)orderEvaluateCallBack:(OrderEvaluateCallBack)callBack;

@end

NS_ASSUME_NONNULL_END
