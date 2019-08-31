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
#import "MkEmptyView.h"

@interface GMProductAreaViewController () <GMProductAreaCollectionViewDelegate,GMBrandAreaTableViewDelegate>

@property (nonatomic, strong) GMBrandAreaTableView *brandTableView;
@property (nonatomic, strong) GMProductAreaCollectionView *productCollectionView;
@property (nonatomic, copy) NSString *cateId;
@property (nonatomic, strong) NSArray <BrandAreaInfoModel *> *brandArray;
@property (nonatomic, strong) MKEmptyView *emptyView;


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
    [self updateNavigationBar];
    
    [self setupConstranits];
    
    [self requestBrand];
}

- (void)setupConstranits {
    [self.brandTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.view);
        make.width.mas_equalTo(75.f);
    }];
    
    [self.productCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
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
        make.edges.equalTo(self.productCollectionView);
    }];
}

- (void)requestBrand {
    [GMLoadingActivity showLoadingActivityInView:self.view];
    [ServerAPIManager asyncQueryBrandClassWithCateId:self.cateId succeedBlock:^(NSArray<BrandAreaInfoModel *> * _Nonnull array) {
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        MKNSLog(@"requestBrand--%@",array);
        self.brandArray = array;
        [self.brandTableView reloadTableViewWithDataArray:array];
        if (self.brandArray.count > 0) {
            BrandAreaInfoModel *model = self.brandArray[0];
            [self requestProductWithBrandId:model.brandId];
        } else {
            [self.emptyView showEmptyNeedLoadBtn:NO];
        }
    } failedBlock:^(NSError * _Nonnull error) {
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        [self showAlertViewWithError:error];
    }];
}

- (void)requestProductWithBrandId:(NSString *)brandId {
    [GMLoadingActivity showLoadingActivityInView:self.view];
    [ServerAPIManager asyncQueryProductWithCateId:self.cateId brandId:brandId succeedBlock:^(NSArray<HomePageTypeItem *> * _Nonnull array) {
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        MKNSLog(@"requestProduct--%@",array);
        [self.productCollectionView reloadProductAreaCollectionWithDataArray:array];
        if (array.count > 0) {
            self.emptyView.hidden = YES;
        } else {
            [self.emptyView showEmptyNeedLoadBtn:NO];
            [self updateEmptyView];
        }
    } failedBlock:^(NSError * _Nonnull error) {
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        [self showAlertViewWithError:error];
    }];
}

- (void)brandAreaTableViewDidSelectRowAtIndex:(NSInteger)index {
    BrandAreaInfoModel *model = self.brandArray[index];
    [self requestProductWithBrandId:model.brandId];
}

- (void)collectionViewDidSelectItemWithModel:(HomePageTypeItem *)model {
    GMProductDetailViewController *vc = [[GMProductDetailViewController alloc] initWithProductId:model.productId];
    [self.navigationController pushViewController:vc animated:YES];
}

- (GMBrandAreaTableView *)brandTableView {
    if (! _brandTableView) {
        _brandTableView = [[GMBrandAreaTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _brandTableView.brandTBDelegate = self;
        [self.view addSubview:_brandTableView];
    }
    return _brandTableView;
}

- (GMProductAreaCollectionView *)productCollectionView {
    if (! _productCollectionView) {
        _productCollectionView = [[GMProductAreaCollectionView alloc] initWithFrame:CGRectZero];
        _productCollectionView.productAreaCVDelegate = self;
        [self.view addSubview:_productCollectionView];
    }
    return _productCollectionView;
}

- (MKEmptyView *)emptyView {
    if (! _emptyView) {
        _emptyView = [[MKEmptyView alloc] initWithFrame:CGRectZero];
//        _emptyView.hidden = YES; --test
        [self.view addSubview:_emptyView];
    }
    return _emptyView;
}
@end
