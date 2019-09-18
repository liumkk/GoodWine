//
//  GMUserCenterViewController.m
//  GoodWine
//
//  Created by LMK on 2019/5/28.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMUserCenterViewController.h"
#import "GMUserCenterTableView.h"
#import "GMVersionViewController.h"
#import "GMMyCouponViewController.h"
#import "GMServiceViewController.h"
#import "GMAddressManagerViewcontroller.h"
#import "GMCollectViewController.h"
#import "GMSettingViewController.h"

@interface GMUserCenterViewController () <GMUserCenterTableViewDelegate>

@property (nonatomic, strong) GMUserCenterTableView *userCenterTableView;

@end

@implementation GMUserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubviews];
    
    [self setupConstraints];
}

- (void)initSubviews {
    self.title = @"我的";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)userCollectionViewDidSelectRowAtIndex:(NSInteger)index {
    if (index == 0) {
        GMAddressManagerViewcontroller *addressVC = [[GMAddressManagerViewcontroller alloc] init];
        addressVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:addressVC animated:YES];
    } else if (index == 1) {
        GMMyCouponViewController *vc = [[GMMyCouponViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (index == 2) {
        GMCollectViewController *vc = [[GMCollectViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (index == 3) {
        GMServiceViewController *serviceVC = [[GMServiceViewController alloc] init];
        serviceVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:serviceVC animated:YES];
    } else if (index == 4) {
        GMSettingViewController *settingVC = [[GMSettingViewController alloc] init];
        settingVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:settingVC animated:YES];
    } else if (index == 5) {
        GMVersionViewController *versionVC = [[GMVersionViewController alloc] init];
        versionVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:versionVC animated:YES];
    }
}

- (void)setupConstraints {
    
    [self.userCenterTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (GMUserCenterTableView *)userCenterTableView {
    if (! _userCenterTableView) {
        _userCenterTableView = [[GMUserCenterTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _userCenterTableView.userTableViewDelegate = self;
        [self.view addSubview:_userCenterTableView];
    }
    return _userCenterTableView;
}

@end
