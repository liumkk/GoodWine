//
//  GMShoppCartViewController.m
//  GoodWine
//
//  Created by LMK on 2019/5/28.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMShoppCartViewController.h"
#import "GMShoppCarTableView.h"

@interface GMShoppCartViewController ()

@property (nonatomic, strong) GMShoppCarTableView *shoppCarTV;

@end

@implementation GMShoppCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubviews];
    [self setupConstranits];
}

- (void)initSubviews {
    self.title = @"购物车";
}

- (void)setupConstranits {
    [self.shoppCarTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (GMShoppCarTableView *)shoppCarTV {
    if (! _shoppCarTV) {
        _shoppCarTV = [[GMShoppCarTableView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_shoppCarTV];
    }
    return _shoppCarTV;
}

@end
