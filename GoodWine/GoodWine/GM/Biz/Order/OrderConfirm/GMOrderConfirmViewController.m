//
//  GMOrderConfirmViewController.m
//  GoodWine
//
//  Created by LMK on 2019/8/14.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMOrderConfirmViewController.h"
#import "GMOrderConfirmTableView.h"
#import "GMOrderConfirmFooterView.h"
#import "GMAddressManagerViewcontroller.h"
#import "GMOrderDetailViewController.h"
#import "QFTimerPicker.h"
#import "GMMyCouponViewController.h"

@interface GMOrderConfirmViewController () <GMOrderConfirmTableViewDelegate>

@property (nonatomic, strong) GMOrderConfirmTableView *orderConfirmTV;
@property (nonatomic, strong) GMOrderConfirmFooterView *orderConfirmFooterView;
@property (nonatomic, strong) NSArray<ShoppCarInfoModel *> *dataArray;
@property (nonatomic, strong) NSArray *idArray;
@property (nonatomic, strong) GMOrderConfirmInfoModels *orderConfirmModel;
@property (nonatomic, strong) GMMyOrderDetailModel *myOrderModel;

@end

@implementation GMOrderConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单确认";
    [self updateNavigationBarNeedBack:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupConstranits];
}

- (void)setupConstranits {
    [self.orderConfirmTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 64.f, 0));
    }];
    
    [self.orderConfirmFooterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(64.f);
    }];
}

#pragma mark -- request --

- (void)reloadOrderConfirmWithshoppCarArray:(NSArray<ShoppCarInfoModel *> *)dataArray idArray:(NSArray *)idArray {
    self.myOrderModel.state = 0; //从购物车进来
    self.myOrderModel.idsArray = idArray;
    
    self.dataArray = dataArray;
    self.idArray = idArray;
    [GMLoadingActivity showLoadingActivityInView:self.view];
    @weakify(self)
    [ServerAPIManager asyncQueryOrderConfirmWithShoppCarIds:self.idArray succeedBlock:^(GMOrderConfirmInfoModels * _Nonnull infoModel) {
        @strongify(self)
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        self.orderConfirmModel = infoModel;
        [self.orderConfirmFooterView updateFooterViewWithModel:infoModel.calcAmountModel];
        [self.orderConfirmTV reloadTableViewWithDataArray:self.dataArray model:infoModel.calcAmountModel];
        if (infoModel.addressArray.count > 0) {
            AddressInfoModel *addressModel = infoModel.addressArray[0];
            self.myOrderModel.memberReceiveAddressId = addressModel.addressId;
            [self.orderConfirmTV reloadTableViewWithAddressModel:addressModel];
        }
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self)
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        [self showAlertViewWithTitle:error.userInfo[GM_Net_Key_ErrInfo] btnNames:@[@"确定"] clickedCallBack:^(NSInteger index) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }];
}

- (void)reloadOrderConfirmWithProductDetail:(GMProductDetailModel *)model skuItem:(GMProductSkuItem *)item quantity:(nonnull NSString *)quantity {
    self.myOrderModel.state = 1; //从商品详情进来
    self.myOrderModel.productDetailModel = model;
    self.myOrderModel.productSkuItem = item;
    self.myOrderModel.quantity = quantity;
    
    [GMLoadingActivity showLoadingActivityInView:self.view];
    @weakify(self)
    [ServerAPIManager asyncQueryOrderConfirmWithProductModel:model skuItem:item quantity:quantity succeedBlock:^(GMOrderConfirmInfoModels * _Nonnull infoModel) {
        @strongify(self)
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        self.orderConfirmModel = infoModel;
        ShoppCarInfoModel *scInfoModel = [[ShoppCarInfoModel alloc] init];
        scInfoModel.productPic = item.pic;
        scInfoModel.productName = model.brandName;
        scInfoModel.productSubTitle = item.sp1;
        scInfoModel.currentPrice = item.price;
        scInfoModel.quantity = quantity;
        NSArray *arr = @[scInfoModel];
        [self.orderConfirmTV reloadTableViewWithDataArray:arr model:infoModel.calcAmountModel];
        if (infoModel.addressArray.count > 0) {
            AddressInfoModel *addressModel = infoModel.addressArray[0];
            self.myOrderModel.memberReceiveAddressId = addressModel.addressId;
            [self.orderConfirmTV reloadTableViewWithAddressModel:addressModel];
        }
        [self.orderConfirmFooterView updateFooterViewWithModel:infoModel.calcAmountModel];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self)
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        [self showAlertViewWithTitle:error.userInfo[GM_Net_Key_ErrInfo] btnNames:@[@"确定"] clickedCallBack:^(NSInteger index) {
//            if ([error.userInfo[GM_Net_Key_ErrCode] integerValue] == 210) {
                [self.navigationController popViewControllerAnimated:YES];
//            }
        }];
    }];
}

