//
//  CollectItem.h
//  GoodWine
//
//  Created by LMK on 2019/8/30.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectItem : MTLModel <MTLJSONSerializing>

@property (nonatomic, assign) NSInteger collectId;
@property (nonatomic, assign) NSInteger productId;
@property (nonatomic, copy) NSString *productName;
@property (nonatomic, copy) NSString *productPic;
@property (nonatomic, copy) NSString *productSubTitle;
@property (nonatomic, assign) NSInteger productPrice;   
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, assign) NSInteger deleteStatus;

@end

NS_ASSUME_NONNULL_END
