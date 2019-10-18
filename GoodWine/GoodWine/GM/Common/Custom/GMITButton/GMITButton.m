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
//    button.layer.cornerRadius = 5.f;
//    button.layer.masksToBounds = YES;
//    button.layer.borderWidth = 1.f;
//    button.layer.borderColor = [UIColor blueColor].CGColor;
    [button setUpConstrain];
    
    return button;
}

- (void)updateIconImageName:(NSString *)imageName contentText:(NSString *)contentText {
    NSURL *URL = [NSURL URLWithString:imageName];
    [self.iconImageView sd_setImageWithURL:URL];
    
    self.contentLabel.text = contentText;
}

- (void)updateImageName:(NSString *)imageName contentText:(NSString *)contentText Width:(CGFloat)width topMargin:(CGFloat)topMargin bottomMargin:(CGFloat)bottomMargin {
    
    self.iconImageView.image = [UIImage imageNamed:imageName];
    self.contentLabel.text = contentText;
    
    [self.iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(topMargin);
        make.size.mas_equalTo(CGSizeMake(width, width));
    }];
    
    [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(bottomMargin);
    }];
}

- (void)setUpConstrain {
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(10.f);
        make.size.mas_equalTo(CGSizeMake(40.f, 40.f));
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(10.f);
    }];
    
}

- (UILabel *)contentLabel {
    
    if (! _contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.textColor = COLOR_TEXT_BLACK;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.font = [UIFont systemFontOfSize:13.f];
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
