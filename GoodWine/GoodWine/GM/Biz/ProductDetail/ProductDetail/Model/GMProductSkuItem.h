//
//  GMProductSkuItem.h
//  GoodWine
//
//  Created by LMK on 2019/8/17.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMProductSkuItem : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *productSkuId;
@property (nonatomic, copy) NSString *skuCode;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *sp1;
@property (nonatomic, copy) NSString *pic;

@end

NS_ASSUME_NONNULL_END
