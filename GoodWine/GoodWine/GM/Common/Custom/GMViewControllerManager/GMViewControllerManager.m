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
    
    UINavigationController *navT =  self.tabBarController.selectedViewController;
    
    [navT popToRootViewControllerAnimated:NO];
    
    AppDelegate *appdelegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    GMLoginViewController *loginController = [[GMLoginViewController alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginController];
    
    appdelegate.window.rootViewController = nav;
    
    self.rootController = (GMNavigationController *)nav;
    
}

@end
