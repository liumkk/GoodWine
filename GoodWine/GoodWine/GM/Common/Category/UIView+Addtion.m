//
//  UIView+Addtion.m
//  GoodWine
//
//  Created by LMK on 2019/5/30.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "UIView+Addtion.h"

@implementation UIView (Addtion)

+ (instancetype)creatDefaultLineView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = COLOR_LINE_COLOR;
    return view;
}

+ (void)maskCorner:(UIView *)view rectCorner:(UIRectCorner)rectCorner corner:(CGFloat)corner {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(corner, corner)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

+ (UIImage *)createPureColorImageWithColor:(UIColor *)color alpha:(CGFloat)alpha size:(CGSize)size {
    // 纯色的UIView
    UIView *pureColorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    pureColorView.backgroundColor = color;
    pureColorView.alpha = alpha;
    
    // 由上下文获取UIImage
    UIGraphicsBeginImageContext(size);
    [pureColorView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *pureColorImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return pureColorImage;
}

@end
