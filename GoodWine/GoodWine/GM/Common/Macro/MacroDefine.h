//
//  MacroDefine.h
//  GoodWine
//
//  Created by LMK on 2019/5/28.
//  Copyright © 2019年 LMK. All rights reserved.
//

#ifndef MacroDefine_h
#define MacroDefine_h

//--------------------------------常用宏----------------------------------------------//

#define Width_Screen  [UIScreen mainScreen].bounds.size.width
#define Height_Screen [UIScreen mainScreen].bounds.size.height

#define Auto_Size_Scale           Width_Screen/375

#define Height_StatusBar 20
#define Height_NavBar 44
#define Height_TabBar 49

//--------------------------------常用宏----------------------------------------------//

#define IS_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhoneX_Bottom_Margin            (IS_iPhoneX ? 88 : 0)

//字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))


//-----------------------------------------------------------------------------------------//

#ifdef DEBUG

#define MKNSLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])

#else

#define MKNSLog(...)

#endif

//----------------------------------------------------------------------------------------------//

#define singleton_interface(className) \
+ (className *)shared##className;


#define singleton_implementation(className) \
static className *_instance; \
+ (className *)shared##className \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
+ (id)allocWithZone:(NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
}

#endif /* MacroDefine_h */
