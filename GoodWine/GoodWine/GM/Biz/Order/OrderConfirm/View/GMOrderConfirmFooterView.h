//
//  GMOrderConfirmFooterView.h
//  GoodWine
//
//  Created by LMK on 2019/8/16.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMOrderConfirmFooterView : UIView

@property (nonatomic, strong) UILabel *totalLabeL;
@property (nonatomic, strong) UIButton *confirmButton;

- (void)updateFooterViewWithModel:(CalcAmountInfoModel *)model;

@end

NS_ASSUME_NONNULL_END
