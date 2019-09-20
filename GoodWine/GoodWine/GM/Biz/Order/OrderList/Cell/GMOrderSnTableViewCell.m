//
//  GMOrderSnTableViewCell.m
//  GoodWine
//
//  Created by LMK on 2019/9/17.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMOrderSnTableViewCell.h"

@implementation GMOrderSnTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupConstraints];
        
    }
    return self;
}

- (void)setupConstraints {
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(16.f);
        make.size.mas_equalTo(CGSizeMake(30.f, 30.f));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.iconImageView.mas_right).offset(10.f);
        //        make.width.mas_equalTo(70.f);
    }];
    
    [self.statusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).offset(-16.f);
        make.size.mas_equalTo(CGSizeMake(60.f, 20.f));
    }];
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self);
        make.left.equalTo(self).offset(16.f);
        make.height.mas_equalTo(LINE_HEIGHT);
    }];
}

- (void)updateCellWithModel:(GMOrderDetailInfoModel *)model {
    self.titleLabel.text = model.orderSn;
    if ([model.commentType integerValue] == 2) {
        [self.statusBtn setBackgroundImage:[UIImage imageNamed:@"white_bg"] forState:UIControlStateNormal];
        [self.statusBtn setTitleColor:COLOR_TEXT_BLACK forState:UIControlStateNormal];
    } else {
        [self.statusBtn setBackgroundImage:[UIImage imageNamed:@"red_bg"] forState:UIControlStateNormal];
        [self.statusBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    [self.statusBtn setTitle:[model.status statusFormatterWithType:model.commentType] forState:UIControlStateNormal];
}

- (void)updateCellImageName:(NSString *)imageName title:(NSString *)title content:(NSString *)content needLine:(BOOL)needLine {

    self.titleLabel.text = title;
}

#pragma mark --init subviews

- (UIImageView *)iconImageView {
    if (! _iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"goodWine"]];
        [self.contentView addSubview:_iconImageView];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel {
    if (! _titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = Font_15;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIButton *)statusBtn {
    if (! _statusBtn) {
        _statusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _statusBtn.titleLabel.font = Font(14.f);
        [self.contentView addSubview:_statusBtn];
    }
    return _statusBtn;
}

@end
