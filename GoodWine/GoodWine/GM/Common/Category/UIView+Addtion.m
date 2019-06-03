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

@end
