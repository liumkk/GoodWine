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

- (void)openLocationFunction {
    // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error) {
            UserCenter.storeId = @"1"; //--test
            MKNSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            if (error.code == AMapLocationErrorLocateFailed) {
                return;
            }
        }
        
        if (regeocode) {
            MKNSLog(@"reGeocode:%@", regeocode);
            [ServerAPIManager asyncQueryStoreInfoWithRegionCode:regeocode.adcode succeedBlock:^(GMStoreInfoModel * _Nonnull infoModel) {
                MKNSLog(@"GMStoreInfoModel--%@",infoModel);
                UserCenter.storeId = infoModel.storeId;
            } failedBlock:^(NSError * _Nonnull error) {
                MKNSLog(@"GMStoreInfoModel--查询门店失败");
                UserCenter.storeId = @"1"; //--test
            }];
        }
    }];
}

- (void)cleanUpAction {
    [self.locationManager stopUpdatingLocation];
    
    [self.locationManager setDelegate:nil];
}

- (void)dealloc {
    [self cleanUpAction];
}

@end
