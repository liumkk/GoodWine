//
//  MKLocationManager.m
//  GoodWine
//
//  Created by LMK on 2019/8/8.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "MKLocationManager.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

#import <CoreLocation/CLLocationManager.h>

#define     MKApiKey        @"bb580696faf63d215ca472e9f9d6fc6e"
#define     MKWebApiKey     @"7da5a57fc078a7240d77aa45d561204e"

@interface MKLocationManager () <AMapLocationManagerDelegate>

@property (nonatomic, strong) AMapLocationManager *locationManager;

@end

@implementation MKLocationManager

static MKLocationManager *_sharedInstance = nil;

+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[MKLocationManager alloc] init];
    });
    return _sharedInstance;
    
}

- (id)init{
    
    if (self = [super init]) {
        [AMapServices sharedServices].apiKey = MKApiKey;
        
        self.locationManager = [[AMapLocationManager alloc] init];
        [self.locationManager setDelegate:self];
        // 带逆地理信息的一次定位（返回坐标和地址信息）
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
        //   定位超时时间，最低2s，此处设置为5s
        self.locationManager.locationTimeout =5;
        //   逆地理请求超时时间，最低2s，此处设置为5s
        self.locationManager.reGeocodeTimeout = 5;
    }
    return self;
}

- (void)openLocationFunctionCallBack:(void(^)(void))callBack authority:(nonnull void (^)(void))authority {
    if ([self determineWhetherTheAPPOpensTheLocation]) {
        [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
            if (error) {
                MKNSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
                if (error.code == AMapLocationErrorLocateFailed) {
                    [UserCenter queryStoreId];
                    
                    if (callBack) {
                        callBack();
                    }
                    return;
                }
            }
            
            if (regeocode) {
                MKNSLog(@"reGeocode:%@", regeocode);
                [ServerAPIManager asyncQueryStoreInfoWithRegionCode:regeocode.adcode succeedBlock:^(GMStoreInfoModel * _Nonnull infoModel) {
                    [UserCenter queryStoreId];
                    if (callBack) {
                        callBack();
                    }
                } failedBlock:^(NSError * _Nonnull error) {
                    MKNSLog(@"GMStoreInfoModel--查询门店失败");
                    [UserCenter queryStoreId];
                    if (callBack) {
                        callBack();
                    }
                }];
            }
        }];
    } else {
        [UserCenter queryStoreId];
        
        if (callBack) {
            callBack();
        }
//        if (authority) {
//            authority();
//        }
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请到设置->隐私->定位服务中开启【美酒快线】定位服务，以便于门店展示" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置",nil];
//
//        [alert show];
    }
}

- (void)openLocationFunctionSucceed:(void (^)(void))succeed failed:(void (^)(void))failed authority:(nonnull void (^)(void))authority {
    if ([self determineWhetherTheAPPOpensTheLocation]) {
        // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
        [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
            
            if (error) {
                MKNSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
                if (error.code == AMapLocationErrorLocateFailed) {
                    if (failed) {
                        failed();
                    }
                    return;
                }
            }
            
            if (regeocode) {
                MKNSLog(@"reGeocode:%@", regeocode);
                [ServerAPIManager asyncQueryStoreInfoWithRegionCode:regeocode.adcode succeedBlock:^(GMStoreInfoModel * _Nonnull infoModel) {
                    UserCenter.storeId = infoModel.storeId;
                    UserCenter.storeInfoModel = infoModel;
                    if (succeed) {
                        succeed();
                    }
                } failedBlock:^(NSError * _Nonnull error) {
                    MKNSLog(@"GMStoreInfoModel--查询门店失败");
                    if (failed) {
                        failed();
                    }
                }];
            }
        }];
    } else {
        if (authority) {
            authority();
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请到设置->隐私->定位服务中开启【美酒快线】定位服务，用来获取附近门店商品" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置",nil];
        
        [alert show];
//        GMTabBarController *tbController = (GMTabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController;
//        GMNavigationController *nav = [tbController.viewControllers objectAtIndex:tbController.selectedIndex];
//        UIViewController *topVC = nav.topViewController;
//        [topVC showAlertViewWithTitle:@"lalal"];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex ==1){
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}

- (void)cleanUpAction {
    [self.locationManager stopUpdatingLocation];
    
    [self.locationManager setDelegate:nil];
}

- (BOOL)determineWhetherTheAPPOpensTheLocation {
    
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] ==kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] ==kCLAuthorizationStatusAuthorizedAlways)) {
        return YES;
    } else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
        return NO;
    } else {
        return NO;
    }
}

- (void)dealloc {
    [self cleanUpAction];
}

@end
