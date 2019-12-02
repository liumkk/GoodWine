//
//  GMOrderDetailViewController.m
//  GoodWine
//
//  Created by LMK on 2019/8/31.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMOrderDetailViewController.h"
#import "GMOrderDetailTableView.h"
#import "GMOrderDetailFooterView.h"
#import "GMOrderPayViewController.h"
#import "GMOrderEvaluateViewController.h"

@interface GMOrderDetailViewController () <GMOrderDetailTableViewDelegate>

@property (nonatomic, copy) GMOrderDetailTableView *detailTableView;
@property (nonatomic, strong) GMMyOrderDetailModel *myOrderModel;
@property (nonatomic, strong) GMOrderDetailFooterView *footerView;
@property (nonatomic, strong) GMOrderDetailInfoModel *orderDetailInfoModel;

@property (nonatomic, strong) GMOrderDetailInfoModel *orderModel;

@end

@implementation GMOrderDetailViewController

- (instancetype)initWithModel:(GMMyOrderDetailModel *)model {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.myOrderModel = model;
        [self requestOrderDetail];
    }
    return self;
}

//从订单列表进入时调用
- (instancetype)initWithOrderModel:(GMOrderDetailInfoModel *)orderModel {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.orderModel = orderModel;
        [self requestQueryOrderDetail];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self updateNavigationBarNeedBack:YES];
    [self setupConstranits];
    [self updateHeaderView];
}

- (void)setupConstranits {
    
    [self.detailTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 64.f, 0));
    }];
    
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(64.f);
    }];
}

- (void)requestQueryOrderDetail {
    [GMLoadingActivity showLoadingActivityInView:self.view];
    @weakify(self)
    [ServerAPIManager asyncQueryOrderWithOrderId:self.orderModel.orderId succeedBlock:^(GMOrderDetailInfoModel * model) {
        @strongify(self)
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        self.orderDetailInfoModel = model;
        [self.detailTableView reloadTableViewWithModel:model];
        [self.footerView updateFooterViewWithOrderDetailModel:model];
    } failedBlock:^(NSError * error) {
        @strongify(self)
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        [self showAlertViewWithError:error];
    }];
}

- (void)requestOrderDetail {
    if (self.myOrderModel.state == 0) {
        [GMLoadingActivity showLoadingActivityInView:self.view];
        @weakify(self)
        [ServerAPIManager asyncQueryOrderDetailWithModel:self.myOrderModel succeedBlock:^(GMOrderDetailInfoModel * model) {
            @strongify(self)
            [GMLoadingActivity hideLoadingActivityInView:self.view];
            //购物车商品生成订单后，会从购物车中移除
            [[NSNotificationCenter defaultCenter] postNotificationName:Notification_addProduct object:nil];
            self.orderDetailInfoModel = model;
            [self.detailTableView reloadTableViewWithModel:model];
            [self.footerView updateFooterViewWithOrderDetailModel:model];
        } failedBlock:^(NSError * error) {
            @strongify(self)
            [GMLoadingActivity hideLoadingActivityInView:self.view];
            [self showAlertViewWithError:error];
        }];
    } else {
        [GMLoadingActivity showLoadingActivityInView:self.view];
        @weakify(self)
        [ServerAPIManager asyncQueryOrderDetailProductWithModel:self.myOrderModel succeedBlock:^(GMOrderDetailInfoModel * _Nonnull model) {
            @strongify(self)
            [GMLoadingActivity hideLoadingActivityInView:self.view];
            self.orderDetailInfoModel = model;
            [self.detailTableView reloadTableViewWithModel:model];
            [self.footerView updateFooterViewWithOrderDetailModel:model];
        } failedBlock:^(NSError * _Nonnull error) {
            @strongify(self)
            [GMLoadingActivity hideLoadingActivityInView:self.view];
            [self showAlertViewWithError:error];
        }];
    }
}

