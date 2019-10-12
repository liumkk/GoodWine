//
//  GMWebViewController.h
//  GoodWine
//
//  Created by LMK on 2019/10/10.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GMWebViewController : GMBaseViewController

- (instancetype)initNeedAdapter:(BOOL)adapter;

@property (nonatomic, copy) NSString *urlString;

@end

NS_ASSUME_NONNULL_END