#pragma mark -- delegate --
- (void)orderConfirmTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        GMAddressManagerViewcontroller *addressVC = [[GMAddressManagerViewcontroller alloc] init];
        @weakify(self)
        [addressVC addressManagerSelectAddressCallBack:^(AddressInfoModel * _Nonnull model) {
            @strongify(self)
            self.myOrderModel.memberReceiveAddressId = model.addressId;
            [self.orderConfirmTV reloadTableViewWithAddressModel:model];
        }];
        [self.navigationController pushViewController:addressVC animated:YES];
    } else if (indexPath.section == 2) {
        if (indexPath.row == 2) {
            GMMyCouponViewController *vc = [[GMMyCouponViewController alloc] initWithArray:self.orderConfirmModel.couponHistoryArray];
            [vc myCouponCallBack:^(MyCouponInfoModel * _Nonnull model) {
                self.myOrderModel.couponId = model.couponId;
                [self.orderConfirmTV.contentArray replaceObjectAtIndex:2 withObject:model.couponItem.name];
                [self.orderConfirmTV reloadData];
            }];
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 4) {
            QFTimerPicker *picker = [[QFTimerPicker alloc]initWithSuperView:self.view response:^(NSString *selectedStr) {
                NSLog(@"%@",selectedStr);
                NSString *timeStr = [selectedStr stringByReplacingCharactersInRange:NSMakeRange(selectedStr.length - 2, 2) withString:@"00:00"];
                self.myOrderModel.expectedTime = timeStr;
                [self.orderConfirmTV.contentArray replaceObjectAtIndex:4 withObject:timeStr];
                [self.orderConfirmTV reloadData];
            }];
            [picker show];
        }
        
    }
}

- (void)confirmOrderAction:(UIButton *)btn {
    if (self.myOrderModel.memberReceiveAddressId) {
        GMOrderDetailViewController *vc = [[GMOrderDetailViewController alloc] initWithModel:self.myOrderModel];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        [MKToastView showToastToView:self.view text:@"请选择收货地址"];
    }
}

- (GMOrderConfirmTableView *)orderConfirmTV {
    if (! _orderConfirmTV) {
        _orderConfirmTV = [[GMOrderConfirmTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _orderConfirmTV.orderConfirmDelegate = self;
        [self.view addSubview:_orderConfirmTV];
    }
    return _orderConfirmTV;
}

- (GMOrderConfirmFooterView *)orderConfirmFooterView {
    if (! _orderConfirmFooterView) {
        _orderConfirmFooterView = [[GMOrderConfirmFooterView alloc] initWithFrame:CGRectZero];
        [_orderConfirmFooterView.confirmButton addTarget:self action:@selector(confirmOrderAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_orderConfirmFooterView];
    }
    return _orderConfirmFooterView;
}

- (GMMyOrderDetailModel *)myOrderModel {
    if (! _myOrderModel) {
        _myOrderModel = [[GMMyOrderDetailModel alloc] init];
    }
    return _myOrderModel;
}

- (void)dealloc {
    MKNSLog(@"%@ -- dealloc",[self class]);
}

@end
