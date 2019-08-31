//
//  GMProductDetailViewController.m
//  GoodWine
//
//  Created by LMK on 2019/8/16.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMProductDetailViewController.h"
#import "GMProductDetailTableView.h"
#import "GMProductDetailFooterView.h"
#import "GMProductEvaluateViewController.h"
#import "GMSelectProductView.h"
#import "GMOrderConfirmViewController.h"
#import "GMCouponViewController.h"

#define footerView_height           50.f

@interface GMProductDetailViewController () <GMProductDetailTableViewDelegate,GMSelectProductViewDelegate>

@property (nonatomic, strong) GMProductDetailTableView *productDetailTV;
@property (nonatomic, strong) GMProductDetailFooterView *productDetailFooterView;
@property (nonatomic, strong) ProductInfoModel *productInfoModel;
@property (nonatomic, strong) NSArray <ProductEvaluateInfoModel*>*evaluateArray;
@property (nonatomic, strong) GMSelectProductView *selectView;
@property (nonatomic, strong) GMMaskView *maskView;
@property (nonatomic, assign) BOOL isBuy;

@end

@implementation GMProductDetailViewController

- (instancetype)initWithProductId:(NSString *)productId {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        [self requestProductDetailWithProductId:productId];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情";
    [self updateNavigationBar];
    
    [self setupConstranits];
    
    @weakify(self)
    [self.maskView touchesBegan:^{
        @strongify(self)
        self.selectView.frame = CGRectMake(0, Height_Screen, Width_Screen, self.selectView.bgView.height);
        self.maskView.hidden = YES;
    }];
}

