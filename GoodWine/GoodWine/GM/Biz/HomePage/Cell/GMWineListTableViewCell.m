//
//  GMWineListTableViewCell.m
//  GoodWine
//
//  Created by LMK on 2019/6/4.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMWineListTableViewCell.h"

@implementation GMWineListTableViewCell

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
        make.size.mas_equalTo(CGSizeMake(30.f, 30.f));
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView);
        make.left.equalTo(self.iconImageView.mas_right).offset(16.f);
        make.right.equalTo(self.contentView.mas_right).offset(-30.f);
    }];
    
    
}

- (void)updateWineListCellWithImage:(NSString *)image contentText:(NSString *)contentText {
    
}

+ (CGFloat)heightForCell {
    
//    return 60.f;
    NSString *string = @"沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王";
    CGSize size = [string boundingRectWithSize:CGSizeMake(Width_Screen - 30, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f]} context:nil].size;
    return ceil(size.height);
    
}

#pragma mark --init subviews

- (UIImageView *)iconImageView {
    if (! _iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"test"]];
        [self.contentView addSubview:_iconImageView];
    }
    return _iconImageView;
}

- (UILabel *)contentLabel {
    if (! _contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.font = [UIFont systemFontOfSize:14.f];
        _contentLabel.text = @"沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王沙河王";
        _contentLabel.numberOfLines = 0;
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}

@end
