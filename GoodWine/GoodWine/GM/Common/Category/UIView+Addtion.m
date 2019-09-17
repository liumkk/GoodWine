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

@end
