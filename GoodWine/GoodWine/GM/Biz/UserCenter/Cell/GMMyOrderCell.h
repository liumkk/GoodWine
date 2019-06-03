//
//  GMMyOrderCell.h
//  GoodWine
//
//  Created by LMK on 2019/5/29.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMMyOrderCell : UITableViewCell

@property (nonatomic, strong) UILabel *orderLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) GMITButton *orderStateButton;

@end

NS_ASSUME_NONNULL_END
