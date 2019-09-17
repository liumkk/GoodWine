//
//  GMForgetPasswordTableView.h
//  GoodWine
//
//  Created by LMK on 2019/8/22.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GMForgetPasswordTableViewDelegate <NSObject>

- (void)sendVerificationCodeWithPhone:(NSString *)phone;

- (void)forgetTableViewPhoneTF:(UITextField *)phoneTF
                 verficationTF:(UITextField *)verficationTF
                    passwordTF:(UITextField *)passwordTF;

@end

@interface GMForgetPasswordTableView : UITableView

@property (nonatomic, strong) MKVerificationCodeView *verificationView;
@property (nonatomic, weak) id <GMForgetPasswordTableViewDelegate> forgetPwdTBDelegate;

@end

NS_ASSUME_NONNULL_END
