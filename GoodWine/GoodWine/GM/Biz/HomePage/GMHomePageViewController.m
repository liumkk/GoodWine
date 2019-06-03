//
//  GMHomePageViewController.m
//  GoodWine
//
//  Created by LMK on 2019/5/28.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMHomePageViewController.h"
#import "GMHomePageTableView.h"

@interface GMHomePageViewController ()

@property (nonatomic, strong) GMHomePageTableView *homePageTableView;

@end

@implementation GMHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubviews];
    
    [self setupConstraints];
}

- (void)initSubviews {
    self.title = @"首页";
    
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark --update constraints

- (void)setupConstraints {
    
    [self.homePageTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}


- (GMHomePageTableView *)homePageTableView {
    if (! _homePageTableView) {
        _homePageTableView = [[GMHomePageTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_homePageTableView];
    }
    return _homePageTableView;
}

@end
