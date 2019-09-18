//
//  GMMyCouponTableViewCell.h
//  GoodWine
//
//  Created by LMK on 2019/9/18.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMMyCouponTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *validLabel;
@property (nonatomic, strong) UILabel *statusLabel;

- (void)updateMyCouponCellWithModel:(MyCouponInfoModel *)model;

@end

NS_ASSUME_NONNULL_END
