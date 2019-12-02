//
//  GMSearchTableView.h
//  GoodWine
//
//  Created by LMK on 2019/11/29.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GMSearchTableViewDelegate <NSObject>

- (void)searchTableViewDidSelectItemModel:(HomePageTypeItem *)model;

@end

@interface GMSearchTableView : UITableView

@property (nonatomic, weak) id <GMSearchTableViewDelegate> searchDelegate;

- (void)reloadSearchTableViewWithDataArray:(NSMutableArray<HomePageTypeItem *> *)datatArray;

@end

NS_ASSUME_NONNULL_END
