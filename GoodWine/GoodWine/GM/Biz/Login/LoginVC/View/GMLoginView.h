//
//  GMLoginView.h
//  GoodWine
//
//  Created by LMK on 2019/6/4.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMLoginView : UIView

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *identifyLabel;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UIView *nameLineView;

@property(nonatomic, strong) UILabel *passwordLabel;
@property(nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIView *pwdLineView;

@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *forgetButton;
@property (nonatomic, strong) UIButton *signUpButton;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)setupConstraints;

@end

NS_ASSUME_NONNULL_END
