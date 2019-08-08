//
//  GMDataManager.h
//  GoodWine
//
//  Created by LMK on 2019/8/3.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
#define     Cookie_Key            @"JSESSIONID"
#define     DataManager       [GMDataManager shared]

@interface GMDataManager : NSObject

+ (instancetype)shared;

- (void)saveCookie;
- (NSString *)getCookie;
- (void)removeCookie;
@end

NS_ASSUME_NONNULL_END
