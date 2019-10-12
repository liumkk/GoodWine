//
//  GMHomePageViewController.m
//  GoodWine
//
//  Created by LMK on 2019/5/28.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMHomePageViewController.h"
#import "GMHomePageTableView.h"
#import "GMProductDetailViewController.h"
#import "GMProductAreaViewController.h"
#import "GMCouponViewController.h"
#import "GMSearchView.h"
#import "GMSearchViewController.h"

@interface GMHomePageViewController () <GMHomePageTableViewDelegate>

@property (nonatomic, strong) GMHomePageTableView *homePageTableView;
@property (nonatomic, strong) HomePageInfoModel *infoModel;
@property (nonatomic, strong) GMSearchView *searchView;


@end

@implementation GMHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubviews];
    
    [self setupConstraints];
    
    [self addRefreshHeaderView];
    
    [self requestQueryHomePageinfoNeedLoad:YES];
    
//    self.homePageTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.homePageTableView.mj_footer endRefreshing];
//            [self.homePageTableView reloadHomePageTableViewWithHomePageInfoModel:self.infoModel];
//        });
//    }];
}

- (void)initSubviews {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.titleView = self.searchView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateNavigationBarNeedBack:NO];
}

#pragma mark --add MJRefresh
- (void)addRefreshHeaderView {
    self.homePageTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestQueryHomePageinfoNeedLoad:NO];
    }];
}

- (void)requestQueryHomePageinfoNeedLoad:(BOOL)needLoad {
    if (needLoad) {
        [GMLoadingActivity showLoadingActivityInView:self.view];
    }
    [ServerAPIManager asyncQueryHomePageInfoWithStoreId:UserCenter.storeId SucceedBlock:^(HomePageInfoModel * _Nonnull infoModel) {
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        [self.homePageTableView.mj_header endRefreshing];
        [self.homePageTableView updateBannerImageWithHomePageInfoModel:infoModel];
        [self.homePageTableView reloadHomePageTableViewWithHomePageInfoModel:infoModel];
    } failedBlock:^(NSError * _Nonnull error) {
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        [self showAlertViewWithTitle:@"提示" Error:error buttonTitle:@"确定"];
        [self.homePageTableView.mj_header endRefreshing];
    }];
}

- (void)collectionViewDidSelectItemWithModel:(HomePageTypeItem *)model {
    GMProductDetailViewController *vc = [[GMProductDetailViewController alloc] initWithProductId:model.productId];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickWineAreaWithAreaType:(WineAreaType)type {
    if (type == WineAreaTypeCoupon) {
        GMCouponViewController *vc = [[GMCouponViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        NSString *cateId;
        NSString *title;
        if (type == WineAreaTypeWhite) {
            cateId = @"2";
            title = @"白酒专区";
        } else if (type == WineAreaTypeRed) {
            cateId = @"3";
            title = @"红酒专区";
        } else if (type == WineAreaTypeOther) {
            cateId = @"4";
            title = @"其他酒品";
        } 
        GMProductAreaViewController *vc = [[GMProductAreaViewController alloc] initWithCateId:cateId];
        vc.hidesBottomBarWhenPushed = YES;
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)searchAction:(UIButton *)btn {
    GMSearchViewController *vc = [[GMSearchViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
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
        _homePageTableView.homePageTVDelegate = self;
        [self.view addSubview:_homePageTableView];
    }
    return _homePageTableView;
}

- (GMSearchView *)searchView {
    if (! _searchView) {
        _searchView = [[GMSearchView alloc] initWithFrame:CGRectMake(30.f, 10.f, Width_Screen - 60.f, 35.f)];
        [_searchView.searchButton addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchView;
}

@end
