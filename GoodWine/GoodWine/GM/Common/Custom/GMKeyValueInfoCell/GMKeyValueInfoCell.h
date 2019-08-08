//
//  GMKeyValueInfoCell.h
//  GoodWine
//
//  Created by LMK on 2019/5/28.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, GMKVInfoCellType) {
    GMKVInfoCellTypeDefaultLabel,
    GMKVInfoCellTypeLeftImageView,
    GMKVInfoCellTypeAllTextField,
    GMKVInfoCellTypeNumTextField,
    GMKVInfoCellTypePasswordTextField
};

@interface GMKeyValueInfoCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITextField *textFieldWithBtn;

@property (nonatomic, strong) UIButton *passwordShowBtn;
@property (nonatomic, strong) UIView *topLine;


@property (nonatomic, assign) GMKVInfoCellType cellType;
// 获取当前正在使用的控件
@property (nonatomic, strong) UIView *currentControl;

- (void)updateCellContentWithCellType:(GMKVInfoCellType)cellType leftText:(NSString *)leftText rightText:(NSString *)rightText needLine:(BOOL)needLine;

+ (CGFloat)heightForCell;

+ (CGFloat)heightForCellWithFloat:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
