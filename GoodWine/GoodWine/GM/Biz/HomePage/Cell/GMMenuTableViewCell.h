//
//  GMMenuTableViewCell.h
//  GoodWine
//
//  Created by LMK on 2019/6/4.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMMenuTableViewCell : UITableViewCell

@property (nonatomic, strong)GMITButton *whiteSpiritArea;
@property (nonatomic, strong)GMITButton *redWineArea;
@property (nonatomic, strong)GMITButton *otherArea;
@property (nonatomic, strong)GMITButton *couponArea;


+ (CGFloat)heightForCell;

@end

NS_ASSUME_NONNULL_END
