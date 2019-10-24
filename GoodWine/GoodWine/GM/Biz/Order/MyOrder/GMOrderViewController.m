//
//  GMOrderViewController.m
//  GoodWine
//
//  Created by LMK on 2019/5/28.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMOrderViewController.h"
#import "GMOrderCollectionView.h"
#import "GMOrderListViewController.h"

@interface GMOrderViewController () <GMOrderCollectionViewDelegate>

@property (nonatomic, strong) GMOrderCollectionView *orderCollectView;

@end

@implementation GMOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupConstranits];
    [self initSubviews];
}

- (void)initSubviews {
    self.title = @"订单";
    [self updateNavigationBarNeedBack:NO];
    self.orderCollectView.orderCollectDelegate = self;
}

- (void)setupConstranits {
    [self.orderCollectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
- (void)orderCollectionViewDidSelectItemAtIndex:(NSInteger)index {
    [ViewControllerManager checkLoginWithVC:self login:^{
        GMOrderListViewController *vc = [[GMOrderListViewController alloc] initWithStatus:[NSString stringWithFormat:@"%ld",index]];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

- (GMOrderCollectionView *)orderCollectView {
    if (! _orderCollectView) {
        _orderCollectView = [[GMOrderCollectionView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_orderCollectView];
    }
    return _orderCollectView;
}

@end
