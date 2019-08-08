//
//  GMLoadingActivity.h
//  GoodWine
//
//  Created by LMK on 2019/7/13.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMLoadingActivity : NSObject

+ (void)showLoadingActivityInView:(UIView *)superView;

+ (void)hideLoadingActivityInView:(UIView *)superView;

@end

NS_ASSUME_NONNULL_END
