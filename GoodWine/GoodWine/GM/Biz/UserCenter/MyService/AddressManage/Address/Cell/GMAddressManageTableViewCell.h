//
//  GMAddressManageTableViewCell.h
//  GoodWine
//
//  Created by LMK on 2019/8/3.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMAddressManageTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIImageView *addressImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *addressLabel;

- (void)updateAddressCellWithModel:(AddressInfoModel *)model;

@end

NS_ASSUME_NONNULL_END
