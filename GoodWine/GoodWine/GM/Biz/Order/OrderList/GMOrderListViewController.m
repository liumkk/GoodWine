//
//  GMOrderListViewController.m
//  GoodWine
//
//  Created by LMK on 2019/9/9.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMOrderListViewController.h"
#import "GMOrderListTableView.h"
#import <AlipaySDK/AlipaySDK.h>

@interface GMOrderListViewController () <GMOrderListTableViewDelegate>

@property (nonatomic, strong) GMOrderListTableView *orderListTableView;
@property (nonatomic, strong) NSMutableArray <GMOrderDetailInfoModel *> *modelArray;
@property (nonatomic, strong) MKEmptyView *emptyView;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, assign) NSInteger page;


@end

@implementation GMOrderListViewController

- (instancetype)initWithStatus:(NSString *)status {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.status = status;
        self.title = [self.status statusFormatter];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self updateNavigationBar];
    [self setupConstranits];
    [self requestOrderListStatus:self.status isLoadMore:NO];
    
    [self addRefreshHeaderView];
    [self addRefreshFooterView];
}

- (void)setupConstranits {
    [self.orderListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)requestOrderListStatus:(NSString *)status isLoadMore:(BOOL)isLoadMore {
    [GMLoadingActivity showLoadingActivityInView:self.view];
    @weakify(self)
    [ServerAPIManager asyncQueryOrderListWithPageSize:@"10" pageNum:isLoadMore ? [NSString stringWithFormat:@"%ld",(long)self.page] : @"1" status:self.status succeedBlock:^(NSArray<GMOrderDetailInfoModel *> * _Nonnull array) {
        @strongify(self)
//        self.modelArray = array;
//        [self.orderListTableView reloadTableViewWithDataArray:self.modelArray];
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        [self endMJRefresh];
        if (array.count == 0) {
            if (!isLoadMore) {
                self.page = 1;
                [self.emptyView showEmptyNeedLoadBtn:NO];
                [self.orderListTableView.mj_footer resetNoMoreData];
            } else {
                [self.orderListTableView.mj_footer endRefreshingWithNoMoreData];
            }
        } else {
            if (!isLoadMore) {
                self.page = 1;
                [self.modelArray removeAllObjects];
                [self.orderListTableView.mj_footer resetNoMoreData];
            }
            self.page ++;
            [self.modelArray addObjectsFromArray:array];
            
            self.emptyView.hidden = YES;
            [self.orderListTableView reloadTableViewWithDataArray:self.modelArray];
        }
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self)
        [self.emptyView showEmptyNeedLoadBtn:NO];
        [self showAlertViewWithError:error];
    }];
}

- (void)orderListTableViewDidSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GMOrderDetailInfoModel *infoModel = self.modelArray[indexPath.section];
    if ([infoModel.status integerValue] == 0) {
        @weakify(self)
        [ServerAPIManager asyncGetPayDataWithOrderId:infoModel.orderId succeedBlock:^(NSString * _Nonnull data) {
            
            [[AlipaySDK defaultService] payOrder:data fromScheme:GMUrlSchemes callback:^(NSDictionary *resultDic) {
                NSLog(@"reslut = %@",resultDic);
                if ([resultDic[@"resultStatus"] isEqualToString:@"6001"]) {
                    //用户取消
                    [MKToastView showToastToView:self.view text:@"已取消支付"];
                }
            }];
        } failedBlock:^(NSError * _Nonnull error) {
            @strongify(self)
            [self showAlertViewWithError:error];
        }];
    }
}

- (void)orderListTableViewDeleteRowAtIndexPath:(NSIndexPath *)indexPath {
//    GMOrderDetailInfoModel *infoModel = self.modelArray[indexPath.section];
//    [ServerAPIManager asyncDeleteProductWithShoppCarIds:@[1] succeedBlock:^{
//        [self.modelArray removeObjectAtIndex:index];
//        //        [self.shoppCarTV reloadTableViewWithDataArray:self.dataArray];
//        [self.orderListTableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationNone];
//        [self.modelArray beginUpdates];
//        [self.modelArray endUpdates];
//    } failedBlock:^(NSError * _Nonnull error) {
//        [self showAlertViewWithError:error];
//    }];
}

- (void)addRefreshHeaderView {
    @weakify(self)
    self.orderListTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        if ([self.orderListTableView.mj_footer isRefreshing]) {
            [self.orderListTableView.mj_footer endRefreshing];
        }
        [self requestOrderListStatus:self.status isLoadMore:NO];
    }];
}

- (void)addRefreshFooterView {
    @weakify(self)
    self.orderListTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)
        if ([self.orderListTableView.mj_header isRefreshing]) {
            [self.orderListTableView.mj_header endRefreshing];
        }
        [self requestOrderListStatus:self.status isLoadMore:YES];
    }];
    self.orderListTableView.mj_footer.ignoredScrollViewContentInsetBottom = BottomTarBarSpace;
}

- (void)endMJRefresh {
    
    if ([self.orderListTableView.mj_header isRefreshing]) {
        [self.orderListTableView.mj_header endRefreshing];
    }
    if ([self.orderListTableView.mj_footer isRefreshing]) {
        [self.orderListTableView.mj_footer endRefreshing];
    }
}

- (GMOrderListTableView *)orderListTableView {
    if (! _orderListTableView) {
        _orderListTableView = [[GMOrderListTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _orderListTableView.orderListDelegate = self;
        [self.view addSubview:_orderListTableView];
    }
    return _orderListTableView;
}
     
- (NSMutableArray<GMOrderDetailInfoModel *> *)modelArray {
     if(! _modelArray) {
         _modelArray = [[NSMutableArray alloc] init];
     }
     return _modelArray;
    
}

- (MKEmptyView *)emptyView {
    if (! _emptyView) {
        _emptyView = [[MKEmptyView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_emptyView];
    }
    return _emptyView;
}
     
@end
