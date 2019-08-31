//
//  GMMaskView.h
//  GoodWine
//
//  Created by LMK on 2019/8/20.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^Touch)(void);

@interface GMMaskView : UIView

- (void)touchesBegan:(Touch)touch;

@end

NS_ASSUME_NONNULL_END
