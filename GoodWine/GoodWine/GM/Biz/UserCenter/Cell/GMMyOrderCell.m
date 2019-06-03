//
//  GMMyOrderCell.m
//  GoodWine
//
//  Created by LMK on 2019/5/29.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMMyOrderCell.h"

@implementation GMMyOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupConstraints];
        
    }
    return self;
}

- (void)setupConstraints {
    
}

- (void)updateCell {
    
}

+ (CGFloat)heightForCell {
    
    return 120.f;
    
}

#pragma mark --init subviews

- (UILabel *)orderLabel {
    if (! _orderLabel) {
        _orderLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _orderLabel.text = @"我的订单";
        [self.contentView addSubview:_orderLabel];
    }
    return _orderLabel;
}

- (UILabel *)detailLabel {
    if (! _detailLabel) {
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _detailLabel.text = @"查看全部订单";
        [self.contentView addSubview:_detailLabel];
    }
    return _detailLabel;
}

- (UIView *)lineView {
    if (! _lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = COLOR_LINE_COLOR;
        [self.contentView addSubview:_lineView];
    }
    return _lineView;
}

- (GMITButton *)orderStateButton {
    if (! _orderStateButton) {
        _orderStateButton = [GMITButton buttonWithType:UIButtonTypeCustom];
        _orderStateButton.iconImageView.image = [UIImage imageNamed:@"test"];
        _orderStateButton.contentLabel.text = @"配送中";
        [self.contentView addSubview:_orderStateButton];
    }
    return _orderStateButton;
}

@end
