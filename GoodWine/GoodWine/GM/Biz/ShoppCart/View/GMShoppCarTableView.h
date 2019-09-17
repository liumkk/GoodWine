//
//  GMShoppCarTableView.h
//  GoodWine
//
//  Created by LMK on 2019/8/7.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GMShoppCarTableViewDelegate <NSObject>

- (void)shoppCarTableCellSelectBtn:(UIButton *)btn;
- (void)shoppCarTableViewDeleteRowAtIndex:(NSInteger)index;
- (void)addNumAtIndex:(NSInteger)index isAdd:(BOOL)isAdd;
- (void)shoppCarTableViewDidSelectRowAtIndex:(NSInteger)index;
@end

@interface GMShoppCarTableView : UITableView

@property (nonatomic, weak) id <GMShoppCarTableViewDelegate> shoppCarCellDelegate;

- (void)reloadTableViewWithDataArray:(NSArray <ShoppCarInfoModel *>*)dataArray;

@end

NS_ASSUME_NONNULL_END
