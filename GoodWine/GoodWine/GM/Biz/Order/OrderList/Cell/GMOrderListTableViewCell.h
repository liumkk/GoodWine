//
//  GMOrderListTableViewCell.h
//  GoodWine
//
//  Created by LMK on 2019/9/9.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMOrderListTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) UIImageView *productImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *numLabel;

@end

NS_ASSUME_NONNULL_END
