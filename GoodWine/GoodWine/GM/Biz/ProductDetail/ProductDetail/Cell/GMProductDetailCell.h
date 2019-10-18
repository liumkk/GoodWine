//
//  GMProductDetailCell.h
//  GoodWine
//
//  Created by LMK on 2019/8/16.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMProductDetailCell : UITableViewCell

@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UILabel *promotionPriceLabel;
@property (nonatomic, strong) UILabel *originalPriceLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *purityLabel;
@property (nonatomic, strong) UILabel *contentLabel;

- (void)updateProductDetailCellWithModel:(GMProductDetailModel *)productDetailModel;

@end

NS_ASSUME_NONNULL_END
