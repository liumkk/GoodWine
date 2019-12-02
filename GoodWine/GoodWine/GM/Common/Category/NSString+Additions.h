//
//  NSString+Additions.h
//  GoodWine
//
//  Created by LMK on 2019/7/29.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Additions)

//添加中划线
+ (NSMutableAttributedString *)setMiddleLinePriceWithString:(NSString *)string;

//改变指定位置文字颜色和大小
+ (NSMutableAttributedString *)getAttrStr:(NSString *)str beginL:(CGFloat)beginL endL:(CGFloat)endL color:(UIColor *)color font:(UIFont *)font;

//首行缩进
+ (NSAttributedString *)setFirstLineHeadIndentWithString:(NSString *)string indent:(CGFloat)indent;

//计算文字高度
- (CGFloat)heightStringWithFont:(UIFont *)font width:(CGFloat)width;

//计算文字宽度
- (CGFloat)widthStringWithFont:(UIFont *)font height:(CGFloat)height;

+ (NSString *)getCurrentTime;

- (NSString *)formatterYuan;

- (NSString *)statusFormatter;
- (NSString *)statusFormatterWithType:(NSString *)type;

@end

NS_ASSUME_NONNULL_END
