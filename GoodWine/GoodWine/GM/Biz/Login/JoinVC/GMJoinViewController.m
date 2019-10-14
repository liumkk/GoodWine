//
//  GMJoinViewController.m
//  GoodWine
//
//  Created by LMK on 2019/10/14.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMJoinViewController.h"

#define Join_PhoneNum       @"18010965905"

@interface GMJoinViewController ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *telBtn;

@end

@implementation GMJoinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateNavigationBarNeedBack:YES];
    
    [self initSubviews];
    [self setupConstraints];
}

- (void)initSubviews {
    self.title = @"招商加盟";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)telPhone:(UIButton *)btn {
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",Join_PhoneNum];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

- (void)setupConstraints {

    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(60.f);
        make.size.mas_equalTo(CGSizeMake(180.f, 180.f));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(20.f);
    }];
    
    [self.telBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.titleLabel).insets(UIEdgeInsetsMake(60.f, 0, 0, 0));
    }];
}

- (UIImageView *)iconImageView {
    if (! _iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"goodWine"]];
        [self.view addSubview:_iconImageView];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel {
    if (! _titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = COLOR_THEME_COLOR;
        _titleLabel.font = Font(18.f);
        _titleLabel.numberOfLines = 0;
        NSString *title = [NSString stringWithFormat:@"美酒快线\n所在地区暂无门店!\n招商加盟热线:%@",Join_PhoneNum];
        NSMutableAttributedString *attributedStr = [NSString getAttrStr:title beginL:0 endL:4 color:COLOR_TEXT_BLACK font:Font(25.f)];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 15.0; // 设置行间距
        paragraphStyle.alignment = NSTextAlignmentCenter;
        [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedStr.length)];
        _titleLabel.attributedText = attributedStr;
        [self.view addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIButton *)telBtn {
    if (! _telBtn) {
        _telBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_telBtn addTarget:self action:@selector(telPhone:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_telBtn];
    }
    return _telBtn;
}

@end
