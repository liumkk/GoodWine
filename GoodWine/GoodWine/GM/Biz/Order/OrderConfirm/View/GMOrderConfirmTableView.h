//
//  GMOrderConfirmTableView.h
//  GoodWine
//
//  Created by LMK on 2019/8/14.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GMOrderConfirmTableViewDelegate <NSObject>

- (void)orderConfirmTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface GMOrderConfirmTableView : UITableView

@property (nonatomic, weak) id <GMOrderConfirmTableViewDelegate> orderConfirmDelegate;

- (void)reloadTableViewWithAddressModel:(GMAddressInfoModel *)model;
- (void)reloadTableViewWithDataArray:(NSArray <ShoppCarInfoModel *> *)dataArray model:(CalcAmountInfoModel *)model;

@end

NS_ASSUME_NONNULL_END
