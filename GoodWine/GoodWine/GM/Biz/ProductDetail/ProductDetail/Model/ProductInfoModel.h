//
//  ProductInfoModel.h
//  GoodWine
//
//  Created by LMK on 2019/8/31.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductInfoModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) GMProductDetailModel *productDetailModel;
@property (nonatomic, assign) BOOL collectionFlag;

+ (instancetype)productInfoModelWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
