//
//  GMMyCouponTableView.h
//  GoodWine
//
//  Created by LMK on 2019/9/16.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GMMyCouponTableViewDelegate <NSObject>

- (void)myCouponTableViewDidSelectRowAtIndex:(NSInteger)index;

@end

@interface GMMyCouponTableView : UITableView

@property (nonatomic, weak) id <GMMyCouponTableViewDelegate> myCouponDelegate;

- (void)reloadTableViewWithDataArray:(NSArray <MyCouponInfoModel*> *)array;


@end

NS_ASSUME_NONNULL_END
