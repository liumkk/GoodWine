//
//  GMProductAreaViewController.m
//  GoodWine
//
//  Created by LMK on 2019/8/27.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMProductAreaViewController.h"
#import "GMBrandAreaTableView.h"
#import "GMProductAreaCollectionView.h"
#import "GMProductDetailViewController.h"
#import "GMProductAreaTableView.h"

@interface GMProductAreaViewController () <GMProductAreaTableViewDelegate,GMBrandAreaTableViewDelegate>

@property (nonatomic, strong) GMBrandAreaTableView *brandTableView;
@property (nonatomic, strong) GMProductAreaTableView *productTableView;
@property (nonatomic, copy) NSString *cateId;
@property (nonatomic, strong) NSArray <BrandAreaInfoModel *> *brandArray;
@property (nonatomic, strong) NSMutableArray <HomePageTypeItem *> *dataArray;
@property (nonatomic, strong) MKEmptyView *emptyView;
@property (nonatomic, copy) NSString *brandId;
@property (nonatomic, assign) NSInteger page;

@end

@implementation GMProductAreaViewController

- (instancetype)initWithCateId:(NSString *)cateId {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.cateId = cateId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    
    [self updateNavigationBarNeedBack:YES];
    
    [self setupConstranits];
    
    [self requestBrand];
    [self addRefreshHeaderView];
    [self addRefreshFooterView];
}

- (void)setupConstranits {
    [self.brandTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.view);
        make.width.mas_equalTo(75.f);
    }];
    
    [self.productTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.brandTableView);
        make.left.equalTo(self.brandTableView.mas_right);
        make.right.bottom.equalTo(self.view);
    }];
    
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)updateEmptyView {
    
    [self.emptyView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.productTableView);
    }];
}

- (void)requestBrand {
    [GMLoadingActivity showLoadingActivityInView:self.view];
    @weakify(self)
    [ServerAPIManager asyncQueryBrandClassWithCateId:self.cateId succeedBlock:^(NSArray<BrandAreaInfoModel *> * _Nonnull array) {
        @strongify(self)
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        self.brandArray = array;
        if (self.brandArray.count > 0) {
            [self.brandTableView reloadTableViewWithDataArray:array];
            
            BrandAreaInfoModel *model = self.brandArray[0];
            self.brandId = model.brandId;
            [self requestProductWithBrandId:self.brandId IsLoadMore:NO];
        } else {
            [self.emptyView showEmptyNeedLoadBtn:NO];
        }
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self)
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        [self.emptyView showEmptyNeedLoadBtn:NO];
        [self showAlertViewWithError:error];
    }];
}

- (void)requestProductWithBrandId:(NSString *)brandId IsLoadMore:(BOOL)isLoadMore {
    [GMLoadingActivity showLoadingActivityInView:self.view];
    @weakify(self)
    [ServerAPIManager asyncQueryProductWithCateId:self.cateId brandId:brandId pageSize:@"10" pageNum:isLoadMore ? [NSString stringWithFormat:@"%ld",(long)self.page] : @"1" succeedBlock:^(NSArray<HomePageTypeItem *> * _Nonnull array) {
        @strongify(self)
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        [self endMJRefresh];
        if (array.count == 0) {
            if (!isLoadMore) {
                self.page = 1;
                [self.emptyView showEmptyNeedLoadBtn:NO];
                [self updateEmptyView];
                [self.productTableView.mj_footer resetNoMoreData];
            } else {
                [self.productTableView.mj_footer endRefreshingWithNoMoreData];
            }
        } else {
            if (!isLoadMore) {
                self.page = 1;
                [self.dataArray removeAllObjects];
                [self.productTableView.mj_footer resetNoMoreData];
            }
            self.page ++;
            [self.dataArray addObjectsFromArray:array];
            
            self.emptyView.hidden = YES;
            [self.productTableView reloadProductAreaTableViewWithDataArray:self.dataArray];
        }
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self)
        [self.emptyView showEmptyNeedLoadBtn:NO];
        [self updateEmptyView];
        [self showAlertViewWithError:error];
    }];
}

- (void)brandAreaTableViewDidSelectRowAtIndex:(NSInteger)index {
    BrandAreaInfoModel *model = self.brandArray[index];
    self.brandId = model.brandId;
    [self requestProductWithBrandId:self.brandId IsLoadMore:NO];
}

- (void)productAreaTableViewDidSelectItemModel:(HomePageTypeItem *)model {
    GMProductDetailViewController *vc = [[GMProductDetailViewController alloc] initWithProductId:model.productId];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)addRefreshHeaderView {
    @weakify(self)
    self.productTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        if ([self.productTableView.mj_footer isRefreshing]) {
            [self.productTableView.mj_footer endRefreshing];
        }
        [self requestProductWithBrandId:self.brandId IsLoadMore:NO];
    }];
}

- (void)addRefreshFooterView {
    @weakify(self)
    self.productTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)
        if ([self.productTableView.mj_header isRefreshing]) {
            [self.productTableView.mj_header endRefreshing];
        }
        [self requestProductWithBrandId:self.brandId IsLoadMore:YES];
    }];
    self.productTableView.mj_footer.ignoredScrollViewContentInsetBottom = BottomTarBarSpace;
}

- (void)endMJRefresh {
    
    if ([self.productTableView.mj_header isRefreshing]) {
        [self.productTableView.mj_header endRefreshing];
    }
    if ([self.productTableView.mj_footer isRefreshing]) {
        [self.productTableView.mj_footer endRefreshing];
    }
}

- (NSMutableArray<HomePageTypeItem *> *)dataArray {
    if (! _dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (GMBrandAreaTableView *)brandTableView {
    if (! _brandTableView) {
        _brandTableView = [[GMBrandAreaTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _brandTableView.brandTBDelegate = self;
        [self.view addSubview:_brandTableView];
    }
    return _brandTableView;
}

- (GMProductAreaTableView *)productTableView {
    if (! _productTableView) {
        _productTableView = [[GMProductAreaTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _productTableView.productAreaDelegate = self;
        [self.view addSubview:_productTableView];
    }
    return _productTableView;
}

- (MKEmptyView *)emptyView {
    if (! _emptyView) {
        _emptyView = [[MKEmptyView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_emptyView];
    }
    return _emptyView;
}

@end
