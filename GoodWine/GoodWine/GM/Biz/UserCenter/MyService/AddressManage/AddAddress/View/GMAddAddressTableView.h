//
//  GMAddAddressTableView.h
//  GoodWine
//
//  Created by LMK on 2019/8/5.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GMAddAddressTableViewDelegate <NSObject>

- (void)addAddressTableViewConfirmBtnName:(NSString *)name
                                 phoneNum:(NSString *)phoneNum
                                  address:(NSString *)address
                             detailAddess:(NSString *)detailAddress;

@end

@interface GMAddAddressTableView : UITableView

@property (nonatomic, weak) id <GMAddAddressTableViewDelegate> addAddressDelegate;

@end

NS_ASSUME_NONNULL_END
