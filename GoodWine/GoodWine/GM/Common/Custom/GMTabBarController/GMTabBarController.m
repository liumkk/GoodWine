//
//  GMTabBarController.m
//  GoodWine
//
//  Created by LMK on 2019/5/27.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMTabBarController.h"

@interface GMTabBarController ()

@end

@implementation GMTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubViewControllers];
}

- (void)initSubViewControllers {
    GMHomePageViewController *homePageVC = [[GMHomePageViewController alloc] init];
    GMNavigationController *homePageNAC = [[GMNavigationController alloc] initWithRootViewController:homePageVC];
    homePageNAC.tabBarItem.title = @"首页";
    homePageNAC.tabBarItem.image = [[UIImage imageNamed:@"HomePageTabItemIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homePageNAC.tabBarItem.selectedImage = [[UIImage imageNamed:@"HomePageTabItemSelectedIcom"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    GMShoppCartViewController *shoppVC = [[GMShoppCartViewController alloc] init];
    GMNavigationController *shoppNAC = [[GMNavigationController alloc] initWithRootViewController:shoppVC];
    shoppNAC.tabBarItem.title = @"购物车";
    shoppNAC.tabBarItem.image = [[UIImage imageNamed:@"ShoppCartTabItemIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    shoppNAC.tabBarItem.selectedImage = [[UIImage imageNamed:@"ShoppCartTabItemSelectedIcom"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    GMOrderViewController *orderVC = [[GMOrderViewController alloc] init];
    GMNavigationController *orderNAC = [[GMNavigationController alloc] initWithRootViewController:orderVC];
    orderNAC.tabBarItem.title = @"订单";
    orderNAC.tabBarItem.image = [[UIImage imageNamed:@"OrderTabItemIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    orderNAC.tabBarItem.selectedImage = [[UIImage imageNamed:@"OrderTabItemSelectedIcom"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    GMUserCenterViewController *myVC = [[GMUserCenterViewController alloc] init];
    GMNavigationController *myNAC = [[GMNavigationController alloc] initWithRootViewController:myVC];
    myNAC.tabBarItem.title = @"我的";
    myNAC.tabBarItem.image = [[UIImage imageNamed:@"UserCenterTabItemIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    myNAC.tabBarItem.selectedImage = [[UIImage imageNamed:@"UserCenterTabItemSelectedIcom"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    self.viewControllers = @[homePageNAC,shoppNAC,orderNAC,myNAC];
}

@end
