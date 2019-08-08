//
//  GMVersionViewController.m
//  GoodWine
//
//  Created by LMK on 2019/8/2.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMVersionViewController.h"
#import "GMVersionTableView.h"

@interface GMVersionViewController ()

@property (nonatomic, strong) GMVersionTableView *tableView;

@end

@implementation GMVersionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"版本信息";
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self updateNavigationBar];
    [self setupConstranits];
}

- (void)setupConstranits {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (GMVersionTableView *)tableView {
    if (! _tableView) {
        _tableView = [[GMVersionTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
