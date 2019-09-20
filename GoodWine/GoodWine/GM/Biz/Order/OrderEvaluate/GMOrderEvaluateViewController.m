//
//  GMOrderEvaluateViewController.m
//  GoodWine
//
//  Created by LMK on 2019/9/19.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMOrderEvaluateViewController.h"
#import "GMOrderEvaluateView.h"

@interface GMOrderEvaluateViewController ()

@property (nonatomic, strong) GMOrderEvaluateView *evaluateView;
@property (nonatomic, assign) NSInteger productStar;
@property (nonatomic, assign) NSInteger storeStar;
@property (nonatomic, assign) NSInteger serviceStar;

@property (nonatomic, copy) OrderEvaluateCallBack callBack;

@property (nonatomic, strong) GMOrderItem *model;


@end

@implementation GMOrderEvaluateViewController

- (instancetype)initWithModel:(GMOrderItem *)model {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加评价";
    [self updateNavigationBar];
    [self setupConstranits];
    [self initSubviews];
}

- (void)setupConstranits {
    [self.evaluateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)initSubviews {
    
    [self.evaluateView updateEvaluateViewWithModel:self.model];
    
    //初始默认为5星
    self.productStar = 5;
    self.storeStar = 5;
    self.serviceStar = 5;
    
    for (UIButton *btn in self.evaluateView.productStarArray) {
        [btn addTarget:self action:@selector(productStartBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    for (UIButton *btn in self.evaluateView.storeStarArray) {
        [btn addTarget:self action:@selector(storeStarBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    for (UIButton *btn in self.evaluateView.serviceStarArray) {
        [btn addTarget:self action:@selector(serviceStarBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self.evaluateView.confirmBtn addTarget:self action:@selector(confirmBtn:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)confirmBtn:(UIButton *)btn {
    if (IsStrEmpty(self.evaluateView.textView.text)) {
        [MKToastView showToastToView:self.view text:@"请输入评价"];
    } else {
        [ServerAPIManager asyncAddEvaluateWithContent:self.evaluateView.textView.text
                                              orderId:self.model.orderId
                                          productStar:[NSString stringWithFormat:@"%ld",self.productStar]
                                            anonymous:@"0"
                                         deliveryStar:[NSString stringWithFormat:@"%ld",self.serviceStar]
                                     satisfactionStar:[NSString stringWithFormat:@"%ld",self.storeStar] succeedBlock:^{
            [MKToastView showToastToView:self.view text:@"评价成功" time:Toast_Time completion:^{
                if (self.callBack) {
                    self.callBack();
                }
                [self.navigationController popViewControllerAnimated:YES];
            }];
        } failedBlock:^(NSError * error) {
            [self showAlertViewWithError:error];
        }];
    }
}

- (void)productStartBtn:(UIButton *)btn {
    self.productStar = btn.tag +1;
    for (int i = 0; i < btn.tag +1; i ++) {
        UIButton *btn = self.evaluateView.productStarArray[i];
        [btn setBackgroundImage:[UIImage imageNamed:@"red_collected"] forState:UIControlStateNormal];
    }
    
    for (int i = (int)btn.tag +1; i < self.evaluateView.productStarArray.count; i ++) {
        UIButton *btn = self.evaluateView.productStarArray[i];
        [btn setBackgroundImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
    }
}

- (void)storeStarBtn:(UIButton *)btn {
    self.storeStar = btn.tag +1;
    for (int i = 0; i < btn.tag +1; i ++) {
        UIButton *btn = self.evaluateView.storeStarArray[i];
        [btn setBackgroundImage:[UIImage imageNamed:@"red_collected"] forState:UIControlStateNormal];
    }
    
    for (int i = (int)btn.tag +1; i < self.evaluateView.storeStarArray.count; i ++) {
        UIButton *btn = self.evaluateView.storeStarArray[i];
        [btn setBackgroundImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
    }
}

- (void)serviceStarBtn:(UIButton *)btn {
    self.serviceStar = btn.tag +1;
    for (int i = 0; i < btn.tag +1; i ++) {
        UIButton *btn = self.evaluateView.serviceStarArray[i];
        [btn setBackgroundImage:[UIImage imageNamed:@"red_collected"] forState:UIControlStateNormal];
    }
    
    for (int i = (int)btn.tag +1; i < self.evaluateView.serviceStarArray.count; i ++) {
        UIButton *btn = self.evaluateView.serviceStarArray[i];
        [btn setBackgroundImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
    }
}

- (GMOrderEvaluateView *)evaluateView {
    if (! _evaluateView) {
        _evaluateView = [[GMOrderEvaluateView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_evaluateView];
    }
    return _evaluateView;
}

- (void)orderEvaluateCallBack:(OrderEvaluateCallBack)callBack {
    self.callBack = callBack;
}

@end
