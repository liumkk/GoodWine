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

- (void)showAlertViewWithTitle:(NSString *)title;

- (void)showAlertViewWithError:(NSError *)error;

- (void)showAlertViewWithTitle:(NSString *)title Error:(NSError *)error buttonTitle:(NSString *)buttonTitle;

- (void)showAlertViewWithTitle:(NSString *)title btnNames:(NSArray *)btnNames clickedCallBack:(void (^)(NSInteger index))callback;

- (void)showAlertViewInDynamicWithTitle:(NSString *)title message:(NSString *)message btnNames:(NSArray *)btnNames clickedCallBack:(void (^)(NSInteger index))callback;

- (void)showActionSheetWithButtonText:(NSString *)sheetText actionSheetStyle:(UIAlertActionStyle)actionSheetStyle handler:(void (^)(UIAlertAction *))handler;

@end

NS_ASSUME_NONNULL_END
