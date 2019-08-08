//
//  UIViewController+Additions.h
//  GoodWine
//
//  Created by LMK on 2019/7/13.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Additions)

- (void)showAlertViewWithError:(NSError *)error;

- (void)showAlertViewWithTitle:(NSString *)title Error:(NSError *)error buttonTitle:(NSString *)buttonTitle;

@end

NS_ASSUME_NONNULL_END
