//
//  MKEmptyView.h
//  GoodWine
//
//  Created by LMK on 2019/8/30.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKEmptyView : UIView

@property (nonatomic, strong) UIImageView *emptyImageView;
@property (nonatomic, strong) UIButton *loadBtn;

- (void)showEmptyWithTitle:(NSString *)title needBtn:(BOOL)needBtn;

- (void)showEmptyNeedLoadBtn:(BOOL)needBtn;
- (void)updateEmptyTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
