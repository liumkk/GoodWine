//
//  GMSettingViewController.m
//  GoodWine
//
//  Created by LMK on 2019/9/9.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMSettingViewController.h"
#import "GMSettingTableView.h"
#import "GMForgetPasswordViewController.h"

@interface GMSettingViewController () <GMSettingTableViewDelegate>

@property (nonatomic, copy) GMSettingTableView *settingTableView;

@end

@implementation GMSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.view.backgroundColor = [UIColor whiteColor];
    [self updateNavigationBar];
    [self setupConstranits];
    
}

- (void)setupConstranits {
    [self.settingTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)LogoutAction {
    [ServerAPIManager asynclogoutSucceedBlock:^{
        [ViewControllerManager showLoginView];
    } failedBlock:^(NSError * _Nonnull error) {
        [self showAlertViewWithError:error];
    }];
}

- (void)settingTableViewDidSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        GMForgetPasswordViewController *vc = [[GMForgetPasswordViewController alloc] init];
        vc.title = @"修改密码";
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 1) {
        [[SDImageCache sharedImageCache] clearDisk];
        [MKToastView showToastToView:self.view text:@"清除缓存成功"];
        [self.settingTableView reloadData];
    }
}

- (GMSettingTableView *)settingTableView {
    if (! _settingTableView) {
        _settingTableView = [[GMSettingTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _settingTableView.settingDelegate = self;
        [self.view addSubview:_settingTableView];
    }
    return _settingTableView;
}

@end
