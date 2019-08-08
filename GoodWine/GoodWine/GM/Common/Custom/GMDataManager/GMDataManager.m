//
//  GMDataManager.m
//  GoodWine
//
//  Created by LMK on 2019/8/3.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMDataManager.h"

@implementation GMDataManager

static GMDataManager *shared = nil;

+ (instancetype)shared {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        shared = [[GMDataManager alloc] init];
        
    });
    return shared;
}

- (void)saveCookie {
    //cookies获取
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookieArr = [cookieJar cookies];
    for(NSHTTPCookie *cookie in cookieArr) {
        NSLog(@"cookie －> %@", cookie);
        if ([cookie.name isEqualToString:@"JSESSIONID"]) {
            //存储cookies
            //                [MyDataSaveHelper setAccessToken:cookie.value];
            [[NSUserDefaults standardUserDefaults] setObject:cookie.value forKey:Cookie_Key];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        //存储之后删除cookies
//        [cookieJar deleteCookie:cookie];
    }
}

- (NSString *)getCookie {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *cookie = [defaults objectForKey:Cookie_Key];
//    return cookie.length > 0 ? cookie : @"";
    return cookie;
}

- (void)removeCookie {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:Cookie_Key];
    [defaults synchronize];
}

@end
