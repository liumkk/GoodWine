//
//  GMSettingTableViewCell.m
//  GoodWine
//
//  Created by LMK on 2019/9/17.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMSettingTableViewCell.h"

@implementation GMSettingTableViewCell

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
        make.size.mas_equalTo(CGSizeMake(0.f, 0.f));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.iconImageView.mas_right).offset(10.f);
//        make.width.mas_equalTo(70.f);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).offset(-16.f);
    }];
    
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self);
        make.left.equalTo(self).offset(16.f);
        make.height.mas_equalTo(LINE_HEIGHT);
    }];
}

- (void)updateCellImageName:(NSString *)imageName title:(NSString *)title content:(NSString *)content needLine:(BOOL)needLine {
    self.topLine.hidden = !needLine;
//    self.iconImageView.image = [UIImage imageNamed:imageName];
    self.titleLabel.text = title;
    self.contentLabel.text = content;
    
    if (self.accessoryType == UITableViewCellAccessoryDisclosureIndicator) {
        [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.right.equalTo(self.contentView.mas_right);
        }];
    }
}

#pragma mark --init subviews

- (UIImageView *)iconImageView {
    if (! _iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
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

- (UILabel *)contentLabel {
    if (! _contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.textColor = COLOR_GRAY_200;
        _contentLabel.font = Font_15;
        _contentLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}

- (UIView *)topLine {
    if (! _topLine) {
        _topLine = [[UIView alloc] initWithFrame:CGRectZero];
        _topLine.backgroundColor = COLOR_LINE_COLOR;
        _topLine.hidden = YES;
        [self addSubview:_topLine];
    }
    return _topLine;
}

@end
