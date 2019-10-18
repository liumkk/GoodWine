//
//  GMAddressManagerViewcontroller.m
//  GoodWine
//
//  Created by LMK on 2019/8/3.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMAddressManagerViewcontroller.h"
#import "GMAddressManageTableView.h"
#import "GMAddAddressViewController.h"

@interface GMAddressManagerViewcontroller () <GMAddressManageTableViewDelegate>

@property (nonatomic, strong) GMAddressManageTableView *addressTableView;
@property (nonatomic, strong) NSMutableArray <AddressInfoModel *> *dataArray;
@property (nonatomic, copy) SelectAddressCallBack callBack;
@property (nonatomic, assign) NSInteger page;

@end

@implementation GMAddressManagerViewcontroller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"地址管理";
    self.page = 1;
    [self updateNavigationBarNeedBack:YES];
    [self setupConstranits];
    [self requestQueryAddressIsLoadMore:NO];
    [self addRefreshHeaderView];
    [self addRefreshFooterView];
}

- (void)requestQueryAddressIsLoadMore:(BOOL)isLoadMore {
    [GMLoadingActivity showLoadingActivityInView:self.view];
    @weakify(self)
    [ServerAPIManager asyncQueryAddressWithPageSize:@"10" pageNum:isLoadMore ? [NSString stringWithFormat:@"%ld",(long)self.page] : @"1" succeedBlock:^(NSArray * _Nonnull array) {
        @strongify(self)
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        [self endMJRefresh];
        if (array.count == 0) {
            if (!isLoadMore) {
                self.page = 1;
                [self.addressTableView.mj_footer resetNoMoreData];
            } else {
                [self.addressTableView.mj_footer endRefreshingWithNoMoreData];
            }
        } else {
            if (!isLoadMore) {
                self.page = 1;
                [self.dataArray removeAllObjects];
                [self.addressTableView.mj_footer resetNoMoreData];
            }
            self.page ++;
            [self.dataArray addObjectsFromArray:array];
            
            [self.addressTableView reloadTableViewWithDataArray:self.dataArray];
        }
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self)
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        [self showAlertViewWithError:error];
    }];
}

- (void)addAddress {
    GMAddAddressViewController *addVC = [[GMAddAddressViewController alloc] init];
    [addVC addAddressCallBack:^{
        [self requestQueryAddressIsLoadMore:NO];
    }];
    [self.navigationController pushViewController:addVC animated:YES];
}

- (void)addressManageTableView:(UITableView *)tableView
          deleteRowAtIndexPath:(NSIndexPath *)indexPath
                         model:(AddressInfoModel *)model {
    [GMLoadingActivity showLoadingActivityInView:self.view];
    
    @weakify(self)
    [ServerAPIManager asyncDeleteAddressWithAddressId:model.addressId succeedBlock:^{
        @strongify(self)
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [tableView beginUpdates];
        [tableView endUpdates];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self)
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        [self showAlertViewWithError:error];
    }];
}

- (void)addressManagerTableViewDidSelectRowAtModel:(AddressInfoModel *)model {
    if (self.callBack) {
        self.callBack(model);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)setupConstranits {
    [self.addressTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)addRefreshHeaderView {
    @weakify(self)
    self.addressTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        if ([self.addressTableView.mj_footer isRefreshing]) {
            [self.addressTableView.mj_footer endRefreshing];
        }
        [self requestQueryAddressIsLoadMore:NO];
    }];
}

- (void)addRefreshFooterView {
    @weakify(self)
    self.addressTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)
        if ([self.addressTableView.mj_header isRefreshing]) {
            [self.addressTableView.mj_header endRefreshing];
        }
        [self requestQueryAddressIsLoadMore:YES];
    }];
    self.addressTableView.mj_footer.ignoredScrollViewContentInsetBottom = BottomTarBarSpace;
}

- (void)endMJRefresh {
    
    if ([self.addressTableView.mj_header isRefreshing]) {
        [self.addressTableView.mj_header endRefreshing];
    }
    if ([self.addressTableView.mj_footer isRefreshing]) {
        [self.addressTableView.mj_footer endRefreshing];
    }
}

- (NSMutableArray<AddressInfoModel *> *)dataArray {
    if (! _dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (GMAddressManageTableView *)addressTableView {
    if (! _addressTableView) {
        _addressTableView = [[GMAddressManageTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _addressTableView.addressDelegate = self;
        [self.view addSubview:_addressTableView];
    }
    return _addressTableView;
}

- (void)addressManagerSelectAddressCallBack:(SelectAddressCallBack)callBack {
    self.callBack = callBack;
}

@end
