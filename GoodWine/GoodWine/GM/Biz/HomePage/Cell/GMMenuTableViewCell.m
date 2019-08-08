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
        [_whiteSpiritArea updateIconImageName:@"" contentText:@"白酒专区"];
        [self.contentView addSubview:_whiteSpiritArea];
    }
    return _whiteSpiritArea;
}

- (GMITButton *)redWineArea {
    if (! _redWineArea) {
        _redWineArea = [GMITButton buttonWithType:UIButtonTypeCustom];
        [_redWineArea updateIconImageName:@"" contentText:@"红酒专区"];
        [self.contentView addSubview:_redWineArea];
    }
    return _redWineArea;
}

- (GMITButton *)otherArea {
    if (! _otherArea) {
        _otherArea = [GMITButton buttonWithType:UIButtonTypeCustom];
        [_otherArea updateIconImageName:@"" contentText:@"其他酒品"];
        [self.contentView addSubview:_otherArea];
    }
    return _otherArea;
}

- (GMITButton *)couponArea {
    if (! _couponArea) {
        _couponArea = [GMITButton buttonWithType:UIButtonTypeCustom];
        [_couponArea updateIconImageName:@"" contentText:@"领券中心"];
        [self.contentView addSubview:_couponArea];
    }
    return _couponArea;
}

@end
