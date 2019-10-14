//
//  GMRegisterViewController.h
//  GoodWine
//
//  Created by LMK on 2019/8/22.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^RegisterCallBack)(NSString *name, NSString *pwd);

@interface GMRegisterViewController : GMBaseViewController

@property (nonatomic, copy) RegisterCallBack callBack;

@end

NS_ASSUME_NONNULL_END
