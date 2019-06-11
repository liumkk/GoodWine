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
    button.layer.cornerRadius = 5.f;
    button.layer.masksToBounds = YES;
    button.layer.borderWidth = 1.f;
    button.layer.borderColor = [UIColor blueColor].CGColor;
    [button setUpConstrain];
    
    return button;
}

- (void)updateIconImageName:(NSString *)imageName contentText:(NSString *)contentText {
    NSURL *URL = [NSURL URLWithString:@"http://img.taopic.com/uploads/allimg/140806/235020-140P60H10661.jpg"];

    [self.iconImageView sd_setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"test"] options:0];
    
    self.contentLabel.text = contentText;
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
        _contentLabel.font = [UIFont systemFontOfSize:14.f];
        [self addSubview:_contentLabel];
    }
    return _contentLabel;
}

- (UIImageView *)iconImageView {
    
    if (! _iconImageView) {
        
        _iconImageView = [[UIImageView alloc] init];
//        _iconImageView.image = [UIImage imageNamed:@"test"];
        
        [self addSubview:_iconImageView];
    }
    return _iconImageView;
}

@end
