//
//  GMAddAddressViewController.m
//  GoodWine
//
//  Created by LMK on 2019/8/5.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMAddAddressViewController.h"
#import "GMAddAddressTableView.h"

@interface GMAddAddressViewController () <GMAddAddressTableViewDelegate>

@property (nonatomic, strong) GMAddAddressTableView *addTableView;
@property (nonatomic, copy) GMAddAddressCallBack callBack;


@end

@implementation GMAddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加地址";
    [self updateNavigationBarNeedBack:YES];
    [self setupConstranits];
}

- (void)addAddressTableViewConfirmBtnName:(NSString *)name phoneNum:(NSString *)phoneNum address:(NSString *)address detailAddess:(NSString *)detailAddress {
//    name = @"哈哈";     //--test
//    phoneNum = @"13916391993";
//    address = @"合肥";
//    detailAddress = @"xx小区";
    if (IsStrEmpty(name) || IsStrEmpty(phoneNum) || IsStrEmpty(address) || IsStrEmpty(detailAddress)) {
        [MKToastView showToastToView:self.view text:@"请输入完整信息"];
        return;
    }
    [GMLoadingActivity showLoadingActivityInView:self.view];
    [ServerAPIManager asyncAddAddressWithName:name phoneNum:phoneNum address:address detailAddress:detailAddress succeedBlock:^{
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        [MKToastView showToastToView:self.view text:@"添加地址成功" time:2.f completion:^{
            if (self.callBack) {
                self.callBack();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } failedBlock:^(NSError * error) {
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        [self showAlertViewWithError:error];
    }];
}

- (void)setupConstranits {
    [self.addTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (GMAddAddressTableView *)addTableView {
    if (! _addTableView) {
        _addTableView = [[GMAddAddressTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _addTableView.addAddressDelegate = self;
        [self.view addSubview:_addTableView];
    }
    return _addTableView;
}

- (void)addAddressCallBack:(GMAddAddressCallBack)callBack {
    self.callBack = callBack;
}
@end
