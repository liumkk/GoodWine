//
//  GMUserCenter.m
//  GoodWine
//
//  Created by LMK on 2019/7/31.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMUserCenter.h"

@implementation GMUserCenter

static GMUserCenter *_sharedInstance = nil;

+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sharedInstance = [[GMUserCenter alloc] init];
        
    });
    return _sharedInstance;
}

- (id)init {
    
    self = [super init];
    
    if (self) {
//        [self initData];
    }
    return self;
}

- (void)queryStoreId {
    UserCenter.storeId = @"46";
    GMStoreInfoModel *model = [[GMStoreInfoModel alloc] init];
    model.contactPhone = @"13916391993";
    model.platPhone = @"13916391993";
    UserCenter.storeInfoModel = model;
}

@end
