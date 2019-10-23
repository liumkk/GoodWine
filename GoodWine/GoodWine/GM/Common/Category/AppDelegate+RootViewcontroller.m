//
//  AppDelegate+RootViewcontroller.m
//  GoodWine
//
//  Created by LMK on 2019/5/27.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "AppDelegate+RootViewcontroller.h"

@implementation AppDelegate (RootViewcontroller)

- (void)showTabbarController {
    @weakify(self)
    [ServerAPIManager asyncQueryUserCodeSucceedBlock:^(NSString * _Nonnull str) {
        @strongify(self)
        if (UserCenter.userCode) {
            [self setTabbarController];
        } else {
            [self checkLoginViewController];
        }
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self)
        [self setTabbarController];
    }];
}

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
