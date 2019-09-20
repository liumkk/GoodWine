//
//  GMAddressManageTableView.h
//  GoodWine
//
//  Created by LMK on 2019/8/3.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GMAddressManageTableViewDelegate <NSObject>

- (void)addAddress;
- (void)addressManageTableView:(UITableView *)tableView
        deleteRowAtIndexPath:(NSIndexPath *)indexPath
                       model:(AddressInfoModel *)model;
- (void)addressManagerTableViewDidSelectRowAtModel:(AddressInfoModel *)model;

@end

@interface GMAddressManageTableView : UITableView

@property (nonatomic, weak) id <GMAddressManageTableViewDelegate> addressDelegate;

- (void)reloadTableViewWithDataArray:(NSArray <AddressInfoModel *> *)dataArray;

@end

NS_ASSUME_NONNULL_END