- (void)setupConstranits {
    [self.productDetailTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, footerView_height + BottomTarBarSpace, 0));
    }];
    
    [self.productDetailFooterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-BottomTarBarSpace);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(footerView_height);
    }];
    
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)requestProductDetailWithProductId:(NSString *)productId {
    [GMLoadingActivity showLoadingActivityInView:self.view];
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
     @weakify(self)
    [ServerAPIManager asyncQueryProductDetailWithProductId:productId succeedBlock:^(ProductInfoModel * _Nonnull model) {
        @strongify(self)
        self.productInfoModel = model;
        dispatch_group_leave(group);
    } failedBlock:^(NSError *error) {
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [ServerAPIManager asyncQueryProductEvaluateWithProductId:productId succeedBlock:^(NSArray<ProductEvaluateInfoModel *> * _Nonnull dataArray) {
        @strongify(self)
        self.evaluateArray = dataArray;
        dispatch_group_leave(group);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_group_leave(group);
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        @strongify(self)
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        [self.productDetailTV reloadTableViewWithModel:self.productInfoModel.productDetailModel evaluateArray:self.evaluateArray];
        [self.selectView updateSelectProductViewWithModel:self.productInfoModel.productDetailModel];
        [self.productDetailFooterView collectBtnSelected:self.productInfoModel.collectionFlag];
    });
}

- (void)productDetailTableViewDidSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 0) {
        GMCouponViewController *vc = [[GMCouponViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)showAllEvaluate {
    GMProductEvaluateViewController *peVC = [[GMProductEvaluateViewController alloc] initWithDataArray:self.evaluateArray];
    [self.navigationController pushViewController:peVC animated:YES];
}

- (void)collectProductAction:(UIButton *)btn {
  
    if (btn.selected) {
        [ServerAPIManager asyncDeleteCollectWithProductId:self.productInfoModel.productDetailModel.productId succeedBlock:^{
            [MKToastView showToastToView:self.view text:@"已取消关注"];
            [self.productDetailFooterView collectBtnSelected:NO];
        } failedBlock:^(NSError * _Nonnull error) {
            [self showAlertViewWithError:error];
        }];
    } else {
        [ServerAPIManager asyncCollectProductWithModel:self.productInfoModel.productDetailModel succeedBlock:^{
            [MKToastView showToastToView:self.view text:@"关注成功"];
            [self.productDetailFooterView collectBtnSelected:YES];
        } failedBlock:^(NSError * _Nonnull error) {
            [self showAlertViewWithError:error];
        }];
    }
    
}

- (void)serviceAction:(UIButton *)btn {
    
}

- (void)shoppCarAction:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:NO];
    [ViewControllerManager.tabBarController setSelectedIndex:1];
}

- (void)joinShoppCarAction:(UIButton *)btn {
    self.isBuy = NO;
    self.maskView.hidden = NO;
    [self.selectView setNeedsLayout];
    @weakify(self)
    [UIView animateWithDuration:0.3 animations:^{
        @strongify(self)
        self.selectView.frame = CGRectMake(0, Height_Screen - NavigationBarAndStatusBarHeight - self.selectView.bgView.height, Width_Screen, self.selectView.bgView.height);
    }];
}

- (void)buyAction:(UIButton *)btn {
    self.isBuy = YES;
    self.maskView.hidden = NO;
    [self.selectView setNeedsLayout];
    @weakify(self)
    [UIView animateWithDuration:0.3 animations:^{
        @strongify(self)
        self.selectView.frame = CGRectMake(0, Height_Screen - NavigationBarAndStatusBarHeight - self.selectView.bgView.height, Width_Screen, self.selectView.bgView.height);
    }];
}

- (void)selectProductWithItem:(GMProductSkuItem *)item buyNum:(NSString *)buyNum {
    if (self.isBuy) {
        GMOrderConfirmViewController *vc = [[GMOrderConfirmViewController alloc] init];
        [vc reloadOrderConfirmWithProductDetail:self.productInfoModel.productDetailModel skuItem:item quantity:buyNum];
        self.selectView.frame = CGRectMake(0, Height_Screen, Width_Screen, self.selectView.bgView.height);
        self.maskView.hidden = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        @weakify(self)
        [ServerAPIManager asyncAddShoppCarWithDetailModel:self.productInfoModel.productDetailModel skuItem:item quantity:buyNum succeedBlock:^{
           @strongify(self)
            [[NSNotificationCenter defaultCenter] postNotificationName:Notification_addProduct object:nil];
            self.selectView.frame = CGRectMake(0, Height_Screen, Width_Screen, self.selectView.bgView.height);
            self.maskView.hidden = YES;
//            [MKToastView showToastToView:self.view text:@"添加购物车成功"];
            [self showAlertViewWithTitle:@"添加购物车成功"];
        } failedBlock:^(NSError * error) {
            [self showAlertViewWithError:error];
        }];
    }
}

- (GMProductDetailTableView *)productDetailTV {
    if (! _productDetailTV) {
        _productDetailTV = [[GMProductDetailTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _productDetailTV.productDetailDelegate = self;
        [self.view addSubview:_productDetailTV];
    }
    return _productDetailTV;
}

- (GMProductDetailFooterView *)productDetailFooterView {
    if (! _productDetailFooterView) {
        _productDetailFooterView = [[GMProductDetailFooterView alloc] initWithFrame:CGRectZero];
        [_productDetailFooterView.collectBtn addTarget:self action:@selector(collectProductAction:) forControlEvents:UIControlEventTouchUpInside];
        [_productDetailFooterView.serviceBtn addTarget:self action:@selector(serviceAction:) forControlEvents:UIControlEventTouchUpInside];
        [_productDetailFooterView.shoppCarBtn addTarget:self action:@selector(shoppCarAction:) forControlEvents:UIControlEventTouchUpInside];
        [_productDetailFooterView.joinShoppCarBtn addTarget:self action:@selector(joinShoppCarAction:) forControlEvents:UIControlEventTouchUpInside];
        [_productDetailFooterView.buyButton addTarget:self action:@selector(buyAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_productDetailFooterView];
    }
    return _productDetailFooterView;
}

- (GMSelectProductView *)selectView {
    if (! _selectView) {
        _selectView = [[GMSelectProductView alloc] initWithFrame:CGRectMake(0, Height_Screen + NavigationBarAndStatusBarHeight, Width_Screen, 200.f)];
        _selectView.selectProductDelegate = self;
        [self.view addSubview:_selectView];
    }
    return _selectView;
}

- (GMMaskView *)maskView {
    if (! _maskView) {
        _maskView = [[GMMaskView alloc] initWithFrame:CGRectMake(0, 0, Width_Screen, Height_Screen)];
        _maskView.hidden = YES;
        [self.view addSubview:_maskView];
    }
    return _maskView;
}

- (void)dealloc {
    
}

@end
