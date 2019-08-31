//
//  ShoppCarInfoModel.h
//  GoodWine
//
//  Created by LMK on 2019/8/8.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShoppCarInfoModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *shoppCarId;
@property (nonatomic, copy) NSString *productSkuId; //规格id
@property (nonatomic, copy) NSString *productName; //商品名称
@property (nonatomic, copy) NSString *productSubTitle;
@property (nonatomic, copy) NSString *productPic; //商品主图
@property (nonatomic, copy) NSString *currentPrice;
@property (nonatomic, copy) NSString *quantity; //购买数量
@property (nonatomic, copy) NSString *productSkuCode; //sku码
@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSString *productCategoryId; //商品分类
@property (nonatomic, copy) NSString *invalidStatus; //是否失效 0未失效 1已失效 ,
@property (nonatomic, copy) NSString *createDate; //创建时间
@property (nonatomic, copy) NSString *sp1;
@property (nonatomic, copy) NSString *productSn;


@property (nonatomic, assign) BOOL isSelected;

+ (instancetype)shoppCarInfoModelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
