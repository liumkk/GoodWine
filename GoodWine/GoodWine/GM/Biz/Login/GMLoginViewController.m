//
//  GMLoginViewController.m
//  GoodWine
//
//  Created by LMK on 2019/5/27.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMLoginViewController.h"

@interface GMLoginViewController ()

@end

@implementation GMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubviews];
}

- (void)initSubviews {
    self.title = @"登录";
    
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
