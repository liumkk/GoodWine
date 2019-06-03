//
//  GMITButton.m
//  GoodWine
//
//  Created by LMK on 2019/5/29.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMITButton.h"

@implementation GMITButton

+ (instancetype)buttonWithType:(UIButtonType)buttonType {
    GMITButton *button = [super buttonWithType:buttonType];
    
    [button setUpConstrain];
    
    return button;
}

- (void)setUpConstrain {
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.right.equalTo(self).offset(-5);
        make.centerX.equalTo(self);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
    }];
    
}

- (UILabel *)contentLabel {
    
    if (! _contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        _contentLabel.font = BIZ_BUTTON_LABEL_FONT;
        _contentLabel.textColor = COLOR_TEXT_BLACK;
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:_contentLabel];
    }
    return _contentLabel;
}

- (UIImageView *)iconImageView {
    
    if (! _iconImageView) {
        
        _iconImageView = [[UIImageView alloc] init];
        
        [self addSubview:_iconImageView];
    }
    return _iconImageView;
}

@end
