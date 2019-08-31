//
//  MKToastView.h
//  GoodWine
//
//  Created by LMK on 2019/8/6.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKToastView : NSObject

+ (void)showToastToView:(UIView *)view text:(NSString *)text time:(NSTimeInterval)time;

+ (void)showToastToView:(UIView *)view text:(NSString *)text;

+ (void)showToastToView:(UIView *)view text:(NSString *)text time:(NSTimeInterval)time completion:(void(^)(void))completion;

@end

NS_ASSUME_NONNULL_END
