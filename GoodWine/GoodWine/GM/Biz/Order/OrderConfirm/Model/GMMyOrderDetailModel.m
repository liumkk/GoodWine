//
//  GMMyOrderDetailModel.m
//  GoodWine
//
//  Created by LMK on 2019/8/31.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMMyOrderDetailModel.h"

@implementation GMMyOrderDetailModel

- (NSString *)expectedTime {
    if (IsStrEmpty(_expectedTime)) {
        return @"";
    } else {
        return _expectedTime;
    }
    
}

- (NSString *)payType {
    return @"0";
}

@end
