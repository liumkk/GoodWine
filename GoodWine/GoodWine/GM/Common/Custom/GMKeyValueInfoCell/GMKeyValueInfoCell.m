//
//  GMKeyValueInfoCell.m
//  GoodWine
//
//  Created by LMK on 2019/5/28.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMKeyValueInfoCell.h"

@implementation GMKeyValueInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupConstraints];
        
    }
    return self;
}

- (void)setupConstraints {
    
}

- (void)updateCell {
    
}

+ (CGFloat)heightForCell {
    return 50.f;
}

+ (CGFloat)heightForCellWithFloat:(CGFloat)height {
    
    return height;
}

#pragma mark --init subviews


@end
