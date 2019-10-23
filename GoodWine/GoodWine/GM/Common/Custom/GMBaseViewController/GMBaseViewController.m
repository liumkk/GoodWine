//
//  GMBaseViewController.m
//  GoodWine
//
//  Created by LMK on 2019/5/27.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMBaseViewController.h"
#import <IQKeyboardManager.h>
#import <IQKeyboardReturnKeyHandler.h>

@interface GMBaseViewController () {
    IQKeyboardReturnKeyHandler * _returnKeyHander;
}

@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIBarButtonItem *backButtonItem;

@end

@implementation GMBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //点击背景收回键盘
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    //修改return键
    _returnKeyHander = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
     [[IQKeyboardManager sharedManager] setToolbarDoneBarButtonItemText:@"收起"];
    [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:30];
}

- (void)updateNavigationBarNeedBack:(BOOL)need {
    
    [self.navigationController.navigationBar setShadowImage:nil];
    [self.navigationController.navigationBar setBackgroundImage:[UIView createPureColorImageWithColor:COLOR_WHITE alpha:1 size:CGSizeMake(Width_Screen, SafeAreaTopHeight)] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:16],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    if (need) {
        [self.backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        self.backButtonItem.customView = self.backBtn;
        self.navigationItem.leftBarButtonItem = self.backButtonItem;
        
        //        UIImage *leftBarButtonImage = [UIImage imageNamed:@"back"];
        //        leftBarButtonImage = [leftBarButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:leftBarButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    }
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)updateClearNavigationBarNeedBack:(BOOL)need alpha:(CGFloat)alpha {
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBackgroundImage:[UIView createPureColorImageWithColor:COLOR_WHITE alpha:alpha size:CGSizeMake(Width_Screen, SafeAreaTopHeight)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:16],
       NSForegroundColorAttributeName:COLORRGB(51, 51, 51, alpha)}];
    
    if (need) {
        [self.backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        self.backButtonItem.customView = self.backBtn;
        self.navigationItem.leftBarButtonItem = self.backButtonItem;
        
        if (alpha > 0.9) {
            
            [self.backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        } else {
            [self.navigationController.navigationBar setShadowImage:[UIImage new]];
            [self.backBtn setImage:[UIImage imageNamed:@"back_gray"] forState:UIControlStateNormal];
        }
    }
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIButton *)backBtn {
    if (! _backBtn) {
        _backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 24)];
        [_backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        _backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    }
    return _backBtn;
}

- (UIBarButtonItem *)backButtonItem {
    if (! _backButtonItem) {
        _backButtonItem = [[UIBarButtonItem alloc] init];
    }
    return _backButtonItem;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

@end
