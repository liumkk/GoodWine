//
//  GMOrderSnTableViewCell.h
//  GoodWine
//
//  Created by LMK on 2019/9/17.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMOrderSnTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *cancleBtn;
@property (nonatomic, strong) UIButton *statusBtn;

- (void)updateCellWithModel:(GMOrderDetailInfoModel *)model;

@end

NS_ASSUME_NONNULL_END
