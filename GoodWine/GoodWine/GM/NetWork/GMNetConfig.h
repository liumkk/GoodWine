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
#import "GMServerAPIManager+Product.h"
#import "GMServerAPIManager+Order.h"

/**
 * 环境切换，0-测试环境，1-生产环境
 */
#define GM_PLATFORM_CONFIG 0

#if GM_PLATFORM_CONFIG

#define GMServerBaseURL           @"http://180.169.95.129:18081/pic-server/faceGeneral/"


#else

#define GMServerBaseURL           @"http://118.31.225.18:8085/"

#define GMLogin                       @"sso/login"
#define GMGetStoreInfo(_code)         [NSString stringWithFormat:@"store/storeInfo?regionCode=%@",_code]
#define GMHomePageInfo(_storeId)      [NSString stringWithFormat:@"home/content?storeId=%@",_storeId]
#define GMHomeCoupon(_storeId)        [NSString stringWithFormat:@"home/couponList?storeId=%@",_storeId]
#define GMGetCoupon(_couponId)        [NSString stringWithFormat:@"member/coupon/add/%ld",_couponId]

#define GMShoppCarList(_storeId)      [NSString stringWithFormat:@"cart/list?storeId=%@",_storeId]
#define GMModifyProductNum(_id,_num)    \
        [NSString stringWithFormat:@"cart/update/quantity?id=%@&quantity=%@",_id,_num]
#define GMAddShoppCar                 @"cart/add"

#define GMAllAddress(_pageSize,_pageNum,_storeId) \
        [NSString stringWithFormat:@"member/address/list?pageSize=%@&pageNum=%@&storeId=%@",_pageSize,_pageNum,_storeId]

#define GMAddAddress                  @"member/address/add"
#define GMDeleteAddress(_addressId)   [NSString stringWithFormat:@"member/address/delete/%@",_addressId]

#define GMGetCollectList(_pageSize,_pageNum,_storeId)   \
        [NSString stringWithFormat:@"member/collection/listProduct?pageSize=%@&pageNum=%@&storeId=%@",_pageSize,_pageNum,_storeId]

#define GMDeleteCollect(_productId)   [NSString stringWithFormat:@"member/collection/deleteProduct?productId=%@",_productId]
#define GMCollectProduct              @"member/collection/addProduct"

#define GMProductDetail(_productId)   [NSString stringWithFormat:@"product/productDetail?productId=%@",_productId]

#define GMProductEvaluate(_productId) [NSString stringWithFormat:@"product/comment/list?productId=%@",_productId]

#define GMProductBrandList(_storeId,_cateId)      \
        [NSString stringWithFormat:@"product/brandList/?storeId=%@&cateId=%@",_storeId,_cateId]

#define GMProductList(_pageSize,_pageNum,_storeId,_cateId,_brandId)      \
        [NSString stringWithFormat:@"product/productList?pageSize=%@&pageNum=%@&storeId=%@&cateId=%@&brandId=%@",_pageSize,_pageNum,_storeId,_cateId,_brandId]

#define GMOrderConfirmFromShoppCar     @"order/generateConfirmOrder"
#define GMDeleteProductForShoppCar     @"cart/delete"
#define GMOrderConfirmFromProduct      @"order/confirmOrderFromProduct"

#define GMOrderDetailFromShoppCar      @"order/generateOrder"
#define GMOrderDetailFromProduct       @"order/orderFromProduct"

#define GMDeleteOrder(_orderId)        [NSString stringWithFormat:@"order/cancelOrder?orderId=%@",_orderId]

#define GMGetPayData(_orderId)         [NSString stringWithFormat:@"order/getPayData?orderId=%@&payType=1",_orderId]


#endif

#endif /* GMNetConfig_h */
