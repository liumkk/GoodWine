//
//  GMOrderDetailTableView.h
//  GoodWine
//
//  Created by LMK on 2019/8/31.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMOrderDetailHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GMOrderDetailTableViewDelegate <NSObject>

- (void)payOrder;

@end

@interface GMOrderDetailTableView : UITableView

@property (nonatomic, weak) id <GMOrderDetailTableViewDelegate> orderDetailDelegate;
@property (nonatomic, strong) GMOrderDetailHeaderView *detailHeaderView;
- (void)reloadTableViewWithModel:(GMOrderDetailInfoModel *)model myModel:(GMMyOrderDetailModel *)myOrder;

@end

NS_ASSUME_NONNULL_END
