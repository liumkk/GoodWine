//
//  GMOrderPayView.h
//  GoodWine
//
//  Created by LMK on 2019/8/31.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMOrderPayView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *platformImageView;
@property (nonatomic, strong) UILabel *platformLabel;
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) UIButton *payBtn;

- (void)updateWithPayAmount:(NSString *)amount;

@end

NS_ASSUME_NONNULL_END
