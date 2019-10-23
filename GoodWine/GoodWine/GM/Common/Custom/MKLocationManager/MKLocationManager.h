//
//  MKLocationManager.h
//  GoodWine
//
//  Created by LMK on 2019/8/8.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN
#define LocationManager        [MKLocationManager sharedInstance]

@interface MKLocationManager : NSObject

+ (instancetype)sharedInstance;

- (void)openLocationFunctionCallBack:(void(^)(void))callBack authority:(nonnull void (^)(void))authority;
- (void)openLocationFunctionSucceed:(void(^)(void))succeed failed:(void(^)(void))failed authority:(void(^)(void))authority;

- (BOOL)determineWhetherTheAPPOpensTheLocation;

@end

NS_ASSUME_NONNULL_END
