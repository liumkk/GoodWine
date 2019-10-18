//
//  GMProductDetailModel.h
//  GoodWine
//
//  Created by LMK on 2019/8/17.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMProductDetailModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSString *productCategoryId;
@property (nonatomic, assign) NSInteger brandId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *brandName; //品牌名称
@property (nonatomic, assign) NSInteger sale;     //销量
@property (nonatomic, copy) NSString *subTitle; //副标题
@property (nonatomic, copy) NSString *originalPrice;    //市场价
@property (nonatomic, copy) NSString *price; //价格
@property (nonatomic, copy) NSString *purity; //酒类型
@property (nonatomic, copy) NSString *alcohol; //酒精度
@property (nonatomic, copy) NSString *detailDesc;
@property (nonatomic, copy) NSString *albumPics;
@property (nonatomic, copy) NSString *productSn;
@property (nonatomic, copy, readonly) NSArray<GMProductSkuItem *> *skuArray;

+ (instancetype)productDetailModelWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
