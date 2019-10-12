//
//  GMVersionViewController.m
//  GoodWine
//
//  Created by LMK on 2019/8/2.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMVersionViewController.h"
#import "GMVersionTableView.h"

@interface GMVersionViewController () <GMVersionTableViewDelegate>

@property (nonatomic, strong) GMVersionTableView *tableView;

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

@end
