//
//  GMSearchViewController.m
//  GoodWine
//
//  Created by LMK on 2019/9/18.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMSearchViewController.h"
#import "GMSearchView.h"
#import "GMSearchCollectionView.h"
#import "GMProductDetailViewController.h"

@interface GMSearchViewController () <GMSearchCollectionViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) GMSearchCollectionView *searchCollectionView;
@property (nonatomic, strong) GMSearchView *searchView;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) NSMutableArray <HomePageTypeItem *> *searchArray;
@property (nonatomic, strong) MKEmptyView *emptyView;
@property (nonatomic, assign) NSInteger page;


@end

@implementation GMSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self initSubviews];
    [self setupConstranits];
    [self addRefreshHeaderView];
    [self addRefreshFooterView];
}

- (void)initSubviews {
    [self updateNavigationBarNeedBack:YES];
    self.view.backgroundColor = COLOR_TABLE_BG_RAY;
    self.navigationItem.titleView = self.searchView;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.searchView.searchTextField.text.length == 0) {
        [self.searchView.searchTextField becomeFirstResponder];
    }
}

- (void)setupConstranits {
    [self.searchCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 9.f, 0, 9.f));
    }];
    
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)searchProduct:(UIButton *)btn {
    [self.searchView.searchTextField resignFirstResponder];
    if (self.searchView.searchTextField.text.length > 0) {
        [self requestSearchProductIsLoadMore:NO];
    }
}

- (void)requestSearchProductIsLoadMore:(BOOL)isLoadMore {
    [GMLoadingActivity showLoadingActivityInView:self.view];
    @weakify(self)
    [ServerAPIManager asyncSearchWithSearchName:self.searchView.searchTextField.text
                                       pageSize:@"10"
                                        pageNum:isLoadMore ? [NSString stringWithFormat:@"%ld",(long)self.page] : @"1"
                                   succeedBlock:^(NSArray<HomePageTypeItem *> * _Nonnull array) {
       @strongify(self)
       [GMLoadingActivity hideLoadingActivityInView:self.view];
       [self endMJRefresh];
       if (array.count == 0) {
           if (!isLoadMore) {
               self.page = 1;
               [self.emptyView showEmptyNeedLoadBtn:NO];
               [self.searchCollectionView.mj_footer resetNoMoreData];
           } else {
               [self.searchCollectionView.mj_footer endRefreshingWithNoMoreData];
           }
       } else {
           if (!isLoadMore) {
               self.page = 1;
               [self.searchArray removeAllObjects];
               [self.searchCollectionView.mj_footer resetNoMoreData];
           }
           self.page ++;
           [self.searchArray addObjectsFromArray:array];
           
           self.emptyView.hidden = YES;
           [self.searchCollectionView reloadStoreDetailCollectionViewWithDataArray:self.searchArray];
       }
    } failedBlock:^(NSError * _Nonnull error) {
        
    }];
}

- (void)searchCollectionView:(UICollectionView *)collectionView didSelectItemModel:(HomePageTypeItem *)model {
    if (UserCenter.isLogin) {
        GMProductDetailViewController *vc = [[GMProductDetailViewController alloc] initWithProductId:model.productId];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        [ViewControllerManager pushLoginViewControllerWithVC:self];
    }
}

- (void)addRefreshHeaderView {
    @weakify(self)
    self.searchCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        if ([self.searchCollectionView.mj_footer isRefreshing]) {
            [self.searchCollectionView.mj_footer endRefreshing];
        }
        [self requestSearchProductIsLoadMore:NO];
    }];
}

- (void)addRefreshFooterView {
    @weakify(self)
    self.searchCollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)
        if ([self.searchCollectionView.mj_header isRefreshing]) {
            [self.searchCollectionView.mj_header endRefreshing];
        }
        [self requestSearchProductIsLoadMore:YES];
    }];
    self.searchCollectionView.mj_footer.ignoredScrollViewContentInsetBottom = BottomTarBarSpace;
}

- (void)endMJRefresh {
    
    if ([self.searchCollectionView.mj_header isRefreshing]) {
        [self.searchCollectionView.mj_header endRefreshing];
    }
    if ([self.searchCollectionView.mj_footer isRefreshing]) {
        [self.searchCollectionView.mj_footer endRefreshing];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self searchProduct:nil];
    
    return YES;
}

- (GMSearchCollectionView *)searchCollectionView {
    if (! _searchCollectionView) {
        _searchCollectionView = [[GMSearchCollectionView alloc] initWithFrame:CGRectZero];
        _searchCollectionView.searchCollectionDelegate = self;
        [self.view addSubview:_searchCollectionView];
    }
    return _searchCollectionView;
}

- (GMSearchView *)searchView {
    if (! _searchView) {
        _searchView = [[GMSearchView alloc] initWithFrame:CGRectMake(0, 0, Width_Screen - 30.f, 35.f)];
        _searchView.searchTextField.userInteractionEnabled = YES;
        _searchView.searchTextField.delegate = self;
        _searchView.searchTextField.returnKeyType = UIReturnKeyDone;
        _searchView.searchButton.hidden = YES;
    }
    return _searchView;
}

- (UIButton *)rightBtn {
    if (! _rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(0, 0, 30, 44);
        [_rightBtn setTitle:@"搜索" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:COLOR_TEXT_BLACK forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = Font(15.f);
        [_rightBtn addTarget:self action:@selector(searchProduct:) forControlEvents:UIControlEventTouchUpInside];
        [_rightBtn setBackgroundColor:[UIColor clearColor]];
    }
    return _rightBtn;
}

- (MKEmptyView *)emptyView {
    if (! _emptyView) {
        _emptyView = [[MKEmptyView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_emptyView];
    }
    return _emptyView;
}

- (NSMutableArray<HomePageTypeItem *> *)searchArray {
    if (! _searchArray) {
        _searchArray = [[NSMutableArray alloc] init];
    }
    return _searchArray;
}

@end
