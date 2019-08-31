//
//  GMProductEvaluateTableViewCell.m
//  GoodWine
//
//  Created by LMK on 2019/8/19.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMProductEvaluateTableViewCell.h"

@interface GMProductEvaluateTableViewCell ()

@property (nonatomic, strong) NSArray *startArray;

@end

@implementation GMProductEvaluateTableViewCell

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
        make.left.equalTo(self.contentView).offset(16.f);
        make.top.equalTo(self.contentView).offset(10.f);
        make.size.mas_equalTo(CGSizeMake(30.f, 40.f));
    }];
    
    [self.nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(10.f);
        make.top.equalTo(self.contentView).offset(10.f);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.mas_bottom).offset(10.f);
        make.left.equalTo(self.contentView).offset(16.f);
        make.right.equalTo(self.contentView.mas_right).offset(-10.f);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(16.f);
        make.height.mas_equalTo(LINE_HEIGHT);
    }];
    
    [self.start1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(10.f);
        make.top.equalTo(self.nickName.mas_bottom).offset(3.f);
        make.size.mas_equalTo(CGSizeMake(20.f, 20.f));
    }];
    
    [self.start2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.start1.mas_right);
        make.top.equalTo(self.start1);
        make.size.mas_equalTo(CGSizeMake(20.f, 20.f));
    }];
    
    [self.start3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.start2.mas_right);
        make.top.equalTo(self.start2);
        make.size.mas_equalTo(CGSizeMake(20.f, 20.f));
    }];
    
    [self.start4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.start3.mas_right);
        make.top.equalTo(self.start3);
        make.size.mas_equalTo(CGSizeMake(20.f, 20.f));
    }];
    
    [self.start5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.start4.mas_right);
        make.top.equalTo(self.start4);
        make.size.mas_equalTo(CGSizeMake(20.f, 20.f));
    }];
    
    self.startArray = @[self.start1, self.start2, self.start3, self.start4, self.start5];
}

- (void)updateEvaluateTableCellWithModel:(ProductEvaluateInfoModel *)infoModel {
    for (UIImageView *img in self.startArray) {
        img.hidden = YES;
    }
    for (int i = 0; i < infoModel.productStar; i ++) {
        UIImageView *img = self.startArray[i];
        img.hidden = NO;
    }
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:infoModel.memberIcon] placeholderImage:[UIImage imageNamed:@"headerDefault"]];
    self.nickName.text = infoModel.memberNickName;
    self.contentLabel.text = infoModel.content;
}

#pragma mark --init subviews

- (UIImageView *)iconImageView {
    if (! _iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_iconImageView];
    }
    return _iconImageView;
}

- (UILabel *)nickName {
    if (! _nickName) {
        _nickName = [[UILabel alloc] initWithFrame:CGRectZero];
        _nickName.textColor = COLOR_GRAY_150;
        _nickName.font = Font_15;
        [self.contentView addSubview:_nickName];
    }
    return _nickName;
}

- (UILabel *)contentLabel {
    if (! _contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = COLOR_GRAY_150;
        _contentLabel.font = evaluateContentCellFont;
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}

- (UIImageView *)start1 {
    if (! _start1) {
        _start1 = [self creatSrartImageView];
        [self.contentView addSubview:_start1];
    }
    return _start1;
}

- (UIImageView *)start2 {
    if (! _start2) {
        _start2 = [self creatSrartImageView];
        [self.contentView addSubview:_start2];
    }
    return _start2;
}

- (UIImageView *)start3 {
    if (! _start3) {
        _start3 = [self creatSrartImageView];
        [self.contentView addSubview:_start3];
    }
    return _start3;
}

- (UIImageView *)start4 {
    if (! _start4) {
        _start4 = [self creatSrartImageView];
        [self.contentView addSubview:_start4];
    }
    return _start4;
}

- (UIImageView *)start5 {
    if (! _start5) {
        _start5 = [self creatSrartImageView];
        [self.contentView addSubview:_start5];
    }
    return _start5;
}

- (UIImageView *)creatSrartImageView {
    UIImageView *start = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lightStart"]];
    start.hidden = YES;
    return start;
}

- (UIView *)lineView {
    if (! _lineView) {
        _lineView = [UIView creatDefaultLineView];
        [self.contentView addSubview:_lineView];
    }
    return _lineView;
}

@end
