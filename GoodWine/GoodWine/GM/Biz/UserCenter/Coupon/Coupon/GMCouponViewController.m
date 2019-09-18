//
//  GMCouponViewController.m
//  GoodWine
//
//  Created by LMK on 2019/8/30.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMCouponViewController.h"
#import "GMCouponTableView.h"

@interface GMCouponViewController () <GMCouponTableViewDelegate>

@property (nonatomic, strong) GMCouponTableView *couponTableView;
@property (nonatomic, strong) MKEmptyView *emptyView;
@property (nonatomic, strong) NSArray <CouponInfoModel *> *dataArray;


@end

@implementation GMCouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"优惠券";
    
    [self updateNavigationBar];
    
    [self setupConstranits];
    [self requestQueryCouponList];
}

- (void)setupConstranits {
    
    [self.couponTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)requestQueryCouponList {
    [GMLoadingActivity showLoadingActivityInView:self.view];
    [ServerAPIManager asyncQueryCouponSucceedBlock:^(NSArray<CouponInfoModel *> * array) {
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        self.dataArray = array;
        if (array.count > 0) {
            [self.couponTableView reloadTableViewWithDataArray:array];
        } else {
            [self.emptyView showEmptyNeedLoadBtn:NO];
        }
        
    } failedBlock:^(NSError * _Nonnull error) {
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        [self showAlertViewWithError:error];
    }];
}

- (void)couponTableViewDidSelectRowAtIndex:(NSInteger)index {
    CouponInfoModel *model = self.dataArray[index];
    if (model.receive == 0) {
        [GMLoadingActivity showLoadingActivityInView:self.view];
        [ServerAPIManager asyncGetCouponWithCouponId:[NSString stringWithFormat:@"%ld",model.couponId] succeedBlock:^{
            [MKToastView showToastToView:self.view text:@"领取成功"];
            model.receive = 1;
            [self.couponTableView reloadTableViewWithDataArray:self.dataArray];
        } failedBlock:^(NSError * _Nonnull error) {
            [GMLoadingActivity hideLoadingActivityInView:self.view];
            [self showAlertViewWithError:error];
        }];
    }
}

- (GMCouponTableView *)couponTableView {
    if (! _couponTableView) {
        _couponTableView = [[GMCouponTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _couponTableView.couponDelegate = self;
        [self.view addSubview:_couponTableView];
    }
    return _couponTableView;
}

- (MKEmptyView *)emptyView {
    if (! _emptyView) {
        _emptyView = [[MKEmptyView alloc] initWithFrame:CGRectZero];
        _emptyView.hidden = YES;
        [self.view addSubview:_emptyView];
    }
    return _emptyView;
}

@end
