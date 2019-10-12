//
//  GMCollectViewController.m
//  GoodWine
//
//  Created by LMK on 2019/8/30.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMCollectViewController.h"
#import "GMCollectTableView.h"
#import "GMProductDetailViewController.h"

@interface GMCollectViewController () <GMCollectTableViewDelegate>

@property (nonatomic, strong) GMCollectTableView *collectTB;
@property (nonatomic, strong) NSMutableArray <CollectProductItem *> *productArray;
@property (nonatomic, strong) MKEmptyView *emptyView;

@end

@implementation GMCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关注商品";
    
    [self updateNavigationBarNeedBack:YES];
    [self setupConstranits];
    [self requestCollectList];
}

- (void)setupConstranits {
    [self.collectTB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)requestCollectList {
    @weakify(self)
    [ServerAPIManager asyncGetCollectListWithSucceedBlock:^(CollectListInfoModel * _Nonnull model) {
        @strongify(self)
        self.productArray = (NSMutableArray *)model.collectProductArray;
        if (self.productArray.count > 0) {
            self.emptyView.hidden = YES;
            [self.collectTB reloadTableViewWithDataArray:model.collectProductArray];
        } else {
            [self.emptyView showEmptyNeedLoadBtn:NO];
        }
    } failedBlock:^(NSError * _Nonnull error) {
        [self showAlertViewWithError:error];
    }];
}

- (void)collectTableViewDidSelectRowAtIndex:(NSInteger)index {
    CollectProductItem *item = self.productArray[index];
    GMProductDetailViewController *vc = [[GMProductDetailViewController alloc] initWithProductId:item.productId];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
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

- (MKEmptyView *)emptyView {
    if (! _emptyView) {
        _emptyView = [[MKEmptyView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_emptyView];
    }
    return _emptyView;
}

@end
