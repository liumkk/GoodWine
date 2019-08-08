//
//  GMLoginViewController.m
//  GoodWine
//
//  Created by LMK on 2019/5/27.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMLoginViewController.h"
#import "GMloginView.h"

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
    [ServerAPIManager asyncLoginWithUserName:@"zhangsan"
                                    password:@"123456"
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
    MKNSLog(@"忘记密码");
}

- (void)signUpAction:(UIButton *)btn {
    MKNSLog(@"注册");
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
