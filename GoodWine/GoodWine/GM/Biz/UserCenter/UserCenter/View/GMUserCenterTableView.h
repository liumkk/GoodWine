//
//  GMUserCenterTableView.h
//  GoodWine
//
//  Created by LMK on 2019/5/29.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GMUserCenterTableViewDelegate <NSObject>

- (void)loginAction;
- (void)userCollectionViewDidSelectRowAtIndex:(NSInteger)index;

@end

@interface GMUserCenterTableView : UITableView

@property (nonatomic, weak) id <GMUserCenterTableViewDelegate> userTableViewDelegate;

@end

NS_ASSUME_NONNULL_END
