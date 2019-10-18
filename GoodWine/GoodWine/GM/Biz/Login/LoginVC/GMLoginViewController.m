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
#import "GMJoinViewController.h"

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
    @weakify(self)
    [ServerAPIManager asyncQueryUserCodeSucceedBlock:^(NSString * _Nonnull str) {
        @strongify(self)
        if ([User_Code isEqualToString:str]) {
            UserCenter.storeId = @"46";
            [self login];
        } else {
            //检查定位是否成功
            [LocationManager openLocationFunctionSucceed:^{
                [self login];
            } failed:^{
                [GMLoadingActivity hideLoadingActivityInView:self.view];
                GMJoinViewController *vc = [[GMJoinViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            } authority:^{
                [GMLoadingActivity hideLoadingActivityInView:self.view];
            }];
        }
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self)
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        [self showAlertViewWithError:error];
    }];
}

- (void)login {
    if (IsStrEmpty(self.loginView.nameTextField.text) || IsStrEmpty(self.loginView.passwordLabel.text)) {
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        [MKToastView showToastToView:self.view text:@"账号密码不能为空"];
    } else {
        @weakify(self)
        [ServerAPIManager asyncLoginWithUserName:self.loginView.nameTextField.text
                                        password:self.loginView.passwordTextField.text
                                    succeedBlock:^(GMUserCenterInfoModel * model) {
                                        @strongify(self)
                                        [GMLoadingActivity hideLoadingActivityInView:self.view];
                                        UserCenter.userInfoModel = model;
                                        [ViewControllerManager showTabController];
                                    } failedBlock:^(NSError * _Nonnull error) {
                                        @strongify(self)
                                        [GMLoadingActivity hideLoadingActivityInView:self.view];
                                        [self showAlertViewWithError:error];
                                    }];
    }
}

- (void)forgetAction:(UIButton *)btn {
    GMForgetPasswordViewController *vc = [[GMForgetPasswordViewController alloc] init];
    vc.title = @"忘记密码";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)signUpAction:(UIButton *)btn {
    GMRegisterViewController *vc = [[GMRegisterViewController alloc] init];
    vc.callBack = ^(NSString * _Nonnull name, NSString * _Nonnull pwd) {
        self.loginView.nameTextField.text = name;
        self.loginView.passwordTextField.text = pwd;
        [self loginAction:nil];
    };
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
