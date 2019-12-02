//
//  GMNetworkError.m
//  GoodWine
//
//  Created by LMK on 2019/6/3.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMNetworkError.h"

@implementation GMNetworkError

+ (NSError *)getParamError {
    
    return [NSError errorWithDomain:GM_Net_Error_Domain code:[GM_Net_RespCode_Error_Param integerValue] userInfo:@{GM_Net_Key_ErrCode:GM_Net_RespCode_Error_Param,GM_Net_Key_ErrInfo:@"缺省请求参数"}];
}

+ (NSError *)changeNetError:(NSError *)error {
    
    if (error.code == -1001) {
        return [NSError errorWithDomain:GM_Net_Error_Domain code:[GM_Net_RespCode_Error_Timeout integerValue] userInfo:@{GM_Net_Key_ErrCode:GM_Net_RespCode_Error_Timeout,GM_Net_Key_ErrInfo:@"网络请求超时"}];
    }else if (error.code == -1009) {
        return [NSError errorWithDomain:GM_Net_Error_Domain code:[GM_Net_RespCode_Error integerValue] userInfo:@{GM_Net_Key_ErrCode:GM_Net_RespCode_Error_NoNetWork,GM_Net_Key_ErrInfo:@"网络连接失败，请检查网络设置"}];
    } else if (error.code == -1011) {
        return [NSError errorWithDomain:GM_Net_Error_Domain code:[GM_Net_RespCode_Error integerValue] userInfo:@{GM_Net_Key_ErrCode:GM_Net_RespCode_Error_NoNetWork,GM_Net_Key_ErrInfo:@"网络错误"}];
    }
    return error;
}

+ (NSError *)getBizWithMessage:(NSString *)message {
    
    if (!message) {
        message = @"";
    }
    
    return [NSError errorWithDomain:GM_Net_Error_Domain code:[GM_Net_RespCode_Error integerValue] userInfo:@{GM_Net_Key_ErrCode:GM_Net_RespCode_Error,GM_Net_Key_ErrInfo:message}];
}

+ (NSError *)getBizWithMessage:(NSString *)message code:(NSString *)code {
    
    if (!message) {
        message = @"";
    }
    
    if (!code) {
        code = @"0";
    }
    
    return [NSError errorWithDomain:GM_Net_Error_Domain code:[GM_Net_RespCode_Error integerValue] userInfo:@{GM_Net_Key_ErrCode:code,GM_Net_Key_ErrInfo:message}];
}

@end
