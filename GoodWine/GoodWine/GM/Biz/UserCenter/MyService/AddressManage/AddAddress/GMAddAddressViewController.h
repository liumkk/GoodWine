//
//  GMAddAddressViewController.h
//  GoodWine
//
//  Created by LMK on 2019/8/5.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMBaseViewController.h"

typedef void(^GMAddAddressCallBack)(void);

NS_ASSUME_NONNULL_BEGIN

@interface GMAddAddressViewController : GMBaseViewController

- (void)addAddressCallBack:(GMAddAddressCallBack)callBack;

@end

NS_ASSUME_NONNULL_END
