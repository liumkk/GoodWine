//
//  GMOrderListTableView.h
//  GoodWine
//
//  Created by LMK on 2019/9/9.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GMOrderListTableViewDelegate <NSObject>

- (void)orderListTableViewStatusAtIndex:(NSInteger )index;
- (void)orderListTableViewDeleteRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface GMOrderListTableView : UITableView

@property (nonatomic, weak)id <GMOrderListTableViewDelegate> orderListDelegate;

- (void)reloadTableViewWithDataArray:(NSArray <GMOrderDetailInfoModel *> *)array;

@end

NS_ASSUME_NONNULL_END
