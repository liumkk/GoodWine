//
//  GMUserCenter.h
//  GoodWine
//
//  Created by LMK on 2019/7/31.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMUserCenterInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

#define UserCenter                [GMUserCenter sharedInstance]

@interface GMUserCenter : NSObject

@property (nonatomic, strong) GMUserCenterInfoModel *userInfoModel;
@property (nonatomic, assign) BOOL isLogin;

@property (nonatomic, copy) NSString *storeId;

+ (instancetype)sharedInstance;

- (void)setIsLogin:(BOOL)isLogin;

@end

NS_ASSUME_NONNULL_END
