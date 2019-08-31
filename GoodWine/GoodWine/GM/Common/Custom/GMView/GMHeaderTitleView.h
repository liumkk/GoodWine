//
//  GMHeaderTitleView.h
//  GoodWine
//
//  Created by LMK on 2019/8/19.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMHeaderTitleView : UIView

@property (nonatomic, strong) UILabel *titleLabel;

- (void)updateTitleText:(NSString *)title titleColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
