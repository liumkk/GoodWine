//
//  GMMenuTableViewCell.m
//  GoodWine
//
//  Created by LMK on 2019/6/4.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMMenuTableViewCell.h"

#define padding             10.f
#define cell_height         80.f

@implementation GMMenuTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupConstraints];
        
    }
    return self;
}

- (void)setupConstraints {
    [@[self.whiteSpiritArea, self.redWineArea, self.otherArea,self.couponArea] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:padding leadSpacing:0 tailSpacing:0];
    
    [@[self.whiteSpiritArea, self.redWineArea, self.otherArea,self.couponArea] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.height.mas_equalTo(cell_height);
    }];
}

- (void)updateCell {
    
}

+ (CGFloat)heightForCell {
    
    return cell_height;
    
}

#pragma mark --init subviews

- (GMITButton *)whiteSpiritArea {
    if (! _whiteSpiritArea) {
        _whiteSpiritArea = [GMITButton buttonWithType:UIButtonTypeCustom];
        _whiteSpiritArea.tag = 1;
        [_whiteSpiritArea updateImageName:@"mj_bj" contentText:@"白酒专区" Width:40.f topMargin:15.f bottomMargin:5.f];
        [self.contentView addSubview:_whiteSpiritArea];
        [_whiteSpiritArea.iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self->_whiteSpiritArea.mas_centerX).offset(5.f);
            make.top.equalTo(self).offset(15.f);
            make.size.mas_equalTo(CGSizeMake(30.f, 40.f));
        }];
    }
    return _whiteSpiritArea;
}

- (GMITButton *)redWineArea {
    if (! _redWineArea) {
        _redWineArea = [GMITButton buttonWithType:UIButtonTypeCustom];
        _redWineArea.tag = 2;
        [_redWineArea updateImageName:@"mj_hj" contentText:@"红酒专区" Width:40.f topMargin:15.f bottomMargin:5.f];
        [self.contentView addSubview:_redWineArea];
    }
    return _redWineArea;
}

- (GMITButton *)otherArea {
    if (! _otherArea) {
        _otherArea = [GMITButton buttonWithType:UIButtonTypeCustom];
        _otherArea.tag = 3;
        [_otherArea updateImageName:@"mj_qtj" contentText:@"其他酒品" Width:40.f topMargin:15.f bottomMargin:5.f];
        [self.contentView addSubview:_otherArea];
        [_otherArea.iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self->_otherArea.mas_centerX);
            make.top.equalTo(self).offset(15.f);
            make.size.mas_equalTo(CGSizeMake(20.f, 40.f));
        }];
    }
    return _otherArea;
}

- (GMITButton *)couponArea {
    if (! _couponArea) {
        _couponArea = [GMITButton buttonWithType:UIButtonTypeCustom];
        _couponArea.tag = 4;
        [_couponArea updateImageName:@"mj_yhq2" contentText:@"领券中心" Width:40.f topMargin:15.f bottomMargin:5.f];
        [self.contentView addSubview:_couponArea];
    }
    return _couponArea;
}

@end
