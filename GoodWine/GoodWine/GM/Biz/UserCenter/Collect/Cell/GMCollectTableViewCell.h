//
//  GMCollectTableViewCell.h
//  GoodWine
//
//  Created by LMK on 2019/8/30.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMCollectTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *bgView;

@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *saleLabel;
@property (nonatomic, strong) UIView *lineView;

- (void)updateCollectCellWithModel:(CollectProductItem *)item;

@end

NS_ASSUME_NONNULL_END
