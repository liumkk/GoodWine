//
//  GMUserInfoCell.m
//  GoodWine
//
//  Created by LMK on 2019/5/29.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMUserInfoCell.h"

@implementation GMUserInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self setupConstraints];
        
    }
    return self;
}

- (void)setupConstraints {
    [self.headerImageiew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16.f);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(40.f, 40.f));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerImageiew.mas_right).offset(20.f);
        make.top.equalTo(self.headerImageiew);
    }];
    
    [self.phoneNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.bottom.equalTo(self.headerImageiew);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16.f);
        make.right.bottom.equalTo(self);
        make.height.mas_equalTo(LINE_HEIGHT);
    }];
}

- (void)updateCell {
    
}

+ (CGFloat)heightForCell {
    
    return 100.f;
    
}

#pragma mark --init subviews

- (UIImageView *)headerImageiew {
    if (! _headerImageiew) {
        _headerImageiew = [[UIImageView alloc] initWithFrame:CGRectZero];
        _headerImageiew.image = [UIImage imageNamed:@"test"];
        _headerImageiew.clipsToBounds = YES;
        _headerImageiew.layer.cornerRadius = 20;
        [self.contentView addSubview:_headerImageiew];
    }
    return _headerImageiew;
}

- (UILabel *)nameLabel {
    if (! _nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.text = @"美酒快线";
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UILabel *)phoneNumLabel {
    if (! _phoneNumLabel) {
        _phoneNumLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _phoneNumLabel.text = @"139****1993";
        [self.contentView addSubview:_phoneNumLabel];
    }
    return _phoneNumLabel;
}

- (UIView *)lineView {
    if (! _lineView) {
        _lineView = [UIView creatDefaultLineView];
        [self.contentView addSubview:_lineView];
    }
    return _lineView;
}

@end
