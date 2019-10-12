//
//  GMBaseViewController.h
//  GoodWine
//
//  Created by LMK on 2019/5/27.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMBaseViewController : UIViewController

- (void)updateNavigationBarNeedBack:(BOOL)need;
- (void)updateClearNavigationBarNeedBack:(BOOL)need alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
