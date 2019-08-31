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
    self.title = @"忘记密码";
    [self updateNavigationBar];
    
    [self setupConstranits];
}

- (void)registerTableViewPhoneTF:(UITextField *)phoneTF verficationTF:(UITextField *)verficationTF passwordTF:(UITextField *)passwordTF {
    if (IsStrEmpty(phoneTF.text) || IsStrEmpty(verficationTF.text) || IsStrEmpty(passwordTF.text)) {
        [MKToastView showToastToView:self.view text:@"请输入有效信息"];
    } else {
        
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
