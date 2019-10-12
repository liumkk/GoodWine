//
//  GMServiceTableView.h
//  GoodWine
//
//  Created by LMK on 2019/8/2.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GMServiceTableViewDelegate <NSObject>

- (void)serviceTableViewDidSelectRowAtIndex:(NSInteger)index;

@end

@interface GMServiceTableView : UITableView

@property (nonatomic, weak) id <GMServiceTableViewDelegate> serviceTBDelegate;

@end

NS_ASSUME_NONNULL_END
