//
//  GMProductDetailFooterView.h
//  GoodWine
//
//  Created by LMK on 2019/8/16.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMProductDetailFooterView : UIView

@property (nonatomic, strong) UIButton *joinShoppCarBtn;
@property (nonatomic, strong) UIButton *buyButton;
@property (nonatomic, strong) GMITButton *collectBtn;
@property (nonatomic, strong) GMITButton *serviceBtn;
@property (nonatomic, strong) GMITButton *shoppCarBtn;

- (void)collectBtnSelected:(BOOL)selected;

@end

NS_ASSUME_NONNULL_END
