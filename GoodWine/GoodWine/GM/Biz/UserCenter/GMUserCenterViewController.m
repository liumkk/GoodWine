//
//  GMUserCenterViewController.m
//  GoodWine
//
//  Created by LMK on 2019/5/28.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMUserCenterViewController.h"
#import "GMUserCenterTableView.h"

@interface GMUserCenterViewController ()

@property (nonatomic, strong)GMUserCenterTableView *userCenterTableView;

@end

@implementation GMUserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubviews];
    
    [self setupConstraints];
}

- (void)initSubviews {
    self.title = @"个人中心";
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupConstraints {
    
    [self.userCenterTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

- (GMUserCenterTableView *)userCenterTableView {
    if (! _userCenterTableView) {
        _userCenterTableView = [[GMUserCenterTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_userCenterTableView];
    }
    return _userCenterTableView;
}

@end
