//
//  GMLoginViewController.m
//  GoodWine
//
//  Created by LMK on 2019/5/27.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMLoginViewController.h"
#import "GMloginView.h"
#import "GMForgetPasswordViewController.h"
#import "GMRegisterViewController.h"

@interface GMLoginViewController ()

@property (nonatomic, strong) GMLoginView *loginView;

@end

@implementation GMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.edgesForExtendedLayout = UIRectEdgeNone; //--坐标从导航栏下面开始
    [self initSubviews];
    [self setupConstraints];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateNavigationBarNeedBack:NO];
}

- (void)initSubviews {
    self.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupConstraints {
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)loginAction:(UIButton *)btn {

    [GMLoadingActivity showLoadingActivityInView:self.view];
    [ServerAPIManager asyncLoginWithUserName:self.loginView.nameTextField.text.length == 0 ? @"zhangsan" : self.loginView.nameTextField.text
                                    password:self.loginView.passwordTextField.text.length == 0 ? @"123456" : self.loginView.passwordTextField.text
                                succeedBlock:^(GMUserCenterInfoModel * model) {
        UserCenter.userInfoModel = model;
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        [ViewControllerManager showTabController];
    } failedBlock:^(NSError * _Nonnull error) {
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        [self showAlertViewWithError:error];
    }];
}

- (void)forgetAction:(UIButton *)btn {
    GMForgetPasswordViewController *vc = [[GMForgetPasswordViewController alloc] init];
    vc.title = @"忘记密码";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)signUpAction:(UIButton *)btn {
    GMRegisterViewController *vc = [[GMRegisterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (GMLoginView *)loginView {
    if (! _loginView) {
        _loginView = [[GMLoginView alloc] initWithFrame:CGRectZero];
        [_loginView.loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
        [_loginView.forgetButton addTarget:self action:@selector(forgetAction:) forControlEvents:UIControlEventTouchUpInside];
        [_loginView.signUpButton addTarget:self action:@selector(signUpAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_loginView];
    }
    return _loginView;
}

@end
