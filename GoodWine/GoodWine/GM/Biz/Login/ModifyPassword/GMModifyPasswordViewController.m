//
//  GMModifyPasswordViewController.m
//  GoodWine
//
//  Created by LMK on 2019/9/9.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMModifyPasswordViewController.h"
#import "GMModifyTableView.h"

@interface GMModifyPasswordViewController ()

@property (nonatomic, strong) GMModifyTableView *modifyTableView;
@end

@implementation GMModifyPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    [self updateNavigationBar];
    
    [self setupConstranits];
}

- (void)setupConstranits {
    [self.modifyTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (GMModifyTableView *)modifyTableView {
    if (! _modifyTableView) {
        _modifyTableView = [[GMModifyTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
//        _modifyTableView.forgetPwdTBDelegate = self;
        [self.view addSubview:_modifyTableView];
    }
    return _modifyTableView;
}

@end
