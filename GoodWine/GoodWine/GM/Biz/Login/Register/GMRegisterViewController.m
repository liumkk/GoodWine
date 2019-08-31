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
    [self updateNavigationBar];
    
    [self setupConstranits];
}

- (void)registerTableViewNameTF:(UITextField *)nameTF phoneTF:(UITextField *)phoneTF verficationTF:(UITextField *)verficationTF passwordTF:(UITextField *)passwordTF {
    if (IsStrEmpty(nameTF.text) || IsStrEmpty(phoneTF.text) || IsStrEmpty(verficationTF.text) || IsStrEmpty(passwordTF.text)) {
        [MKToastView showToastToView:self.view text:@"请输入有效信息"];
    } else {
        
    }
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
