//
//  UIView+Addtion.h
//  GoodWine
//
//  Created by LMK on 2019/5/30.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Addtion)

+ (instancetype)creatDefaultLineView;
+ (void)maskCorner:(UIView *)view rectCorner:(UIRectCorner)rectCorner corner:(CGFloat)corner;

+ (UIImage *)createPureColorImageWithColor:(UIColor *)color alpha:(CGFloat)alpha size:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
