//
//  GMSelectProductView.h
//  GoodWine
//
//  Created by LMK on 2019/8/20.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GMSelectProductViewDelegate <NSObject>

- (void)selectProductWithItem:(GMProductSkuItem *)item buyNum:(NSString *)buyNum;

@end

@interface GMSelectProductView : UIView

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *productNumLabel;
@property (nonatomic, strong) UILabel *standardLabel;
@property (nonatomic, strong) UIView *selectView;
@property (nonatomic, strong) UILabel *buyNumLabel;
@property (nonatomic, strong) UIButton *jianBtn;
@property (nonatomic, strong) UIButton *jiaBtn;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, weak) id <GMSelectProductViewDelegate>selectProductDelegate;


- (void)updateSelectProductViewWithModel:(GMProductDetailModel *)model;

@end

NS_ASSUME_NONNULL_END
