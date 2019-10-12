//
//  GMShoppCarTableViewCell.m
//  GoodWine
//
//  Created by LMK on 2019/8/7.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMShoppCarTableViewCell.h"

#define HeaderView_width        80.f

@interface GMShoppCarTableViewCell ()

@property (nonatomic, strong) ShoppCarInfoModel *model;

@end

@implementation GMShoppCarTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupConstraints];
        
    }
    return self;
}

- (void)setupConstraints {
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(7.f);
        make.size.mas_equalTo(CGSizeMake(35.f, 35.f));
    }];
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(10.f);
        make.size.mas_equalTo(CGSizeMake(30.f, 30.f));
    }];
    
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.selectBtn.mas_right).offset(10.f);
        make.size.mas_equalTo(CGSizeMake(HeaderView_width, HeaderView_width));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleImageView);
        make.left.equalTo(self.titleImageView.mas_right).offset(10.f);
        make.right.equalTo(self.contentView).offset(-10.f);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5.f);
        make.left.right.equalTo(self.titleLabel);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(10.f);
        make.left.equalTo(self.titleLabel);
        make.height.mas_equalTo(20.f);
    }];
    
    [self.jiaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.priceLabel);
        make.right.equalTo(self.contentView.mas_right).offset(-10.f);
        make.size.mas_equalTo(CGSizeMake(20.f, 20.f));
    }];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.jiaBtn);
        make.right.equalTo(self.jiaBtn.mas_left).offset(-5.f);
        make.size.mas_equalTo(CGSizeMake(30.f, 30.f));
    }];
    
    [self.jianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.jiaBtn);
        make.right.equalTo(self.numLabel.mas_left).offset(-5.f);
        make.size.mas_equalTo(CGSizeMake(20.f, 20.f));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self);
        make.left.equalTo(self).offset(16.f);
        make.height.mas_equalTo(LINE_HEIGHT);
    }];
    
    self.titleImageView.bounds = CGRectMake(0, 0, HeaderView_width, HeaderView_width);
    [UIView maskCorner:self.titleImageView rectCorner:UIRectCornerAllCorners corner:5.f];
    
}

- (void)updateShoppCarTableCellWithModel:(ShoppCarInfoModel *)infoModel needLine:(BOOL)needLine {
    self.model = infoModel;
    
    self.lineView.hidden = !needLine;
    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:infoModel.productPic] placeholderImage:[UIImage imageNamed:@"goodWine"]];
    self.titleLabel.text = infoModel.productName;
    self.contentLabel.text = infoModel.productSubTitle;
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f元",[infoModel.currentPrice floatValue]];
    self.numLabel.text = [NSString stringWithFormat:@"%@",self.model.quantity];
    if ([infoModel.invalidStatus isEqualToString:@"1"]) {
        self.selectBtn.hidden = YES;
        self.statusLabel.hidden = NO;
    } else {
        self.statusLabel.hidden = YES;
        self.selectBtn.hidden = NO;
        self.selectBtn.selected = infoModel.isSelected;
    }
    
}

+ (CGFloat)heightForCell {
    
    return 100.f;
    
}

#pragma mark --init subviews

- (UILabel *)statusLabel {
    if (! _statusLabel) {
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _statusLabel.text = @"已下架";
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        _statusLabel.textColor = COLOR_THEME_COLOR;
        _statusLabel.font = Font_10;
        _statusLabel.layer.cornerRadius = 17.5;
        _statusLabel.layer.masksToBounds = YES;
        _statusLabel.layer.borderWidth = 0.5;
        _statusLabel.layer.borderColor = COLOR_THEME_COLOR.CGColor;
        [self.contentView addSubview:_statusLabel];
    }
    return _statusLabel;
}

- (UIButton *)selectBtn {
    if (! _selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"select"] forState:UIControlStateSelected];
        [self.contentView addSubview:_selectBtn];
    }
    return _selectBtn;
}

- (UIImageView *)titleImageView {
    if (! _titleImageView) {
        _titleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _titleImageView.image = [UIImage imageNamed:@"goodWine"];
        [self.contentView addSubview:_titleImageView];
    }
    return _titleImageView;
}

- (UILabel *)titleLabel {
    if (! _titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.text = @"口子窖";
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (! _contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.text = @"酱香型";
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}

- (UILabel *)priceLabel {
    if (! _priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceLabel.text = @"100.00";
        [self.contentView addSubview:_priceLabel];
    }
    return _priceLabel;
}

- (UIButton *)jianBtn {
    if (! _jianBtn) {
        _jianBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_jianBtn setTitle:@"-" forState:UIControlStateNormal];
        [_jianBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _jianBtn.titleLabel.font = [UIFont systemFontOfSize:30.f];
        [self.contentView addSubview:_jianBtn];
    }
    return _jianBtn;
}

- (UIButton *)jiaBtn {
    if (! _jiaBtn) {
        _jiaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_jiaBtn setTitle:@"+" forState:UIControlStateNormal];
        [_jiaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _jiaBtn.titleLabel.font = [UIFont systemFontOfSize:30.f];
        [self.contentView addSubview:_jiaBtn];
    }
    return _jiaBtn;
}

- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _numLabel.text = @"1";
        _numLabel.textAlignment = NSTextAlignmentCenter;
        _numLabel.layer.borderColor = COLOR_GRAY_200.CGColor;
        _numLabel.layer.borderWidth = 1.f;
        _numLabel.layer.cornerRadius = 5.f;
        _numLabel.layer.masksToBounds = YES;
        [self.contentView addSubview:_numLabel];
    }
    return _numLabel;
}

- (UIView *)lineView {
    if (! _lineView) {
        _lineView = [UIView creatDefaultLineView];
        [self.contentView addSubview:_lineView];
    }
    
    return _lineView;
}

@end
