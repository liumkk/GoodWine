//
//  GMMaskView.m
//  GoodWine
//
//  Created by LMK on 2019/8/20.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMMaskView.h"

@interface GMMaskView ()
@property (nonatomic, copy) Touch touch;
@end

@implementation GMMaskView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self) {
        self = [super initWithFrame:frame];
        self.backgroundColor = COLOR_MASK_BG_COLOR;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.touch) {
        self.touch();
    }
}

- (void)touchesBegan:(Touch)touch {
    self.touch = touch;
}

@end
