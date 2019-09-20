//
//  GMAddressManagerViewcontroller.h
//  GoodWine
//
//  Created by LMK on 2019/8/3.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectAddressCallBack)(AddressInfoModel *model);

@interface GMAddressManagerViewcontroller : GMBaseViewController

- (void)addressManagerSelectAddressCallBack:(SelectAddressCallBack)callBack;

@end

NS_ASSUME_NONNULL_END
