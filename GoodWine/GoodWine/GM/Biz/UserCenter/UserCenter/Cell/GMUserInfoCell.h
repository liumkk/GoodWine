//
//  GMUserInfoCell.h
//  GoodWine
//
//  Created by LMK on 2019/5/29.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMUserInfoCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headerImageiew;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneNumLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *rightLabel;

+ (CGFloat)heightForCell;

- (void)updateCell;

@end

NS_ASSUME_NONNULL_END
