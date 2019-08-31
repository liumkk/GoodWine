//
//  CollectProductItem.h
//  GoodWine
//
//  Created by LMK on 2019/8/30.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectProductItem : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *productId;
@property (nonatomic, assign) NSInteger productCategoryId;
@property (nonatomic, copy) NSString *productCategoryName;
@property (nonatomic, assign) NSInteger brandId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *brandName; //品牌名称
@property (nonatomic, assign) NSInteger sale;     //销量
@property (nonatomic, copy) NSString *subTitle; //副标题
@property (nonatomic, assign) NSInteger originalPrice;    //市场价
@property (nonatomic, assign) NSInteger price; //现价
@property (nonatomic, copy) NSString *detailDesc;
@property (nonatomic, copy) NSString *albumPics;
@property (nonatomic, copy) NSString *productSn;
@property (nonatomic, copy) NSString *unit;
@property (nonatomic, copy) NSString *keywords;
@property (nonatomic, assign) NSInteger alcohol;


@end

NS_ASSUME_NONNULL_END
