//
//  GMOrderPayViewController.m
//  GoodWine
//
//  Created by LMK on 2019/8/31.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMOrderPayViewController.h"
#import "GMOrderPayView.h"

@interface GMOrderPayViewController ()

@property (nonatomic, strong) GMOrderPayView *payView;
@property (nonatomic, copy) NSString *amount;

@end

@implementation GMOrderPayViewController

- (instancetype)initWithPayAmount:(NSString *)amount {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.amount = amount;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择支付方式";
    
    [self updateNavigationBar];
    [self setupConstranits];
}

- (void)setupConstranits {
    [self.payView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)payBtnAction:(UIButton *)btn {
    
}

- (GMOrderPayView *)payView {
    if (! _payView) {
        _payView = [[GMOrderPayView alloc] initWithFrame:CGRectZero];
        [_payView updateWithPayAmount:self.amount];
        [_payView.payBtn addTarget:self action:@selector(payBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_payView];
    }
    return _payView;
}

@end
