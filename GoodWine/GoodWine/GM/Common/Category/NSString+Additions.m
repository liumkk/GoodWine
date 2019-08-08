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

@end
