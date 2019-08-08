//
//  UIView+MKAdditions.h
//  GoodWine
//
//  Created by LMK on 2019/6/10.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (MKAdditions)

@property(nonatomic, assign) CGFloat left;
@property(nonatomic, assign) CGFloat top;
@property(nonatomic, assign) CGFloat right;
@property(nonatomic, assign) CGFloat bottom;

@property(nonatomic, assign) CGFloat width;
@property(nonatomic, assign) CGFloat height;

@property(nonatomic, assign) CGFloat centerX;
@property(nonatomic, assign) CGFloat centerY;

@end

NS_ASSUME_NONNULL_END
