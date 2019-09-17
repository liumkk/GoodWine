//
//  GMForgetPasswordViewController.m
//  GoodWine
//
//  Created by LMK on 2019/8/22.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMForgetPasswordViewController.h"
#import "GMForgetPasswordTableView.h"

@interface GMForgetPasswordViewController () <GMForgetPasswordTableViewDelegate>

@property (nonatomic, strong) GMForgetPasswordTableView *pwdTableView;

@end

@implementation GMForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"忘记密码";
    [self updateNavigationBar];
    
    [self setupConstranits];
}

- (void)sendVerificationCodeWithPhone:(NSString *)phone {
    if (phone.length != 11) {
        [MKToastView showToastToView:self.view text:@"请填写有效手机号码"];
    } else {
        [self.pwdTableView.verificationView initTimer];
        [ServerAPIManager asyncQueryAuthCodeWithPhoneNum:@"" succeedBlock:^{
            
        } failedBlock:^(NSError * _Nonnull error) {
            [self showAlertViewWithError:error];
            [self.pwdTableView.verificationView clearTimer];
        }];
    }
}

- (void)forgetTableViewPhoneTF:(UITextField *)phoneTF verficationTF:(UITextField *)verficationTF passwordTF:(UITextField *)passwordTF {
    if (IsStrEmpty(phoneTF.text) || IsStrEmpty(verficationTF.text) || IsStrEmpty(passwordTF.text)) {
        [MKToastView showToastToView:self.view text:@"请输入有效信息"];
    } else {
        [ServerAPIManager asyncModifyPasswordWithPhoneNum:phoneTF.text password:passwordTF.text authCode:verficationTF.text succeedBlock:^{
            [MKToastView showToastToView:self.view text:@"修改密码成功" time:2.f completion:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        } failedBlock:^(NSError * error) {
            [self showAlertViewWithError:error];
        }];
    }
}

- (void)setupConstranits {
    [self.pwdTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (GMForgetPasswordTableView *)pwdTableView {
    if (! _pwdTableView) {
        _pwdTableView = [[GMForgetPasswordTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _pwdTableView.forgetPwdTBDelegate = self;
        [self.view addSubview:_pwdTableView];
    }
    return _pwdTableView;
}

@end
