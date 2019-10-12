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
#import "GMPaySuccessViewController.h"
#import "GMOrderEvaluateViewController.h"

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
    [self updateNavigationBarNeedBack:YES];
    [self setupConstranits];
    [self requestOrderListIsLoadMore:NO];
    
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

- (void)requestOrderListIsLoadMore:(BOOL)isLoadMore {
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

- (void)orderListTableViewStatusAtIndex:(NSInteger)index {
    GMOrderDetailInfoModel *infoModel = self.modelArray[index];
    if ([infoModel.status integerValue] == 0) {
        //去付款
        [self payWithOrderId:infoModel.orderId];
    } else if ([infoModel.status integerValue] == 2) {
        //确认收货
        [self delicerProductWithOrderId:infoModel.orderId];
    } else if ([infoModel.status integerValue] == 3) {
        //去评价
        if ([infoModel.commentType integerValue] != 2) {
            GMOrderEvaluateViewController *vc = [[GMOrderEvaluateViewController alloc] initWithModel:infoModel.orderArray[0]];
            [vc orderEvaluateCallBack:^{
                [self requestOrderListIsLoadMore:NO];
            }];
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else {
        
    }
}

- (void)payWithOrderId:(NSString *)orderId {
    [self showAlertViewInDynamicWithTitle:@"温馨提示" message:@"现在去付款" btnNames:@[@"取消",@"确定"] clickedCallBack:^(NSInteger index) {
        if (index == 1) {
            [GMLoadingActivity showLoadingActivityInView:self.view];
            @weakify(self)
            [ServerAPIManager asyncGetPayDataWithOrderId:orderId succeedBlock:^(NSString * _Nonnull data) {
                @strongify(self)
                [GMLoadingActivity hideLoadingActivityInView:self.view];
                [[AlipaySDK defaultService] payOrder:data fromScheme:GMUrlSchemes callback:^(NSDictionary *resultDic) {
                    @strongify(self)
                    NSLog(@"reslut = %@",resultDic);
                    if ([resultDic[@"resultStatus"] integerValue] == 9000) {
                        GMPaySuccessViewController *vc = [[GMPaySuccessViewController alloc] init];
                        [self.navigationController pushViewController:vc animated:YES];
                    } else {
                        NSInteger orderState = [resultDic[@"resultStatus"] integerValue];
                        NSString *returnStr;
                        switch (orderState) {
                            case 8000:
                                returnStr=@"订单正在处理中";
                                break;
                            case 4000:
                                returnStr=@"订单支付失败";
                                
                                break;
                            case 6001:
                                returnStr=@"订单取消";
                                
                                break;
                            case 6002:
                                returnStr=@"网络连接出错";
                                
                                break;
                            default:
                                break;
                        }
                        [MKToastView showToastToView:self.view text:returnStr];
                    }
                }];
            } failedBlock:^(NSError * _Nonnull error) {
                @strongify(self)
                [GMLoadingActivity hideLoadingActivityInView:self.view];
                [self showAlertViewWithError:error];
            }];
        }
    }];
}

- (void)delicerProductWithOrderId:(NSString *)orderId {
    [self showAlertViewWithTitle:@"是否确认收货" btnNames:@[@"取消",@"收货"] clickedCallBack:^(NSInteger index) {
        if (index == 1) {
            [GMLoadingActivity showLoadingActivityInView:self.view];
            @weakify(self)
            [ServerAPIManager asyncDeliverProductWithOrderId:orderId succeedBlock:^{
                @strongify(self)
                [self.orderListTableView reloadData];
                [MKToastView showToastToView:self.view text:@"收货成功"];
            } failedBlock:^(NSError * _Nonnull error) {
                @strongify(self)
                [GMLoadingActivity hideLoadingActivityInView:self.view];
                [self showAlertViewWithError:error];
            }];
        }
    }];
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
        [self requestOrderListIsLoadMore:NO];
    }];
}

- (void)addRefreshFooterView {
    @weakify(self)
    self.orderListTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)
        if ([self.orderListTableView.mj_header isRefreshing]) {
            [self.orderListTableView.mj_header endRefreshing];
        }
        [self requestOrderListIsLoadMore:YES];
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
