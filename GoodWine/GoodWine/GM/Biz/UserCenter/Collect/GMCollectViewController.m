//
//  GMCollectViewController.m
//  GoodWine
//
//  Created by LMK on 2019/8/30.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMCollectViewController.h"
#import "GMCollectTableView.h"
#import "GMProductDetailViewController.h"

@interface GMCollectViewController () <GMCollectTableViewDelegate>

@property (nonatomic, strong) GMCollectTableView *collectTB;
@property (nonatomic, strong) NSMutableArray <CollectProductItem *> *productArray;
@property (nonatomic, strong) MKEmptyView *emptyView;
@property (nonatomic, assign) NSInteger page;

@end

@implementation GMCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关注商品";
    self.page = 1;
    
    [self updateNavigationBarNeedBack:YES];
    [self setupConstranits];
    [self requestCollectListIsLoadMore:NO];
    [self addRefreshHeaderView];
    [self addRefreshFooterView];
    
}

- (void)setupConstranits {
    [self.collectTB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)requestCollectListIsLoadMore:(BOOL)isLoadMore {
    [GMLoadingActivity showLoadingActivityInView:self.view];
    @weakify(self)
    [ServerAPIManager asyncGetCollectListWithPageSize:@"10" pageNum:isLoadMore ? [NSString stringWithFormat:@"%ld",(long)self.page] : @"1" SucceedBlock:^(CollectListInfoModel * model) {
        @strongify(self)
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        [self endMJRefresh];
        if (model.collectProductArray.count == 0) {
            if (!isLoadMore) {
                self.page = 1;
                [self.emptyView showEmptyNeedLoadBtn:NO];
                [self.collectTB.mj_footer resetNoMoreData];
            } else {
                [self.collectTB.mj_footer endRefreshingWithNoMoreData];
            }
        } else {
            if (!isLoadMore) {
                self.page = 1;
                [self.productArray removeAllObjects];
                [self.collectTB.mj_footer resetNoMoreData];
            }
            self.page ++;
            [self.productArray addObjectsFromArray:model.collectProductArray];
            
            self.emptyView.hidden = YES;
            [self.collectTB reloadTableViewWithDataArray:self.productArray];
        }
    } failedBlock:^(NSError * error) {
        @strongify(self)
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        [self.emptyView showEmptyNeedLoadBtn:NO];
        [self showAlertViewWithError:error];
    }];
}

- (void)collectTableViewDidSelectRowAtIndex:(NSInteger)index {
    CollectProductItem *item = self.productArray[index];
    GMProductDetailViewController *vc = [[GMProductDetailViewController alloc] initWithProductId:item.productId];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)collectTableViewDeleteRowAtIndex:(NSInteger)index {
    CollectProductItem *item = self.productArray[index];
    [ServerAPIManager asyncDeleteCollectWithProductId:item.productId succeedBlock:^{
        [self.productArray removeObjectAtIndex:index];
        [self.collectTB deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        [self.collectTB beginUpdates];
        [self.collectTB endUpdates];
    } failedBlock:^(NSError * _Nonnull error) {
        [self showAlertViewWithError:error];
    }];
}

- (void)addRefreshHeaderView {
    @weakify(self)
    self.collectTB.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        if ([self.collectTB.mj_footer isRefreshing]) {
            [self.collectTB.mj_footer endRefreshing];
        }
        [self requestCollectListIsLoadMore:NO];
    }];
}

- (void)addRefreshFooterView {
    @weakify(self)
    self.collectTB.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)
        if ([self.collectTB.mj_header isRefreshing]) {
            [self.collectTB.mj_header endRefreshing];
        }
        [self requestCollectListIsLoadMore:YES];
    }];
    self.collectTB.mj_footer.ignoredScrollViewContentInsetBottom = BottomTarBarSpace;
}

- (void)endMJRefresh {
    
    if ([self.collectTB.mj_header isRefreshing]) {
        [self.collectTB.mj_header endRefreshing];
    }
    if ([self.collectTB.mj_footer isRefreshing]) {
        [self.collectTB.mj_footer endRefreshing];
    }
}

- (GMCollectTableView *)collectTB {
    if (! _collectTB) {
        _collectTB = [[GMCollectTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _collectTB.collectTBDelegate = self;
        [self.view addSubview:_collectTB];
    }
    return _collectTB;
}

- (MKEmptyView *)emptyView {
    if (! _emptyView) {
        _emptyView = [[MKEmptyView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_emptyView];
    }
    return _emptyView;
}

- (NSMutableArray<CollectProductItem *> *)productArray {
    if (! _productArray) {
        _productArray = [[NSMutableArray alloc] init];
    }
    return _productArray;
}

@end
