//
//  GMITButton.h
//  GoodWine
//
//  Created by LMK on 2019/5/29.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMITButton : UIButton

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *contentLabel;

- (void)updateIconImageName:(NSString *)imageName contentText:(NSString *)contentText;

@end

NS_ASSUME_NONNULL_END
