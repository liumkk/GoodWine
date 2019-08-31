//
//  GMOrderProductTableViewCell.h
//  GoodWine
//
//  Created by LMK on 2019/8/14.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMOrderProductTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UIView *lineView;

- (void)updateOrderProductTableCellWithModel:(ShoppCarInfoModel *)model;

- (void)updateOrderProductTableCellWithOrderItem:(GMOrderItem *)item;

+ (CGFloat)heightForCell;

@end

NS_ASSUME_NONNULL_END
