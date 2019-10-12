//
//  GMPaySuccessViewController.m
//  GoodWine
//
//  Created by LMK on 2019/9/16.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMPaySuccessViewController.h"

@interface GMPaySuccessViewController ()

@property (nonatomic, strong) UIImageView *successImageView;
@property (nonatomic, strong) UILabel *titlelabel;
@property (nonatomic, strong) UIButton *backBtn;

@end

@implementation GMPaySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付成功";
    [self updateNavigationBarNeedBack:YES];
    
    [self setupConstranits];
}

- (void)setupConstranits {
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.mas_equalTo(20.f);
    }];
    
    [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backBtn.mas_top).offset(-10.f);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(15.f);
    }];
    
    [self.successImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.titlelabel.mas_top).offset(-20.f);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(137.f, 99.f));
    }];
}

- (void)backBtn:(UIButton *)btn {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (UIImageView *)successImageView {
    if (! _successImageView) {
        _successImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"success"]];
        [self.view addSubview:_successImageView];
    }
    return _successImageView;
}

- (UIButton *)backBtn {
    if (! _backBtn) {
        _backBtn = [UIButton buttonWithType: UIButtonTypeCustom];
        [_backBtn setTitle:@"返回首页" forState:UIControlStateNormal];
        [_backBtn setTitleColor:COLOR_THEME_COLOR forState:UIControlStateNormal];
        _backBtn.titleLabel.font = Font(14.f);
        [_backBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_backBtn];
    }
    return _backBtn;
}

- (UILabel *)titlelabel {
    if (! _titlelabel) {
        _titlelabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titlelabel.text = @"恭喜您下单成功!";
        _titlelabel.textColor = COLOR_THEME_COLOR;
        _titlelabel.font = Font(13.f);
        _titlelabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_titlelabel];
    }
    return _titlelabel;
}

@end
