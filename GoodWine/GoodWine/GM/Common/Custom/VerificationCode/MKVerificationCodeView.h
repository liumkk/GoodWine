//
//  MKVerificationCodeView.h
//  GoodWine
//
//  Created by LMK on 2019/8/22.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKVerificationCodeView : UIView

@property (nonatomic, strong) UIButton *verifyButton;

- (void)initTimer;
- (void)clearTimer;

@end

NS_ASSUME_NONNULL_END
