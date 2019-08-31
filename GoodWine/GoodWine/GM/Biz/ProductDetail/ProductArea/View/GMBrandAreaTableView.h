//
//  GMBrandAreaTableView.h
//  GoodWine
//
//  Created by LMK on 2019/8/27.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GMBrandAreaTableViewDelegate <NSObject>

- (void)brandAreaTableViewDidSelectRowAtIndex:(NSInteger)index;

@end

@interface GMBrandAreaTableView : UITableView

@property (nonatomic, weak) id <GMBrandAreaTableViewDelegate> brandTBDelegate;

- (void)reloadTableViewWithDataArray:(NSArray <BrandAreaInfoModel *> *)array;

@end

NS_ASSUME_NONNULL_END
