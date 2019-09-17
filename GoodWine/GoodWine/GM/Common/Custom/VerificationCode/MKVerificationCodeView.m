//
//  MKVerificationCodeView.m
//  GoodWine
//
//  Created by LMK on 2019/8/22.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "MKVerificationCodeView.h"

#define VERIFYBUTTON_WIDTH 80
#define VERIFYBUTTON_WIDTH_W 120
#define VERIFYBUTTON_HEIGHT 35
#define VERIFYBUTTON_EDGE     UIEdgeInsetsMake(0, 5, 0, -5)

#define DEADLINE_TIME 60

@interface MKVerificationCodeView ()

@property (nonatomic, assign) NSInteger defaultTime;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation MKVerificationCodeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self) {
        self = [super initWithFrame:frame];
        
        self.bounds = CGRectMake(0, 0, VERIFYBUTTON_WIDTH, VERIFYBUTTON_HEIGHT);
        [self setupConstraints];
    }
    return self;
}

- (void)initTimer {
    self.defaultTime = DEADLINE_TIME;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(timerRun:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)timerRun:(NSTimer *)timer {
    self.defaultTime -- ;
    if (self.defaultTime == 0) {
        self.verifyButton.enabled = YES;
        [self.verifyButton setTitle:@"重新发送" forState:UIControlStateNormal];
        self.bounds = CGRectMake(0, 0, VERIFYBUTTON_WIDTH, VERIFYBUTTON_HEIGHT);
        [self clearTimer];
    } else {
        self.verifyButton.enabled = NO;
        [self.verifyButton setTitle:[NSString stringWithFormat:@"%lds后重新发送",self.defaultTime] forState:UIControlStateDisabled];
        self.bounds = CGRectMake(0, 0, VERIFYBUTTON_WIDTH_W, VERIFYBUTTON_HEIGHT);
    }
}

- (void)clearTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (UIButton *)verifyButton {
    
    if (!_verifyButton) {
        _verifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_verifyButton setTitleColor:COLOR_THEME_COLOR forState:UIControlStateNormal];
        [_verifyButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [_verifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        _verifyButton.titleLabel.font = Font_13;
//        [_verifyButton addTarget:self action:@selector(initTimer) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_verifyButton];
    }
    return _verifyButton;
}

- (void)setupConstraints {
    [self.verifyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(VERIFYBUTTON_EDGE);
    }];
}

@end
