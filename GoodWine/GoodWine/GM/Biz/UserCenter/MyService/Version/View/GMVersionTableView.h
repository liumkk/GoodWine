//
//  GMVersionTableView.h
//  GoodWine
//
//  Created by LMK on 2019/8/2.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GMVersionTableViewDelegate <NSObject>

- (void)versionTableViewDidSelectRowAtIndex:(NSInteger)index;

@end

@interface GMVersionTableView : UITableView

@property (nonatomic, weak) id <GMVersionTableViewDelegate> versionTBDelegate;

@end

NS_ASSUME_NONNULL_END
