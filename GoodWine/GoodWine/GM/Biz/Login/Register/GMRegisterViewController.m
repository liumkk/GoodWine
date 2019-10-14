//
//  GMRegisterViewController.m
//  GoodWine
//
//  Created by LMK on 2019/8/22.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMRegisterViewController.h"
#import "GMRegisterTableView.h"

@interface GMRegisterViewController () <GMRegisterTableViewDelegate>

@property (nonatomic, strong) GMRegisterTableView *registerTableView;

@end

@implementation GMRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    [self updateNavigationBarNeedBack:YES];
    
    [self setupConstranits];
}

- (void)sendVerificationCodeWithPhone:(NSString *)phone {
    if (phone.length != 11) {
        [MKToastView showToastToView:self.view text:@"请填写有效手机号码"];
    } else {
        [self.registerTableView.verificationView initTimer];
        [ServerAPIManager asyncQueryAuthCodeWithPhoneNum:phone succeedBlock:^{
            [MKToastView showToastToView:self.view text:@"发送成功"];
        } failedBlock:^(NSError * _Nonnull error) {
            [self showAlertViewWithError:error];
            [self.registerTableView.verificationView clearTimer];
        }];
    }
    
}

- (void)registerTableViewNameTF:(UITextField *)nameTF phoneTF:(UITextField *)phoneTF verficationTF:(UITextField *)verficationTF passwordTF:(UITextField *)passwordTF {
    [self.view endEditing:YES];
    if (IsStrEmpty(nameTF.text) || IsStrEmpty(phoneTF.text) || IsStrEmpty(verficationTF.text) || IsStrEmpty(passwordTF.text)) {
        [MKToastView showToastToView:self.view text:@"请输入有效信息"];
    } else if (self.registerTableView.protocolView.selectBtn.selected == NO) {
        [MKToastView showToastToView:self.view text:@"请阅读服务协议"];
    } else {
        [GMLoadingActivity showLoadingActivityInView:self.view];
        @weakify(self)
        [ServerAPIManager asyncRegisterWithUserName:nameTF.text PhoneNum:phoneTF.text password:passwordTF.text authCode:verficationTF.text succeedBlock:^{
            @strongify(self)
            [GMLoadingActivity hideLoadingActivityInView:self.view];
            [MKToastView showToastToView:self.view text:@"注册成功" time:1.f completion:^{
                self.callBack(phoneTF.text, passwordTF.text);
                [self.navigationController popViewControllerAnimated:YES];
            }];
        } failedBlock:^(NSError * error) {
            @strongify(self)
            [GMLoadingActivity hideLoadingActivityInView:self.view];
            [self showAlertViewWithError:error];
        }];
    }
}

- (void)pushProtocol {
    GMWebViewController *vc = [[GMWebViewController alloc] initNeedAdapter:NO];
    vc.urlString = @"http://www.wufangyuan.cn/static/shuoming.html";
    vc.title = @"隐私协议";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setupConstranits {
    [self.registerTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (GMRegisterTableView *)registerTableView {
    if (! _registerTableView) {
        _registerTableView = [[GMRegisterTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _registerTableView.registerTBDelegate = self;
        [self.view addSubview:_registerTableView];
    }
    return _registerTableView;
}

@end
