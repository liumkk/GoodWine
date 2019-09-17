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

@interface GMOrderDetailViewController () <GMOrderDetailTableViewDelegate>

@property (nonatomic, copy) GMOrderDetailTableView *detailTableView;
@property (nonatomic, strong) GMMyOrderDetailModel *myOrderModel;
@property (nonatomic, strong) GMOrderDetailFooterView *footerView;
@property (nonatomic, strong) GMOrderDetailInfoModel *orderDetailInfoModel;

@end

@implementation GMOrderDetailViewController

- (instancetype)initWithModel:(GMMyOrderDetailModel *)model {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.myOrderModel = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self updateNavigationBar];
    [self setupConstranits];
    
    [self requestOrderDetail];
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

- (void)requestOrderDetail {
    if (self.myOrderModel.state == 0) {
        @weakify(self)
        [ServerAPIManager asyncQueryOrderDetailWithModel:self.myOrderModel succeedBlock:^(GMOrderDetailInfoModel * model) {
            @strongify(self)
            //购物车商品生成订单后，会从购物车中移除
            [[NSNotificationCenter defaultCenter] postNotificationName:Notification_addProduct object:nil];
            self.orderDetailInfoModel = model;
            [self.detailTableView reloadTableViewWithModel:model myModel:self.myOrderModel];
            [self.footerView updateFooterViewWithOrderDetailModel:model];
        } failedBlock:^(NSError * error) {
            @strongify(self)
            [self showAlertViewWithError:error];
        }];
    } else {
        @weakify(self)
        [ServerAPIManager asyncQueryOrderDetailProductWithModel:self.myOrderModel succeedBlock:^(GMOrderDetailInfoModel * _Nonnull model) {
            @strongify(self)
            self.orderDetailInfoModel = model;
            [self.detailTableView reloadTableViewWithModel:model myModel:self.myOrderModel];
            [self.footerView updateFooterViewWithOrderDetailModel:model];
        } failedBlock:^(NSError * _Nonnull error) {
            @strongify(self)
            [self showAlertViewWithError:error];
        }];
    }
}

- (void)payOrder {
    GMOrderPayViewController *vc = [[GMOrderPayViewController alloc] initWithOrderDetailModel:self.orderDetailInfoModel];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)cancleOrderAction:(UIButton *)btn {
    @weakify(self)
    [ServerAPIManager asyncDeleteOrder:self.orderDetailInfoModel.orderId succeedBlock:^{
        @strongify(self)
        [MKToastView showToastToView:self.view text:@"取消订单成功"];
        self.footerView.cancleBtn.hidden = YES;
        [self.detailTableView.detailHeaderView updateOrderDetailHeaderViewWithStatus:@"已关闭" content:@"订单已关闭" btnTitle:@"继续购买"];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self)
        [self showAlertViewWithError:error];
    }];
}

- (void)phoneServiceAction:(UIButton *)btn {
    
}

- (void)back {
    NSInteger index=[[self.navigationController viewControllers] indexOfObject:self];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index-2]animated:YES];
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
        [_footerView.cancleBtn addTarget:self action:@selector(cancleOrderAction:) forControlEvents:UIControlEventTouchUpInside];
        [_footerView.phoneBtn addTarget:self action:@selector(phoneServiceAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_footerView];
    }
    return _footerView;
}

@end
