//
//  MKLocationManager.m
//  GoodWine
//
//  Created by LMK on 2019/8/8.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "MKLocationManager.h"

@interface MKLocationManager ()

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, strong) NSDictionary *locationForGeocode;

@property (nonatomic, copy) CompletionBlock completionBlock;

@property (nonatomic, copy) FailedBlock failedBlock;

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
        if ([CLLocationManager locationServicesEnabled]) {
            
            if (nil == self.locationManager)
                self.locationManager = [[CLLocationManager alloc]init];
            self.locationManager.delegate = self;
            self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
            self.locationManager.distanceFilter = 100; // meters
            
        }else {
            NSLog(@"TKLocationManager don't open");
        }
    }
    return self;
}

- (BOOL)checkLocationFunctionEnable {
    
    if(!([CLLocationManager locationServicesEnabled]) || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        return NO;
    }
    return YES;
}

- (void)openLocationFunction {
    
    if (/*[FeatureManager isFeatureDisabled:FeatureYext]*/YES) {
        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.locationManager requestWhenInUseAuthorization];
        }
    } else {
        //        if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        //            [self.locationManager requestAlwaysAuthorization];
        //        }
    }
    [self.locationManager startUpdatingLocation];
}

-(void)stopLocationFunction {
    [self.locationManager stopUpdatingLocation];
}

- (void)updateLocationFunctionWithCompletion:(CompletionBlock)completion failed:(FailedBlock)failed {
    self.completionBlock = completion;
    self.failedBlock = failed;
    [self openLocationFunction];
}

// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    
    // If it's a relatively recent event, turn off updates to save power.
    self.location = [locations lastObject];
    // If the event is recent, do something with it.
    NSLog(@"latitude %+.6f, longitude %+.6f\n, longitude %+.6f\n",
          self.location.coordinate.latitude,
          self.location.coordinate.longitude,
          self.location.altitude);
    
    [self stopLocationFunction];
    
//    CLLocationCoordinate2D converterCoordinate = [UMSLocationConverter wgs84ToBd09:self.location.coordinate];
    
//    NSString *latitude = [NSString stringWithFormat:@"%f",converterCoordinate.latitude];
//    NSString *longitude = [NSString stringWithFormat:@"%f",converterCoordinate.longitude];
//    NSString *altitude = [NSString stringWithFormat:@"%f",self.location.altitude];
//    [UserCenter setLatitude:latitude Longitude:longitude Altitude:altitude];
    
    NSBlockOperation *blockForUpdate = [NSBlockOperation blockOperationWithBlock:^{
        
        //        NSString *urLocation = [userReference objectForKey:LocationFromDevice];
        //        NSNumber *latitude = @([[userReference objectForKey:LatitudeFromDevice] floatValue]);
        //        NSNumber *longitude = @([[userReference objectForKey:LongitudeFromDevice] floatValue]);
        //
        //        [ServerAPIManager asyncUpdateUserProfileByUserName:nil gender:nil location:urLocation latitude:latitude longitude:longitude account:nil succeedBlock:nil failedBlock:nil];
        
    }];
    
    [self CoordinateGeocode:blockForUpdate];
    
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"location error is %@",error);
    if (self.failedBlock) {
        self.failedBlock();
    }
}

- (void)CoordinateGeocode:(NSBlockOperation*)block
{
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    CLLocationCoordinate2D coord = self.location.coordinate;
    
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
    
    [geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error){
            NSLog(@"Geocode failed with error: %@", error);
            if (self.failedBlock) {
                self.failedBlock();
            }
            return;
        }
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        
        self.locationForGeocode = placemark.addressDictionary;
        NSString *city = placemark.locality;
        
        if (!city || city.length == 0) {
            city = placemark.administrativeArea;
        }
        
        if (city.length>0) {
            //            [userReference setObject:city forKey:LocationFromDevice];
//            if ([city isChineseLanguage]) {
//                UserCenter.currentCityName = city;
//                if (!UserCenter.lastTimeCity.cityName || UserCenter.lastTimeCity.cityName.length == 0) {
//                    [UserCenter setLastTimeCity:[CityManager cityModelWithCityName:UserCenter.currentCityName]];
//                }
//            }
        }else if (placemark.administrativeArea.length > 0) {
            //            [userReference setObject:placemark.administrativeArea forKey:LocationFromDevice];
        }
        
        NSString *countryCode = placemark.ISOcountryCode;
        if (countryCode.length>0) {
            //            [userReference setObject:countryCode forKey:CountryCodeFromDevice];
        }
        [block start];
        
//        if (self.completionBlock) {
//            self.completionBlock(locationInfoDict);
//        }
    }];
}

- (void)clear {
    
    self.completionBlock = nil;
    self.failedBlock = nil;
    
}

@end
