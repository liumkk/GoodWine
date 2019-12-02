//
//  GMDescriptionTableViewCell.h
//  GoodWine
//
//  Created by LMK on 2019/12/2.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMDescriptionTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;

- (void)updateCellWithTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
