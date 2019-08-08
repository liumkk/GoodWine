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

@end

NS_ASSUME_NONNULL_END
