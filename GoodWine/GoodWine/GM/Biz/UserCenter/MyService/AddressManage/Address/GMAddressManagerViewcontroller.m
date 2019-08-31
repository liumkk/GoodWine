//
//  GMAddressManagerViewcontroller.m
//  GoodWine
//
//  Created by LMK on 2019/8/3.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMAddressManagerViewcontroller.h"
#import "GMAddressManageTableView.h"
#import "GMAddAddressViewController.h"

@interface GMAddressManagerViewcontroller () <GMAddressManageTableViewDelegate>

@property (nonatomic, strong) GMAddressManageTableView *addressTableView;
@property (nonatomic, strong) NSMutableArray <GMAddressInfoModel *> *dataArray;
@property (nonatomic, copy) SelectAddressCallBack callBack;


@end

@implementation GMAddressManagerViewcontroller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"地址管理";
    
    [self updateNavigationBar];
    [self setupConstranits];
    [self requestQueryAddress];
}

- (void)requestQueryAddress {
    [GMLoadingActivity showLoadingActivityInView:self.view];
    [ServerAPIManager asyncQueryAddressWithSucceedBlock:^(NSArray * _Nonnull array) {
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        [self.dataArray removeAllObjects];
        self.dataArray = (NSMutableArray *)array;
        [self.addressTableView reloadTableViewWithDataArray:self.dataArray];
    } failedBlock:^(NSError * _Nonnull error) {
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        [self showAlertViewWithError:error];
    }];
}

- (void)addAddress {
    GMAddAddressViewController *addVC = [[GMAddAddressViewController alloc] init];
    [addVC addAddressCallBack:^{
        [self requestQueryAddress];
    }];
    [self.navigationController pushViewController:addVC animated:YES];
}

- (void)addressManageTableView:(UITableView *)tableView
          deleteRowAtIndexPath:(NSIndexPath *)indexPath
                         model:(GMAddressInfoModel *)model {
    [GMLoadingActivity showLoadingActivityInView:self.view];
    
    [ServerAPIManager asyncDeleteAddressWithAddressId:model.addressId succeedBlock:^{
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView reloadData];
    } failedBlock:^(NSError * _Nonnull error) {
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        [self showAlertViewWithError:error];
    }];
}

- (void)addressManagerTableViewDidSelectRowAtModel:(GMAddressInfoModel *)model {
    if (self.callBack) {
        self.callBack(model);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)setupConstranits {
    [self.addressTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (GMAddressManageTableView *)addressTableView {
    if (! _addressTableView) {
        _addressTableView = [[GMAddressManageTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _addressTableView.addressDelegate = self;
        [self.view addSubview:_addressTableView];
    }
    return _addressTableView;
}

- (void)addressManagerSelectAddressCallBack:(SelectAddressCallBack)callBack {
    self.callBack = callBack;
}

@end
