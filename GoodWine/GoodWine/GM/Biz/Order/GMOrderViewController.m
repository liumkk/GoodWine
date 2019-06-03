//
//  GMOrderViewController.m
//  GoodWine
//
//  Created by LMK on 2019/5/28.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMOrderViewController.h"

@interface GMOrderViewController ()

@end

@implementation GMOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubviews];
}

- (void)initSubviews {
    self.title = @"订单";
    
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
