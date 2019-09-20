//
//  UIViewController+Additions.m
//  GoodWine
//
//  Created by LMK on 2019/7/13.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "UIViewController+Additions.h"

@implementation UIViewController (Additions)

- (void)showAlertViewWithTitle:(NSString *)title {
    
    UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:title preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertViewController addAction:cancelAction];
    
    [self presentViewController:alertViewController animated:YES completion:nil];
}

- (void)showAlertViewWithError:(NSError *)error {
    NSString *errorStr = error.userInfo[GM_Net_Key_ErrInfo];
    
    if (errorStr.length > 0) {
        UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:error.userInfo[GM_Net_Key_ErrInfo] preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertViewController addAction:cancelAction];
        
        [self presentViewController:alertViewController animated:YES completion:nil];
    }
}

- (void)showAlertViewWithTitle:(NSString *)title Error:(NSError *)error buttonTitle:(NSString *)buttonTitle {
    
    NSString *errorStr = error.userInfo[GM_Net_Key_ErrInfo];
    
    if (title.length > 0 || errorStr.length > 0) {
        UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:title message:error.userInfo[GM_Net_Key_ErrInfo] preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleCancel handler:nil];
        [alertViewController addAction:cancelAction];
        
        [self presentViewController:alertViewController animated:YES completion:nil];
    }
    
}

- (void)showAlertViewWithTitle:(NSString *)title btnNames:(NSArray *)btnNames clickedCallBack:(void (^)(NSInteger))callback {
    [self showAlertViewInDynamicWithTitle:title message:@"" btnNames:btnNames clickedCallBack:callback];
}

- (void)showAlertViewInDynamicWithTitle:(NSString *)title message:(NSString *)message btnNames:(NSArray *)btnNames clickedCallBack:(void (^)(NSInteger index))callback {
    
    UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    for (NSString* name  in btnNames)
    {
        NSInteger index = [btnNames indexOfObject:name];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:name style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (callback) {
                callback(index);
            }
        }];
        
        [alertViewController addAction:action];
    }
    
    [self presentViewController:alertViewController animated:YES completion:nil];
    
}

- (void)showActionSheetWithButtonText:(NSString *)sheetText actionSheetStyle:(UIAlertActionStyle)actionSheetStyle handler:(void (^)(UIAlertAction *))handler {
    if (!sheetText || sheetText.length == 0) {
        sheetText = @"";
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *sheetAction = [UIAlertAction actionWithTitle:sheetText style:actionSheetStyle handler:handler];
    [alertController addAction:cancelAction];
    [alertController addAction:sheetAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
