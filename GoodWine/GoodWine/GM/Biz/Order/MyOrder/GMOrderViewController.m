//
//  GMOrderViewController.m
//  GoodWine
//
//  Created by LMK on 2019/5/28.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMOrderViewController.h"
#import "GMOrderCollectionView.h"

@interface GMOrderViewController () <GMOrderCollectionViewDelegate>

@property (nonatomic, strong) GMOrderCollectionView *orderCollectView;

@end

@implementation GMOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubviews];
}

- (void)initSubviews {
    self.title = @"订单";
    self.orderCollectView.orderCollectDelegate = self;
    self.view.backgroundColor = COLOR_GRAY_244;;
}

- (void)orderCollectionViewDidSelectItemAtIndex:(NSInteger)index {
    
}

- (GMOrderCollectionView *)orderCollectView {
    if (! _orderCollectView) {
        _orderCollectView = [[GMOrderCollectionView alloc] initWithFrame:CGRectMake(0, 0, Width_Screen, 180.f)];
        [self.view addSubview:_orderCollectView];
    }
    return _orderCollectView;
}

@end
