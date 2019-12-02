//
//  GMProductAreaTableView.h
//  GoodWine
//
//  Created by LMK on 2019/11/29.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GMProductAreaTableViewDelegate <NSObject>

- (void)productAreaTableViewDidSelectItemModel:(HomePageTypeItem *)model;

@end

@interface GMProductAreaTableView : UITableView

@property (nonatomic, weak) id <GMProductAreaTableViewDelegate> productAreaDelegate;

- (void)reloadProductAreaTableViewWithDataArray:(NSMutableArray<HomePageTypeItem *> *)datatArray;

@end

NS_ASSUME_NONNULL_END
