//
//  GMServiceViewController.m
//  GoodWine
//
//  Created by LMK on 2019/8/1.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMServiceViewController.h"
#import "GMServiceTableView.h"

@interface GMServiceViewController () <GMServiceTableViewDelegate>

@property (nonatomic, strong) GMServiceTableView *tableView;

@end

@implementation GMServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateNavigationBarNeedBack:YES];
    [self setupConstraints];
}

- (void)updateNavigationBar {
    self.navigationItem.title = @"客服";
    UIImage *leftBarButtonImage = [UIImage imageNamed:@"back"];
    leftBarButtonImage = [leftBarButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:leftBarButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)setupConstraints {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)serviceTableViewDidSelectRowAtIndex:(NSInteger)index {
    if (index == 0) {
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",UserCenter.storeInfoModel.platPhone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    } else {
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",UserCenter.storeInfoModel.contactPhone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}

- (GMServiceTableView *)tableView {
    if (! _tableView) {
        _tableView = [[GMServiceTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.serviceTBDelegate = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
