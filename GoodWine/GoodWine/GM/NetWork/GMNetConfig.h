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

#import "GMServerAPIManager+UserAccess.h"
#import "GMServerAPIManager+HomePage.h"
#import "GMServerAPIManager+GMMyCenter.h"
#import "GMServerAPIManager+ShoppCar.h"

/**
 * 环境切换，0-测试环境，1-生产环境
 */
#define GM_PLATFORM_CONFIG 0

#if GM_PLATFORM_CONFIG

#define GMServerBaseURL           @"http://180.169.95.129:18081/pic-server/faceGeneral/"


#else

#define GMServerBaseURL           @"http://118.31.225.18:8085/"

#define GMLogin                   @"sso/login"
#define GMHomePageInfo            @"home/content?storeId=1"
#define GMAllAddress              @"member/address/list?pageSize=10&pageNum=1&storeId=1"
#define GMAddAddress              @"member/address/add"
#define GMShoppCarList            @"cart/list?storeId=1"


#endif

#endif /* GMNetConfig_h */
