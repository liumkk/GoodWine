//
//  GMLoadingActivity.m
//  GoodWine
//
//  Created by LMK on 2019/7/13.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMLoadingActivity.h"

@implementation GMLoadingActivity

+ (void)showLoadingActivityInView:(UIView *)superView {
    [MBProgressHUD showHUDAddedTo:superView animated:YES];
}

+ (void)hideLoadingActivityInView:(UIView *)superView {
    [MBProgressHUD hideHUDForView:superView animated:YES];
    [self removeAllHudWithView:[self mainWindow]];
}

+ (void)removeAllHudWithView:(UIView *)view {
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[MBProgressHUD class]]) {
            MBProgressHUD *hud = (MBProgressHUD *)subView;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:NO];
        } else {
            [self removeAllHudWithView:subView];
        }
    }
}

+ (UIWindow *)mainWindow {
    UIApplication *app = [UIApplication sharedApplication];
    if ([app.delegate respondsToSelector:@selector(window)]) {
        return [app.delegate window];
    } else {
        return [app keyWindow];
    }
}

@end
