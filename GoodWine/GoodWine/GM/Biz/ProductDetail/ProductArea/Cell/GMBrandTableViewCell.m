//
//  GMBrandTableViewCell.m
//  GoodWine
//
//  Created by LMK on 2019/8/29.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMBrandTableViewCell.h"

@implementation GMBrandTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupConstraints];
        
    }
    return self;
}

- (void)setupConstraints {
    [self.brandLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 16, 0, 10));
    }];
}

- (void)updateCellWithLabelText:(NSString *)text {
    self.brandLabel.text = text;
}

#pragma mark --init subviews

- (UILabel *)brandLabel {
    if (! _brandLabel) {
        _brandLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _brandLabel.textColor = COLOR_TEXT_BLACK;
        _brandLabel.numberOfLines = 0;
        _brandLabel.font = Font_15;
        [self.contentView addSubview:_brandLabel];
    }
    return _brandLabel;
}

@end
