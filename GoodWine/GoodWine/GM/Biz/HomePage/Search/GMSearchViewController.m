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
#import "GMSearchTableView.h"

@interface GMSearchViewController () <GMSearchTableViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) GMSearchCollectionView *searchCollectionView;
@property (nonatomic, strong) GMSearchTableView *searchTableView;
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
    [self.searchTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
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
               [self.searchTableView.mj_footer resetNoMoreData];
           } else {
               [self.searchTableView.mj_footer endRefreshingWithNoMoreData];
           }
       } else {
           if (!isLoadMore) {
               self.page = 1;
               [self.searchArray removeAllObjects];
               [self.searchTableView.mj_footer resetNoMoreData];
           }
           self.page ++;
           [self.searchArray addObjectsFromArray:array];
           
           self.emptyView.hidden = YES;
           [self.searchTableView reloadSearchTableViewWithDataArray:self.searchArray];
       }
    } failedBlock:^(NSError * _Nonnull error) {
        
    }];
}

- (void)searchTableViewDidSelectItemModel:(HomePageTypeItem *)model {
    GMProductDetailViewController *vc = [[GMProductDetailViewController alloc] initWithProductId:model.productId];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)addRefreshHeaderView {
    @weakify(self)
    self.searchTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        if ([self.searchTableView.mj_footer isRefreshing]) {
            [self.searchTableView.mj_footer endRefreshing];
        }
        [self requestSearchProductIsLoadMore:NO];
    }];
}

- (void)addRefreshFooterView {
    @weakify(self)
    self.searchTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)
        if ([self.searchTableView.mj_header isRefreshing]) {
            [self.searchTableView.mj_header endRefreshing];
        }
        [self requestSearchProductIsLoadMore:YES];
    }];
    self.searchTableView.mj_footer.ignoredScrollViewContentInsetBottom = BottomTarBarSpace;
}

- (void)endMJRefresh {
    
    if ([self.searchTableView.mj_header isRefreshing]) {
        [self.searchTableView.mj_header endRefreshing];
    }
    if ([self.searchTableView.mj_footer isRefreshing]) {
        [self.searchTableView.mj_footer endRefreshing];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self searchProduct:nil];
    
    return YES;
}

- (GMSearchTableView *)searchTableView {
    if (! _searchTableView) {
        _searchTableView = [[GMSearchTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _searchTableView.searchDelegate = self;
        [self.view addSubview:_searchTableView];
    }
    return _searchTableView;
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
