//
//  GMSettingTableView.h
//  GoodWine
//
//  Created by LMK on 2019/9/9.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GMSettingTableViewDelegate <NSObject>

- (void)LogoutAction;
- (void)settingTableViewDidSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface GMSettingTableView : UITableView

@property (nonatomic, weak) id <GMSettingTableViewDelegate> settingDelegate;

@end

NS_ASSUME_NONNULL_END