- (void)payOrder {
    if ([self.orderModel.status integerValue] == 0) {
        GMOrderPayViewController *vc = [[GMOrderPayViewController alloc] initWithOrderDetailModel:self.orderDetailInfoModel];
        vc.OrderPayVCCallBack = ^{
            self.OrderDetailVCCallBack();
            self.orderModel.status = @"1";
            [self.detailTableView.detailHeaderView updateOrderDetailHeaderViewWithModel:self.orderModel];
        };
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([self.orderModel.status integerValue] == 2) {
        //确认收货
        [self delicerProductWithOrderId:self.orderModel.orderId];
    } else if ([self.orderModel.status integerValue] == 3) {
        if ([self.orderModel.commentType integerValue] != 2) {
            GMOrderEvaluateViewController *vc = [[GMOrderEvaluateViewController alloc] initWithModel:self.orderModel.orderArray[0]];
            [vc orderEvaluateCallBack:^{
                self.OrderDetailVCCallBack();
                
                self.orderModel.commentType = @"2";
                [self.detailTableView.detailHeaderView updateOrderDetailHeaderViewWithModel:self.orderModel];
            }];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            [self popToHomeVC];
        }
    } else{
        //回到首页
        [self popToHomeVC];
    }
}

- (void)popToHomeVC {
    [self.navigationController popToRootViewControllerAnimated:NO];
    [ViewControllerManager.tabBarController setSelectedIndex:0];
}

- (void)updateHeaderView {
    if ([self.orderModel.status integerValue] == 0 || [self.orderModel.status integerValue] == 1) {
        self.footerView.cancleBtn.hidden = NO;
    }
    [self.detailTableView.detailHeaderView updateOrderDetailHeaderViewWithModel:self.orderModel];
}

- (void)delicerProductWithOrderId:(NSString *)orderId {

    [self showAlertViewWithTitle:@"是否确认收货" btnNames:@[@"取消",@"收货"] clickedCallBack:^(NSInteger index) {
        if (index == 1) {
            [GMLoadingActivity showLoadingActivityInView:self.view];
            @weakify(self)
            [ServerAPIManager asyncDeliverProductWithOrderId:orderId succeedBlock:^{
                @strongify(self)
                [GMLoadingActivity hideLoadingActivityInView:self.view];
                self.OrderDetailVCCallBack();
                
                [MKToastView showToastToView:self.view text:@"收货成功"];
                self.orderModel.status = @"3";
                [self.detailTableView.detailHeaderView updateOrderDetailHeaderViewWithModel:self.orderModel];
            } failedBlock:^(NSError * _Nonnull error) {
                @strongify(self)
                [GMLoadingActivity hideLoadingActivityInView:self.view];
                [self showAlertViewWithError:error];
            }];
        }
    }];
}

- (void)cancleOrderAction:(UIButton *)btn {
    [GMLoadingActivity showLoadingActivityInView:self.view];
    @weakify(self)
    [ServerAPIManager asyncDeleteOrder:self.orderDetailInfoModel.orderId succeedBlock:^{
        @strongify(self)
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        self.OrderDetailVCCallBack();
        
        [MKToastView showToastToView:self.view text:@"取消订单成功"];
        self.footerView.cancleBtn.hidden = YES;
        self.orderModel.status = @"4";
        [self.detailTableView.detailHeaderView updateOrderDetailHeaderViewWithModel:self.orderModel];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self)
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        [self showAlertViewWithError:error];
    }];
}

- (void)phoneServiceAction:(UIButton *)btn {
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",UserCenter.storeInfoModel.contactPhone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

- (void)back {
    if (self.myOrderModel) {
        NSInteger index=[[self.navigationController viewControllers] indexOfObject:self];
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index-2] animated:YES];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (GMOrderDetailInfoModel *)orderModel {
    if (! _orderModel) {
        _orderModel = [[GMOrderDetailInfoModel alloc] init];
    }
    return _orderModel;
}

- (GMOrderDetailTableView *)detailTableView {
    if (! _detailTableView) {
        _detailTableView = [[GMOrderDetailTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _detailTableView.orderDetailDelegate = self;
        [self.view addSubview:_detailTableView];
    }
    return _detailTableView;
}

- (GMOrderDetailFooterView *)footerView {
    if (! _footerView) {
        _footerView = [[GMOrderDetailFooterView alloc] initWithFrame:CGRectZero];
        _footerView.cancleBtn.hidden = YES;
        [_footerView.cancleBtn addTarget:self action:@selector(cancleOrderAction:) forControlEvents:UIControlEventTouchUpInside];
        [_footerView.phoneBtn addTarget:self action:@selector(phoneServiceAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_footerView];
    }
    return _footerView;
}

@end
