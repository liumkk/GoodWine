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
@property (nonatomic, strong) HomePageInfoModel *infoModel;

@end

@implementation GMHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubviews];
    
    [self setupConstraints];
    
    [self requestQueryHomePageinfo];
    
//    self.homePageTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.homePageTableView.mj_footer endRefreshing];
//            [self.homePageTableView reloadHomePageTableViewWithHomePageInfoModel:self.infoModel];
//        });
//    }];
}

- (void)initSubviews {
    self.title = @"首页";
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)requestQueryHomePageinfo {
    [GMLoadingActivity showLoadingActivityInView:self.view];
    [ServerAPIManager asyncQueryHomePageInfoWithSucceedBlock:^(HomePageInfoModel * _Nonnull infoModel) {
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        [self.homePageTableView updateBannerImageWithHomePageInfoModel:infoModel];
        [self.homePageTableView reloadHomePageTableViewWithHomePageInfoModel:infoModel];
    } failedBlock:^(NSError * _Nonnull error) {
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        [self showAlertViewWithTitle:@"提示" Error:error buttonTitle:@"确定"];
    }];
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
