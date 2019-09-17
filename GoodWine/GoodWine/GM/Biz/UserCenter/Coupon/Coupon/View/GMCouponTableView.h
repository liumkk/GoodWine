//
//  GMCouponTableView.h
//  GoodWine
//
//  Created by LMK on 2019/8/30.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GMCouponTableViewDelegate <NSObject>

- (void)couponTableViewDidSelectRowAtIndex:(NSInteger)index;

@end

@interface GMCouponTableView : UITableView

@property (nonatomic, weak) id <GMCouponTableViewDelegate> couponDelegate;

- (void)reloadTableViewWithDataArray:(NSArray <CouponInfoModel*> *)array;

@end

NS_ASSUME_NONNULL_END
