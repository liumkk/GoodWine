//
//  GMNetConfig.h
//  GoodWine
//
//  Created by LMK on 2019/6/3.
//  Copyright © 2019年 LMK. All rights reserved.
//

#ifndef GMNetConfig_h
#define GMNetConfig_h

#import "GMNetworkError.h"
#import "GMServerClient.h"
#import "GMServerAPIManager.h"

/**
 * 环境切换，0-测试环境，1-生产环境
 */
#define GM_PLATFORM_CONFIG 1

#if GM_PLATFORM_CONFIG

#define GMServerBaseURL           @"http://180.169.95.129:18081/pic-server/faceGeneral/"

#else

#define GMServerBaseURL           @"http://58.247.0.18:19138/pic-server/faceGeneral/"


#endif

#endif /* GMNetConfig_h */
