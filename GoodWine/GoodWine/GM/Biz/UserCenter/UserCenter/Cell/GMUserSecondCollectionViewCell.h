//
//  GMUserSecondCollectionViewCell.h
//  GoodWine
//
//  Created by LMK on 2019/7/31.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMUserSecondCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel *titleLabel;


- (void)updateCellWithImageString:(NSString *)imageString titleText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
