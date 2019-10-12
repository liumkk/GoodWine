//
//  GMMyCouponViewController.m
//  GoodWine
//
//  Created by LMK on 2019/9/16.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMMyCouponViewController.h"
#import "GMMyCouponTableView.h"

@interface GMMyCouponViewController () <GMMyCouponTableViewDelegate>

@property (nonatomic, strong) GMMyCouponTableView *myCouponTableView;
@property (nonatomic, strong) MKEmptyView *emptyView;
@property (nonatomic, strong) NSMutableArray <MyCouponInfoModel *> *dataArray;
@property (nonatomic, assign) NSInteger page;

@property (nonatomic, copy) MyCouponCallBack callBack;

@property (nonatomic, assign) BOOL isSelectCoupon; //YES=选择可用优惠券  NO=展示优惠券列表

@end

@implementation GMMyCouponViewController

//此方法仅为从选择优惠券进入时调用，不需要去后台请求数据
- (instancetype)initWithArray:(NSArray<MyCouponInfoModel *> *)array {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.dataArray = (NSMutableArray *)array;
        self.isSelectCoupon = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的优惠券";
    self.page = 1;
    [self updateNavigationBarNeedBack:YES];
    
    [self setupConstranits];
    if (self.isSelectCoupon == YES) {
        if (self.dataArray.count > 0) {
            [self.myCouponTableView reloadTableViewWithDataArray:self.dataArray];
        } else {
            [self.emptyView showEmptyNeedLoadBtn:NO];
        }
    } else {
        [self requestQueryCouponListIsLoadMore:NO];
        [self addRefreshHeaderView];
        [self addRefreshFooterView];
    }
}

- (void)setupConstranits {
    
    [self.myCouponTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)requestQueryCouponListIsLoadMore:(BOOL)isLoadMore {
    [GMLoadingActivity showLoadingActivityInView:self.view];
    @weakify(self)
    [ServerAPIManager asyncQueryMyCouponPageNum:isLoadMore ? [NSString stringWithFormat:@"%ld",(long)self.page] : @"1" pageSize:@"4" SucceedBlock:^(NSArray<MyCouponInfoModel *> * array) {
        @strongify(self)
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        [self endMJRefresh];
        if (array.count == 0) {
            if (!isLoadMore) {
                self.page = 1;
                [self.emptyView showEmptyNeedLoadBtn:NO];
                [self.myCouponTableView.mj_footer resetNoMoreData];
            } else {
                [self.myCouponTableView.mj_footer endRefreshingWithNoMoreData];
            }
        } else {
            if (!isLoadMore) {
                self.page = 1;
                [self.dataArray removeAllObjects];
                [self.myCouponTableView.mj_footer resetNoMoreData];
            }
            self.page ++;
            [self.dataArray addObjectsFromArray:array];
            
            self.emptyView.hidden = YES;
            [self.myCouponTableView reloadTableViewWithDataArray:self.dataArray];
        }
    } failedBlock:^(NSError * error) {
        @strongify(self)
        [self.emptyView showEmptyNeedLoadBtn:NO];
        [self showAlertViewWithError:error];
    }];
}

- (void)myCouponTableViewDidSelectRowAtIndex:(NSInteger)index {
    MyCouponInfoModel *model = self.dataArray[index];
    if ([model.useStatus integerValue] == 0) {
        if (self.callBack) {
            self.callBack(model);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)addRefreshHeaderView {
    @weakify(self)
    self.myCouponTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        if ([self.myCouponTableView.mj_footer isRefreshing]) {
            [self.myCouponTableView.mj_footer endRefreshing];
        }
        [self requestQueryCouponListIsLoadMore:NO];
    }];
}

- (void)addRefreshFooterView {
    @weakify(self)
    self.myCouponTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)
        if ([self.myCouponTableView.mj_header isRefreshing]) {
            [self.myCouponTableView.mj_header endRefreshing];
        }
         [self requestQueryCouponListIsLoadMore:YES];
    }];
    self.myCouponTableView.mj_footer.ignoredScrollViewContentInsetBottom = BottomTarBarSpace;
}

- (void)endMJRefresh {
    
    if ([self.myCouponTableView.mj_header isRefreshing]) {
        [self.myCouponTableView.mj_header endRefreshing];
    }
    if ([self.myCouponTableView.mj_footer isRefreshing]) {
        [self.myCouponTableView.mj_footer endRefreshing];
    }
}

- (GMMyCouponTableView *)myCouponTableView {
    if (! _myCouponTableView) {
        _myCouponTableView = [[GMMyCouponTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _myCouponTableView.myCouponDelegate = self;
        [self.view addSubview:_myCouponTableView];
    }
    return _myCouponTableView;
}

- (MKEmptyView *)emptyView {
    if (! _emptyView) {
        _emptyView = [[MKEmptyView alloc] initWithFrame:CGRectZero];
        _emptyView.hidden = YES;
        [self.view addSubview:_emptyView];
    }
    return _emptyView;
}

- (NSMutableArray<MyCouponInfoModel *> *)dataArray {
    if (! _dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)myCouponCallBack:(MyCouponCallBack)callBack {
    self.callBack = callBack;
}

@end
