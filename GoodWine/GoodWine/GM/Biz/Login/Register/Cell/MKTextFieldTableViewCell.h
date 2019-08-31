//
//  MKTextFeildTableViewCell.h
//  GoodWine
//
//  Created by LMK on 2019/8/22.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MKTextFieldCellType) {
    MKTextFieldCellTypeDefault,         //默认样式
    MKTextFieldCellTypeVerficationCode, //验证码倒计时
    MKTextFieldCellTypeEye              //明密文切换
};

@interface MKTextFieldTableViewCell : UITableViewCell

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) MKVerificationCodeView *verificationView;
@property (nonatomic, strong) UIButton *eyeBtn;

@property (nonatomic, strong) UIView *lineView;


- (void)updateTextFieldCellType:(MKTextFieldCellType)type placeholder:(NSString *)placeholder;

@end

NS_ASSUME_NONNULL_END
