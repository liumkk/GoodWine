//
//  GMViewControllerManager.h
//  GoodWine
//
//  Created by LMK on 2019/6/4.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define ViewControllerManager   [GMViewControllerManager shared]

@interface GMViewControllerManager : NSObject

@property (nonatomic, strong) GMNavigationController *rootController;
@property (nonatomic, strong) GMTabBarController *tabBarController;
@property (nonatomic, strong) GMLoginViewController *loginViewController;

//singleton_interface(GMViewControllerManager);
+ (instancetype)shared;

- (void)showTabController;
- (void)showLoginView;

- (void)checkLoginWithVC:(UIViewController *)VC login:(void(^)(void))login;
- (void)pushLoginViewControllerWithVC:(UIViewController *)VC;

@end

NS_ASSUME_NONNULL_END
