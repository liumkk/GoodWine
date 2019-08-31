//
//  GMOrderDetailHeaderView.h
//  GoodWine
//
//  Created by LMK on 2019/8/31.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMOrderDetailHeaderView : UIView

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UILabel *platformLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *payBtn;

- (void)updateOrderDetailHeaderViewWithStatus:(NSString *)status content:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
