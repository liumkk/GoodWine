//
//  GMOrderDetailFooterView.h
//  GoodWine
//
//  Created by LMK on 2019/8/31.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMOrderDetailFooterView : UIView

@property (nonatomic, strong) UILabel *totalLabeL;
@property (nonatomic, strong) UIButton *cancleBtn;
@property (nonatomic, strong) UIButton *phoneBtn;

- (void)updateFooterViewWithOrderDetailModel:(GMOrderDetailInfoModel *)model;

@end

NS_ASSUME_NONNULL_END
