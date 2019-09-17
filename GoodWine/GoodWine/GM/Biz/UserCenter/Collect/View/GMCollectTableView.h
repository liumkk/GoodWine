//
//  GMCollectTableView.h
//  GoodWine
//
//  Created by LMK on 2019/8/30.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GMCollectTableViewDelegate <NSObject>

- (void)collectTableViewDeleteRowAtIndex:(NSInteger)index;
- (void)collectTableViewDidSelectRowAtIndex:(NSInteger)index;

@end

@interface GMCollectTableView : UITableView

@property (nonatomic, weak) id <GMCollectTableViewDelegate> collectTBDelegate;

- (void)reloadTableViewWithDataArray:(NSArray <CollectProductItem *> *)array;

@end

NS_ASSUME_NONNULL_END
