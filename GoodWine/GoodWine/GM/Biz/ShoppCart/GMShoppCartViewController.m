//
//  GMShoppCartViewController.m
//  GoodWine
//
//  Created by LMK on 2019/5/28.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMShoppCartViewController.h"
#import "GMShoppCarTableView.h"
#import "GMShoppCarFooterView.h"
#import "GMOrderConfirmViewController.h"
#import "GMProductDetailViewController.h"

@interface GMShoppCartViewController () <GMShoppCarTableViewDelegate>

@property (nonatomic, strong) GMShoppCarTableView *shoppCarTV;
@property (nonatomic, strong) GMShoppCarFooterView *footerView;
@property (nonatomic, strong) NSMutableArray <ShoppCarInfoModel *> *dataArray;

@end

@implementation GMShoppCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubviews];
    [self setupConstranits];
    [self requestQueryShoppCarList];
    [self addRefreshHeaderView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableView:) name:Notification_addProduct object:nil];
}

- (void)initSubviews {
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"购物车";
    [self updateNavigationBarNeedBack:NO];
}

- (void)refreshTableView: (NSNotification *) notification {
    [self requestQueryShoppCarList];
}

- (void)requestQueryShoppCarList {
    [GMLoadingActivity showLoadingActivityInView:self.view];
    [ServerAPIManager asyncQueryShoppCarListWithSucceedBlock:^(NSArray<ShoppCarInfoModel *> * _Nonnull array) {
        [self endMJRefresh];
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:array];
        [self.shoppCarTV reloadTableViewWithDataArray:self.dataArray];
        self.footerView.allSelectBtn.selected = NO;
    } failedBlock:^(NSError * _Nonnull error) {
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        [self endMJRefresh];
        [self showAlertViewWithError:error];
    }];
}

- (void)shoppCarTableViewDidSelectRowAtIndex:(NSInteger)index {
    ShoppCarInfoModel *model = self.dataArray[index];
    GMProductDetailViewController *vc = [[GMProductDetailViewController alloc] initWithProductId:model.productId];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)shoppCarTableCellSelectBtn:(UIButton *)btn {
    btn.selected = !btn.selected;
    
    ShoppCarInfoModel *infoModel = self.dataArray[btn.tag - 1];
    infoModel.isSelected = btn.selected;
    [self.shoppCarTV reloadTableViewWithDataArray:self.dataArray];
    
    
    for (ShoppCarInfoModel *infoModel in self.dataArray) {
        if ([infoModel.invalidStatus isEqualToString:@"0"]) {
            if (!infoModel.isSelected) {
                self.footerView.allSelectBtn.selected = NO;
                break;
            } else {
                self.footerView.allSelectBtn.selected = YES;
            }
        }
    }
}

- (void)allSelectBtnAction:(UIButton *)btn {
    btn.selected = !btn.selected;
    for (ShoppCarInfoModel *infoModel in self.dataArray) {
        infoModel.isSelected = btn.selected;
        [self.shoppCarTV reloadTableViewWithDataArray:self.dataArray];
    }
}

- (void)checkoutBtnAction:(UIButton *)btn {

    NSMutableArray *selectArray = [[NSMutableArray alloc] init];
    NSMutableArray *idsArray = [[NSMutableArray alloc] init];
    for (ShoppCarInfoModel *infoModel in self.dataArray) {
        if (infoModel.isSelected == YES && [infoModel.invalidStatus isEqualToString:@"0"]) {
            [selectArray addObject:infoModel];
            [idsArray addObject:infoModel.shoppCarId];
        }
    }
    if (selectArray.count > 0) {
        GMOrderConfirmViewController *orderConfirmVC = [[GMOrderConfirmViewController alloc] init];
        orderConfirmVC.hidesBottomBarWhenPushed = YES;
        [orderConfirmVC reloadOrderConfirmWithshoppCarArray:selectArray idArray:idsArray];
        [self.navigationController pushViewController:orderConfirmVC animated:YES];
    } else {
        [MKToastView showToastToView:self.view text:@"请选择至少一种商品~"];
    }
}

- (void)addNumAtIndex:(NSInteger)index isAdd:(BOOL)isAdd {
    ShoppCarInfoModel *model = self.dataArray[index];
    if ([model.quantity integerValue] == 99 && isAdd) {
        [MKToastView showToastToView:self.view text:@"数量足够多啦~"];
    } else if ([model.quantity integerValue] == 1 && !isAdd) {
        [MKToastView showToastToView:self.view text:@"不可以再减少了哦~"];
    } else {
        NSString *quantity;
        if (isAdd) {
            quantity = [NSString stringWithFormat:@"%d",[model.quantity integerValue] + 1];
        } else {
            quantity = [NSString stringWithFormat:@"%d",[model.quantity integerValue] - 1];
        }
        [ServerAPIManager asyncModifyProductNumWithShoppId:model.shoppCarId quantity:quantity succeedBlock:^{
            model.quantity = quantity;
            [self.shoppCarTV reloadTableViewWithDataArray:self.dataArray];
        } failedBlock:^(NSError * _Nonnull error) {
            [self showAlertViewWithError:error];
        }];
    }
}

- (void)shoppCarTableViewDeleteRowAtIndex:(NSInteger)index {

    ShoppCarInfoModel *infoModel = self.dataArray[index];
    [ServerAPIManager asyncDeleteProductWithShoppCarIds:@[infoModel.shoppCarId] succeedBlock:^{
        [self.dataArray removeObjectAtIndex:index];
//        [self.shoppCarTV reloadTableViewWithDataArray:self.dataArray];
        [self.shoppCarTV deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        [self.shoppCarTV beginUpdates];
        [self.shoppCarTV endUpdates];
    } failedBlock:^(NSError * _Nonnull error) {
        [self showAlertViewWithError:error];
    }];
}

- (void)setupConstranits {
    [self.shoppCarTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset( - 50.f);
    }];
    
    [self.view addSubview:self.footerView];
}

- (void)addRefreshHeaderView {
    @weakify(self)
    self.shoppCarTV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        [self requestQueryShoppCarList];
    }];
}

- (void)endMJRefresh {
    
    if ([self.shoppCarTV.mj_header isRefreshing]) {
        [self.shoppCarTV.mj_header endRefreshing];
    }
}

- (GMShoppCarTableView *)shoppCarTV {
    if (! _shoppCarTV) {
        _shoppCarTV = [[GMShoppCarTableView alloc] initWithFrame:CGRectZero];
        _shoppCarTV.shoppCarCellDelegate = self;
        [self.view addSubview:_shoppCarTV];
    }
    return _shoppCarTV;
}

- (GMShoppCarFooterView *)footerView {
    if (! _footerView) {
        _footerView = [[GMShoppCarFooterView alloc] initWithFrame:CGRectMake(0, Height_Screen - TabBarHeight - 50.f-NavigationBarAndStatusBarHeight, Width_Screen, 50.f)];
        [_footerView.allSelectBtn addTarget:self action:@selector(allSelectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_footerView.checkoutBtn addTarget:self action:@selector(checkoutBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footerView;
}

- (NSMutableArray<ShoppCarInfoModel *> *)dataArray {
    if (! _dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Notification_addProduct object:nil];
}

@end
