//
//  UI_Constant.h
//  GoodWine
//
//  Created by LMK on 2019/5/27.
//  Copyright © 2019年 LMK. All rights reserved.
//

#ifndef UI_Constant_h
#define UI_Constant_h

/* Sizes */

// 分割线高度(极细)
#define LINE_HEIGHT                         0.5
#define LINE_WIDTH                          0.5

#define Font_Small                  [UIFont systemFontOfSize:15.f]
#define Font_Normal                 [UIFont systemFontOfSize:16.f]
#define Font_Big                    [UIFont systemFontOfSize:17.f]


/* Colors */

// 统一默认的文字黑色，替代[UIColor blackColor]
#define COLOR_TEXT_BLACK                                                  \
[UIColor colorWithRed:60 / 255.0 green:60 / 255.0 blue:60 / 255.0 alpha:1.0]

// 统一导航栏的灰色
#define COLOR_NAV_BACKGROUND_COLOR                                                    \
[UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1.0]

// 统一textField的背景颜色
#define COLOR_TEXT_FIELD_COLOR                                                        \
[UIColor colorWithRed:247 / 255.0 green:247 / 255.0 blue:247 / 255.0 alpha:1.0]

// 统一textField的placeholder颜色
#define COLOR_TEXT_FIELD_PLACEHOLDER_COLOR                                             \
[UIColor colorWithRed:180 / 255.0 green:180 / 255.0 blue:180 / 255.0 alpha:1.0]

// 多数tableView的背景颜色，微微有点蓝绿的灰色
#define COLOR_TABLE_BG_COLOR                                                    \
[UIColor colorWithRed:238 / 255.0 green:242 / 255.0 blue:245 / 255.0 alpha:1]

// 本项目主题色，橘红色，随处可见的UIButton的文字或背景的颜色
#define COLOR_THEME_COLOR                                                    \
[UIColor colorWithRed:233 / 255.0 green:90 / 255.0 blue:24 / 255.0 alpha:1.0]

// 表示成功的勾所用绿色
#define COLOR_CHECK_GREEN                                                     \
[UIColor colorWithRed:0 / 255.0 green:199 / 255.0 blue:82 / 255.0 alpha:1.0]

// 统一分割线的颜色，浅灰色
#define COLOR_LINE_COLOR                                                      \
[UIColor colorWithRed:220 / 255.0 green:220 / 255.0 blue:220 / 255.0 alpha:1.0]

//项目中用到的黄色 如pagepoint的颜色
#define COLOR_YELLOW_COLOR                                                    \
[UIColor colorWithRed:255 / 255.0 green:190 / 255.0 blue:0 / 255.0 alpha:1.0]

// 项目中频繁使用的中度灰色，替代[UIColor grayColor]
#define COLOR_GRAY_150                                                        \
[UIColor colorWithRed:150 / 255.0 green:150 / 255.0 blue:150 / 255.0 alpha:1.0]

// 用于遮罩的黑色透明背景，统一alpha为0.65
#define COLOR_MASK_BG_COLOR                                                    \
[UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:0.65]

// 用于不可用状态文字描述
#define COLOR_GRAY_200                                                    \
[UIColor colorWithRed:200 / 255.0 green:200 / 255.0 blue:200 / 255.0 alpha:1]

#endif /* UI_Constant_h */
