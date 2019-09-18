//
//  GMSearchView.h
//  GoodWine
//
//  Created by LMK on 2019/9/18.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMSearchView : UIView

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UIView *paddingView;
@property (nonatomic, strong) UIImageView *searchImageView;
@property (nonatomic, strong) UIButton *searchButton;

@end

NS_ASSUME_NONNULL_END
