//
//  GMShoppCarTableViewCell.h
//  GoodWine
//
//  Created by LMK on 2019/8/7.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMShoppCarTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIButton *jianBtn;
@property (nonatomic, strong) UIButton *jiaBtn;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UIView *lineView;

- (void)updateShoppCarTableCellWithModel:(ShoppCarInfoModel *)infoModel needLine:(BOOL)needLine;

+ (CGFloat)heightForCell;

@end

NS_ASSUME_NONNULL_END
