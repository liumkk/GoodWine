//
//  CollectListInfoModel.h
//  GoodWine
//
//  Created by LMK on 2019/8/30.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectListInfoModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSArray<CollectProductItem *> *collectProductArray;
@property (nonatomic, copy, readonly) NSArray<CollectItem *> *collectArray;

+ (instancetype)collectListInfoModelWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
