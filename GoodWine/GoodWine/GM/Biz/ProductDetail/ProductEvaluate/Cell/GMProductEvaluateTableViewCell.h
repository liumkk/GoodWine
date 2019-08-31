//
//  GMProductEvaluateTableViewCell.h
//  GoodWine
//
//  Created by LMK on 2019/8/19.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define evaluateContentCellFont         Font_14

@interface GMProductEvaluateTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nickName;
@property (nonatomic, strong) UIImageView *start1;
@property (nonatomic, strong) UIImageView *start2;
@property (nonatomic, strong) UIImageView *start3;
@property (nonatomic, strong) UIImageView *start4;
@property (nonatomic, strong) UIImageView *start5;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIView *lineView;

- (void)updateEvaluateTableCellWithModel:(ProductEvaluateInfoModel *)infoModel;

@end

NS_ASSUME_NONNULL_END
