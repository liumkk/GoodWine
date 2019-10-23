//
//  GMViewControllerManager.m
//  GoodWine
//
//  Created by LMK on 2019/6/4.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMViewControllerManager.h"

@implementation GMViewControllerManager

//singleton_implementation(GMViewControllerManager);

static GMViewControllerManager *shared = nil;

+ (instancetype)shared {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        shared = [[GMViewControllerManager alloc] init];
        
    });
    return shared;
}

- (void)showTabController {
    
    AppDelegate *appdelegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdelegate setTabbarController];
}

- (void)showLoginView {
    
    [GMLoadingActivity removeAllHudWithView:[UIApplication sharedApplication].delegate.window];
    
//    GMNavigationController *navT =  self.tabBarController.selectedViewController;
//
//    [navT popToRootViewControllerAnimated:NO];
    
    if (UserCenter.userCode) {
        GMNavigationController *navT =  self.tabBarController.selectedViewController;
        [navT popToRootViewControllerAnimated:NO];
        GMLoginViewController *loginVC = [[GMLoginViewController alloc] init];
        loginVC.hidesBottomBarWhenPushed = YES;
        [self.tabBarController.viewControllers[0] pushViewController:loginVC animated:YES];
        [self.tabBarController setSelectedIndex:0];
    } else {
        AppDelegate *appdelegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appdelegate checkLoginViewController];
    }
    
//    GMLoginViewController *loginController = [[GMLoginViewController alloc] init];
//    
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginController];
//    
//    appdelegate.window.rootViewController = nav;
//    
//    self.rootController = (GMNavigationController *)nav;
}

- (void)pushLoginViewControllerWithVC:(UIViewController *)VC {
    GMLoginViewController *loginVC = [[GMLoginViewController alloc] init];
    loginVC.hidesBottomBarWhenPushed = YES;
    
    if (VC) {
        [VC.navigationController pushViewController:loginVC animated:YES];
    } else {
        GMNavigationController *navT =  self.tabBarController.selectedViewController;
        [navT pushViewController:loginVC animated:YES];
    }
}

- (GMTabBarController *)tabBarController {
    if (! _tabBarController) {
        AppDelegate *appdelegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
        _tabBarController = (GMTabBarController *)appdelegate.window.rootViewController;
    }
    return _tabBarController;
}

@end
