//
//  GMVersionViewController.m
//  GoodWine
//
//  Created by LMK on 2019/8/2.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMVersionViewController.h"
#import "GMVersionTableView.h"
#import "GMVersionFooterView.h"

@interface GMVersionViewController () <GMVersionTableViewDelegate>

@property (nonatomic, strong) GMVersionTableView *tableView;
@property (nonatomic, strong) GMVersionFooterView *footerView;

@end

@implementation GMVersionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"版本信息";
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self updateNavigationBarNeedBack:YES];
    [self setupConstranits];
}

- (void)setupConstranits {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-30.f);
        make.left.right.equalTo(self.view);
    }];
}

- (void)versionTableViewDidSelectRowAtIndex:(NSInteger)index {
    if (index == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://apps.apple.com/cn/app/id1483002123"]];
    } else if (index == 2) {
        GMWebViewController *vc = [[GMWebViewController alloc] initNeedAdapter:YES];
        vc.urlString = @"http://www.wufangyuan.cn";
        vc.title = @"官网";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (GMVersionTableView *)tableView {
    if (! _tableView) {
        _tableView = [[GMVersionTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.versionTBDelegate = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (GMVersionFooterView *)footerView {
    if (! _footerView) {
        _footerView = [[GMVersionFooterView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_footerView];
    }
    return _footerView;
}

@end
