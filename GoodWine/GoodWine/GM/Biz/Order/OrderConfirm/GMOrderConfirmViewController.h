//
//  GMOrderConfirmViewController.h
//  GoodWine
//
//  Created by LMK on 2019/8/14.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GMOrderConfirmViewController : GMBaseViewController

- (void)reloadOrderConfirmWithshoppCarArray:(NSArray <ShoppCarInfoModel *> *)dataArray
                                    idArray:(NSArray *)idArray;

- (void)reloadOrderConfirmWithProductDetail:(GMProductDetailModel *)model
                                    skuItem:(GMProductSkuItem *)item
                                   quantity:(NSString *)quantity;
@end

NS_ASSUME_NONNULL_END
