//
//  GMBrandTableViewCell.h
//  GoodWine
//
//  Created by LMK on 2019/8/29.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMBrandTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *brandLabel;

- (void)updateCellWithLabelText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
