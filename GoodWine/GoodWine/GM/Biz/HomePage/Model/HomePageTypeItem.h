//
//  HomePageTypeItem.h
//  GoodWine
//
//  Created by LMK on 2019/7/22.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomePageTypeItem : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *productId;
@property (nonatomic, assign) NSInteger brandId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *brandName; //品牌名称
@property (nonatomic, assign) NSInteger sale;     //销量
@property (nonatomic, copy) NSString *subTitle; //副标题
@property (nonatomic, copy) NSString *originalPrice;    //市场价
@property (nonatomic, copy) NSString *price; //价格
@property (nonatomic, copy) NSString *unit; //规格
@property (nonatomic, copy) NSString *purity;    //类型
@property (nonatomic, copy) NSString *alcohol; //度数
@property (nonatomic, copy) NSString *productCategoryName; //酒类
@property (nonatomic, copy) NSString *detailTitle; //详细标题
@property (nonatomic, copy) NSString *promotionPrice;     //促销价格
@property (nonatomic, assign) NSInteger publishStatus; //上架状态：0->下架；1->上架
@property (nonatomic, assign) NSInteger recommandStatus;    //推荐状态；0->不推荐；1->推荐
@property (nonatomic, assign) NSInteger verifyStatus;    //审核状态：0->未审核；1->审核通过

+ (instancetype)homePageTypeItemWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
