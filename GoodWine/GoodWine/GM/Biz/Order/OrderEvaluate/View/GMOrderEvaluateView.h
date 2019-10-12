//
//  GMOrderEvaluateView.h
//  GoodWine
//
//  Created by LMK on 2019/9/19.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMOrderEvaluateView : UIView

@property (nonatomic, strong) UIImageView *productImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSMutableArray *productStarArray;

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *placedLabel;


@property (nonatomic, strong) UILabel *storeLabel;
@property (nonatomic, strong) NSMutableArray *storeStarArray;
@property (nonatomic, strong) UILabel *serviceLabel;
@property (nonatomic, strong) NSMutableArray *serviceStarArray;

@property (nonatomic, strong) UIButton *confirmBtn;

- (void)updateEvaluateViewWithModel:(GMOrderItem *)model;

@end

NS_ASSUME_NONNULL_END
