//
//  GMSettingTableViewCell.h
//  GoodWine
//
//  Created by LMK on 2019/9/17.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMSettingTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIView *topLine;

- (void)updateCellImageName:(NSString *)imageName title:(NSString *)title content:(NSString *)content needLine:(BOOL)needLine;

@end

NS_ASSUME_NONNULL_END
