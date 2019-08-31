//
//  GMWineListCollectionViewCell.h
//  GoodWine
//
//  Created by LMK on 2019/7/24.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMWineListCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *bgView;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *promotionPriceLabel;
@property (nonatomic, strong) UILabel *originalPriceLabel;
@property (nonatomic, strong) UILabel *saleLabel;

- (void)updateWineListCollectionCellWithHomePageTypeItem:(HomePageTypeItem *)homePageTypeItem;

@end

NS_ASSUME_NONNULL_END
