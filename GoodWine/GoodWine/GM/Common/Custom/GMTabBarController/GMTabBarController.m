//
//  GMTabBarController.m
//  GoodWine
//
//  Created by LMK on 2019/5/27.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMTabBarController.h"

@interface GMTabBarController () <UITabBarControllerDelegate>

@end

@implementation GMTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    [[UITabBar appearance] setTranslucent:NO]; //避免界面pop时 tabbar卡顿
    
    [self initSubViewControllers];
}

- (void)initSubViewControllers {
    GMHomePageViewController *homePageVC = [[GMHomePageViewController alloc] init];
    GMNavigationController *homePageNAC = [[GMNavigationController alloc] initWithRootViewController:homePageVC];
    homePageNAC.tabBarItem.title = @"首页";
    homePageNAC.tabBarItem.image = [[UIImage imageNamed:@"homePageNormal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homePageNAC.tabBarItem.selectedImage = [[UIImage imageNamed:@"homePageSelect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    GMShoppCartViewController *shoppVC = [[GMShoppCartViewController alloc] init];
    GMNavigationController *shoppNAC = [[GMNavigationController alloc] initWithRootViewController:shoppVC];
    shoppNAC.tabBarItem.title = @"购物车";
    shoppNAC.tabBarItem.image = [[UIImage imageNamed:@"shoppCarNormal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    shoppNAC.tabBarItem.selectedImage = [[UIImage imageNamed:@"shoppCarSelect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    GMOrderViewController *orderVC = [[GMOrderViewController alloc] init];
    GMNavigationController *orderNAC = [[GMNavigationController alloc] initWithRootViewController:orderVC];
    orderNAC.tabBarItem.title = @"订单";
    orderNAC.tabBarItem.image = [[UIImage imageNamed:@"orderNormal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    orderNAC.tabBarItem.selectedImage = [[UIImage imageNamed:@"orderSelect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    GMUserCenterViewController *myVC = [[GMUserCenterViewController alloc] init];
    GMNavigationController *myNAC = [[GMNavigationController alloc] initWithRootViewController:myVC];
    myNAC.tabBarItem.title = @"我的";
    myNAC.tabBarItem.image = [[UIImage imageNamed:@"userCenterNormal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    myNAC.tabBarItem.selectedImage = [[UIImage imageNamed:@"userCenterSelect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    self.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBar.tintColor = [UIColor redColor];
    self.viewControllers = @[homePageNAC,shoppNAC,orderNAC,myNAC];
}

#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NSUInteger selectedTab = [self whichTabSelectedAccordingViewController:viewController];
    self.selectedIndex = selectedTab;
    MKNSLog(@"点击了%lu",(unsigned long)self.selectedIndex);
    return YES;
}

- (NSUInteger)whichTabSelectedAccordingViewController:(UIViewController*)viewController {
    
    GMNavigationController * nc = (GMNavigationController *)viewController;
    
    UIViewController * vc = (UIViewController *)nc.viewControllers[0];
    
    if ([vc isKindOfClass:[GMHomePageViewController class]]) {
        return 0;
    } else  if ([vc isKindOfClass:[GMShoppCartViewController class]]) {
//        ViewControllerManager.rootController = self.homePageNC;
//        [MobClick event:AppBotTabCount attributes:@{@"tabChoice":@"首页"}];
        return 1;
    } else if ([vc isKindOfClass:[GMOrderViewController class]]) {
//        ViewControllerManager.rootController = self.youLikeNC;
//        [MobClick event:AppBotTabCount attributes:@{@"tabChoice":@"全民惠"}];
        return 2;
    } else {
//        ViewControllerManager.rootController = self.myNC;
//        [MobClick event:AppBotTabCount attributes:@{@"tabChoice":@"我的"}];
        return 3;
    }
    
}
@end
