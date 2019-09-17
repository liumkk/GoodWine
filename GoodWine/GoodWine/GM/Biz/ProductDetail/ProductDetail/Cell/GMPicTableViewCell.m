//
//  GMPicTableViewCell.m
//  GoodWine
//
//  Created by LMK on 2019/9/17.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMPicTableViewCell.h"

@implementation GMPicTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupConstraints];
        
    }
    return self;
}

- (void)setupConstraints {
    [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)updateCellWithImageName:(NSString *)imageName {
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:imageName]];
}

#pragma mark --init subviews

- (UIImageView *)picImageView {
    if (! _picImageView) {
        _picImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_picImageView];
    }
    return _picImageView;
}

@end
