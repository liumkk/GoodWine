//
//  GMCollectViewController.m
//  GoodWine
//
//  Created by LMK on 2019/8/30.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMCollectViewController.h"
#import "GMCollectTableView.h"

@interface GMCollectViewController () <GMCollectTableViewDelegate>

@property (nonatomic, strong) GMCollectTableView *collectTB;
@property (nonatomic, strong) NSMutableArray <CollectProductItem *> *productArray;

@end

@implementation GMCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关注商品";
    
    [self updateNavigationBar];
    [self setupConstranits];
    [self requestCollectList];
}

- (void)setupConstranits {
    [self.collectTB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)requestCollectList {
    @weakify(self)
    [ServerAPIManager asyncGetCollectListWithSucceedBlock:^(CollectListInfoModel * _Nonnull model) {
        @strongify(self)
        self.productArray = (NSMutableArray *)model.collectProductArray;
        [self.collectTB reloadTableViewWithDataArray:model.collectProductArray];
    } failedBlock:^(NSError * _Nonnull error) {
        [self showAlertViewWithError:error];
    }];
}

- (void)collectTableViewDeleteRowAtIndex:(NSInteger)index {
    CollectProductItem *item = self.productArray[index];
    [ServerAPIManager asyncDeleteCollectWithProductId:item.productId succeedBlock:^{
        [self.productArray removeObjectAtIndex:index];
        [self.collectTB deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        [self.collectTB beginUpdates];
        [self.collectTB endUpdates];
    } failedBlock:^(NSError * _Nonnull error) {
        [self showAlertViewWithError:error];
    }];
}

- (GMCollectTableView *)collectTB {
    if (! _collectTB) {
        _collectTB = [[GMCollectTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _collectTB.collectTBDelegate = self;
        [self.view addSubview:_collectTB];
    }
    return _collectTB;
}

@end
