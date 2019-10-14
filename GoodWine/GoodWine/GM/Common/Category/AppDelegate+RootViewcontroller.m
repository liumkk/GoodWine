//
//  AppDelegate+RootViewcontroller.m
//  GoodWine
//
//  Created by LMK on 2019/5/27.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "AppDelegate+RootViewcontroller.h"

@implementation AppDelegate (RootViewcontroller)

- (void)setTabbarController {
    
    GMTabBarController *tabBarController = [[GMTabBarController alloc] initWithNibName:nil bundle:nil];
    tabBarController.tabBar.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = tabBarController;
}

- (void)checkLoginViewController {
    GMLoginViewController *loginVC = [[GMLoginViewController alloc] init];
    GMNavigationController *loginNAC = [[GMNavigationController alloc] initWithRootViewController:loginVC];
    
    self.window.rootViewController = loginNAC;
}

@end
