//
//  GMOrderPayViewController.m
//  GoodWine
//
//  Created by LMK on 2019/8/31.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMOrderPayViewController.h"
#import "GMOrderPayView.h"
#import "GMPaySuccessViewController.h"

#import <AlipaySDK/AlipaySDK.h>

@interface GMOrderPayViewController ()

@property (nonatomic, strong) GMOrderPayView *payView;
@property (nonatomic, strong) GMOrderDetailInfoModel *orderModel;

@end

@implementation GMOrderPayViewController

- (instancetype)initWithOrderDetailModel:(GMOrderDetailInfoModel *)model {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.orderModel = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择支付方式";
    
    [self updateNavigationBarNeedBack:YES];
    [self setupConstranits];
}

- (void)setupConstranits {
    [self.payView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)payBtnAction:(UIButton *)btn {
    [GMLoadingActivity showLoadingActivityInView:self.view];
    @weakify(self)
    [ServerAPIManager asyncGetPayDataWithOrderId:self.orderModel.orderId succeedBlock:^(NSString * _Nonnull data) {
        @strongify(self)
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        [[AlipaySDK defaultService] payOrder:data fromScheme:GMUrlSchemes callback:^(NSDictionary *resultDic) {
            @strongify(self)
            NSLog(@"reslut = %@",resultDic);
            if ([resultDic[@"resultStatus"] integerValue] == 9000) {
                GMPaySuccessViewController *vc = [[GMPaySuccessViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            } else {
                NSInteger orderState = [resultDic[@"resultStatus"] integerValue];
                NSString *returnStr;
                switch (orderState) {
                    case 8000:
                        returnStr=@"订单正在处理中";
                        break;
                    case 4000:
                        returnStr=@"订单支付失败";
                        
                        break;
                    case 6001:
                        returnStr=@"订单取消";
                        
                        break;
                    case 6002:
                        returnStr=@"网络连接出错";
                        
                        break;
                    default:
                        break;
                }
                [MKToastView showToastToView:self.view text:returnStr];
            }
        }];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self)
        [GMLoadingActivity hideLoadingActivityInView:self.view];
        [self showAlertViewWithError:error];
    }];
}

- (GMOrderPayView *)payView {
    if (! _payView) {
        _payView = [[GMOrderPayView alloc] initWithFrame:CGRectZero];
        [_payView updateWithPayAmount:self.orderModel.payAmount];
        [_payView.payBtn addTarget:self action:@selector(payBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_payView];
    }
    return _payView;
}

@end
