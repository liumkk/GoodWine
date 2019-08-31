//
//  GMNetworkError.h
//  GoodWine
//
//  Created by LMK on 2019/6/3.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define GM_Net_Error_Domain  @"UMSFS_Net_Error_Domain"
#define GM_Net_Key_ErrCode   @"code"
#define GM_Net_Key_ErrInfo   @"message"

#define GM_Net_RespCode_Success               @"0000"
#define GM_Net_RespCode_Error                 @"01"
#define GM_Net_RespCode_Error_Param           @"0009"
#define GM_Net_RespCode_Error_Timeout         @"2000"
#define GM_Net_RespCode_Error_NoNetWork       @"9999"
#define GM_Net_RespCode_Error_NoSession       @"406"

@interface GMNetworkError : NSObject

+ (NSError *)getParamError;

+ (NSError *)changeNetError:(NSError *)error;

+ (NSError *)getBizWithMessage:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
