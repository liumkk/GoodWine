//
//  NSString+Additions.m
//  GoodWine
//
//  Created by LMK on 2019/7/29.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)

+ (NSMutableAttributedString *)setMiddleLinePriceWithString:(NSString *)string {

    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:string attributes:attribtDic];
    return attribtStr;
}

- (CGFloat)heightStringWithFont:(UIFont *)font width:(CGFloat)width {
    CGFloat height = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size.height;
    return height;
}

- (CGFloat)widthStringWithFont:(UIFont *)font height:(CGFloat)height {
    CGFloat width=[self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.width;
    return width;
}

+ (NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

- (NSString *)formatterYuan {
    return [NSString stringWithFormat:@"￥%.2f",[self floatValue]];
}

- (NSString *)statusFormatter {
    if ([self isEqualToString:@"0"]) {
        return @"待付款";
    } else if ([self isEqualToString:@"1"]) {
        return @"待发货";
    } else if ([self isEqualToString:@"2"]) {
        return @"已发货";
    } else if ([self isEqualToString:@"3"]) {
        return @"已完成";
    } else if ([self isEqualToString:@"4"]) {
        return @"已关闭";
    } else {
        return @"已失效";
    }
}

@end
