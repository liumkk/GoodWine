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
    
    [self updateNavigationBar];
    [self setupConstranits];
}

- (void)setupConstranits {
    [self.evaluateTableView mas_makeConstraints:^(MASConstraintMaker *make) {
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

@end
