//
//  GMOrderDetailTableView.h
//  GoodWine
//
//  Created by LMK on 2019/8/31.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GMOrderDetailTableViewDelegate <NSObject>

- (void)payOrder;

@end

@interface GMOrderDetailTableView : UITableView

@property (nonatomic, weak) id <GMOrderDetailTableViewDelegate> orderDetailDelegate;

- (void)reloadTableViewWithModel:(GMOrderDetailInfoModel *)model;

@end

NS_ASSUME_NONNULL_END
