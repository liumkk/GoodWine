//
//  GMProductEvaluateViewController.m
//  GoodWine
//
//  Created by LMK on 2019/8/19.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMProductEvaluateViewController.h"
#import "GMProductEvaluateTableView.h"

@interface GMProductEvaluateViewController ()

@property (nonatomic, strong) GMProductEvaluateTableView *evaluateTableView;
@property (nonatomic, strong) NSArray <ProductEvaluateInfoModel *> *dataArray;
@property (nonatomic, strong) MKEmptyView *emptyView;

@end

@implementation GMProductEvaluateViewController

- (instancetype)initWithDataArray:(NSArray<ProductEvaluateInfoModel *> *)dataArray {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.dataArray = dataArray;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评价详情";
    
    [self updateNavigationBarNeedBack:YES];
    [self setupConstranits];
    
    if (self.dataArray.count == 0) {
        [self.emptyView showEmptyNeedLoadBtn:NO];
    } else {
        self.emptyView.hidden = YES;
    }
}

- (void)setupConstranits {
    [self.evaluateTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (GMProductEvaluateTableView *)evaluateTableView {
    if (! _evaluateTableView) {
        _evaluateTableView = [[GMProductEvaluateTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_evaluateTableView reloadTableViewWithDataArray:self.dataArray];
        [self.view addSubview:_evaluateTableView];
    }
    return _evaluateTableView;
}

- (MKEmptyView *)emptyView {
    if (! _emptyView) {
        _emptyView = [[MKEmptyView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_emptyView];
    }
    return _emptyView;
}

@end
