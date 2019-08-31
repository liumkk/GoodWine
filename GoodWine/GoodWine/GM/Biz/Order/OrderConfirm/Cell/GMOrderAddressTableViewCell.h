//
//  GMOrderAddressTableViewCell.h
//  GoodWine
//
//  Created by LMK on 2019/8/14.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMOrderAddressTableViewCell : UITableViewCell

@property (nonatomic, copy) UILabel *addressLabel;
@property (nonatomic, copy) UILabel *receiverLabel;

- (void)updateCellWithModel:(GMAddressInfoModel *)model;

- (void)updateCellWithOrderDetailModel:(GMOrderDetailInfoModel *)model;

@end

NS_ASSUME_NONNULL_END
