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

@end
